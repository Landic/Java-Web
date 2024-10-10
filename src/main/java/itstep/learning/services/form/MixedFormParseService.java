package itstep.learning.services.form;

/*
 * Mixed parser: Apache (for multipart) + Servlet API (for urlencoded)
 */

import com.google.inject.Inject;
import com.google.inject.Singleton;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;

@Singleton
public class MixedFormParseService implements FormParseService {
    private final static int memoryLimit = 3*1024*1024; // 3MB file in memory
    private final static int maxSingleFile = 2*1024*1024; // 2MB file in memory
    private final static int maxFormSize = 5*1024*1024; // 5MB file in memory
    private ServletFileUpload servletFileUpload;
    private final Logger logger;

    @Inject
    public MixedFormParseService(Logger logger) {
        this.logger = logger;
        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(memoryLimit);
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
        servletFileUpload = new ServletFileUpload(factory);
        servletFileUpload.setFileSizeMax(maxSingleFile);
        servletFileUpload.setSizeMax(maxFormSize);
    }

    @Override
    public FormResult parse(HttpServletRequest req) {
        final Map<String, String> formFields = new HashMap<String, String>();
        final Map<String, FileItem> formFiles = new HashMap<String, FileItem>();


        // !! за документацією алгоритм наступний, але він не завжди спрацьовує
        // boolean isMultipart = ServletFileUpload.isMultipartContent(req);

        String contentType = req.getHeader("Content-Type");
        boolean isMultipart = contentType != null && contentType.startsWith("multipart/form-data");


        if(isMultipart) { // Apache
            String charset = req.getCharacterEncoding(); // встановлюється у CharsetFilter
            if(charset == null) {
                charset = "UTF-8";
            }
            try
            {
                for(FileItem fileItem : servletFileUpload.parseRequest(req)){
                    if(fileItem.isFormField()){
                        formFields.put(fileItem.getFieldName(), fileItem.getString());
                    }
                    else{
                        formFiles.put(fileItem.getFieldName(), fileItem);
                    }
                }
            }
            catch (FileUploadException ex)
            {
                logger.warning(ex.getMessage());
            }

        }
        else { // Servlet API
            for(Map.Entry<String, String[]> entry : req.getParameterMap().entrySet()){
                formFields.put(entry.getKey(), entry.getValue()[0]);
            }
        }

        return new FormResult(){
            @Override
            public Map<String, String> getFields() {return formFields;}

            @Override
            public Map<String, FileItem> getFiles() {return formFiles;}
        };
    }
}

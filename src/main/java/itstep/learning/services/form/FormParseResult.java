package itstep.learning.services.form;

import org.apache.commons.fileupload.FileItem;

import java.util.Map;

public interface FormParseResult {
    Map<String, String> getFields();
    Map<String, FileItem> getFiles();
}
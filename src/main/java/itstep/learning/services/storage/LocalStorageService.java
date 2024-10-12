package itstep.learning.services.storage;

import com.google.inject.Singleton;
import org.apache.commons.fileupload.FileItem;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

@Singleton
public class LocalStorageService implements StorageService {
    private final static String storagePath = "C:/storage/Java213/";
    private final static int bufferSize = 4096;
    @Override
    public File getFile(String fileName) {
        if(fileName == null){
            return null;
        }
        File file = new File(storagePath, fileName);
        if(!file.exists()){
            return null;
        }
        return file;
    }

    @Override
    public String saveFile(FileItem fileItem) throws IOException {
        if(fileItem == null){
            throw new NullPointerException("fileItem is null");
        }
        if(fileItem.getSize() == 0){
            throw new NullPointerException("fileItem is empty");
        }
        String fileName = fileItem.getName();
        if(fileName == null){
            throw new NullPointerException("fileItem has no name");
        }
        // виділяємо розширення з початкового імені файлу
        int dotIndex = fileName.lastIndexOf(".");
        if(dotIndex == -1){
            throw new IOException("fileItem has no extension");
        }
        String extension = fileName.substring(dotIndex);
        if(".".equals(extension)){
            throw new IOException("fileItem has empty extension");
        }

        // генеруємо нове ім'я файлу, перевіряємо що такого немає у сховищі
        String savedName;
        File file;
        do{
            savedName = UUID.randomUUID() + extension;
            file = new File(storagePath + savedName);
        }while(file.exists());
        long size = fileItem.getSize();
        if(size > bufferSize){
            size = bufferSize;
        }
        byte[] buffer = new byte[(int)size];
        int len;
        try(FileOutputStream fos = new FileOutputStream(file);  InputStream is = fileItem.getInputStream()){
            while((len = is.read(buffer)) > 0){
                fos.write(buffer, 0, len);
            }
        }

        return savedName;
    }
}
package itstep.learning.services.stream;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.charset.Charset;

public interface StreamService {
    String readAsString(InputStream inputStream) throws IOException;
    void pipe(InputStream inputStream, OutputStream outputStream) throws IOException;
    void pipe(InputStream inputStream, OutputStream outputStream, int bufferSize) throws IOException;
}

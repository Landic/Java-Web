package itstep.learning.services;


import java.security.SecureRandom;
import java.util.stream.Collectors;

public class GeneratorService {
    private static final String ALLOWED_CHARACTERS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    private static final int DEFAULT_LENGTH = 11;

    private final SecureRandom random = new SecureRandom();

    public String generateFileName(Integer length) {
        int finalLength = (length != null && length > 0) ? length : DEFAULT_LENGTH;

        return random.ints(finalLength, 0, ALLOWED_CHARACTERS.length())
                .mapToObj(ALLOWED_CHARACTERS::charAt)
                .map(Object::toString)
                .collect(Collectors.joining());
    }
}

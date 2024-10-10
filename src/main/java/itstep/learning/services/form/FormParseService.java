package itstep.learning.services.form;

import javax.servlet.http.HttpServletRequest;

public interface FormParseService {
    FormResult parse(HttpServletRequest req);
}

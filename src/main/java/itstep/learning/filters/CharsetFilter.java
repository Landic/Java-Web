package itstep.learning.filters;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/*
Реєстрація фільтру також можлива або через web.xml, або через ацотацію @WebFilter
Але в даному разі перевага надається web.xml, оскільки анотації не гарантують
порядок виконання фільтрів, тоді як у web.xml порядок відповідає послідовності
декларацій фільтрів
 */

public class CharsetFilter implements Filter {
    private FilterConfig filterConfig;
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        // "прямий" хід - від сервера до JSP (представлення)
        // Звертаємо увагу, що request/response ідуть з базовими типами (не-HTTP)
        // за потреби роботи з HTTP-функціями необхідно здійснити перетворення
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;
        // встановлюємо кодування, що буде діяти при читанні/записі даних
        request.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        System.out.println("CharsetFilter worked for: " + request.getRequestURI());

        // якщо не вказати виклик наступного фільтру, то оброблення запиту зупиняється
        // користувач побачить порожню вкладку браузера

        filterChain.doFilter(servletRequest, servletResponse); // await next
        // "зворотній" хід - від представлення до сервера
    }

    @Override
    public void destroy() {
        this.filterConfig = null;
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
    }
}


/*
Фільтри (сервлетні фільтри) - концепція Middleware - код, що
- передує сервлетам (контролерам)
- утворює ланцюг викликів (передачі роботи)
- може припинити оброблення запиту
- проходиться двічі: "прямо" при обробці запиту, та "зворотно" - відповідно
- дозволяє додавання інших фільтрів у будь-яку частину ланцюга

Кодування символів:
особливістю роботи з запитом є те, що кодування можна змінити тільки ДО
того, як з нього почнеться читання. Після зчитування хоча б одного символу
зміна кодування призводить до винятку
Як висновок - кодування слід встановити максимально рано - у найперших
кодах роботи з запитом. Це свідчить на користь використання фільтру.


Задача: створити фільтр SecurityFilter, який буде додавати до запиту
атрибут "signature" зі значенням true.
у HomeController перевіряти наявність цього атрибуту
 */
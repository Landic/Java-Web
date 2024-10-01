package itstep.learning.servlets;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class WebXmlServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        boolean isSigned = false;
        Object signature = req.getAttribute("signature");
        if(signature instanceof Boolean){
            isSigned = (Boolean) signature;
        }
        if(isSigned == true){
            req.setAttribute("body", "web_xml.jsp");
        }
        else{
            req.setAttribute("body", "insecure.jsp");
        }
        req.getRequestDispatcher("WEB-INF/views/_layout.jsp").forward(req, resp);
    }
}

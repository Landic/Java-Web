package itstep.learning.servlets;

import com.google.inject.Singleton;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@Singleton
public class AuthTestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String authorization = request.getHeader("Authorization");
        String username = request.getParameter("username");
        String password = request.getParameter("password");


        if (authorization == null) {
            out.print("{\"code\": 401, \"status\": \"error\", \"data\": \"Authorization header not found\"}");
        }
        else if (!authorization.startsWith("Basic ")) {
            out.print("{\"code\": 400, \"status\": \"error\", \"data\": \"Non-Basic scheme\"}");
        }
        else if ("234".equals(username) && "123".equals(password)) {
            out.print("{\"code\": 200, \"status\": \"success\", \"data\": \"" + username + ":" + password + "\"}");
        }
        else {
            out.print("{\"code\": 401, \"status\": \"error\", \"data\": \"Invalid credentials\"}");
        }

        out.flush();
    }
}

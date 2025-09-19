/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ProcessCreateUser", urlPatterns = {"/create-user"})
public class ProcessCreateUser extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String ConfirmPassword = request.getParameter("confirm-password");
        boolean isValid = true;
//ktra password
        String message = null;
        if (!ConfirmPassword.equals(password)) {
            isValid = false;
            message = "Mat khau khong trung";
        }
        //ktra trung username
        boolean isExistUsername = UserDAO.isExistUsername(username);
        if (isExistUsername) {
            isValid = false;
            message = "Tai khoan da ton tai";
        }
        
        User user = new User(username,password);
        boolean isCreated = UserDAO.insertUser(user);
        if (!isCreated) {
            message = "Server error";
            isValid = false;
        }
        if (!isValid) {
            request.setAttribute("message", message);
            RequestDispatcher dis = request.getRequestDispatcher("register.jsp");
            dis.forward(request, response);
        } else {
            response.sendRedirect("./login");
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}

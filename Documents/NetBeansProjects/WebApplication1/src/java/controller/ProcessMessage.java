/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Message;
import model.User;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ProcessMessage", urlPatterns = {"/message"})
public class ProcessMessage extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                response.setContentType("text/html;charset=UTF-8");
                ArrayList<Message> messages = ProductDAO.getMessage();
                String json = new Gson().toJson(messages);

                response.addHeader("Access-Control-Allow-Origin", "*");
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         response.setContentType("text/html;charset=UTF-8");
         String message = (String) request.getParameter("message");
         HttpSession session = request.getSession();
        User userInfo = (User) session.getAttribute("user");
        if (userInfo == null) {
            response.sendRedirect("./login");
            return;
        }
        ProductDAO.createMessage(userInfo.getId(), message);
                String res = new Gson().toJson("Thanh cong");
                response.addHeader("Access-Control-Allow-Origin", "*");
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(res);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

//import dao.ProductDAO;
//import dao.SupplierDAO;
import dao.ProductDAO;
import dao.SupplierDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Product;
import model.Supplier;
import model.User;

/**
 *
 * @author User
 */
public class ProcessHomePage extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
//        HttpSession session = request.getSession();
//        User user = (User)session.getAttribute("user");
        String sortBy = (String)request.getParameter("sortBy");
        String order = (String)request.getParameter("order");
        String pageStr = (String)request.getParameter("page");
//        if (sortBy != null && sortBy.equals("sale_rate")) {
//            sortBy = "(compare_at_price - price) / compare_at_price";
//        }
        String supplierId = (String)request.getParameter("supplierId");
        String filter = "";
        if(supplierId != null){
            filter = "where supplier_id = " + supplierId;
        }
        int page;
        int count = ProductDAO.getTotalCounts(filter);
        int pageSize = 6;
        int totalPages = (int) Math.ceil(count*1.00/pageSize);
        try{
            page =Integer.parseInt(pageStr);
        } catch (Exception e) {
            page =1;
        }
        if (page==0||page>totalPages) {
            page=1;
        }
        ArrayList<Product> productList = ProductDAO.getProductList(sortBy, order, filter,page);
        ArrayList<Supplier> supplierList = SupplierDAO.getSupplierList();

        request.setAttribute("productList", productList);
        request.setAttribute("supplierList", supplierList);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        RequestDispatcher dis = request.getRequestDispatcher("home.jsp");
        dis.forward(request, response);
        
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

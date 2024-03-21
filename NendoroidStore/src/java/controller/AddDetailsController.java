/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.DAO;
import dto.Customer;
import dto.Order;
import dto.Product;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AddDetailsController", urlPatterns = {"/AddDetailsController"})
public class AddDetailsController extends HttpServlet {

    public static final String ERROR = "Cart.jsp";
    public static final String SUCCESS = "Order.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        Customer customer = (Customer) request.getSession().getAttribute("customer");
        try {
            DAO dao = new DAO();

            int productID = Integer.parseInt(request.getParameter("productID"));

            List<Order> listOrder = dao.getOrder();
            Order newOrder = null;
            for(int i = listOrder.size() - 1; i > 0 ; i--){
                if(listOrder.get(i).getCustomerID().equals(customer.getId())){
                    newOrder = listOrder.get(listOrder.size() - 1);
                }
            }
            Product product = dao.getProduct(productID);

            boolean checkCreate = dao.createOrderDetails(newOrder.getId(), productID, product.getPrice(), 1);
            if (!checkCreate) {
                request.setAttribute("alert", "Create failed!");
            } else {
                url = SUCCESS;
            }
        } catch (Exception e) {
            log("Error at SearchController: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
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
     *
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
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

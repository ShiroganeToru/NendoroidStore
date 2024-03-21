/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.DAO;
import dto.Admin;
import dto.Bank;
import dto.Customer;
import dto.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class LoginController extends HttpServlet {

    public static final String ADMIN_PAGE = "Management.jsp";
    public static final String USER_PAGE = "Home.jsp";
    public static final String ERROR = "Login.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;

        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            DAO dao = new DAO();
            User user = dao.checkLogin(username, password);
            
            if (user == null) {
                request.setAttribute("alert", "Incorrect username or password");
                url = ERROR;
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                if (user.getRole() == 0) {
                    url = ADMIN_PAGE;
                    Admin admin = dao.getAdmin(user.getId());
                    session.setAttribute("admin", admin);
                } else {
                    url = USER_PAGE;
                    Customer customer = dao.getCustomer(user.getId());
                    session.setAttribute("customer", customer);
                    Bank bank = dao.getBank(customer.getBankID());
                    session.setAttribute("bank", bank);
                }
            }
        } catch (Exception e) {
            log("Error at LoginController: " + e.toString());
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

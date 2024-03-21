/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
public class MainController extends HttpServlet {

    public static final String HOME_PAGE = "Home.jsp";
    public static final String LOGIN = "Login";
    public static final String LOGIN_CONTROLLER = "LoginController";
    public static final String LOGOUT = "Logout";
    public static final String LOGOUT_CONTROLLER = "LogoutController";
    public static final String UPDATE = "Update";
    public static final String UPDATE_CONTROLLER = "UpdateController";
    public static final String SAVE = "Save";
    public static final String SAVE_CONTROLLER = "SaveController";
    public static final String DELETE = "Delete";
    public static final String DELETE_CONTROLLER = "DeleteController";
    public static final String SEARCH = "Search";
    public static final String SEARCH_CONTROLLER = "SearchController"; 
    public static final String ADD_TO_CART = "AddToCart";
    public static final String ADD_TO_CART_CONTROLLER = "AddToCartController";
    public static final String REMOVE = "Remove";
    public static final String REMOVE_CONTROLLER = "RemoveController";
    public static final String CREATE = "Create";
    public static final String CREATE_CONTROLLER = "CreateController";
    public static final String ADD_INFO = "Add info";
    public static final String ADD_INFO_CONTROLLER = "CustomerController";
    public static final String UPDATE_INFO = "Update info";
    public static final String UPDATE_INFO_CONTROLLER = "UpdateInfoController";
    public static final String PAY = "Pay";
    public static final String PAY_CONTROLLER = "PayController";
    public static final String DEPOSIT = "Deposit";
    public static final String DEPOSIT_CONTROLLER = "DepositController";
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = HOME_PAGE;
        try {
            String action = request.getParameter("action");
            
            if(action == null){
                url = HOME_PAGE;
            } else if (action.equalsIgnoreCase(LOGIN)){
                url = LOGIN_CONTROLLER;
            } else if (action.equalsIgnoreCase(LOGOUT)){
                url = LOGOUT_CONTROLLER;
            } else if (action.equalsIgnoreCase(UPDATE)){
                url = UPDATE_CONTROLLER;
            } else if (action.equalsIgnoreCase(SAVE)){
                url = SAVE_CONTROLLER;
            } else if (action.equalsIgnoreCase(DELETE)){
                url = DELETE_CONTROLLER;
            } else if (action.equalsIgnoreCase(SEARCH)){
                url = SEARCH_CONTROLLER;
            } else if (action.equalsIgnoreCase(ADD_TO_CART)){
                url = ADD_TO_CART_CONTROLLER;
            } else if (action.equalsIgnoreCase(REMOVE)){
                url = REMOVE_CONTROLLER;
            } else if (action.equalsIgnoreCase(CREATE)){
                url = CREATE_CONTROLLER;
            } else if (action.equalsIgnoreCase(ADD_INFO)){
                url = ADD_INFO_CONTROLLER;
            } else if (action.equalsIgnoreCase(UPDATE_INFO)){
                url = UPDATE_INFO_CONTROLLER;
            } else if (action.equalsIgnoreCase(PAY)){
                url = PAY_CONTROLLER;
            } else if (action.equalsIgnoreCase(DEPOSIT)){
                url = DEPOSIT_CONTROLLER;
            }
        } catch (Exception e) {
            log("Error at MainController: " + e.toString());
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

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.Admin;
import dto.Bank;
import dto.Cart;
import dto.Customer;
import dto.Order;
import dto.OrderDetails;
import dto.Product;
import dto.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import utils.DBUtils;

/**
 *
 * @author Admin
 */
public class DAO extends DBUtils {

    Connection connection = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public User checkLogin(String username, String password) {
        String LOGIN = "SELECT id, username, password, role FROM tbl_User WHERE username = ? AND password = ?";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(LOGIN);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new User(
                        rs.getString("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getInt("role")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String generateUniqueId() {
        Random random = new Random();
        int randomNumber = random.nextInt(999) + 1;
        String newId = "C" + String.format("%03d", randomNumber);
        return newId;
    }

    public String generateUniqueCustomerId() {
        Random random = new Random();
        int randomNumber = random.nextInt(999) + 1;
        String newId = "N" + String.format("%03d", randomNumber);
        return newId;
    }

    public boolean isIdExist(String id) {
        String CHECK = "SELECT * FROM tbl_User WHERE id = ?";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(CHECK);
            ps.setString(1, id);
            rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean register(String username, String password) {
        String REGISTER = "INSERT INTO tbl_User VALUES (?, ?, ?, 1)";
        boolean checkRegister = false;
        String id = generateUniqueId();
        while (isIdExist(id)) {
            id = generateUniqueId();
        }
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(REGISTER);
            ps.setString(1, id);
            ps.setString(2, username);
            ps.setString(3, password);
            checkRegister = ps.executeUpdate() > 0 ? true : false;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return checkRegister;
    }

    public boolean customerInfo(String fullname, String avatar, String phone, String address, String userID) {
        String REGISTER = "INSERT tbl_Customer (id, fullname, avatar, phone, address, userID) VALUES (?, ?, ?, ?, ?, ?)";
        boolean checkRegister = false;
        String id = generateUniqueCustomerId();
        while (isIdExist(id)) {
            id = generateUniqueCustomerId();
        }
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(REGISTER);
            ps.setString(1, id);
            ps.setString(2, fullname);
            ps.setString(3, avatar);
            ps.setString(4, phone);
            ps.setString(5, address);
            ps.setString(6, userID);
            checkRegister = ps.executeUpdate() > 0 ? true : false;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return checkRegister;
    }

    public Product getProduct(int id) {
        String GET = "SELECT * FROM tbl_Product WHERE id = ?";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(GET);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getString("type"),
                        rs.getString("description"),
                        rs.getString("color"),
                        rs.getInt("quantity"),
                        rs.getFloat("price"),
                        rs.getString("open_day"),
                        rs.getString("closed_day"),
                        rs.getInt("isSale")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Customer getCustomer(String userID) throws SQLException {
        String GET = "SELECT * FROM tbl_Customer WHERE userID = ?";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(GET);
            ps.setString(1, userID);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Customer(
                        rs.getString("id"),
                        rs.getString("fullname"),
                        rs.getString("avatar"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("userID"),
                        rs.getString("bankID")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            connection.close();
            ps.close();
            rs.close();
        }
        return null;
    }

    public Bank getBank(String bankID) throws SQLException {
        String GET = "SELECT * FROM tbl_Bank WHERE id like ?";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(GET);
            ps.setString(1, bankID);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Bank(
                        rs.getString("id"),
                        rs.getString("bank_name"),
                        rs.getFloat("balance"),
                        rs.getString("username"),
                        rs.getString("password")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            connection.close();
            ps.close();
            rs.close();
        }
        return null;
    }

    public Admin getAdmin(String userID) {
        String ADMIN = "SELECT * FROM tbl_Admin WHERE userID LIKE ?";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(ADMIN);
            ps.setString(1, userID);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Admin(
                        rs.getString("id"),
                        rs.getString("fullname"),
                        rs.getString("avatar"),
                        rs.getString("userID")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Product> getListProduct() {
        String GET = "SELECT * FROM tbl_Product";
        List<Product> listProduct = new ArrayList<>();
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(GET);
            rs = ps.executeQuery();
            while (rs.next()) {
                listProduct.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getString("type"),
                        rs.getString("description"),
                        rs.getString("color"),
                        rs.getInt("quantity"),
                        rs.getFloat("price"),
                        rs.getString("open_day"),
                        rs.getString("closed_day"),
                        rs.getInt("isSale")
                ));
            }
            return listProduct;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Customer> getListCustomer() {
        String ALL = "SELECT * FROM tbl_Customer";
        List<Customer> listCustomer = new ArrayList<>();
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(ALL);
            rs = ps.executeQuery();
            while (rs.next()) {
                listCustomer.add(new Customer(
                        rs.getString("id"),
                        rs.getString("fullname"),
                        rs.getString("avatar"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("userID"),
                        rs.getString("bankID")
                ));
            }
            return listCustomer;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<User> getListUser() {
        String ALL = "SELECT * FROM tbl_User";
        List<User> listUser = new ArrayList<>();
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(ALL);
            rs = ps.executeQuery();
            while (rs.next()) {
                listUser.add(new User(
                        rs.getString("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getInt("role")
                ));
            }
            return listUser;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean insertProduct(Product product) {
        String INSERT = "INSERT tbl_Product VALUES (?,?,?,?,?,?,?,?,?,?,?)";
        boolean checkInsert = false;
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(INSERT);
            ps.setInt(1, product.getId());
            ps.setString(2, product.getName());
            ps.setString(3, product.getImage());
            ps.setString(4, product.getType());
            ps.setString(5, product.getDescription());
            ps.setString(6, product.getColor());
            ps.setInt(7, product.getQuantity());
            ps.setFloat(8, product.getPrice());
            ps.setString(9, product.getOpenDay());
            ps.setString(10, product.getClosedDay());
            ps.setInt(11, product.getIsSale());
            checkInsert = ps.executeUpdate() > 0 ? true : false;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return checkInsert;
    }

    public boolean updateProduct(Product product) {
        String UPDATE = "UPDATE tbl_Product SET name = ?, image = ?, type = ?, description = ?, color = ?, quantity = ?, price = ?, open_day = ?, closed_day = ?, isSale = ? WHERE id = ?";
        boolean checkUpdate = false;
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(UPDATE);

            ps.setString(1, product.getName());
            ps.setString(2, product.getImage());
            ps.setString(3, product.getType());
            ps.setString(4, product.getDescription());
            ps.setString(5, product.getColor());
            ps.setInt(6, product.getQuantity());
            ps.setFloat(7, product.getPrice());
            ps.setString(8, product.getOpenDay());
            ps.setString(9, product.getClosedDay());
            ps.setInt(10, product.getIsSale());
            ps.setInt(11, product.getId());
            checkUpdate = ps.executeUpdate() > 0 ? true : false;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return checkUpdate;
    }

    public boolean deleteProduct(int id) {
        String DELETE = "DELETE FROM tbl_Product WHERE id = ?";
        boolean checkDelete = false;
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(DELETE);
            ps.setInt(1, id);
            checkDelete = ps.executeUpdate() > 0 ? true : false;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return checkDelete;
    }

    public List<Product> getSearchList(String search) {
        String SEARCH = "SELECT * FROM tbl_Product WHERE name LIKE ?";
        List<Product> listProduct = new ArrayList<>();
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(SEARCH);
            ps.setString(1, '%' + search + '%');
            rs = ps.executeQuery();
            while (rs.next()) {
                listProduct.add(new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getString("type"),
                        rs.getString("description"),
                        rs.getString("color"),
                        rs.getInt("quantity"),
                        rs.getFloat("price"),
                        rs.getString("open_day"),
                        rs.getString("closed_day"),
                        rs.getInt("isSale")
                ));
            }
            return listProduct;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addToCart(String customerID, String productID) {
        String ADDTOCART = "INSERT INTO tbl_Cart(customerID, productID, quantity) VALUES (?, ?, 1)";
        boolean checkAddToCart = false;
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(ADDTOCART);
            ps.setString(1, customerID);
            ps.setString(2, productID);
            checkAddToCart = ps.executeUpdate() > 0 ? true : false;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return checkAddToCart;
    }

    public boolean removeCart(int cartID) {
        boolean checkRemove = false;
        String query = "DELETE FROM tbl_Cart WHERE cartID = ?";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(query);
            ps.setInt(1, cartID);
            checkRemove = ps.executeUpdate() > 0 ? true : false;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return checkRemove;
    }

    public List<Cart> getCart() {
        List<Cart> cartList = new ArrayList<>();
        String GET = "SELECT * FROM tbl_Cart";
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(GET);
            rs = ps.executeQuery();
            while (rs.next()) {
                cartList.add(new Cart(
                        rs.getInt("cartID"),
                        rs.getString("customerID"),
                        rs.getInt("productID"),
                        rs.getInt("quantity")
                ));
            }
            return cartList;
        } catch (Exception e) {
        }
        return null;
    }

    public boolean createOrder(String orderDate, String phone, String address, String customerID) {
        String CREATE = "INSERT INTO tbl_Order(orderDate, status, phone, address, customerID) VALUES (?, N'Not paid yet', ?, ?, ?)";
        boolean checkCreate = false;
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(CREATE);
            ps.setString(1, orderDate);
            ps.setString(2, phone);
            ps.setString(3, address);
            ps.setString(4, customerID);
            checkCreate = ps.executeUpdate() > 0 ? true : false;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return checkCreate;
    }

    public List<Order> getOrder() {
        String GET = "SELECT * FROM tbl_Order";
        List<Order> listOrder = new ArrayList<>();
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(GET);
            rs = ps.executeQuery();
            while (rs.next()) {
                listOrder.add(new Order(
                        rs.getInt("id"),
                        rs.getString("orderDate"),
                        rs.getString("status"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("customerID")
                ));
            }
            return listOrder;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<OrderDetails> getOrderDetails() {
        String GET = "SELECT * FROM tbl_OrderDetails";
        List<OrderDetails> listOrder = new ArrayList<>();
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(GET);
            rs = ps.executeQuery();
            while (rs.next()) {
                listOrder.add(new OrderDetails(
                        rs.getInt("id"),
                        rs.getInt("orderID"),
                        rs.getInt("productID"),
                        rs.getFloat("price"),
                        rs.getInt("quantity")
                ));
            }
            return listOrder;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean createOrderDetails(int orderID, int productID, float price, int quantity) {
        String CREATE = "INSERT INTO tbl_OrderDetails (orderID, productID, price, quantity) VALUES (?, ?, ?, ?)";
        boolean checkCreate = false;
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(CREATE);
            ps.setInt(1, orderID);
            ps.setInt(2, productID);
            ps.setFloat(3, price);
            ps.setInt(4, quantity);
            checkCreate = ps.executeUpdate() > 0 ? true : false;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return checkCreate;
    }

    public boolean updateInfo(String id, String name, String avatar, String phone, String address) {
        String UPDATE = "UPDATE tbl_Customer SET fullname = ?, avatar = ?, phone = ?, address = ? WHERE id LIKE ?";
        boolean checkUpdate = false;
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(UPDATE);
            ps.setString(1, name);
            ps.setString(2, avatar);
            ps.setString(3, phone);
            ps.setString(4, address);
            ps.setString(5, id);
            checkUpdate = ps.executeUpdate() > 0 ? true : false;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return checkUpdate;
    }

    public boolean buyProduct(float balance, String bankID) {
        String BALANCE = "UPDATE tbl_Bank SET balance = ? WHERE id LIKE ?";
        boolean checkUpdate = false;
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(BALANCE);
            ps.setFloat(1, balance);
            ps.setString(2, bankID);
            checkUpdate = ps.executeUpdate() > 0 ? true : false;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return checkUpdate;
    }

    public boolean updateStatus(int orderID) {
        String BALANCE = "UPDATE tbl_Order SET status = 'Payment Complete' WHERE id = ?";
        boolean checkUpdate = false;
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(BALANCE);
            ps.setInt(1, orderID);
            checkUpdate = ps.executeUpdate() > 0 ? true : false;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return checkUpdate;
    }

    public boolean depositBalance(float deposit, String id) {
        String DEPOSIT = "UPDATE tbl_Bank SET balance = ? WHERE id LIKE ?";
        boolean checkDeposit = false;
        try {
            connection = DBUtils.getConnection();
            ps = connection.prepareStatement(DEPOSIT);
            ps.setFloat(1, deposit);
            ps.setString(2, id);
            checkDeposit = ps.executeUpdate() > 0 ? true : false;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return checkDeposit;
    }
}

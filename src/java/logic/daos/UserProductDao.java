package logic.daos;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import logic.interfaces.GenericDao;
import logic.models.UserProductModel;
import persistence.interfaces.DataBase;
import persistence.mysql.ConexionBD;

public class UserProductDao implements GenericDao<UserProductModel, Integer> {

    private static DataBase connection;
    private static UserProductModel product;
    private static List<UserProductModel> products;
    private static UserProductDao instance;

    public UserProductDao() {
        UserProductDao.connection = ConexionBD.getInstance();
        UserProductDao.product = new UserProductModel();
        UserProductDao.products = new ArrayList();
    }

    public static UserProductDao getInstance() {
        if (instance == null) {
            instance = new UserProductDao();
        }
        return instance;
    }

    @Override
    public UserProductModel read(Integer id) {
        ResultSet data = (ResultSet) UserProductDao.connection.read(this.getReadQuery(id));
        try {
            if (data.next()) {
                product.setId(data.getInt("id"));
                product.setId_user(data.getInt("id_user"));
                product.setId_product(data.getInt("id_product"));
            }
            return product;
        } catch (SQLException ex) {
            Logger.getLogger(UserProductDao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    @Override
    public boolean create(UserProductModel model) {
        return UserProductDao.connection.create(getInsertQuery(model));
    }

    @Override
    public boolean update(UserProductModel model, Integer id) {
        return UserProductDao.connection.update(getUpdateQuery(model, id));
    }

    @Override
    public boolean delete(Integer id) {
        return UserProductDao.connection.delete(getDeleteQuery(id));
    }

    @Override
    public List<UserProductModel> readAll() {
        products.clear();
        try {
            ResultSet data = (ResultSet) UserProductDao.connection.read(this.getReadAllQuery());

            while (data.next()) {
                UserProductModel useProduct = new UserProductModel();
                useProduct.setId(data.getInt("id"));
                useProduct.setId_user(data.getInt("id_user"));
                useProduct.setId_product(data.getInt("id_product"));
                products.add(useProduct);
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserProductDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }

    public int getLast() {
        int id = 0;
        try {
            ResultSet data = (ResultSet) UserProductDao.connection.read(this.getLastId());
            while (data.next()) {

                id = data.getInt("id");
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserProductDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return id;
    }

    private String getReadQuery(int id) {
        return "SELECT * FROM product_user WHERE id = " + id + ";";
    }

    private String getInsertQuery(UserProductModel model) {
        int idProduct = getLast();
        return "INSERT INTO product_user (id_user, id_product) "
                + "VALUES("
                + "" + model.getId_user() + ", "
                + "" + idProduct + ""
                + ");";
    }

    private String getUpdateQuery(UserProductModel model, Integer id) {
        return "UPDATE product_user SET "
                + "id_user=" + model.getId_user() + ", "
                + "id_product=" + model.getId_product() + " "
                + "WHERE id=" + id + ";";
    }

    private String getDeleteQuery(Integer id) {
        return "DELETE FROM product_user WHERE id=" + id + ";";
    }

    private String getReadAllQuery() {
        return "SELECT * FROM product_user;";
    }

    private String getLastId() {
        return "SELECT MAX(id) AS id FROM product;";
    }

}

package logic.daos;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import logic.interfaces.GenericDao;
import logic.models.ProductCategoryModel;
import persistence.interfaces.DataBase;
import persistence.mysql.ConexionBD;

public class ProductCategoryDao implements GenericDao<ProductCategoryModel, Integer> {

    private static DataBase connection;
    private static ProductCategoryModel product;
    private static List<ProductCategoryModel> products;
    private static ProductCategoryDao instance;

    public ProductCategoryDao() {
        ProductCategoryDao.connection = ConexionBD.getInstance();
        ProductCategoryDao.product = new ProductCategoryModel();
        ProductCategoryDao.products = new ArrayList();
    }

    public static ProductCategoryDao getInstance() {
        if (instance == null) {
            instance = new ProductCategoryDao();
        }
        return instance;
    }

    @Override
    public ProductCategoryModel read(Integer id) {
        ResultSet data = (ResultSet) ProductCategoryDao.connection.read(this.getReadQuery(id));
        try {
            if (data.next()) {
                product.setId(data.getInt("id"));
                product.setId_category(data.getInt("id_category"));
                product.setId_product(data.getInt("id_product"));
            }
            return product;
        } catch (SQLException ex) {
            Logger.getLogger(ProductCategoryDao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    @Override
    public boolean create(ProductCategoryModel model) {
        return ProductCategoryDao.connection.create(getInsertQuery(model));
    }

    @Override
    public boolean update(ProductCategoryModel model, Integer id) {
        return ProductCategoryDao.connection.update(getUpdateQuery(model, id));
    }

    @Override
    public boolean delete(Integer id) {
        return ProductCategoryDao.connection.delete(getDeleteQuery(id));
    }

    @Override
    public List<ProductCategoryModel> readAll() {
        products.clear();
        try {
            ResultSet data = (ResultSet) ProductCategoryDao.connection.read(this.getReadAllQuery());

            while (data.next()) {
                ProductCategoryModel catProduct = new ProductCategoryModel();
                catProduct.setId(data.getInt("id"));
                catProduct.setId_category(data.getInt("id_category"));
                catProduct.setId_product(data.getInt("id_product"));
                products.add(catProduct);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ProductCategoryDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }

    public int getLast() {
        int id = 0;
        try {
            ResultSet data = (ResultSet) ProductCategoryDao.connection.read(this.getLastId());
            while (data.next()) {

                id = data.getInt("id");
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserProductDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return id;
    }

    private String getReadQuery(int id) {
        return "SELECT * FROM product_category WHERE id = " + id + ";";
    }

    private String getInsertQuery(ProductCategoryModel model) {
        int idProduct = getLast();
        return "INSERT INTO product_category (id_category, id_product) "
                + "VALUES("
                + "" + model.getId_category() + ", "
                + "" + idProduct+ ""
                + ");";
    }

    private String getUpdateQuery(ProductCategoryModel model, Integer id) {
        return "UPDATE product_category SET "
                + "id_category=" + model.getId_category() + ", "
                + "id_product=" + model.getId_product() + " "
                + "WHERE id=" + id + ";";
    }

    private String getDeleteQuery(Integer id) {
        return "DELETE FROM product_category WHERE id=" + id + ";";
    }

    private String getReadAllQuery() {
        return "SELECT * FROM product_category;";
    }

    private String getLastId() {
        return "SELECT MAX(id) AS id FROM product;";
    }

}

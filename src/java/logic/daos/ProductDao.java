package logic.daos;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import logic.interfaces.GenericDao;
import logic.models.ProductModel;
import persistence.interfaces.DataBase;
import persistence.mysql.ConexionBD;

public class ProductDao implements GenericDao<ProductModel, String> {
    
    private static DataBase connection;
    private static ProductModel product;
    private static List<ProductModel> products;
    private static ProductDao instance;
    
    public ProductDao() {
        ProductDao.connection = ConexionBD.getInstance();
        ProductDao.product = new ProductModel();
        ProductDao.products = new ArrayList();
    }
    
    public static ProductDao getInstance() {
        if (instance == null) {
            instance = new ProductDao();
        }
        return instance;
    }
    
    @Override
    public ProductModel read(String id) {
        ResultSet data = (ResultSet) ProductDao.connection.read(this.getReadQuery(id));
        try {
            if (data.next()) {
                product = new ProductModel();
                product.setId(Integer.parseInt(data.getString("id")));
                product.setName(data.getString("name"));
                product.setDescription(data.getString("description"));
                product.setPrice(data.getString("price"));
                product.setImageUrl(data.getString("image_url"));
            }
            return product;
        } catch (SQLException ex) {
            Logger.getLogger(ProductModel.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
    @Override
    public boolean create(ProductModel model) {
        return ProductDao.connection.create(getInsertQuery(model));
    }
    
    @Override
    public boolean update(ProductModel model, String id) {
        return ProductDao.connection.update(getUpdateQuery(model, id));
    }
    
    @Override
    public boolean delete(String id) {
        return ProductDao.connection.delete(getDeleteQuery(id));
    }
    
    @Override
    public List<ProductModel> readAll() {
        products.clear();
        try {
            ResultSet data = (ResultSet) ProductDao.connection.read(this.getReadAllQuery());
            
            while (data.next()) {
                ProductModel p = new ProductModel();
                p.setId(Integer.parseInt(data.getString("id")));
                p.setName(data.getString("name"));
                p.setDescription(data.getString("description"));
                p.setPrice(data.getString("price"));
                p.setImageUrl(data.getString("image_url"));
                products.add(p);
            }
            Collections.shuffle(products);
            
        } catch (SQLException ex) {
            Logger.getLogger(ProductDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }
    

    public List<ProductModel> readAllByUserId(String id) {
        products.clear();
        try {
            ResultSet data = (ResultSet) ProductDao.connection.read(this.getReadByUserIdQuery(id));
            
            while (data.next()) {
                ProductModel p = new ProductModel();
                p.setId(Integer.parseInt(data.getString("id")));
                p.setName(data.getString("name"));
                p.setDescription(data.getString("description"));
                p.setPrice(data.getString("price"));
                p.setImageUrl(data.getString("image_url"));
                products.add(p);
            }
            Collections.shuffle(products);
            
        } catch (SQLException ex) {
            Logger.getLogger(ProductDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }
    
    public List<ProductModel> readAllByCategoryId(String id) {
        products.clear();
        try {
            ResultSet data = (ResultSet) ProductDao.connection.read(this.getReadByCategoryIdQuery(id));
            
            while (data.next()) {
                ProductModel p = new ProductModel();
                p.setId(Integer.parseInt(data.getString("id")));
                p.setName(data.getString("name"));
                p.setDescription(data.getString("description"));
                p.setPrice(data.getString("price"));
                p.setImageUrl(data.getString("image_url"));
                products.add(p);
            }
            Collections.shuffle(products);
            
        } catch (SQLException ex) {
            Logger.getLogger(ProductDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return products;
    }
    
    private String getReadQuery(String id) {
        return "SELECT * FROM product WHERE id = " + id + ";";
    }
    
    private String getInsertQuery(ProductModel product) {
        return "INSERT INTO product (name, description, price, image_url) "
                + "VALUES("
                + "'" + product.getName() + "',"
                + "'" + product.getDescription() + "',"
                + "'" + product.getPrice() + "',"
                + "'" + product.getImageUrl() + "');";
    }
    
    private String getUpdateQuery(ProductModel product, String id) {
        return "UPDATE product "
                + "SET "
                + "name='" + product.getName() + "', "
                + "description='" + product.getDescription() + "', "
                + "price='" + product.getPrice() + "', "
                + "image_url='" + product.getImageUrl() + "' "
                + "WHERE id=" + id + ";";
    }
    
    private String getDeleteQuery(String id) {
        return "DELETE FROM product WHERE id=" + id + ";";
    }
    
    private String getReadAllQuery() {
        return "SELECT * FROM product;";
    }
    
     private String getReadByUserIdQuery(String id) {
        return "SELECT * FROM product p INNER JOIN product_user up ON p.id = up.id_product where up.id_user = "+id+";";
    }
     private String getReadByCategoryIdQuery(String id) {
        return "SELECT * FROM product p INNER JOIN product_category up ON p.id = up.id_product where up.id_category = "+id+";";
    }

}

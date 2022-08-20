package logic.daos;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import logic.interfaces.GenericDao;
import logic.models.CategoryModel;
import persistence.interfaces.DataBase;
import persistence.mysql.ConexionBD;

public class CategoryDao implements GenericDao<CategoryModel, String> {

    private static DataBase connection;
    private static CategoryModel category;
    private static List<CategoryModel> categories;
    private static CategoryDao instance;

    public CategoryDao() {
        CategoryDao.connection = ConexionBD.getInstance();
        CategoryDao.category = new CategoryModel();
        CategoryDao.categories = new ArrayList();
    }

    public static CategoryDao getInstance() {
        if (instance == null) {
            instance = new CategoryDao();
        }
        return instance;
    }

    @Override
    public CategoryModel read(String idModel) {
        ResultSet data = (ResultSet) CategoryDao.connection.read(this.getReadQuery(idModel));
        try {
            if (data.next()) {
                category.setName(data.getString("name"));
                category.setId(data.getInt("id"));
            }
            return category;
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }

    }

    @Override
    public boolean create(CategoryModel model) {
        return CategoryDao.connection.create(getInsertQuery(model));
    }

    @Override
    public boolean update(CategoryModel model, String idModel) {
        return CategoryDao.connection.update(getUpdateQuery(model, idModel));
    }

    @Override
    public boolean delete(String idModel) {
        return CategoryDao.connection.delete(getDeleteQuery(idModel));
    }

    @Override
    public List<CategoryModel> readAll() {
        categories.clear();
        try {
            ResultSet data = (ResultSet) CategoryDao.connection.read(this.getReadAllQuery());

            while (data.next()) {
                categories.add(new CategoryModel(data.getInt("id"), data.getString("name")));
            }

        } catch (SQLException ex) {
            Logger.getLogger(CategoryDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return categories;
    }

    private String getReadQuery(String id) {
        return "SELECT * FROM category WHERE id = " + id + ";";
    }

    private String getInsertQuery(CategoryModel model) {
        return "INSERT INTO category(name)VALUES('" + model.getName() + "');";
    }

    private String getUpdateQuery(CategoryModel model, String id) {
        return "UPDATE category SET name= '" + model.getName() + "' WHERE id=" + id + ";";
    }

    private String getDeleteQuery(String id) {
        return "DELETE FROM category WHERE id=" + id + ";";
    }

    private String getReadAllQuery() {
        return "SELECT * FROM category;";
    }

}

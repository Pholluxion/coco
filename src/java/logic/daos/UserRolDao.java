package logic.daos;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import logic.interfaces.GenericDao;
import logic.models.UserRolModel;
import persistence.interfaces.DataBase;
import persistence.mysql.ConexionBD;

public class UserRolDao implements GenericDao<UserRolModel, Integer> {

    private static DataBase connection;
    private static UserRolModel userRol;
    private static List<UserRolModel> userRols;
    private static UserRolDao instance;

    public UserRolDao() {

        UserRolDao.connection = ConexionBD.getInstance();
        UserRolDao.userRol = new UserRolModel();
        UserRolDao.userRols = new ArrayList();

    }

    public static UserRolDao getInstance() {
        if (instance == null) {
            instance = new UserRolDao();
        }
        return instance;
    }

    @Override
    public UserRolModel read(Integer idModel) {
        ResultSet data = (ResultSet) UserRolDao.connection.read(this.getReadQuery(idModel));
        try {
            if (data.next()) {
                userRol.setName(data.getString("name"));
                userRol.setId(data.getInt("id"));
            }
            return userRol;
        } catch (SQLException ex) {
            Logger.getLogger(UserRolDao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }

    }

    @Override
    public boolean create(UserRolModel model) {
        return UserRolDao.connection.create(getInsertQuery(model));
    }

    @Override
    public boolean update(UserRolModel model, Integer idModel) {
        return UserRolDao.connection.update(getUpdateQuery(model, idModel));
    }

    @Override
    public boolean delete(Integer idModel) {
        return UserRolDao.connection.delete(getDeleteQuery(idModel));
    }

    @Override
    public List<UserRolModel> readAll() {
        try {
            ResultSet data = (ResultSet) UserRolDao.connection.read(this.getReadAllQuery());

            while (data.next()) {
                userRols.add(new UserRolModel(data.getInt("id"), data.getString("name")));
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserRolDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return userRols;
    }

    private String getReadQuery(int userRolId) {
        return "SELECT * FROM user_rol WHERE id = " + userRolId + ";";
    }

    private String getInsertQuery(UserRolModel userRol) {
        return "INSERT INTO user_rol(name)VALUES('" + userRol.getName() + "');";
    }

    private String getUpdateQuery(UserRolModel userRol, Integer idModel) {
        return "UPDATE user_rol SET name= '" + userRol.getName() + "' WHERE id=" + idModel + ";";
    }

    private String getDeleteQuery(Integer idModel) {
        return "DELETE FROM user_rol WHERE id=" + idModel + ";";
    }

    private String getReadAllQuery() {
        return "SELECT * FROM user_rol;";
    }
}

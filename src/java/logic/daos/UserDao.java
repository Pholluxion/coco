package logic.daos;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import logic.interfaces.GenericDao;
import logic.models.UserModel;
import persistence.interfaces.DataBase;
import persistence.mysql.ConexionBD;

public class UserDao implements GenericDao<UserModel, Long> {

    private static DataBase connection;
    private static UserModel user;
    private static List<UserModel> users;
    private static UserDao instance;

    public UserDao() {

        UserDao.connection = ConexionBD.getInstance();
        UserDao.user = new UserModel();
        UserDao.users = new ArrayList();

    }

    public static UserDao getInstance() {
        if (instance == null) {
            instance = new UserDao();
        }
        return instance;
    }

    @Override
    public UserModel read(Long idModel) {
        ResultSet data = (ResultSet) UserDao.connection.read(this.getReadQuery(idModel));
        try {
            if (data.next()) {
                user = new UserModel();
                user.setId(data.getLong("id"));
                user.setName(data.getString("name"));
                user.setEmail(data.getString("email"));
                user.setPassword(data.getString("password"));
                user.setDocument(data.getString("document"));
                user.setPhoneNumber(data.getString("phone_number"));
                user.setDocType(data.getInt("doc_type"));
                user.setUserRol(data.getInt("rol"));
            }
            return user;
        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }

    }

    @Override
    public boolean create(UserModel model) {
        return UserDao.connection.create(getInsertQuery(model));
    }

    @Override
    public boolean update(UserModel model, Long idModel) {
        return UserDao.connection.update(getUpdateQuery(model, idModel));
    }

    @Override
    public boolean delete(Long idModel) {
        return UserDao.connection.delete(getDeleteQuery(idModel));
    }

    @Override
    public List<UserModel> readAll() {
        users.clear();
        try {
            ResultSet data = (ResultSet) UserDao.connection.read(this.getReadAllQuery());

            while (data.next()) {
                user = new UserModel();
                user.setId(data.getLong("id"));
                user.setName(data.getString("name"));
                user.setEmail(data.getString("email"));
                user.setPassword(data.getString("password"));
                user.setDocument(data.getString("document"));
                user.setPhoneNumber(data.getString("phone_number"));
                user.setDocType(data.getInt("doc_type"));
                user.setUserRol(data.getInt("rol"));
                users.add(user);
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return users;
    }

    private String getReadQuery(Long userId) {
        return "SELECT * FROM user WHERE id = " + userId + ";";
    }

    private String getInsertQuery(UserModel user) {
        return "INSERT INTO user (name, email, password, doc_type, document, phone_number, rol) "
                + "VALUES('"
                + user.getName() + "', '"
                + user.getEmail() + "', '"
                + user.getPassword() + "', "
                + user.getDocType() + ", '"
                + user.getDocument() + "', '"
                + user.getPhoneNumber() + "', "
                + user.getUserRol() + ");";
    }

    private String getUpdateQuery(UserModel user, Long idModel) {
        return "UPDATE user SET name='" + user.getName()
                + "', email='" + user.getEmail()
                + "', password='" + user.getPassword()
                + "', doc_type=" + user.getDocType()
                + ", document='" + user.getDocument()
                + "', phone_number='" + user.getPhoneNumber()
                + "', rol=" + user.getUserRol()
                + " WHERE id=" + idModel + ";";
    }

    private String getDeleteQuery(Long idModel) {
        return "DELETE FROM user WHERE id=" + idModel + ";";
    }

    private String getReadAllQuery() {
        return "SELECT * FROM user;";
    }

}

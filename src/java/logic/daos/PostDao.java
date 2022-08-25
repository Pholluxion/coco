package logic.daos;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import logic.interfaces.GenericDao;
import logic.models.PostModel;
import persistence.interfaces.DataBase;
import persistence.mysql.ConexionBD;

public class PostDao implements GenericDao<PostModel, String> {

    private static DataBase connection;
    private static PostModel post;
    private static List<PostModel> posts;
    private static PostDao instance;

    public PostDao() {
        PostDao.connection = ConexionBD.getInstance();
        PostDao.post = new PostModel();
        PostDao.posts = new ArrayList();
    }

    public static PostDao getInstance() {
        if (instance == null) {
            instance = new PostDao();
        }
        return instance;
    }

    @Override
    public PostModel read(String idModel) {
        ResultSet data = (ResultSet) PostDao.connection.read(this.getReadQuery(idModel));
        try {
            if (data.next()) {
                post.setId(data.getString("id"));
                post.setMessage(data.getString("message"));
                post.setDate(data.getString("date"));
                post.setUser(data.getString("id_user"));
                post.setTopic(data.getString("id_topic"));
            }
            return post;
        } catch (SQLException ex) {
            Logger.getLogger(PostDao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    @Override
    public boolean create(PostModel model) {
        return PostDao.connection.create(getInsertQuery(model));
    }

    @Override
    public boolean update(PostModel model, String idModel) {
        return PostDao.connection.update(getUpdateQuery(model, idModel));
    }

    @Override
    public boolean delete(String idModel) {
        return PostDao.connection.delete(getDeleteQuery(idModel));
    }

    @Override
    public List<PostModel> readAll() {
        posts.clear();
        try {
            ResultSet data = (ResultSet) PostDao.connection.read(this.getReadAllQuery());

            while (data.next()) {
                PostModel post = new PostModel();
                post.setId(data.getString("id"));
                post.setMessage(data.getString("message"));
                post.setDate(data.getString("date"));
                post.setUser(data.getString("id_user"));
                post.setTopic(data.getString("id_topic"));
                posts.add(post);
            }

        } catch (SQLException ex) {
            Logger.getLogger(PostDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return posts;
    }

    private String getReadQuery(String id) {
        return "SELECT * FROM post WHERE id = " + id + ";";
    }

    private String getInsertQuery(PostModel model) {
        return "INSERT INTO post (message, `date`, id_user, id_topic) "
                + "VALUES("
                + "'" + model.getMessage() + "', "
                + "'" + model.getDate() + "', "
                + "" + model.getUser() + ", "
                + "" + model.getTopic() + ""
                + ");";
    }

    private String getUpdateQuery(PostModel model, String id) {
        return "UPDATE post SET "
                + "message='" + model.getMessage() + "', "
                + "`date`='" + model.getDate() + "', "
                + "id_user=" + model.getUser() + ", "
                + "id_topic=" + model.getTopic() + " "
                + "WHERE id=" + id + ";";
    }

    private String getDeleteQuery(String id) {
        return "DELETE FROM post WHERE id=" + id + ";";
    }

    private String getReadAllQuery() {
        return "SELECT * FROM post;";
    }

}

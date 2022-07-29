package logic.daos;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import logic.interfaces.GenericDao;
import logic.models.DocTypeModel;
import persistence.interfaces.DataBase;
import persistence.mysql.ConexionBD;

public class DocTypeDao implements GenericDao<DocTypeModel, Integer> {

    private static DataBase connection;
    private static DocTypeModel docType;
    private static List<DocTypeModel> docsType;
    private static DocTypeDao instance;

    public DocTypeDao() {

        DocTypeDao.connection = ConexionBD.getInstance();
        DocTypeDao.docType = new DocTypeModel();
        DocTypeDao.docsType = new ArrayList();

    }

    public static DocTypeDao getInstance() {
        if (instance == null) {
            instance = new DocTypeDao();
        }
        return instance;
    }

    @Override
    public DocTypeModel read(Integer idModel) {
        ResultSet data = (ResultSet) DocTypeDao.connection.read(this.getReadQuery(idModel));
        try {
            if (data.next()) {
                docType.setName(data.getString("name"));
                docType.setId(data.getInt("id"));
            }
            return docType;
        } catch (SQLException ex) {
            Logger.getLogger(DocTypeDao.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }

    }

    @Override
    public boolean create(DocTypeModel model) {
        return DocTypeDao.connection.create(getInsertQuery(model));
    }

    @Override
    public boolean update(DocTypeModel model, Integer idModel) {
        return DocTypeDao.connection.update(getUpdateQuery(model, idModel));
    }

    @Override
    public boolean delete(Integer idModel) {
        return DocTypeDao.connection.delete(getDeleteQuery(idModel));
    }

    @Override
    public List<DocTypeModel> readAll() {
        docsType.clear();
        try {
            ResultSet data = (ResultSet) DocTypeDao.connection.read(this.getReadAllQuery());

            while (data.next()) {
                docsType.add(new DocTypeModel(data.getInt("id"), data.getString("name")));
            }

        } catch (SQLException ex) {
            Logger.getLogger(DocTypeDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return docsType;
    }

    private String getReadQuery(int id) {
        return "SELECT * FROM document WHERE id = " + id + ";";
    }

    private String getInsertQuery(DocTypeModel docType) {
        return "INSERT INTO document(name)VALUES('" + docType.getName() + "');";
    }

    private String getUpdateQuery(DocTypeModel docType, Integer id) {
        return "UPDATE document SET name= '" + docType.getName() + "' WHERE id=" + id + ";";
    }

    private String getDeleteQuery(Integer id) {
        return "DELETE FROM document WHERE id=" + id + ";";
    }

    private String getReadAllQuery() {
        return "SELECT * FROM document;";
    }

}

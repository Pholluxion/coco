package persistence.mysql;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import persistence.interfaces.DataBase;

public class ConexionBD implements DataBase<Object> {

    private static ConexionBD instance;

    // Configuracion de la conexion a la base de datos 
    private String DB_driver = "";
    private String url = "";
    private String db = "";
    private String host = "";
    private String username = "";
    private String password = "";
    public Connection con = null;
    private Statement stmt = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;
    private boolean local;

    public static ConexionBD getInstance() {
        if (instance == null) {
            instance = new ConexionBD();
        }
        return instance;
    }

    //Constructor sin parmetros		
    private ConexionBD() {
        DB_driver = "com.mysql.cj.jdbc.Driver";
        host = "localhost:3306";
        db = "coco";
        url = "jdbc:mysql://" + host + "/" + db + "?serverTimezone=UTC"; 		//URL DB
        username = "root";                      			//usuario base de datos global 
        password = "G1a9b9y8";
        try {
            //Asignacin del Driver
            Class.forName(DB_driver);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            // Realizar la conexion
            con = DriverManager.getConnection(url, username, password);
            con.setTransactionIsolation(8);
            System.out.println("conectado");
        } catch (SQLException ex) {
            Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null, ex);
        }
        // Realizar la conexin
    }

    //Retornar la conexin
    public Connection getConnection() {
        return con;
    }

    //Cerrar la conexin
    public void closeConnection(Connection con) {
        if (con != null) {
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public boolean setAutoCommitBD(boolean parametro) {
        try {
            con.setAutoCommit(parametro);
        } catch (SQLException sqlex) {
            System.out.println("Error al configurar el autoCommit " + sqlex.getMessage());
            return false;
        }
        return true;
    }

    public void cerrarConexion() {
        closeConnection(con);
        System.out.println("Cerrado");
    }

    public boolean commitBD() {
        try {
            con.commit();
            return true;
        } catch (SQLException sqlex) {
            System.out.println("Error al hacer commit " + sqlex.getMessage());
            return false;
        }
    }

    public boolean rollbackBD() {
        try {
            con.rollback();
            return true;
        } catch (SQLException sqlex) {
            System.out.println("Error al hacer rollback " + sqlex.getMessage());
            return false;
        }
    }

    @Override
    public Object read(String data) {

        try {
            this.setAutoCommitBD(false);
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            rs = stmt.executeQuery(data);
            this.commitBD();
        } catch (SQLException sqlex) {
            this.rollbackBD();
            Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null, sqlex);
        } catch (RuntimeException rex) {
            this.rollbackBD();
            Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null, rex);
            this.rollbackBD();
        } catch (Exception ex) {
            this.rollbackBD();
            Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs;
    }

    @Override
    public boolean create(String data) {

        try {
            this.setAutoCommitBD(false);
            stmt = con.createStatement();
            stmt.execute(data);
            this.commitBD();
            return true;
        } catch (SQLException | RuntimeException sqlex) {
            this.rollbackBD();
            Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null, sqlex);
            return false;
        }

    }

    @Override
    public boolean update(String data) {

        try {
            this.setAutoCommitBD(false);
            stmt = con.createStatement();
            stmt.executeUpdate(data);
            this.commitBD();
            return true;
        } catch (SQLException | RuntimeException sqlex) {
            this.rollbackBD();
            Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null, sqlex);
            return false;
        }

    }

    @Override
    public boolean delete(String data) {

        try {
            this.setAutoCommitBD(false);
            stmt = con.createStatement();
            stmt.execute(data);
            this.commitBD();
            return true;
        } catch (SQLException | RuntimeException sqlex) {
            this.rollbackBD();
            Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null, sqlex);
            return false;
        }

    }

}

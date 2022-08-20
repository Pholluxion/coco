package logic.models;

public class UserProductModel {

    private int id;
    private int id_user;
    private int id_product;

    public UserProductModel() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_user() {
        return id_user;
    }

    public void setId_user(int id_user) {
        this.id_user = id_user;
    }

    public int getId_product() {
        return id_product;
    }

    public void setId_product(int id_product) {
        this.id_product = id_product;
    }

    @Override
    public String toString() {
        return "UserProduct{" + "id=" + id + ", id_user=" + id_user + ", id_product=" + id_product + '}';
    }

}

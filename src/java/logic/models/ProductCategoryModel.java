package logic.models;

public class ProductCategoryModel {

    private int id;
    private int id_product;
    private int id_category;

    public ProductCategoryModel() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_product() {
        return id_product;
    }

    public void setId_product(int id_product) {
        this.id_product = id_product;
    }

    public int getId_category() {
        return id_category;
    }

    public void setId_category(int id_category) {
        this.id_category = id_category;
    }

    @Override
    public String toString() {
        return "ProductCategoryModel{" + "id=" + id + ", id_product=" + id_product + ", id_category=" + id_category + '}';
    }

}

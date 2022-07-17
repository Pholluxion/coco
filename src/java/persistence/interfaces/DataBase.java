package persistence.interfaces;

public interface DataBase<T> {

    public T read(String data);

    public boolean create(String data);

    public boolean update(String data);

    public boolean delete(String data);


}

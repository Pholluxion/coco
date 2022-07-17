package logic.interfaces;

import java.util.List;

public interface GenericDao<T, V> {

    public T read(V idModel);

    public boolean create(T model);

    public boolean update(T model, V idModel);

    public boolean delete(V idModel);

    public List<T> readAll();
}

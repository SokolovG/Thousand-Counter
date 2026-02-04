import 'package:thousand_counter/models/base_model.dart';

abstract class AbstractRepository<T extends Entity> {
  Future<List<T>> getAll();
  Future<void> add(T entity);
  Future<void> delete(String id);
  Future<T?> get(String id);
  Future update(T entity);
}

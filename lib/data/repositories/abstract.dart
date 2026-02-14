import 'package:thousand_counter/models/base_model.dart';

abstract class AbstractRepository<T extends Entity> {
  Stream<List<T>> getAll();
  Stream<T?> get(String id);
  Future<void> add(T entity);
  Future<void> delete(String id);
  Future update(T entity);
}

import 'package:domain/entities/base_entity.dart';

abstract class BaseModel implements BaseMapper {}

abstract class BaseMapper<T, E extends BaseEntity> {
  T mapToModel(E entity);
}

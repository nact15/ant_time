import 'package:domain/domain.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'value_model.g.dart';

@HiveType(typeId: 1)
class ValueModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String? value;

  ValueModel({
    required this.id,
    required this.name,
    this.value,
  });

  factory ValueModel.mapToModel(ValueEntity entity) {
    return ValueModel(
      id: entity.id,
      name: entity.name,
      value: entity.value,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ValueModel && id == other.id;

  @override
  int get hashCode => id;
}

import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveUseCase<T extends HiveObject> {
  Future<void> clearBox();

  T? getValue();

  Future<void> updateBox(T value);
}

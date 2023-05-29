import 'package:ant_time_flutter/models/value_model.dart';
import 'package:ant_time_flutter/usecases/hive_usecase.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DefaultActivityUseCase implements HiveUseCase<ValueModel> {
  final Box<ValueModel> box;

  DefaultActivityUseCase({required this.box});

  @override
  Future<void> clearBox() async {
    await box.clear();
  }

  @override
  ValueModel? getValue() {
    if (box.values.isNotEmpty) {
      return box.values.first;
    }

    return null;
  }

  @override
  Future<void> updateBox(ValueModel value) async {
    if (box.values.isNotEmpty) {
      await box.putAt(0, value);
    } else {
      await box.add(value);
    }
  }
}

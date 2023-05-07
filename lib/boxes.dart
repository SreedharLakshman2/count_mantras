import 'package:hive/hive.dart';
import './count_info_model.dart';

class Boxes {
  static Box<CounterInfo> getCounterInfo() =>
      Hive.box<CounterInfo>('CounterInfo');
}

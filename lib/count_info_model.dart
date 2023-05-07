import 'package:hive/hive.dart';
part 'count_info_model.g.dart';

@HiveType(typeId: 0)
class CounterInfo extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late DateTime createdDate;

  @HiveField(2)
  late int count;
}

import 'package:children_rewards/core/database/app_database.dart';

class PointRecordDetail {
  final PointRecord record;
  final String? ruleIcon;

  PointRecordDetail({
    required this.record,
    this.ruleIcon,
  });
}

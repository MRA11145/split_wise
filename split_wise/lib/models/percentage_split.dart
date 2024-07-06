import 'package:split_wise/models/split.dart';
import 'package:split_wise/models/user.dart';

class PercentageSplit extends Split{
  late double _percentage;

  PercentageSplit(User user, double percentage) : super(user, 0) {
    _percentage = percentage;
  }

  double getPercentage() {
    return _percentage;
  }
}
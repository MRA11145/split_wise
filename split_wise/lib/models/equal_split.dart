import 'package:split_wise/models/split.dart';
import 'package:split_wise/models/user.dart';

class EqualSplit extends Split{
  EqualSplit(User user, double amount) : super(user, amount) {
  }
}
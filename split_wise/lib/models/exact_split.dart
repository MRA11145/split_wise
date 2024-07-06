import 'package:split_wise/models/split.dart';
import 'package:split_wise/models/user.dart';

class ExactSplit extends Split{
  ExactSplit(User user, double amount) :super(user, amount) {
    amount = amount;
  }

}
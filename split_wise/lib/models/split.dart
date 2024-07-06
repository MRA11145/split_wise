import 'package:split_wise/models/user.dart';

class Split {
  late User _user;
  late double _amount;

  Split(User user, double amount) {
    _user = user;
    _amount  = amount;
  }

  User getUser() {
    return _user;
  }

  void setAmount(double amount) {
    _amount = amount;
  }

  double getAmount() {
    return _amount;
  }

}
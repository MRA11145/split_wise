import 'package:split_wise/models/expense_meta_data.dart';
import 'package:split_wise/models/split.dart';
import 'package:split_wise/models/user.dart';

class Expense{
  late String _id;
  late double _amount;
  late User _paidBy;
  late List<Split> _splits;
  late ExpenseMetaData _metaData;

  Expense(double amount, User paidBy, List<Split> splits, ExpenseMetaData metaData) {
    _amount = amount;
    _paidBy = paidBy;
    _splits = splits;
    _metaData = metaData;
  }

  String getId() {
    return _id;
  }

  double getAmount() {
    return _amount;
  }

  User getPaidBy() {
    return _paidBy;
  }

  List<Split> getSplits() {
    return _splits;
  }

  ExpenseMetaData getMetadata() {
    return _metaData;
  }

  //  abstract boolean validate();
}

import 'package:split_wise/models/equal_split.dart';
import 'package:split_wise/models/expense.dart';
import 'package:split_wise/models/expense_meta_data.dart';
import 'package:split_wise/models/split.dart';
import 'package:split_wise/models/user.dart';
import 'package:split_wise/models/validate.dart';

class EqualExpense extends Expense implements Validate {
  EqualExpense(double amount, User paidBy, List<Split> splits, ExpenseMetaData expenseMetaData) :super(amount, paidBy, splits, expenseMetaData) {
    
  }
  
  @override
  bool validate() {
    for (final split in getSplits()) {
      if (split is! EqualSplit) {
        return false;
      }
    }
   return true;
  }


}
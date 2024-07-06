import 'package:split_wise/models/exact_split.dart';
import 'package:split_wise/models/expense.dart';
import 'package:split_wise/models/expense_meta_data.dart';
import 'package:split_wise/models/split.dart';
import 'package:split_wise/models/user.dart';
import 'package:split_wise/models/validate.dart';

class ExactExpense extends Expense implements Validate {
  ExactExpense(double amount, User paidBy, List<Split> splits, ExpenseMetaData expenseMetaData) : super(amount, paidBy, splits, expenseMetaData);

  @override
  bool validate() {
    for (final split in getSplits()) {
      if (split is! ExactSplit) {
        return false;
      }
    }

    double totalAmount = getAmount();
    double sumSplitAmount = 0;

    for (final split in getSplits()) {
      sumSplitAmount += split.getAmount();
    }

    if (totalAmount != sumSplitAmount) {
      return false;
    }

    return true;
  }
}

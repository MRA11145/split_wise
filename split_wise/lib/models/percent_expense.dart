import 'package:split_wise/models/expense.dart';
import 'package:split_wise/models/expense_meta_data.dart';
import 'package:split_wise/models/percentage_split.dart';
import 'package:split_wise/models/split.dart';
import 'package:split_wise/models/user.dart';
import 'package:split_wise/models/validate.dart';

class PercentExpense extends Expense implements Validate {
  PercentExpense(double amount, User paidBy, List<Split>split, ExpenseMetaData expenseMetaData) : super(amount, paidBy, split, expenseMetaData);
  
  @override
  bool validate() {
    for (final split in getSplits()) {
            if (split is! PercentageSplit) {
                return false;
            }
        }

        double totalPercent = 100;
        double sumSplitPercent = 0;
        for (final split in getSplits()) {
            PercentageSplit exactSplit = split as PercentageSplit;
            sumSplitPercent += exactSplit.getPercentage();
        }

        if (totalPercent != sumSplitPercent) {
            return false;
        }

    return true;
  }
}
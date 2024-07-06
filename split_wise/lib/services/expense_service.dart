import 'package:split_wise/models/equal_expense.dart';
import 'package:split_wise/models/exact_expense.dart';
import 'package:split_wise/models/expense.dart';
import 'package:split_wise/models/expense_meta_data.dart';
import 'package:split_wise/models/expense_type.dart';
import 'package:split_wise/models/percent_expense.dart';
import 'package:split_wise/models/percentage_split.dart';
import 'package:split_wise/models/split.dart';
import 'package:split_wise/models/user.dart';

class ExpenseService {
  static Expense? createExpense(ExpenseType expenseType, double amount, User paidBy, List<Split> splits, ExpenseMetaData expenseMetaData) {
    switch (expenseType) {
      case ExpenseType.EXACT:
        return ExactExpense(amount, paidBy, splits, expenseMetaData);
      
      case ExpenseType.EQUAL:
        int totalSplits = splits.length;
        print("Total split is $totalSplits");
        double splitAmount = (amount * 100 / (totalSplits + 1)) / 100.0;
        for (final split in splits) {
          split.setAmount(splitAmount);
        }
        return EqualExpense(amount, paidBy, splits, expenseMetaData);
        

      case ExpenseType.PERCENT:
          for (Split split in splits) {
            PercentageSplit percentSplit = split as PercentageSplit;
            split.setAmount((amount*percentSplit.getPercentage())/100.0);
                }
          return PercentExpense(amount, paidBy, splits, expenseMetaData);
      default:
        null;
    }
    return null;
  }
}
import 'package:split_wise/models/expense.dart';
import 'package:split_wise/models/expense_meta_data.dart';
import 'package:split_wise/models/expense_type.dart';
import 'package:split_wise/models/split.dart';
import 'package:split_wise/models/user.dart';
import 'package:split_wise/services/expense_service.dart';

class ExpenseManager {
  late List<Expense> _expenses;
  late Map<String, User> userMap;
  late Map<String, Map<String, double>> _balanceSheet;

  ExpenseManager() {
    _expenses = [];
    userMap = {};
    _balanceSheet = {};
  }

  void addUser(User user) {
    userMap[user.getId()] = user;
    _balanceSheet[user.getId()] = {};
  }

  void addExpense(ExpenseType expenseType, double amount, String paidBy, List<Split> splits, ExpenseMetaData expenseMetaData) {
    print("Adding expenses");
    Expense? expense = ExpenseService.createExpense(expenseType, amount, userMap[paidBy]!, splits, expenseMetaData);
    if (expense != Null) {
      _expenses.add(expense!);
    }

    for (Split split in expense!.getSplits()) {
            String paidTo = split.getUser().getId();
            Map<String, double> balances = _balanceSheet[paidBy]!;
            if (!balances.containsKey(paidTo)) {
                balances[paidTo] = 0.0;
            }
            balances[paidTo] = balances[paidTo]! + split.getAmount();
            _balanceSheet[paidBy] = balances;
            // if (!balances.containsKey(paidBy)) {
            //   balances.put(paidBy, 0.0);
            // }

        }
    

    print("Adding expenses ${_expenses.length}");
  }

  void showBalance(String userId) {
    bool isEmpty = _balanceSheet.containsKey(userId);
    if (!isEmpty) {
      Map<String, double> userBalance = _balanceSheet[userId]!;
      userBalance.forEach((key, value) {
        if (value != 0) {
          _printBalance(userId, key, value);
        }
      });
    }
    if (isEmpty) {
      print("No balances");
    }
  }

  void showBalances() {
    bool isEmpty = false;
    _balanceSheet.forEach((key, allBalances) {
      allBalances.forEach((key2, userBalance) {
        if (userBalance > 0) {
          isEmpty = true;
          _printBalance(key, key2, userBalance);
        }
      });
    });
    if (!isEmpty) {
      print("No balances");
    }
  }

  void _printBalance(String user1, String user2, double amount) {
    String user1Name = userMap[user1]!.getName();
    String user2Name = userMap[user2]!.getName();
    if (amount < 0) {
      print(user1Name + " owes " + user2Name + ": " + "${amount * -1}");
    } else if (amount > 0) {
      print(user2Name + " owes " + user1Name + ": " + "${amount}");
    }
  }
}

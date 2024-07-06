import 'dart:io';

import 'package:split_wise/managers.dart/expense_manager.dart';
import 'package:split_wise/models/equal_split.dart';
import 'package:split_wise/models/exact_split.dart';
import 'package:split_wise/models/expense_meta_data.dart';
import 'package:split_wise/models/expense_type.dart';
import 'package:split_wise/models/percentage_split.dart';
import 'package:split_wise/models/split.dart';
import 'package:split_wise/models/user.dart';

void main() {
  ExpenseManager expenseManager = ExpenseManager();
  expenseManager.addUser(User("u1", "User1", "yo1@gmail.com", "9876543210"));
  expenseManager.addUser(User("u2", "User2", "yo2@gmail.com", "9876543211"));
  expenseManager.addUser(User("u3", "User3", "yo3@gmail.com", "9876543212"));
  expenseManager.addUser(User("u4", "User4", "yo4@gmail.com", "9876543213"));

  while (true) {
    final command = stdin.readLineSync()!;
    final commands = command.split(' '); // Split the line into words
    final commandType = commands.first; // Get the first word (command)
    print("The commands are $commands, $commandType");

    switch (commandType) {
      case "SHOW":
        print("YES");
        if (commands.length == 1) {
          expenseManager.showBalances();
        } else {
          expenseManager.showBalance(commands[1]);
        }
        break;
      case "EXPENSE":
        if (commands.length < 5) {
          print('Invalid EXPENSE command format. Please follow the format:');
          print('EXPENSE <paidBy> <amount> <noOfUsers> <user1> [user2 ...] <splitType> [<splitValue1> [splitValue2 ...]');
          break;
        }

        final paidBy = commands[1];
        final amount = double.parse(commands[2]);
        final noOfUsers = int.parse(commands[3]);

        final splits = <Split>[];
        switch (commands[4 + noOfUsers]) {
          // Access split type after user list
          case 'EQUAL':
            for (int i = 0; i < noOfUsers; i++) {
              splits.add(EqualSplit(expenseManager.userMap[commands[4 + i]]!, amount)); // Assuming userMap is a Map<String, User>
            }
            expenseManager.addExpense(ExpenseType.EQUAL, amount, paidBy, splits, ExpenseMetaData.empty());
            break;
          case 'EXACT':
            for (int i = 0; i < noOfUsers; i++) {
              final splitValue = double.parse(commands[5 + noOfUsers + i]);
              splits.add(ExactSplit(expenseManager.userMap[commands[4 + i]]!, splitValue));
            }
            expenseManager.addExpense(ExpenseType.EXACT, amount, paidBy, splits, ExpenseMetaData.empty());
            break;
          case 'PERCENT':
            for (int i = 0; i < noOfUsers; i++) {
              final splitValue = double.parse(commands[5 + noOfUsers + i]);
              splits.add(PercentageSplit(expenseManager.userMap[commands[4 + i]]!, splitValue));
            }
            expenseManager.addExpense(ExpenseType.PERCENT, amount, paidBy, splits, ExpenseMetaData.empty());
            break;
          default:
            print('Invalid split type: ${commands[4 + noOfUsers]}. Please use EQUAL, EXACT, or PERCENT.');
        }
        break;
      default:
        print('Invalid command: $commandType. Please use SHOW or EXPENSE.');
    }
  }
}

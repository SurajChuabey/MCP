import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fintrac/utils/providers/home_dash_provider.dart';


class ExpenseSummaryCard extends StatefulWidget {
  const ExpenseSummaryCard({super.key});

  @override
  State<ExpenseSummaryCard> createState() => _ExpenseSummaryCardState();
}

class _ExpenseSummaryCardState extends State<ExpenseSummaryCard> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<ExpenseProvider>().fetchExpenses());
  }

  @override
  Widget build(BuildContext context) {
    final expense = context.watch<ExpenseProvider>();
    
    double percentageChange =
        ((expense.todayExpense - expense.yesterdayExpense) / expense.yesterdayExpense) * 100;

    bool isIncrease = percentageChange >= 0;

    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Today's Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            const Text(
              "Total Spent",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),

            Text(
              "₹${expense.todayExpense.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Icon(
                  isIncrease ? Icons.trending_up : Icons.trending_down,
                  color: isIncrease ? Colors.green : Colors.red,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  "${isIncrease ? '+' : ''}${percentageChange.toStringAsFixed(1)}% vs Yesterday",
                  style: TextStyle(
                    color: isIncrease ? Colors.green : Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              isIncrease
                  ? "You spent more on Food and Travel today."
                  : "Good job! You spent less than yesterday.",
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

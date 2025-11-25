import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fintrac/utils/providers/home_dash_provider.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({super.key});

  @override
  State<CustomCard> createState() => _CustomCardState();

}

class _CustomCardState extends State<CustomCard> {


  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<ExpenseProvider>().fetchExpenses());
  }

  @override
  Widget build(BuildContext context) {
    final expense = context.watch<ExpenseProvider>();

    return Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            margin: EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [Color(0xFFA8E6CF), Color(0xFFDCEDC1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.account_balance_wallet_outlined, color: Colors.green),
                    SizedBox(width: 8),
                    Text(
                      "Total Budget / Spend",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "₹ ${expense.totalBudget}/ ${expense.monthlyExpense} ",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Expanded(
                        child: Column(
                          children: [
                            Text("Today's Expense", style: TextStyle(fontWeight: FontWeight.w500)),
                            SizedBox(height: 4),
                            Text("₹ ${expense.todayExpense}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      VerticalDivider(thickness: 1, color: Colors.black26),
                      Expanded(
                        child: Column(
                          children: [
                            Text("Weekly Expense", style: TextStyle(fontWeight: FontWeight.w500)),
                            SizedBox(height: 4),
                            Text("₹ ${expense.weeklyExpense}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
}}
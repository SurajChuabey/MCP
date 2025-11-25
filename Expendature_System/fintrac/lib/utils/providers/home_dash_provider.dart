import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ExpenseData {
  ExpenseData(this.category, this.value, this.color);
  final String category;
  final double value;
  final Color color;
}

class ExpenseProvider extends ChangeNotifier {
  double _monthlyExpense = 0.0;
  double _weeklyExpense = 0.0;
  double _todayExpense = 0.0;
  double _totalBudget = 0.0;
  double _yesterdayExpense = 0.0;

  double get monthlyExpense => _monthlyExpense;
  double get weeklyExpense => _weeklyExpense;
  double get todayExpense => _todayExpense;
  double get totalBudget => _totalBudget;
  double get yesterdayExpense => _yesterdayExpense;

  Future<void> fetchExpenses() async {
    final url = Uri.parse('http://192.168.0.142:8000/expenses');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _todayExpense = data['todayExpense'];
      _weeklyExpense = data['weeklyExpense'];
      _monthlyExpense = data['monthlyExpense'];
      _totalBudget = data['totalBudget'];
      _yesterdayExpense = data['yesterdayExpense'];
      notifyListeners();
    } else {
      throw Exception('Failed to load expenses');
    }
  }
}

class PieChartProvider extends ChangeNotifier {
  final List<ExpenseData> _pieChartData = [];
  List<ExpenseData> get piechartdata => _pieChartData;

  final List<Color> categoryColors = [
    Colors.red,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.green,
  ];

  // -------------------------------
  // Default offline fallback values
  // -------------------------------
  void _setDefaultPieData() {
    _pieChartData.clear();
    _pieChartData.addAll([
      ExpenseData("Food", 30, Colors.red),
      ExpenseData("Bills", 20, Colors.blue),
      ExpenseData("Shopping", 15, Colors.orange),
      ExpenseData("Travel", 10, Colors.purple),
      ExpenseData("Others", 5, Colors.green),
    ]);
    notifyListeners();
  }

  Future<void> getTopFiveCatagory() async {
    final url = Uri.parse('http://192.168.0.142:8000/catagory');

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        _pieChartData.clear();

        for (int i = 0; i < data.length; i++) {
          final categoryData = data[i];

          final categoryName = categoryData["catagory"] ?? "Unknown";
          final categoryValue =
              double.tryParse(categoryData["value"].toString()) ?? 0.0;

          final categoryColor = categoryColors[i % categoryColors.length];

          _pieChartData.add(
            ExpenseData(categoryName, categoryValue, categoryColor),
          );
        }

        notifyListeners();
      } else {
        _setDefaultPieData();
      }
    } catch (e) {
      _setDefaultPieData();
    }
  }
}
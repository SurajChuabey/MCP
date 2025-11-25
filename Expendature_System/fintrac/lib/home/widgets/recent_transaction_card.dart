import 'package:fintrac/utils/dateformater.dart';
import 'package:flutter/material.dart';
import 'package:fintrac/home/widgets/transaction_card.dart';

class RecentTransactionCard extends StatefulWidget{
  const RecentTransactionCard({super.key});

  @override
  State<RecentTransactionCard> createState() => _RecentTransactionCardState();

}

class _RecentTransactionCardState extends State<RecentTransactionCard>{

  final Map<String, IconData> leadIconFilter = {
    "Food":Icons.food_bank_rounded,
    "Shopping": Icons.currency_rupee_outlined,
    "Salary":Icons.money
  };

  final List<Map<String, dynamic>> transactions = [
    {"title": "Food", "subtitle": "McDonald's", "amount": 250,"transaction_date":'21/9/25','payment_method':'online','expense_type':'spend'},
    {"title": "Salary", "subtitle": "Company", "amount": 5000,"transaction_date":'21/9/25','payment_method':'online','expense_type':'spend'},
    {"title": "Shopping", "subtitle": "Amazon", "amount": 800,"transaction_date":'21/9/25','payment_method':'cash','expense_type':'received'},
    {"title": "Food", "subtitle": "McDonald's", "amount": 250,"transaction_date":'21/9/25','payment_method':'online','expense_type':'spend'},
    {"title": "Salary", "subtitle": "Company", "amount": 5000,"transaction_date":'21/9/25','payment_method':'cash','expense_type':'received'},
    {"title": "Shopping", "subtitle": "Amazon", "amount": 800,"transaction_date":'21/9/25','payment_method':'online','expense_type':'spend'},
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))),
      margin: const EdgeInsets.all(11),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Recent Transactions',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ...transactions.map((tx)=>Padding(
                padding: const EdgeInsets.all(2.0),
                child: transactionListBuilder(tx),
              )),
            ],
          ),
        ),
      )
    );
  }

  Widget transactionListBuilder(tx){
    bool isLow = tx["expense_type"] == "spend";
    String transactionDate  = convertDate(tx['transaction_date']);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        onTap: () {
            showDialog(
              context: context,
              barrierColor: Colors.black.withOpacity(0.4),
              barrierDismissible: true,
              builder: (context) {
                return FractionallySizedBox(heightFactor: 0.5, child: TransactionCard(leadIconFilter: leadIconFilter, title: tx['title'], amount: (tx['amount'] as num).toDouble(), subtitle: tx['subtitle'],transaction_date: transactionDate,payment_method: tx['payment_method'],));
              },
            );
          },
        tileColor: const Color.fromARGB(255, 236, 235, 231),
        leading: Icon(leadIconFilter[tx["title"]]),
        title: Text(tx["title"],style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: isLow? const Color.fromARGB(255, 240, 139, 131) : const Color.fromARGB(255, 87, 134, 88))),
        subtitle: Text(tx["subtitle"],style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        trailing: Text(tx["amount"].toString(),style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: isLow? const Color.fromARGB(255, 240, 139, 131) : const Color.fromARGB(255, 87, 134, 88))),
      ),
    );
  }
}
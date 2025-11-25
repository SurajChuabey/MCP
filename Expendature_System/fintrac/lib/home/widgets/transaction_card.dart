import 'package:flutter/material.dart';

class TransactionCard extends StatefulWidget {
  final Map<String, IconData> leadIconFilter;
  final String title;
  final double amount;
  final String subtitle;
  final String transaction_date;
  final String payment_method;

  const TransactionCard({
    super.key,
    required this.leadIconFilter,
    required this.title,
    required this.amount,
    required this.subtitle,
    required this.transaction_date,
    required this.payment_method,
  });

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    // Keep the card tightly wrapped
    return Card(
      elevation: 6,
      color: const Color.fromARGB(255, 200, 235, 185),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(8),
      child: Container(
        height: double.infinity,
        width: mq.size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.white,
                  child: Icon(
                    widget.leadIconFilter[widget.title] ?? Icons.help_outline,
                    size: 32,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 12),
                Text(widget.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(widget.subtitle, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                const SizedBox(height: 16),
            
                // Amount box 
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.currency_rupee_outlined, size: 22),
                      const SizedBox(width: 6),
                      Text(
                        widget.amount.toStringAsFixed(2),
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
            
                // Payment method box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 1),
                    color: const Color.fromARGB(255, 234, 248, 240),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    spacing: 10,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.payment_outlined, size: 22, color: Colors.green),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Payment Method', style: TextStyle(fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Text(widget.payment_method, style: const TextStyle(color: Colors.green,fontSize: 20,)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.payment_outlined, size: 22, color: Colors.green),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Transaction Date', style: TextStyle(fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Text(widget.transaction_date, style: const TextStyle(color: Colors.green,fontSize: 20,)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                TextButton(onPressed: (){
                  Navigator.of(context).pop();
                },style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  fixedSize: Size.fromWidth(500),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  )
                )
                , child: Text('Close',style: TextStyle(backgroundColor: Colors.green,color: Colors.white,fontSize: 20),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

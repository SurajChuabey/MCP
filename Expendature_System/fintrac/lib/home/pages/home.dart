import 'package:fintrac/addExpense/pages/addexpense.dart';
import 'package:fintrac/profile/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:fintrac/home/widgets/home_app_bar_icons.dart';
import 'package:fintrac/home/widgets/catagory_card_main.dart';
import 'package:fintrac/home/widgets/grid_card_pie_chart.dart';
import 'package:fintrac/home/widgets/grid_card_summary_chart.dart';
import 'package:fintrac/home/widgets/recent_transaction_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ****************** APP BAR  ****************************

      appBar: PreferredSize( 
        preferredSize: const Size.fromHeight(80),
        //appbar
        child: AppBar(
          backgroundColor: Colors.green.shade100,
          elevation: 0,
          titleSpacing: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading:IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const MyProfile(),
                      );
                    },
                    icon: CircleAvatar(
                          radius: 18, 
                          backgroundColor: Color.fromARGB(255, 108, 182, 111),
                          child: Icon(
                          Icons.person_sharp,
                          color: Colors.white,
                          size: 29,
                          ),
                    ),
                  ) ,
                  
          title: Text(widget.title,style: const TextStyle( fontSize: 26,fontWeight: FontWeight.bold,),),
          actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppBarIcon(text: "Add Expense", onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => Addexpense(),
                        );
                    }),
              ),
          ],
        ),
      ),

//  ******************* BODY ********************************************

      body:Container(
        color: const Color.fromARGB(255, 224, 241, 241),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              CustomCard(),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 250, 
                        child: ExpenseDoughnutChart(),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 250,
                        child: ExpenseSummaryCard(),
                      ),
                    ),
                  ],
                ),

              RecentTransactionCard()
            ],
          ),
        ),
      )
    );
  }
}

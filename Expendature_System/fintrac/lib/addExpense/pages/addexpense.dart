import 'package:fintrac/addExpense/widget/addExpenseCard.dart';
import 'package:flutter/material.dart';

class Addexpense  extends StatefulWidget{

  const Addexpense({super.key});

  @override
  State<Addexpense> createState() => _AddexpenseState();
}

class _AddexpenseState extends State<Addexpense>{

  @override
  Widget build(BuildContext context){
     
     return AddexpenseCard();
  }
}
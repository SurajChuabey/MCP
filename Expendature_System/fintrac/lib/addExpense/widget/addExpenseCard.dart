import 'package:fintrac/addExpense/widget/datePicker.dart';
import 'package:flutter/material.dart';
import 'package:fintrac/utils/providers/expenseAddProvider.dart';
import 'package:flutter/services.dart';

class AddexpenseCard extends StatefulWidget {
  const AddexpenseCard({super.key});

  @override
  State<AddexpenseCard> createState() => _AddexpenseCardState();
}

class _AddexpenseCardState extends State<AddexpenseCard> {
  final expenseApi  = ExpenseApi(baseUrl: 'http://192.168.0.142:5000');

  final List<String> Catagories = ["Shopping", "Health", "Food", "Bills","Ration", "School", "Party","Others"];
  int selectedIndex = 0;

  DateTime selecteddate = DateTime.now();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String saveButtonResponse = 'Save Expense';
  bool isInputCorrect = false;

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    String formattedDate() {
      final d = selecteddate;
      return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
    }

    return Card(
      elevation: 6,
      surfaceTintColor: Colors.amberAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 235, 236, 233),
              Color.fromARGB(255, 178, 230, 179),
              
              
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Catagories',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
          
                // categories
                SizedBox(
                  height: 64,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: Catagories.length,
                    itemBuilder: (context, index) {
                      final title = Catagories[index];
                      final bool isSelected = index == selectedIndex;
          
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0, top: 16.0, bottom: 6.0),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: isSelected
                                ?  Color(0xFF4CAF50) 
                                : Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: const BorderSide(
                                color: Color.fromARGB(255, 96, 143, 106),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          ),
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 20,
                              color: isSelected ?  Colors.black : const Color.fromARGB(255, 121, 114, 114),
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
          
                // amount + date row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      // AMOUNT
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 60,
                          child: TextField(
                            controller: amountController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                            ],
                            decoration: InputDecoration(
                              labelText: "Enter Amount",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // DATE BUTTON
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 60,
                          child: TextButton(
                            onPressed: () async {
                              DateTime? newDate = await pickDate(context, selecteddate);
                              if (newDate != null) {
                                setState(() {
                                  selecteddate = newDate;
                                });
                              }
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(
                                  color: Color.fromARGB(255, 146, 141, 141),
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.calendar_today, size: 18, color: Colors.black),
                                const SizedBox(width: 8),
                                Text(
                                  formattedDate(),
                                  style: const TextStyle(fontSize: 16, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          
                // DESCRIPTION
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextField(
                    controller: descriptionController,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                    ],
                    decoration: InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(height: 12),
                // Example action button to read values (optional)
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            isInputCorrect ? Colors.green : const Color.fromARGB(255, 216, 238, 157),
                          ),
                        ),
                        onPressed: () {
                          final amountText = amountController.text.trim();
                          final descriptionText = descriptionController.text.trim();
                          final category = Catagories[selectedIndex];
                          final date = selecteddate;
          
                          setState(() {
                            if (amountText.isEmpty) {
                              saveButtonResponse = 'Amount Could not be Empty';
                              isInputCorrect = false;
                            } else if (descriptionText.isEmpty) {
                              saveButtonResponse = 'Description Could not be Empty';
                              isInputCorrect = false;
                            } else if (category.isEmpty) {
                              saveButtonResponse = 'Please select category first';
                              isInputCorrect = false;
                            } else {
                              saveButtonResponse = 'Expense Added Successfully';
                              isInputCorrect = true;
                              amountController.clear();
                              descriptionController.clear();
          
                            }
                             
                          });
          
                          final amount = double.tryParse(amountText.replaceAll(',', ''));
                          ExpenseAdd expenses = ExpenseAdd(amount: amount,category: category,date: date,description: descriptionText);
                          expenseApi.postExpenseJson(expenses);

                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            saveButtonResponse,
                            style: const TextStyle(color: Color.fromARGB(255, 14, 13, 13)),
                          ),
                        ),
                      ),
                    ),
                  ),
          
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

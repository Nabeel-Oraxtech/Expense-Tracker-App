import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget{
  const NewExpense({super.key,required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {

  final TextEditingController _titleController=TextEditingController();
  final TextEditingController _amountController=TextEditingController();
  DateTime? _selectedDate;
  var _selectedCategory=Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  void _presentDatePicker() async {
    final now=DateTime.now();
    final firstDate=DateTime(now.year-1,now.month,now.day);

    var pickedDate=await showDatePicker(context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }
  void _submitExpenseData(){
    var enteredAmount=double.tryParse(_amountController.text);
    final amountIsInvalid=enteredAmount==null || enteredAmount<=0;
    if(_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate==null ){
      showDialog(context: context, builder: (ctx)=>  AlertDialog(
          title: const Text('Invalid Input'),
        content: const Text('Please make sure a valid input for title,amount,date and category'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay')
          )
        ],
        ),
      );
      return;
    }
    widget.onAddExpense(
        Expense(
            amount: enteredAmount,
            date: _selectedDate!,
            title: _titleController.text,
            category: _selectedCategory)
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return
          Padding(
          padding: const EdgeInsets.fromLTRB(16,48,16,16),
          child: Column(
            children: [ TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                label:Text('Title'),
              ),
            ),

              Row(
                children: [
                  Expanded(
                      child:
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _amountController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      prefixText: '\$',
                      label:Text('Amount'),
                    ),
                  ),
                  ),
                  const SizedBox(width: 16,),
                  Expanded(
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_selectedDate ==null ? "No date selected":formatter.format(_selectedDate!)),
                          IconButton(
                              onPressed: (){
                                _presentDatePicker();
                              },
                              icon: const Icon( Icons.calendar_month))
                        ],),
                  ),


              ],),

              const SizedBox(height: 20,),

              Row(children: [
                DropdownButton(
                  value: _selectedCategory,
                    items: Category.values.map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child:Text(
                      category.name.toUpperCase(),
                    ),
                  ),
                    ).toList(),
                    onChanged: (value){
                      if(value==null){
                        return;
                      }
                      setState(() {
                        _selectedCategory=value;
                      });
                    }),
                const Spacer(),
                ElevatedButton(
                  onPressed: (){
                    _submitExpenseData();
                  },
              child: const Text('Save Expense')),
                ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'))
              ],)
            ]),
         );

  }
}
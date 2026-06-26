
// ---------------------------------------------
// Create a new statefull widget : GroceryForm
// ---------------------------------------------
  
// The form shall be composed of 2 text fields:
// -	Name of the grocery item
 //-	Quantity (number only)

// ⚠️  For now we don’t select the grocery type, we assume it’s always food

// The form shall be composed of 2 buttons:
//-	Cancel button
// -	Add item button

import 'package:flutter/material.dart';
import '../../../models/grocery.dart';

class GroceryForm extends StatefulWidget {
  const GroceryForm({super.key});

  @override
  State<GroceryForm> createState() => GroceryFormState();
}

class GroceryFormState extends State<GroceryForm> {
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  String errorMessage = "";

  void addItem() {
    final quantity = int.tryParse(quantityController.text.trim());

    if (quantity == null || quantity <= 0) {
      setState(() {
        errorMessage = "Please enter a POSITIVE integer.";
      });
      return;
    } 
    if (nameController.text.trim().isEmpty) {
      setState(() {
        errorMessage = "Please enter the name.";
      });
      return;
    } 

    final grocery = GroceryItem(
      id: DateTime.now().toString(),
      name: nameController.text,
      quantity: quantity,
      category: GroceryCategory.other,
    );

    Navigator.pop(context, grocery);
  }

  @override
  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Quantity',
            ),
          ),
          const SizedBox(height: 20),
          Text(errorMessage, style: TextStyle(color: Colors.red),),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: addItem,
                child: const Text('Add Item'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
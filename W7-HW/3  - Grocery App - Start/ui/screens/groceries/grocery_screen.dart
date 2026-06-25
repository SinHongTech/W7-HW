import 'package:flutter/material.dart';
import '../../../data/mock_grocery_data.dart';
import '../../../models/grocery.dart';
import 'grocery_form.dart';
import 'grocery_tile.dart';

class GroceryScreen extends StatefulWidget {
  const GroceryScreen({super.key});

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  // ---------------------------------------------
  // Navigate to the form screen using showModalBottomSheet
  // ---------------------------------------------

  // https://api.flutter.dev/flutter/material/showModalBottomSheet.html

  Future<void> onCreate() async {
    final result = await showModalBottomSheet<GroceryItem>(
      context: context,
      builder: (context) => const GroceryForm(),
    );

    if (result == null) return;

    setState(() {
      allGroceryItems.add(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (allGroceryItems.isNotEmpty) {
      // ---------------------------------------------
      //  Loop on groceries with an ListView builder
      //  For each grocery items, create a GroceryTile (grocery_tile.dart)
      // ---------------------------------------------
      // https://api.flutter.dev/flutter/widgets/ListView-class.html
      
      content = ListView.builder(
        itemCount: allGroceryItems.length,
        itemBuilder: (context, index) {
          final item = allGroceryItems[index];
          return GroceryTile(grocery: item);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: onCreate, icon: const Icon(Icons.add))],
      ),
      body: content,
    );
  }
}

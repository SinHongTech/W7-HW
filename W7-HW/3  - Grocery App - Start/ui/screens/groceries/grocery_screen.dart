import 'package:flutter/material.dart';
import '../../../models/grocery.dart';
import 'grocery_form.dart';
import 'grocery_tile.dart';

class GroceryScreen extends StatefulWidget {
  final List<GroceryItem> allgroceryItems;
  const GroceryScreen({super.key, required this.allgroceryItems});

  @override
  State<GroceryScreen> createState() => GroceryScreenState();
}

class GroceryScreenState extends State<GroceryScreen> {
  // ---------------------------------------------
  // Navigate to the form screen using showModalBottomSheet
  // ---------------------------------------------

  // https://api.flutter.dev/flutter/material/showModalBottomSheet.html

  Future<void> onCreate() async {
    final result = await showModalBottomSheet<GroceryItem>(
      context: context,
      builder: (context) => GroceryForm(),
    );

    if (result == null) return;

    setState(() {
      widget.allgroceryItems.add(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (widget.allgroceryItems.isNotEmpty) {
      // ---------------------------------------------
      //  Loop on groceries with an ListView builder
      //  For each grocery items, create a GroceryTile (grocery_tile.dart)
      // ---------------------------------------------
      // https://api.flutter.dev/flutter/widgets/ListView-class.html
      
      content = ListView.builder(
        itemCount: widget.allgroceryItems.length,
        itemBuilder: (context, index) {
          final item = widget.allgroceryItems[index];
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

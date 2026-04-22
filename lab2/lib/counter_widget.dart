import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class Item {
  String name;
  double price;
  String grade;

  Item({required this.name, required this.price, required this.grade});
}

class _CounterWidgetState extends State<CounterWidget> {
  List<Item> items = [
    Item(name: "Coat", price: 50.0, grade: "A"),
    Item(name: "Pant", price: 30.0, grade: "B"),
    Item(name: "Shirt", price: 20.0, grade: "A"),
  ];

  String? selectedItem;
  DateTime? pickedDate;

  void _dateselector() async {
    DateTime today = DateTime.now();

    pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(today.year),
      lastDate: today,
      initialDate: today,
    );

    if (pickedDate != null) {
      setState(() {});
    }
  }

  void addItem() {
    setState(() {
      items.add(Item(name: "Shoes", price: 40.0, grade: "B"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              
              itemBuilder: (context, index) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${items[index].name} - \$${items[index].price} - ${items[index].grade}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              pickedDate != null
                  ? "Selected Date: ${pickedDate!.day}/${pickedDate!.month}/${pickedDate!.year}"
                  : "No date selected",
              style: const TextStyle(fontSize: 16),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              hint: const Text("Select an item"),
              value: selectedItem,
              items: items.map((Item item) {
                return DropdownMenuItem<String>(
                  value: item.name,
                  child: Text(item.name),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedItem = newValue;
                });
              },
            ),
          ),

          if (selectedItem != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Selected: $selectedItem",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

          TextButton(
            onPressed: _dateselector,
            child: const Text("Select Date"),
          ),

          TextButton(
            onPressed: addItem,
            child: const Text("Add Item"),
          ),
        ],
      ),
    );
  }
}
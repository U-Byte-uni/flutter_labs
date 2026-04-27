import 'package:flutter/material.dart';
import 'package:quiz/Controllers/education_controller.dart';

class EducationFormScreen extends StatefulWidget {
  const EducationFormScreen({super.key});

  @override
  State<EducationFormScreen> createState() => _EducationFormScreenState();
}

class _EducationFormScreenState extends State<EducationFormScreen> {
  EducationController controller = EducationController();
  TextEditingController name = TextEditingController();
  TextEditingController route = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController vehicle = TextEditingController();
  bool isLoading = false;
  bool showRecords = false;

  void loadData() async {
    await controller.fetchEducationList();
    setState(() {
      showRecords = true;
    });
  }

  void saveData() async {
    if (name.text.isEmpty ||
        route.text.isEmpty ||
        age.text.isEmpty ||
        vehicle.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required')),
      );
      return;
    }

    setState(() => isLoading = true);

    bool success = await controller.saveEducation(
      name.text,
      route.text,
      age.text,
      vehicle.text,
    );

    setState(() => isLoading = false);

    if (success) {
      name.clear();
      route.clear();
      age.clear();
      vehicle.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form'),
        backgroundColor: Colors.blue,),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(hintText: 'Driver Name'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: route,
              decoration: InputDecoration(hintText: 'Driver Route'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: age,
              decoration: InputDecoration(hintText: 'Driver Age'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: vehicle,
              decoration: InputDecoration(hintText: 'Vehicle Name'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoading ? null : saveData,
              child: isLoading ? CircularProgressIndicator() : Text('Submit'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: loadData,
              child: Text('Show Records'),
            ),
            SizedBox(height: 12),
            if (showRecords)
              Expanded(
                child: controller.educationList.isEmpty
                    ? Center(child: Text('No records'))
                    : ListView.builder(
                  itemCount: controller.educationList.length,
                  itemBuilder: (context, index) {
                    final item = controller.educationList[index];
                    return ListTile(
                      title: Text(item.driverName),
                      subtitle: Text('${item.driverRoute} - ${item.vehicleName}'),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
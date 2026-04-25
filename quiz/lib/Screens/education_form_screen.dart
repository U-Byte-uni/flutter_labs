import 'package:flutter/material.dart';
import 'package:quiz/Controllers/education_controller.dart';

class EducationFormScreen extends StatefulWidget {
  const EducationFormScreen({super.key});

  @override
  State<EducationFormScreen> createState() => _EducationFormScreenState();
}

class _EducationFormScreenState extends State<EducationFormScreen> {
  final controller = EducationController();
  final nameController = TextEditingController();
  final deptController = TextEditingController();
  final universityController = TextEditingController();
  bool isLoading = false;
  bool showRecords = false;

  void loadData() async {
    await controller.fetchEducationList();
    setState(() {
      showRecords = true;
    });
  }

  void saveData() async {
    if (nameController.text.isEmpty ||
        deptController.text.isEmpty ||
        universityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required')),
      );
      return;
    }

    setState(() => isLoading = true);

    bool success = await controller.saveEducation(
      nameController.text,
      deptController.text,
      universityController.text,
    );

    setState(() => isLoading = false);

    if (success) {
      nameController.clear();
      deptController.clear();
      universityController.clear();
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
              controller: nameController,
              decoration: InputDecoration(hintText: 'Student Name'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: deptController,
              decoration: InputDecoration(hintText: 'Department'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: universityController,
              decoration: InputDecoration(hintText: 'University'),
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
                      title: Text(item.studentName),
                      subtitle: Text('${item.dept} - ${item.university}'),
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
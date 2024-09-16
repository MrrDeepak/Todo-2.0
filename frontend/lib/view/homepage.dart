import 'package:flutter/material.dart';
import 'package:frontend/view/task_done.dart';
import 'package:frontend/viewmodal/provider.dart';
import 'package:frontend/service/employee_api_service.dart';
import 'package:provider/provider.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final _addProductFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    // Fetch employeeData when the widget is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EmployeeProvider>().fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.black,
        //appBar: AppBar(title: const Center(child: Text('TODO'))),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 2.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello Deepak 👋'),
                  Text(
                    'Manage Your',
                    style: TextStyle(fontSize: 32.0),
                  ),
                  Text(
                    'Daily Task',
                    style: TextStyle(fontSize: 32.0),
                  ),
                  SizedBox(height: 16.0),
                  TaskDone(),
                  SizedBox(height: 16.0),
                  Text(
                    'Ongoing',
                    style: TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0,
                vertical: 2.0,),
                child: Consumer<EmployeeProvider>(
                  builder: (context, employeeProvider, child) {
                    if (employeeProvider.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (employeeProvider.error != null) {
                      return Text(employeeProvider.error!);
                    }
                
                    if (employeeProvider.employeeData.isEmpty) {
                      return const Center(child: Text('No users available'));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: employeeProvider.employeeData.length,
                      itemBuilder: (context, index) {
                        //print(productViewModel.employeeData);
                        final employee = employeeProvider.employeeData[index];
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text((index + 1).toString()),
                            ),
                            title: Text(employee.name),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon:
                                      const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    employeeProvider
                                        .deleteProduct((employee.id).toString());
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          //heroTag: AlertDialog(),
          onPressed: () async {
            await _showAddDataDialog(context);
          },
          tooltip: 'Add New Data',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> _showAddDataDialog(BuildContext context) async {
    final TextEditingController nameController = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Data'),
          content: Form(
            key: _addProductFormKey, // Declare a global key for the form
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Data Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a data name';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_addProductFormKey.currentState!.validate()) {
                  final String name = nameController.text;
                  Provider.of<EmployeeProvider>(context, listen: false)
                      .addProduct(name);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

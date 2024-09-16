import 'package:flutter/foundation.dart';
import 'package:frontend/modal/employee_modal.dart';
import 'package:frontend/service/employee_api_service.dart';

class EmployeeProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<EmployeeModal> _employeeData = [];
  bool _loading = false;
  String? _error;

  List<EmployeeModal> get employeeData => _employeeData;
  bool get loading => _loading;
  String? get error => _error;
  ApiService get apiService => _apiService;

  Future<void> fetchData() async {
    _loading = true;
    //_employeeData = await ApiService.getProducts();
    notifyListeners();
    try {
      _employeeData = (await apiService.getData());
    } catch (e) {
      _error = 'Failed to load users';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // Delete a product by ID
  void deleteProduct(String id) async {
    _employeeData.removeWhere((product) => product.id == id);
    notifyListeners();
    try {
      print(id);
      await apiService.deleteData(
          int.parse(id)); // Call API to delete the product
    } catch (e) {
      // Handle error (e.g., log the error, show a message)
      print('Failed to delete product: $e');
    }
  }

  // Add new product
  void addProduct(String name) async {
    final newData = EmployeeModal(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
    );
    _employeeData.add(newData);
    notifyListeners();
    try{
      await apiService.addData(newData);
    }catch (e) {
      print('Failed to add product: $e');
    }
  }
}

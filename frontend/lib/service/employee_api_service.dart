import 'dart:convert';
import 'package:frontend/modal/employee_modal.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = 'http://localhost:3000/api/items';

  Future<List<EmployeeModal>> getData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => EmployeeModal.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load items. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors or JSON parsing errors
      //print('Error fetching products: $e');
      throw Exception('Error fetching products: $e');
    }
  }

  Future<void> deleteData(int id) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/$id'));
      if (response.statusCode != 204) {
        throw Exception('Failed to delete data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors or server errors
      throw Exception('Error deleting data: $e');
    }
  }
  Future<EmployeeModal> addData(EmployeeModal data) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': data.id,
          'name': data.name,
        }),
      );
      if (response.statusCode == 201) {
        return EmployeeModal.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to add item. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors, JSON encoding errors, or server errors
      print('Error adding data: $e');
      throw Exception('Error adding data: $e');
    }
  }
}

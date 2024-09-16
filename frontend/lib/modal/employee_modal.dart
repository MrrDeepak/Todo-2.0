class EmployeeModal {
  final String id;
  final String name;

  EmployeeModal({required this.id, required this.name, 
  });

  factory EmployeeModal.fromJson(Map<String, dynamic> json) {
    return EmployeeModal(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
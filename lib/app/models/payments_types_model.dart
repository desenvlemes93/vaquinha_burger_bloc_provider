import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class PaymentsTypesModel {
  final int id;
  final String name;
  final String acronym;
  final bool enabled;
  PaymentsTypesModel({
    required this.id,
    required this.name,
    required this.acronym,
    required this.enabled,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'acronym': acronym,
      'enabled': enabled,
    };
  }

  factory PaymentsTypesModel.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'acronym': String acronym,
        'enabled': bool enabled,
      } =>
        PaymentsTypesModel(
          id: id,
          name: name,
          acronym: acronym,
          enabled: enabled,
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }

  String toJson() => json.encode(toMap());

  factory PaymentsTypesModel.fromJson(String source) =>
      PaymentsTypesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

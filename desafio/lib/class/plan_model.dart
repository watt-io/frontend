import 'dart:convert';

import 'package:desafio/enum/person.dart';

class PlanModel {
  String name;
  double valueMinMonthly;
  double valueMaxMonthly;
  double discount;
  Person person;

  PlanModel({
    required this.name,
    required this.valueMinMonthly,
    required this.valueMaxMonthly,
    required this.discount,
    required this.person,
  });

  PlanModel copyWith({
    String? name,
    double? valueMinMonthly,
    double? valueMaxMonthly,
    double? discount,
    Person? person,
  }) {
    return PlanModel(
      name: name ?? this.name,
      valueMinMonthly: valueMinMonthly ?? this.valueMinMonthly,
      valueMaxMonthly: valueMaxMonthly ?? this.valueMaxMonthly,
      discount: discount ?? this.discount,
      person: person ?? this.person,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'valueMinMonthly': valueMinMonthly,
      'valueMaxMonthly': valueMaxMonthly,
      'discount': discount,
      'person': person.name,
    };
  }

  factory PlanModel.fromMap(Map<String, dynamic> map) {
    return PlanModel(
      name: map['name'],
      valueMinMonthly: map['valueMinMonthly']?.toDouble(),
      valueMaxMonthly: map['valueMaxMonthly']?.toDouble(),
      discount: map['discount']?.toDouble(),
      person: PersonFrom(map['person']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlanModel.fromJson(String source) => PlanModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Plan(name: $name, valueMinMonthly: $valueMinMonthly, valueMaxMonthly: $valueMaxMonthly, discount: $discount, person: $person)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlanModel &&
        other.name == name &&
        other.valueMinMonthly == valueMinMonthly &&
        other.valueMaxMonthly == valueMaxMonthly &&
        other.discount == discount &&
        other.person == person;
  }

  @override
  int get hashCode {
    return name.hashCode ^ valueMinMonthly.hashCode ^ valueMaxMonthly.hashCode ^ discount.hashCode ^ person.hashCode;
  }
}

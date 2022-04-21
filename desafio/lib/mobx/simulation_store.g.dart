// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulation_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SimulationStore on _SimulationStoreBase, Store {
  Computed<double>? _$valueComputed;

  @override
  double get value => (_$valueComputed ??= Computed<double>(() => super.value,
          name: '_SimulationStoreBase.value'))
      .value;

  final _$personAtom = Atom(name: '_SimulationStoreBase.person');

  @override
  Person get person {
    _$personAtom.reportRead();
    return super.person;
  }

  @override
  set person(Person value) {
    _$personAtom.reportWrite(value, super.person, () {
      super.person = value;
    });
  }

  final _$_valueAtom = Atom(name: '_SimulationStoreBase._value');

  @override
  String get _value {
    _$_valueAtom.reportRead();
    return super._value;
  }

  @override
  set _value(String value) {
    _$_valueAtom.reportWrite(value, super._value, () {
      super._value = value;
    });
  }

  @override
  String toString() {
    return '''
person: ${person},
value: ${value}
    ''';
  }
}

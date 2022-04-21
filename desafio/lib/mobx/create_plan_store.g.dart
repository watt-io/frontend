// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_plan_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CreatePlanMobx on _CreatePlanMobxBase, Store {
  Computed<String>? _$valueMinMonthlyComputed;

  @override
  String get valueMinMonthly => (_$valueMinMonthlyComputed ??= Computed<String>(
          () => super.valueMinMonthly,
          name: '_CreatePlanMobxBase.valueMinMonthly'))
      .value;
  Computed<String>? _$valueMaxMonthlyComputed;

  @override
  String get valueMaxMonthly => (_$valueMaxMonthlyComputed ??= Computed<String>(
          () => super.valueMaxMonthly,
          name: '_CreatePlanMobxBase.valueMaxMonthly'))
      .value;
  Computed<String>? _$discountComputed;

  @override
  String get discount =>
      (_$discountComputed ??= Computed<String>(() => super.discount,
              name: '_CreatePlanMobxBase.discount'))
          .value;
  Computed<PlanModel>? _$toModelComputed;

  @override
  PlanModel get toModel =>
      (_$toModelComputed ??= Computed<PlanModel>(() => super.toModel,
              name: '_CreatePlanMobxBase.toModel'))
          .value;
  Computed<String?>? _$validateComputed;

  @override
  String? get validate =>
      (_$validateComputed ??= Computed<String?>(() => super.validate,
              name: '_CreatePlanMobxBase.validate'))
          .value;

  final _$nameAtom = Atom(name: '_CreatePlanMobxBase.name');

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$_valueMinMonthlyAtom =
      Atom(name: '_CreatePlanMobxBase._valueMinMonthly');

  @override
  double get _valueMinMonthly {
    _$_valueMinMonthlyAtom.reportRead();
    return super._valueMinMonthly;
  }

  @override
  set _valueMinMonthly(double value) {
    _$_valueMinMonthlyAtom.reportWrite(value, super._valueMinMonthly, () {
      super._valueMinMonthly = value;
    });
  }

  final _$_valueMaxMonthlyAtom =
      Atom(name: '_CreatePlanMobxBase._valueMaxMonthly');

  @override
  double get _valueMaxMonthly {
    _$_valueMaxMonthlyAtom.reportRead();
    return super._valueMaxMonthly;
  }

  @override
  set _valueMaxMonthly(double value) {
    _$_valueMaxMonthlyAtom.reportWrite(value, super._valueMaxMonthly, () {
      super._valueMaxMonthly = value;
    });
  }

  final _$_discountAtom = Atom(name: '_CreatePlanMobxBase._discount');

  @override
  double get _discount {
    _$_discountAtom.reportRead();
    return super._discount;
  }

  @override
  set _discount(double value) {
    _$_discountAtom.reportWrite(value, super._discount, () {
      super._discount = value;
    });
  }

  final _$personAtom = Atom(name: '_CreatePlanMobxBase.person');

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

  final _$saveAsyncAction = AsyncAction('_CreatePlanMobxBase.save');

  @override
  Future<bool> save() {
    return _$saveAsyncAction.run(() => super.save());
  }

  @override
  String toString() {
    return '''
name: ${name},
person: ${person},
valueMinMonthly: ${valueMinMonthly},
valueMaxMonthly: ${valueMaxMonthly},
discount: ${discount},
toModel: ${toModel},
validate: ${validate}
    ''';
  }
}

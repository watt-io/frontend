// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SliderStore on _SliderStoreBase, Store {
  final _$actualValueAtom = Atom(name: '_SliderStoreBase.actualValue');

  @override
  int get actualValue {
    _$actualValueAtom.reportRead();
    return super.actualValue;
  }

  @override
  set actualValue(int value) {
    _$actualValueAtom.reportWrite(value, super.actualValue, () {
      super.actualValue = value;
    });
  }

  final _$businessListAtom = Atom(name: '_SliderStoreBase.businessList');

  @override
  ObservableList<Map<String, dynamic>> get businessList {
    _$businessListAtom.reportRead();
    return super.businessList;
  }

  @override
  set businessList(ObservableList<Map<String, dynamic>> value) {
    _$businessListAtom.reportWrite(value, super.businessList, () {
      super.businessList = value;
    });
  }

  final _$selectedBusinessAtom =
      Atom(name: '_SliderStoreBase.selectedBusiness');

  @override
  ObservableMap<String, dynamic> get selectedBusiness {
    _$selectedBusinessAtom.reportRead();
    return super.selectedBusiness;
  }

  @override
  set selectedBusiness(ObservableMap<String, dynamic> value) {
    _$selectedBusinessAtom.reportWrite(value, super.selectedBusiness, () {
      super.selectedBusiness = value;
    });
  }

  final _$_SliderStoreBaseActionController =
      ActionController(name: '_SliderStoreBase');

  @override
  SliderStore getInstance() {
    final _$actionInfo = _$_SliderStoreBaseActionController.startAction(
        name: '_SliderStoreBase.getInstance');
    try {
      return super.getInstance();
    } finally {
      _$_SliderStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getListOfBusiness({required int value}) {
    final _$actionInfo = _$_SliderStoreBaseActionController.startAction(
        name: '_SliderStoreBase.getListOfBusiness');
    try {
      return super.getListOfBusiness(value: value);
    } finally {
      _$_SliderStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
actualValue: ${actualValue},
businessList: ${businessList},
selectedBusiness: ${selectedBusiness}
    ''';
  }
}

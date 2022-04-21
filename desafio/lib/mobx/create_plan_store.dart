import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/class/format_price.dart';
import 'package:desafio/class/plan_model.dart';
import 'package:desafio/enum/person.dart';
import 'package:mobx/mobx.dart';
part 'create_plan_store.g.dart';

class CreatePlanMobx = _CreatePlanMobxBase with _$CreatePlanMobx;

abstract class _CreatePlanMobxBase with Store, FormatPrice {
  @observable
  String? name;

  @observable
  double _valueMinMonthly = 0;
  @computed
  String get valueMinMonthly => formatWithDecimal(_valueMinMonthly);
  @computed
  set valueMinMonthly(String? value) {
    if (value == null) return;
    _valueMinMonthly = formatDouble(value);
  }

  @observable
  double _valueMaxMonthly = 0;
  @computed
  String get valueMaxMonthly => formatWithDecimal(_valueMaxMonthly);
  @computed
  set valueMaxMonthly(String? value) {
    if (value == null) return;
    _valueMaxMonthly = formatDouble(value);
  }

  @observable
  double _discount = 0;
  @computed
  String get discount => formatWithDecimal(_discount);
  @computed
  set discount(String? value) {
    if (value == null) return;
    _discount = formatDouble(value);
  }

  @observable
  Person person = Person.physical;

  @computed
  PlanModel get toModel => PlanModel(
        name: name!,
        discount: _discount / 100,
        person: person,
        valueMaxMonthly: _valueMaxMonthly,
        valueMinMonthly: _valueMinMonthly,
      );

  @action
  Future<bool> save() async {
    try {
      await FirebaseFirestore.instance.collection('plan').add(toModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  @computed
  String? get validate {
    if (name == null || name!.isEmpty) {
      return 'Digite o nome da empresa';
    }
    if (_valueMaxMonthly == 0) {
      return 'Valor de máximo mensal deve ser maior que zero';
    }
    if (_valueMinMonthly < 0) {
      return 'Valor de mínimo mensal deve ser positivo';
    }
    if (_valueMinMonthly > _valueMaxMonthly) {
      return 'Valores de mínimo e máximo mensal inconsistente';
    }
    if (_discount <= 0) {
      return 'O plano deve ter desconto maior que zero';
    }
    if (_discount >= 100) {
      return 'O plano deve ter desconto inferior que 100%';
    }
    return null;
  }
}

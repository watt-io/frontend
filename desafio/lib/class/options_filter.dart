import 'package:desafio/class/plan_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio/enum/person.dart';

abstract class OptionsFilter {
  static Future<List<PlanModel>> future({required Person person, required double value}) async {
    final list = <PlanModel>[];
    final data = await FirebaseFirestore.instance.collection('plan').where('person', isEqualTo: person.name).get();

    for (var element in data.docs) {
      if (element.data()['valueMaxMonthly'] >= value) {
        if (element.data()['valueMinMonthly'] <= value) {
          list.add(PlanModel.fromMap(element.data()));
        }
      }
    }

    list.sort(((a, b) {
      if (a.discount < b.discount) {
        return 1;
      }
      if (a.discount > b.discount) {
        return -1;
      }
      return 0;
    }));

    return list;
  }
}

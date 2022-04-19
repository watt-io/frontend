import 'package:mobx/mobx.dart';
import 'package:wattio_frontend/data/infos.dart';
part 'slider_store.g.dart';

class SliderStore = _SliderStoreBase with _$SliderStore;

abstract class _SliderStoreBase with Store {
  // Singleton SliderStore
  static SliderStore? _instance;

  @observable
  int actualValue = 1000;

  @observable
  ObservableList<Map<String, dynamic>> businessList =
      ObservableList<Map<String, dynamic>>();

  @observable
  ObservableMap<String, dynamic> selectedBusiness =
      ObservableMap<String, dynamic>();

  @observable
  double savePerMonth = 0.0;

  @action
  SliderStore getInstance() => _instance ??= SliderStore();

  @action
  void getListOfBusiness({required int value}) {
    businessList.clear();
    selectedBusiness.clear();

    for (Map<String, dynamic> business in infos) {
      int minV = int.tryParse(business['valorMinimoMensal'].toString()) ?? 0;
      int maxV = int.tryParse(business['valorMaximoMensal'].toString()) ?? 0;
      if (minV <= value && maxV >= value) {
        businessList.add(business);
      }
    }
  }

  @action
  void getDiscount() {
    double discount =
        double.tryParse(selectedBusiness['desconto'].toString()) ?? 0.0;
    savePerMonth = double.parse(actualValue.toString()) * (discount);
  }
}

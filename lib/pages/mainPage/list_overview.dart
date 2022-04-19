import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:wattio_frontend/data/stores/slider_store.dart';
import 'package:wattio_frontend/helpers/screen_helper.dart';
import 'package:wattio_frontend/styles/colors.dart';
import 'package:wattio_frontend/widgets/buttons/custom_button.dart';
import 'package:wattio_frontend/widgets/cards/business_card.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart' as intl;
import 'package:wattio_frontend/widgets/cards/hire_card.dart';

class ListOverview extends StatelessWidget {
  const ListOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SliderStore sliderStore = SliderStore().getInstance();
    intl.NumberFormat nbformat = intl.NumberFormat('R\$#,###.00', 'pt-BR');

    return Observer(builder: (_) {
      return SizedBox(
        height: ScreenHelper(context: context).screenSize!.height * .8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                child: ListView.builder(
              controller: ScrollController(),
              itemBuilder: (context, index) {
                return Center(
                    child: Wrap(children: [
                  Observer(builder: (_) {
                    return BusinessCard(
                      data: sliderStore.businessList[index],
                      onTapChange: (dynamic value) {
                        sliderStore.selectedBusiness = ObservableMap.of(value);
                        sliderStore.getDiscount();
                      },
                    );
                  })
                ]));
              },
              itemCount: sliderStore.businessList.length,
            )),
            if (sliderStore.selectedBusiness.isNotEmpty)
              Column(
                children: [
                  Text(
                    'Economize até ${nbformat.format(sliderStore.savePerMonth)} por mês!'
                        .toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 100.0,
                  ),
                  CustomButton(
                    buttonText: 'Contratar',
                    function: () => showDialog(
                        context: context,
                        builder: (context) {
                          return HireCard(data: sliderStore.selectedBusiness);
                        }),
                  )
                ],
              )
          ],
        ),
      );
    });
  }
}

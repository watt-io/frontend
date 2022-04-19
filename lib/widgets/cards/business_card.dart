import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:wattio_frontend/data/stores/slider_store.dart';
import 'package:wattio_frontend/styles/colors.dart';

class BusinessCard extends StatefulWidget {
  const BusinessCard({
    Key? key,
    required this.data,
    required this.onTapChange,
  }) : super(key: key);
  final Map<String, dynamic> data;
  final Function(dynamic) onTapChange;

  @override
  State<BusinessCard> createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCard> {
  late Map<String, dynamic> data;
  List<String> personTypes = ['Pessoa Física', 'Pessoa Jurídica'];
  late double percentage;
  late bool hoverSelection;
  @override
  void initState() {
    super.initState();
    percentage =
        double.tryParse((widget.data['desconto'] * 100).toString()) ?? 0;
    hoverSelection = false;
  }

  @override
  Widget build(BuildContext context) {
    SliderStore sliderStore = SliderStore().getInstance();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(bottom: 30.0),
      constraints: const BoxConstraints(maxWidth: 600, minHeight: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: sliderStore.selectedBusiness['nome'] == widget.data['nome']
            ? AppColors.bluePrimary
            : AppColors.bluePrimary.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
              blurStyle: BlurStyle.inner,
              color: Colors.black.withOpacity(0.7),
              blurRadius: 15.0,
              offset: const Offset(5, 5))
        ],
        border: Border.all(
          width: 1.0,
          color: AppColors.textPrimary,
        ),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          flex: 2,
          child: Center(
            child: Material(
              shape: CircleBorder(
                side: BorderSide(
                  width: hoverSelection ? 4.0 : 2.0,
                  color: AppColors.yellowPrimary,
                ),
              ),
              shadowColor: Colors.black,
              elevation: 10.0,
              child: Observer(builder: (_) {
                return InkWell(
                  borderRadius: BorderRadius.circular(15.0),
                  splashColor: AppColors.bluePrimary,
                  onTap: () => widget.onTapChange(widget.data),
                  onHover: (bool value) => setState(() {
                    hoverSelection = value;
                  }),
                  child: CircleAvatar(
                    radius: 15.0,
                    backgroundColor: sliderStore.selectedBusiness['nome'] ==
                            widget.data['nome']
                        ? AppColors.bluePrimary
                        : Colors.transparent,
                  ),
                );
              }),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Column(
            children: [
              Text(
                widget.data['nome'].toString().toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 2.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List<Widget>.of(
                  personTypes.map(
                    (e) {
                      List<String> listOfPersonTypes = widget.data['tipos'];
                      return Row(
                        children: [
                          Icon(
                            listOfPersonTypes.contains(e)
                                ? Icons.check
                                : Icons.close,
                            color: listOfPersonTypes.contains(e)
                                ? Colors.green
                                : Colors.red,
                            size: 20.0,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            e.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'Desconto: $percentage%',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}

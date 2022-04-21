import 'package:auto_size_text/auto_size_text.dart';
import 'package:desafio/class/page_size.dart';
import 'package:desafio/class/price_input_formatter.dart';
import 'package:desafio/enum/gradients.dart';
import 'package:desafio/enum/person.dart';
import 'package:desafio/mobx/simulation_store.dart';
import 'package:desafio/screen/options_screen.dart';
import 'package:desafio/widget/button.dart';
import 'package:desafio/widget/primary/app_bar.dart';
import 'package:desafio/widget/primary/application.dart';
import 'package:desafio/widget/text_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SimulationScreen extends StatefulWidget {
  static String nameRoute = '/Simulação';
  static Map<String, Widget Function(BuildContext)> route = {
    nameRoute: (context) => const SimulationScreen(),
  };

  const SimulationScreen({Key? key}) : super(key: key);

  @override
  State<SimulationScreen> createState() => _SimulationScreenState();
}

class _SimulationScreenState extends State<SimulationScreen> {
  late PageSize pageSize;
  late final SimulationStore store;
  final controller = TextEditingController();

  @override
  void initState() {
    pageSize = PageSize(context);
    store = SimulationStore(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Application(
        appBar: AppBarCustom(context),
        pageSize: pageSize,
        paddingHorizontal: 30,
        children: [
          const SizedBox(height: 13),
          const AutoSizeText(
            'Simulação',
            minFontSize: 20,
            maxLines: 3,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600, height: 1.2),
          ),
          const SizedBox(height: 22),
          RadioListTile<Person>(
            value: Person.physical,
            groupValue: store.person,
            onChanged: (value) => store.person = value!,
            title: const Text('Pessoa Física'),
          ),
          RadioListTile<Person>(
            value: Person.legal,
            groupValue: store.person,
            onChanged: (value) => store.person = value!,
            title: const Text('Pessoa Jurídica'),
          ),
          const SizedBox(height: 40),
          const Text(
            'Entre com o valor médio da sua conta de energia:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 30),
          TextFieldCustom(
            width: 150,
            controller: store.controller,
            onChanged: (v) => store.value = v,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              PriceInputFormatter(),
            ],
            textInputType: TextInputType.number,
            prefixText: 'R\$',
          ),
          const SizedBox(height: 15),
          Slider(
            value: store.value,
            onChanged: (v) => store.value = v,
            min: 0,
            max: 100000,
          ),
          const SizedBox(height: 50),
          Button(
            text: 'Continuar',
            gradients: Gradients.green,
            onTap: () {
              Navigator.of(context).pushNamed(
                OptionsScreen.nameRoute,
                arguments: OptionsScreenArg(person: store.person, value: store.value),
              );
            },
          ),
        ],
      );
    });
  }
}

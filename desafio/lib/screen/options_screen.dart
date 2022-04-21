import 'package:auto_size_text/auto_size_text.dart';
import 'package:desafio/class/options_filter.dart';
import 'package:desafio/enum/gradients.dart';
import 'package:desafio/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:desafio/class/plan_model.dart';
import 'package:desafio/widget/options_tile.dart';
import 'package:desafio/class/page_size.dart';
import 'package:desafio/enum/person.dart';
import 'package:desafio/widget/primary/app_bar.dart';
import 'package:desafio/widget/primary/application.dart';
import 'package:url_launcher/url_launcher.dart';

class OptionsScreenArg {
  final Person person;
  final double value;
  const OptionsScreenArg({
    required this.person,
    required this.value,
  });
}

class OptionsScreen extends StatefulWidget {
  static String nameRoute = '/Opções';
  static Map<String, Widget Function(BuildContext)> route = {
    nameRoute: (context) => OptionsScreen(ModalRoute.of(context)?.settings.arguments as OptionsScreenArg),
  };

  final OptionsScreenArg arg;

  const OptionsScreen(
    this.arg, {
    Key? key,
  }) : super(key: key);

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  late PageSize pageSize;
  final controller = TextEditingController();

  @override
  void initState() {
    pageSize = PageSize(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Application(
      appBar: AppBarCustom(context),
      pageSize: pageSize,
      paddingHorizontal: 30,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 13),
        const Center(
          child: AutoSizeText(
            'Simulação',
            minFontSize: 20,
            maxLines: 3,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600, height: 1.2),
          ),
        ),
        const SizedBox(height: 22),
        const Text('Escolha uma das Cooperativas:'),
        const SizedBox(height: 20),
        FutureBuilder<List<PlanModel>>(
            future: OptionsFilter.future(person: widget.arg.person, value: widget.arg.value),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.data!.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 25),
                  child: Column(
                    children: [
                      const Text(
                        'Infelizmente ainda não estamos dando suporte para este caso. Para mais detalhes entre contado com nossos especialistas',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 70),
                      Button(
                        text: 'Falar com especialista',
                        gradients: Gradients.blue,
                        onTap: () => launch('http://wattio.com.br/contatowattio'),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                separatorBuilder: (_, __) => const SizedBox(height: 40),
                itemBuilder: (context, index) {
                  return OptionsTile(
                    plan: snapshot.data![index],
                    value: widget.arg.value,
                    isPar: index % 2 == 0,
                  );
                },
              );
            }),
        const SizedBox(height: 50),
      ],
    );
  }
}

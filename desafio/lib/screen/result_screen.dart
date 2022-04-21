import 'package:auto_size_text/auto_size_text.dart';
import 'package:desafio/enum/gradients.dart';
import 'package:desafio/widget/button.dart';
import 'package:flutter/material.dart';

import 'package:desafio/class/format_price.dart';
import 'package:desafio/class/page_size.dart';
import 'package:desafio/class/plan_model.dart';
import 'package:desafio/widget/primary/app_bar.dart';
import 'package:desafio/widget/primary/application.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultScreenArg {
  final PlanModel plan;
  final double value;
  const ResultScreenArg({
    required this.plan,
    required this.value,
  });
}

class ResultScreen extends StatefulWidget {
  static String nameRoute = '/Resultados';
  static Map<String, Widget Function(BuildContext)> route = {
    nameRoute: (context) => ResultScreen(ModalRoute.of(context)?.settings.arguments as ResultScreenArg),
  };

  final ResultScreenArg arg;

  const ResultScreen(
    this.arg, {
    Key? key,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with FormatPrice {
  late PageSize pageSize;

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
        const SizedBox(height: 50),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF32CC74),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const Text(
                  'Minha economia anual será de aproximadamente:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                Text(
                  'R\$ ' + formatWithDecimal(widget.arg.value * 12 * widget.arg.plan.discount),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFFE0000),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text.rich(
            TextSpan(
              text: 'Em média ',
              children: [
                TextSpan(
                  text: 'R\$ ' + formatWithDecimal(widget.arg.value * widget.arg.plan.discount),
                  style: const TextStyle(color: Color(0xFFFEBF00)),
                ),
                const TextSpan(text: ' por mês'),
              ],
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 50),
        const Text(
          'Agora é só entrar em contato conosco para que possamos transformar em realidade',
          style: TextStyle(fontSize: 17.2, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 100),
        Center(
          child: Button(
            text: 'Fale com um dos nossos especialista',
            gradients: Gradients.blue,
            width: 230,
            height: 70,
            paddingHorizontal: 25,
            fontSize: 20,
            maxLines: 2,
            onTap: () => launch('http://wattio.com.br/contatowattio'),
          ),
        ),
      ],
    );
  }
}

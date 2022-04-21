import 'package:desafio/enum/gradients.dart';
import 'package:desafio/screen/simulation_screen.dart';
import 'package:desafio/widget/button.dart';
import 'package:desafio/widget/dialog/sell_dialog.dart';
import 'package:flutter/material.dart';

import 'package:desafio/widget/primary/application.dart';
import 'package:desafio/class/page_size.dart';
import 'package:desafio/widget/primary/app_bar.dart';

class HomeScreen extends StatefulWidget {
  static String nameRoute = '/';
  static Map<String, Widget Function(BuildContext)> route = {
    nameRoute: (context) => const HomeScreen(),
  };

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageSize pageSize;

  static const String inf =
      'Somos uma plataforma inteligente para operacionalizar a gestão de clientes para consórcios, cooperativas, gestão em autoconsumo e gestão de clientes cativos. Fazemos todo o processo ponta a ponta, da coleta da fatura de energia ao pagamento, tudo de forma integrada e automatizada.';

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
      children: <Widget>[
        const SizedBox(height: 13),
        const Text(
          'O que deseja fazer hoje?',
          maxLines: 3,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600, height: 1.2),
        ),
        const SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Button(
              width: pageSize.pWidth * 40,
              text: 'Comprar',
              gradients: Gradients.green,
              onTap: () {
                Navigator.of(context).pushNamed(SimulationScreen.nameRoute);
              },
            ),
            Button(
              width: pageSize.pWidth * 40,
              text: 'Vender',
              gradients: Gradients.blue,
              onTap: () => SellDialog.open(context),
            ),
          ],
        ),
        const SizedBox(height: 67),
        const Text(
          'Sobre nós',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Image.asset(
            'asset/terra.png',
            height: 180,
          ),
        ),
        const SizedBox(height: 35),
        // letra maior e espaço entre linhas
        const Text(
          inf,
          style: TextStyle(fontSize: 16, letterSpacing: 00.5),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

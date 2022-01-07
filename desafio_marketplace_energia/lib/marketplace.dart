import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' show NumberFormat;

const Color lightColor = Color(0xff2a3132);
Color highlightColor = const Color(0xffff420e);
Color darkColor = const Color(0xff89da59);
const double valueMin = 1000.0;
const double valueMax = 100000.0;

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage>
    with SingleTickerProviderStateMixin {
  late final TextEditingController valueController;

  late final NumberFormat valueFormat =
      NumberFormat.currency(locale: 'pt-br', symbol: 'R\$');

  final List<dynamic> _cooperativas = [
    {
      'nome': 'EnerFácil',
      'minimo': valueMin,
      'maximo': 40000,
      'desconto': .2,
    },
    {
      'nome': 'EnerLimpa',
      'minimo': 10000,
      'maximo': 80000,
      'desconto': .25,
    },
    {
      'nome': 'EnerGrande',
      'minimo': 40000,
      'maximo': valueMax,
      'desconto': .3,
    }
  ];
  List<Map<String, dynamic>> _ofertas = [];

  int? _radioValue;
  int? _tempRadioValue;
  bool _refreshOfertas = true;
  bool _refreshEconomia = true;
  void updateOfertas() {
    try {
      List<Map<String, dynamic>> _auxList = [];
      valueDouble = valueFormat.parse(valueController.text).toDouble();
      valuePrintable = valueDouble;
      for (var _coop in _cooperativas) {
        if (valueDouble >= _coop['minimo'] && valueDouble <= _coop['maximo']) {
          _auxList.add(_coop);
        }
      }
      setState(() {
        _ofertas = _auxList;
      });
      return;
    } catch (e) {
      print(e);
      return;
    }
  }

  double valueDouble = valueMin;
  double valuePrintable = valueMin;
  bool _economiaVisibleFlag = false;
  bool _ofertasVisibleFlag = false;

  @override
  void initState() {
    valueController =
        TextEditingController(text: valueFormat.format(valueDouble));

    super.initState();
  }

  @override
  void dispose() {
    valueController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: lightColor,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Center(
          child: SizedBox(
            width: min(size.width, 460),
            child: ListView(
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    width: min(size.width, 460),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 24,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.store_mall_directory_rounded,
                                size: 64,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 11),
                                child: Text(
                                  'Calcule a economia\nda sua empresa',
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width < 360 ? 21 : 27,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(bottom: 19, top: 31),
                              constraints: const BoxConstraints(maxWidth: 390),
                              child: Text(
                                'O valor médio mensal da minha conta de energia é:',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width < 350 ? 13 : 15,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              constraints: const BoxConstraints(maxWidth: 350),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: darkColor.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: valueController,
                                cursorColor: darkColor,
                                onChanged: (value) {
                                  try {
                                    var _value = valueFormat.parse(value);
                                    if (_value < valueMin ||
                                        _value > valueMax) {
                                      throw Exception();
                                    }
                                    valueDouble = _value.toDouble();
                                    _refreshOfertas = true;
                                  } catch (e) {}
                                },
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                decoration: const InputDecoration(
                                  isCollapsed: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: highlightColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: size.width < 350 ? 39 : 44,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 8.0),
                              constraints: const BoxConstraints(maxWidth: 346),
                              child: Text(
                                'Digite o valor acima ou mova a '
                                'barra abaixo. Mínimo de '
                                '${valueFormat.format(valueMin)}.',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          inactiveColor: darkColor,
                          activeColor: highlightColor,
                          min: valueMin,
                          max: valueMax,
                          value: valueDouble,
                          onChanged: (double value) {
                            setState(() {
                              valueDouble = value;
                              _refreshOfertas = true;
                            });

                            valueController.text =
                                valueFormat.format(valueDouble);
                          },
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          margin: const EdgeInsets.only(top: 12, bottom: 24),
                          constraints: const BoxConstraints(maxWidth: 340),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: _refreshOfertas
                                ? highlightColor
                                : Colors.grey.shade300,
                            boxShadow: [
                              BoxShadow(
                                color: _refreshOfertas
                                    ? highlightColor.withOpacity(0.5)
                                    : Colors.grey.shade300.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: !_refreshOfertas
                                ? null
                                : () {
                                    updateOfertas();

                                    setState(() {
                                      if (!_ofertasVisibleFlag) {
                                        _ofertasVisibleFlag = true;
                                      }
                                      _refreshOfertas = false;
                                      _refreshEconomia = true;
                                    });
                                  },
                            child: Text(
                              _ofertasVisibleFlag
                                  ? 'Recalcular ofertas!'
                                  : 'Calcular ofertas!',
                              style: const TextStyle(
                                color: lightColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _ofertasVisibleFlag,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                for (var _oferta in _ofertas)
                                  Card(
                                    color: darkColor,
                                    child: Container(
                                      width: 260,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Radio<int>(
                                                    activeColor: highlightColor,
                                                    value: _ofertas
                                                        .indexOf(_oferta),
                                                    groupValue: _tempRadioValue,
                                                    onChanged: (value) {
                                                      if (value != null) {
                                                        setState(() {
                                                          _tempRadioValue =
                                                              value;
                                                          _refreshEconomia =
                                                              true;
                                                        });
                                                      }
                                                    }),
                                                Text(
                                                  'Oferta ${_ofertas.indexOf(_oferta) + 1}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: lightColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 2,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    'Cooperativa: ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: lightColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    _oferta['nome'],
                                                    style: const TextStyle(
                                                      color: lightColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 2,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    'Economia: ',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: lightColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    (_oferta['desconto'] * 100)
                                                            .toString() +
                                                        ' %',
                                                    style: const TextStyle(
                                                      color: lightColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _ofertasVisibleFlag,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            margin: const EdgeInsets.only(top: 12, bottom: 24),
                            constraints: const BoxConstraints(maxWidth: 340),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: _refreshEconomia
                                  ? highlightColor
                                  : Colors.grey.shade300,
                              boxShadow: [
                                BoxShadow(
                                  color: _refreshEconomia
                                      ? highlightColor.withOpacity(0.5)
                                      : Colors.grey.shade300.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: TextButton(
                              onPressed: !_refreshEconomia
                                  ? null
                                  : () {
                                      setState(() {
                                        _radioValue = _tempRadioValue;
                                        _refreshEconomia = false;
                                        if (!_economiaVisibleFlag) {
                                          _economiaVisibleFlag = true;
                                        }
                                      });
                                    },
                              child: Text(
                                _economiaVisibleFlag
                                    ? 'Recalcular economia'
                                    : 'Calcular economia',
                                style: const TextStyle(
                                  color: lightColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _economiaVisibleFlag,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    decoration: BoxDecoration(
                                      color: darkColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          alignment: Alignment.topCenter,
                                          padding: const EdgeInsets.only(
                                                top: 28,
                                                bottom: 4,
                                              ) +
                                              EdgeInsets.only(
                                                left:
                                                    size.width >= 480 ? 32 : 0,
                                              ),
                                          constraints: const BoxConstraints(
                                              maxWidth: 400),
                                          child: Text(
                                            'Minha economia anual será de até',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: lightColor,
                                              fontSize:
                                                  size.width < 350 ? 16 : 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                                bottom: 16,
                                              ) +
                                              const EdgeInsets.only(
                                                left: 0,
                                                top: 56,
                                              ),
                                          alignment: Alignment.bottomCenter,
                                          child: Text(
                                            valueFormat.format(
                                                _radioValue != null
                                                    ? (valuePrintable *
                                                        (_ofertas[_radioValue!]
                                                            ['desconto']) *
                                                        12)
                                                    : 0),
                                            style: TextStyle(
                                              color: highlightColor,
                                              fontSize: size.width < 350
                                                  ? 40
                                                  : size.width < 410
                                                      ? 42
                                                      : 52,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Center(
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Em média',
                                          style: TextStyle(
                                            color: darkColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                size.width < 360 ? 16 : 18,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' ' +
                                              valueFormat.format(_radioValue !=
                                                      null
                                                  ? (valuePrintable *
                                                      (_ofertas[_radioValue!]
                                                          ['desconto']))
                                                  : 0) +
                                              ' ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                size.width < 375 ? 21 : 26,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'por mês*',
                                          style: TextStyle(
                                            color: darkColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                size.width < 360 ? 16 : 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  padding: const EdgeInsets.only(top: 16),
                                  constraints:
                                      const BoxConstraints(maxWidth: 363),
                                  child: const Text(
                                    '*Essa é apenas uma simulação e não configura garantia do desconto.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                margin:
                                    const EdgeInsets.only(top: 18, bottom: 24),
                                constraints:
                                    const BoxConstraints(maxWidth: 340),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: highlightColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: highlightColor.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                              backgroundColor: highlightColor,
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Parabéns!',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: lightColor,
                                                      fontSize: 21,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ));
                                  },
                                  child: const Text(
                                    'Quero contratar!',
                                    style: TextStyle(
                                      color: lightColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 16))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

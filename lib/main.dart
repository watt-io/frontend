import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;

void main() => runApp(MaterialApp(

      home: Scaffold(

            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: Colors.yellowAccent,
              title: Row(mainAxisSize: MainAxisSize.min, children: const <Widget>[
                IconButton(
                  icon: Icon(IconData(0xf01e, fontFamily: 'MaterialIcons')),
                  color: Colors.white,
                  onPressed: null,
                  iconSize: 40,
                ),
                Text('MarketPlace de Energia'),
              ]),
            ),
          body: const ListaApp(),


    )
)

);


class ListaApp extends StatelessWidget {
  const ListaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView(
          children: const <Widget>[
            ItemListaOfertas(
                'O valor médio Mensal da minha conta de energia é:'),
            ListaOfertasStatefulWidget(),
            ItemListaOfertas('*Digite o valor ou arraste a barra!'),
            BarraStatefulWidget(),
            UmaOfertasStatefulWidget(),
          ],
        ));
  }
}

final List<dynamic> _tiposCooperativas = [
  {
    'empresa': 'Energia Para Todos',
    'valorMinimo': valueMin,
    'valorMaximo': 500,
    'valorDesconto': 0.15,
  },
  {
    'empresa': 'Energia Sustentavel',
    'valorMinimo': 400,
    'valorMaximo': 700,
    'valorDesconto': 0.25,
  },
  {
    'empresa': 'Energia Grupo',
    'valorMinimo': 500,
    'valorMaximo': valueMax,
    'valorDesconto': 0.35,
  }
];
late final NumberFormat valorFormatado =
    NumberFormat.currency(locale: 'pt-br', symbol: 'R\$');
late TextEditingController valorControlador;

double valueMin = 100.0;
double valueMax = 900.0;
double valueDouble = valueMin;
double valuePrintable = valueMin;
bool _renovarOfertas = true;
bool _renovarEconomia = true;
bool _ofertasVisibleFlag = false;
int? _radioValorTemporario;
int? _radioValor;
bool _economiaVisibleFlag = false;

class ItemListaOfertas extends StatelessWidget {
  final String texto;

  const ItemListaOfertas(this.texto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 0.8,
        horizontal: 0.8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Text(
          texto,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class ListaOfertasStatefulWidget extends StatefulWidget {
  const ListaOfertasStatefulWidget({Key? key}) : super(key: key);

  @override
  State<ListaOfertasStatefulWidget> createState() =>
      _ListaOfertasfulWidgetState();
}

class _ListaOfertasfulWidgetState extends State<ListaOfertasStatefulWidget> {
  @override
  void initState() {
    valorControlador =
        TextEditingController(text: valorFormatado.format(valueDouble));
    super.initState();
  }

  @override
  void dispose() {
    valorControlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellowAccent,
        margin: const EdgeInsets.symmetric(
        vertical: 0.8,
        horizontal: 0.8,
    ),
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextField(
            style: const TextStyle(
                fontSize: 30),
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
                  controller: valorControlador,
                  onChanged: (value) {
                    {
                      try {
                        var _value = valorFormatado.parse(value);
                        if (_value < valueMin || _value > valueMax) {
                          throw Exception();
                        }
                        valueDouble = _value.toDouble();
                        _renovarOfertas = true;
                      } catch (e) {}
                    }
                  },
                ),

        ),
      );
  }
}

class BarraStatefulWidget extends StatefulWidget {
  const BarraStatefulWidget({Key? key}) : super(key: key);

  @override
  State<BarraStatefulWidget> createState() => _BarraStatefulWidgetState();
}

class _BarraStatefulWidgetState extends State<BarraStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
          margin: const EdgeInsets.symmetric(
          vertical: 0.8,
          horizontal: 0.8,
          ),
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Slider(
                  max: valueMax,
                  min: valueMin,
                  value: valueDouble,
                  activeColor: Colors.black,
                  thumbColor: Colors.yellowAccent,
                  inactiveColor: Colors.black,
                  onChanged: (double value) {
                    setState(() {
                      valueDouble = value;
                      _renovarOfertas = true;
                    });
                    valorControlador.text = valorFormatado.format(valueDouble);
                  },
                )));
  }
}

class BotaoStatefulWidget extends StatefulWidget {
  const BotaoStatefulWidget({required this.atualizaOfertas, Key? key})
      : super(key: key);
  final void Function() atualizaOfertas;

  @override
  State<BotaoStatefulWidget> createState() => _BotaoStatefulWidgetState();
}

class _BotaoStatefulWidgetState extends State<BotaoStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
          color: Colors.yellowAccent,
          margin: const EdgeInsets.symmetric(vertical: 3.8, horizontal: 0.8),
          child:
            ElevatedButton(
              onPressed: !_renovarOfertas
                  ? null
                  : () {
                      widget.atualizaOfertas();
                      setState(() {
                        if (!_ofertasVisibleFlag) {
                          _ofertasVisibleFlag = true;
                        }
                        _renovarOfertas = false;
                        _renovarEconomia = true;
                      });
                    },
              style:  ButtonStyle(
                backgroundColor: MaterialStateProperty.all((Colors.yellowAccent)),
                padding: MaterialStateProperty.all(const EdgeInsets.all(25.0)),
                textStyle: MaterialStateProperty.all((const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black))),
              ),
              child: Text(
                _ofertasVisibleFlag
                    ? 'Recalcular ofertas!'
                    : 'Calcular Ofertas!',
                style: const TextStyle(
                  color: Colors.black,
                ),
                ),
              ),
            );
  }
}

class BotaoEconomiaStatefulWidget extends StatefulWidget {
  const BotaoEconomiaStatefulWidget({required this.atualizaOfertas, Key? key})
      : super(key: key);
  final void Function() atualizaOfertas;

  @override
  State<BotaoEconomiaStatefulWidget> createState() =>
      _BotaoEconomiaStatefulWidgetState();
}

class _BotaoEconomiaStatefulWidgetState
    extends State<BotaoEconomiaStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: _ofertasVisibleFlag,
          child: Card(
              color: Colors.yellowAccent,
              margin: const EdgeInsets.symmetric(vertical: 3.8, horizontal: 0.8),
              child:
            ElevatedButton(
              onPressed: !_renovarEconomia
                  ? null
                  : () {
                widget.atualizaOfertas();
                      setState(() {
                        if (!_economiaVisibleFlag) {
                          _economiaVisibleFlag = true;
                        }
                        _radioValor = _radioValorTemporario;
                        _renovarEconomia = false;
                      });
                    },
              style:  ButtonStyle(
                backgroundColor: MaterialStateProperty.all((Colors.yellowAccent)),
                padding: MaterialStateProperty.all(const EdgeInsets.all(25.0)),
                textStyle: MaterialStateProperty.all((const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black))),
              ),
              child: Text(
                _economiaVisibleFlag
                    ? 'Recalcular Economia!'
                    : 'Calcular Economia',
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),

            )
          ),
        );
  }
}

class EconomiaAnualStatefulWidget extends StatefulWidget {
  const EconomiaAnualStatefulWidget({required this.atualizaOfertas,required this.ofertas, Key? key})
      : super(key: key);
  final void Function() atualizaOfertas;
  final List<Map<String, dynamic>> ofertas;

  @override
  State<EconomiaAnualStatefulWidget> createState() =>
      _EconomiaAnualStatefulWidgetState();
}

class _EconomiaAnualStatefulWidgetState
    extends State<EconomiaAnualStatefulWidget> {


  _EconomiaAnualStatefulWidgetState();

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: _economiaVisibleFlag,
        child: Column(
            children: [
          const Card(
        margin: EdgeInsets.symmetric(
          vertical: 0.8,
          horizontal: 0.8,),
            color: Color(0XFAFAFAFA),
            child: Padding(
              padding: EdgeInsets.all(25.0),
                child: Text(
              'Minha economia anual será de:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),),
              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 0.8,
                  horizontal: 0.8,),
                  color: Colors.yellowAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      valorFormatado.format(_radioValor != null ? (valuePrintable * (widget.ofertas[_radioValor!]['valorDesconto']) * 12) : 0),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),),

          Card(
            margin: const EdgeInsets.symmetric(
              vertical: 0.0,
              horizontal: 0.0,),
            color: const Color(0XFAFAFAFA),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
                      child: Text(
                        'Em média ' + valorFormatado.format(_radioValor != null ? (valuePrintable * (widget.ofertas[_radioValor!]['valorDesconto'])) : 0) + 'por mês!' ,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),),
          const Card(
              margin: EdgeInsets.symmetric(
                vertical: 0.8,
                horizontal: 0.8,),
            color: Color(0XFAFAFAFA),
             child: Padding(
              padding: EdgeInsets.all(25.0),
                      child: Text(' ** Atenção, isso é uma simulação!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )),
                  ]));
  }
}


class QueroContratarStatefulWidget extends StatefulWidget {
  const QueroContratarStatefulWidget({required this.atualizaOfertas, Key? key})
      : super(key: key);
  final void Function() atualizaOfertas;

  @override
  State<QueroContratarStatefulWidget> createState() =>
      _QueroContratarStatefulWidgetState();
}

class _QueroContratarStatefulWidgetState
    extends State<QueroContratarStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: _economiaVisibleFlag,
        child: Card(
            color: Colors.yellowAccent,
            margin: const EdgeInsets.symmetric(vertical: 3.8, horizontal: 0.8),
            child:
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => const Dialog(
                        backgroundColor: Colors.yellowAccent,
                        child: Text(
                          'Parabéns!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ));
                },
                style:  ButtonStyle(
                  backgroundColor: MaterialStateProperty.all((Colors.yellowAccent)),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(25.0)),
                  textStyle: MaterialStateProperty.all((const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black))),
                ),
                child: const Text(
                  'Quero Contratar!',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ));
  }
}


class UmaOfertasStatefulWidget extends StatefulWidget {
  const UmaOfertasStatefulWidget({Key? key}) : super(key: key);

  @override
  State<UmaOfertasStatefulWidget> createState() =>
      _UmaOfertasStatefulWidgetState();
}

class _UmaOfertasStatefulWidgetState extends State<UmaOfertasStatefulWidget> {
  List<Map<String, dynamic>> _ofertas = [];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BotaoStatefulWidget(
        atualizaOfertas: atualizarOfertas,
      ),
      Visibility(
        visible: _ofertasVisibleFlag,
        child: SizedBox(
                width: 280,
            child: Column(
                children: <Widget>[
              for (var _oferta in _ofertas)
                Card(
                    color: Colors.black54,
                    margin: const EdgeInsets.all(3.0),

                    child: RadioListTile<int>(
                      selectedTileColor: Colors.yellowAccent,
                      activeColor: Colors.yellowAccent,
                      value: _ofertas.indexOf(_oferta),
                      groupValue: _radioValorTemporario,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _radioValorTemporario = value;
                            _renovarEconomia = true;
                          });
                        }
                      },
                      title: Text('Oferta ${_ofertas.indexOf(_oferta) + 1}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          )
                      ),
                      subtitle: Column(
                        children: [
                          Center(
                            child: Text(_oferta['empresa'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  )),

                          ),

                          Center(
                            child: Text(
                                  (_oferta['valorDesconto'] * 100).toString() +
                                      '%',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  )
                              ),
                          ),
                        ],
                      ),
                    )
                )
            ]
            )
            ),
        ),
        Visibility(
          visible: _ofertasVisibleFlag,
            child: BotaoEconomiaStatefulWidget(atualizaOfertas: atualizarOfertas),
              ),
      Visibility(
        visible: _economiaVisibleFlag,
        child: EconomiaAnualStatefulWidget(atualizaOfertas: atualizarOfertas, ofertas: _ofertas),
      ),
      Visibility(
          visible: _ofertasVisibleFlag,
          child: QueroContratarStatefulWidget(atualizaOfertas: atualizarOfertas),
            ),
          ]);
  }

  void atualizarOfertas() {
    try {
      List<Map<String, dynamic>> _auxList = [];
      valueDouble = valorFormatado.parse(valorControlador.text).toDouble();
      valuePrintable = valueDouble;

      for (var _cooperativa in _tiposCooperativas) {
        if (valueDouble >= _cooperativa['valorMinimo'] &&
            valueDouble <= _cooperativa['valorMaximo']) {
          _auxList.add(_cooperativa);
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
}

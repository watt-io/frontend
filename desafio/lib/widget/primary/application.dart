import 'package:desafio/widget/primary/drawer_custom.dart';
import 'package:flutter/material.dart';

import 'package:desafio/class/page_size.dart';
import 'package:desafio/widget/primary/app_bar.dart';

class Application extends StatefulWidget {
  final List<Widget> children;
  final PageSize pageSize;
  final CrossAxisAlignment crossAxisAlignment;
  final AppBarCustom appBar;
  final double paddingHorizontal;

  const Application({
    Key? key,
    required this.children,
    required this.pageSize,
    required this.appBar,
    this.paddingHorizontal = 10,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.pageSize.isWeb ? null : widget.appBar,
      drawer: const DrawerCustom(),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            'asset/fundo.jpg',
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Container(
            color: Colors.white,
            width: widget.pageSize.isWeb ? widget.pageSize.widthDefault : MediaQuery.of(context).size.width,
          ),
          Column(
            children: [
              if (widget.pageSize.isWeb)
                SizedBox(
                  width: widget.pageSize.isWeb ? widget.pageSize.widthDefault : double.infinity,
                  child: widget.appBar.webAppBar(),
                ),
              Expanded(
                child: Scrollbar(
                  isAlwaysShown: false,
                  thickness: 5,
                  radius: const Radius.circular(10),
                  child: ScrollConfiguration(
                    behavior: _NoGlowBehavior(),
                    child: SingleChildScrollView(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: widget.paddingHorizontal),
                          color: Colors.white,
                          width: widget.pageSize.isWeb ? widget.pageSize.widthDefault : double.infinity,
                          child: Column(
                            crossAxisAlignment: widget.crossAxisAlignment,
                            children: [
                              // if (widget.pageSize.isWeb) widget.appBar.webAppBar(),
                              ...widget.children,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Remove o efeito da Scroll
class _NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

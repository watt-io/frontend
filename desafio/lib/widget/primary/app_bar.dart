import 'package:flutter/material.dart';

class AppBarCustom extends AppBar {
  final BuildContext context;

  AppBarCustom(
    this.context, {
    Key? key,
  }) : super(
          backgroundColor: Colors.white,
          key: key,
          elevation: 0,
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              if (Navigator.canPop(context))
                Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      if (Navigator.canPop(context)) return Navigator.of(context).pop();
                      Scaffold.of(context).openDrawer();
                    },
                  );
                })
              else
                Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      if (Navigator.canPop(context)) return Navigator.of(context).pop();
                      Scaffold.of(context).openDrawer();
                    },
                  );
                }),
              Expanded(
                child: Center(
                  child: Image.asset(
                    'asset/WATTio_logo.png',
                    height: 26,
                  ),
                ),
              ),
              SizedBox(
                height: 33,
                child: CircleAvatar(
                  backgroundImage: Image.asset(
                    'asset/perfil.jpg',
                    height: 10,
                    filterQuality: FilterQuality.high,
                  ).image,
                ),
              ),
              const SizedBox(width: 13),
            ],
          ),
        );

  Widget webAppBar() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 42,
      width: double.infinity,
      color: backgroundColor,
      child: title,
    );
  }
}

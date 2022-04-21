import 'package:desafio/screen/create_plan_screen.dart';
import 'package:desafio/screen/home_screen.dart';
import 'package:desafio/widget/primary/drawer_tile.dart';
import 'package:flutter/material.dart';

class DrawerCustom extends StatefulWidget {
  const DrawerCustom({Key? key}) : super(key: key);

  @override
  _DrawerCustomState createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
        child: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: <Widget>[
                          const SizedBox(height: 20),
                          Center(
                            child: Image.asset(
                              'asset/WATTio_logo.png',
                              height: 26,
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Divider(),
                          DrawerTile(icon: Icons.house, name: 'Home', route: HomeScreen.nameRoute, isCanBack: false),
                          const Divider(),
                          const DrawerTile(icon: Icons.person, name: 'Perfil', route: ''),
                          const Divider(),
                          DrawerTile(icon: Icons.table_view, name: 'Criar um Plano', route: CreatePlanScreen.nameRoute),
                          const Divider(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Align(
                  alignment: Alignment.center,
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Text(
                      'Sair',
                      style: TextStyle(color: Colors.black),
                    ),
                    label: const Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

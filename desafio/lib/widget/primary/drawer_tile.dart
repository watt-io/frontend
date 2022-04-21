import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String name;
  final String route;
  final bool isCanBack;
  const DrawerTile({
    required this.icon,
    required this.name,
    required this.route,
    this.isCanBack = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: InkWell(
        child: SizedBox(
          height: 52,
          child: Row(
            children: <Widget>[
              Icon(icon, size: 32),
              const SizedBox(width: 20),
              Expanded(
                child: AutoSizeText(
                  name,
                  style: const TextStyle(fontSize: 22),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        onTap: () async {
          Navigator.of(context).pop();
          if (route != '') Navigator.pushNamedAndRemoveUntil(context, route, (route) => isCanBack);
        },
      ),
    );
  }
}

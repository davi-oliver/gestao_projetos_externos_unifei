import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gestao_projeto_unifei/app/home/home_widget.dart';
import 'package:gestao_projeto_unifei/global/theme/theme_mode.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ValidaFormImovel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KThemeModeApp.of(context).primaryBackground,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: HomeWidgets(context).widgetprincipal(),
      ),
    );
  }
}

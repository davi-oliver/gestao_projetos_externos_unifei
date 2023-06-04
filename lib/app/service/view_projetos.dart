import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gestao_projeto_unifei/app/service/view_widgets.dart';
import 'package:gestao_projeto_unifei/global/theme/theme_mode.dart';

class AllProjetos extends StatefulWidget {
  const AllProjetos({super.key});

  @override
  State<AllProjetos> createState() => _AllProjetosState();
}

class _AllProjetosState extends State<AllProjetos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KThemeModeApp.of(context).primary,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ProjetoWidgets(context).widgetprincipal(),
      ),
    );
  }
}

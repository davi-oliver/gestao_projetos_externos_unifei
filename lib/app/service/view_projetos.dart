import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gestao_projeto_unifei/app/home/home_widget.dart';
import 'package:gestao_projeto_unifei/app/home/store/store.dart';
import 'package:gestao_projeto_unifei/app/service/view_widgets.dart';
import 'package:gestao_projeto_unifei/global/theme/theme_mode.dart';
import 'package:provider/provider.dart';

class AllProjetos extends StatefulWidget {
  const AllProjetos({super.key});

  @override
  State<AllProjetos> createState() => _AllProjetosState();
}

class _AllProjetosState extends State<AllProjetos> {
  bool initDid = false;
  late HomeStore homeStore;

  @override
  void didChangeDependencies() {
    homeStore = Provider.of<HomeStore>(context, listen: false);
    init();
    super.didChangeDependencies();
  }

  init() {
    if (!initDid) {
      // homeStore.getInfosFirebase();
      homeStore.getProjetos();
      initDid = true;
    }
  }

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 30), (_) {
      ProjetoWidgets(context).alertAvaliacao(homeStore.userEmail);
      _cancelTimer();
    });
  }

  void _cancelTimer() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KThemeModeApp.of(context).secondaryBackground,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ProjetoWidgets(context).widgetprincipal(),
      ),
    );
  }
}

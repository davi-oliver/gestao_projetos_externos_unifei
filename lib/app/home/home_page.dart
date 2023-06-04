import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gestao_projeto_unifei/app/home/home_functions.dart';
import 'package:gestao_projeto_unifei/app/home/home_widget.dart';
import 'package:gestao_projeto_unifei/app/home/store/store.dart';
import 'package:gestao_projeto_unifei/global/theme/theme_mode.dart';
import 'package:gestao_projeto_unifei/global/widget/widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ValidaForm {
  late HomeStore homeStore;
  bool initDid = false;
  @override
  void didChangeDependencies() {
    homeStore = Provider.of<HomeStore>(context);
    if (!initDid) {
      init();
      initDid = true;
    }
    super.didChangeDependencies();
  }

  init() {
    homeStore.addController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KThemeModeApp.of(context).primary,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Observer(
                  builder: (_) {
                    return HomeWidgets(context).widgetprincipal();
                  },
                ),
                Observer(
                  builder: (_) {
                    return Visibility(
                      visible: homeStore.isLoading,
                      child: GlobalWidget(context).loadingPrincipal(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

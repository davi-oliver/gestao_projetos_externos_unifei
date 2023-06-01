import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gestao_projeto_unifei/app/home/store/store.dart';
import 'package:gestao_projeto_unifei/global/theme/theme_mode.dart';
import 'package:gestao_projeto_unifei/global/widget/widget.dart';
import 'package:provider/provider.dart';
import 'package:mobx/mobx.dart';

class HomeWidgets {
  BuildContext context;
  HomeWidgets(this.context);

  Widget widgetprincipal() {
    final store = Provider.of<HomeStore>(context, listen: false);
    return Stack(
      children: [
        GlobalWidget(context)
            .AppbarCustom('Home', Icons.arrow_back_ios, false, true),
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * .78,
            width: MediaQuery.of(context).size.width * .85,
            margin: EdgeInsets.symmetric(vertical: 120, horizontal: 40),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3, 4),
                      blurRadius: 0.5,
                      spreadRadius: 0.5)
                ],
                borderRadius: BorderRadius.circular(15),
                color: KThemeModeApp.of(context).primaryBackground),
            child: Column(
              children: [
                // appbar customizada

                // barra de progresso customizada
                // deve aumentar o tamanho da barra de progresso de acordo com a quantidade de inputs preenchidos
                // monta uma lista de inputs dinamicos
                Observer(builder: (_) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: store.listaControladores.length,
                    itemBuilder: (context, index) {
                      // para cada item vai ser criado um controller
                      return Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          TextFieldCampo(
                              icon: Icon(store.lista[index]['icone']),
                              icon2: Icon(null),
                              titulo: "${store.lista[index]['campo']}",
                              numero: index == 0 ? true : false,
                              style: KThemeModeApp.of(context)
                                  .bodyMedium
                                  .copyWith(
                                      color:
                                          KThemeModeApp.of(context).primaryText,
                                      fontWeight: FontWeight.bold),
                              controllador: store.listaControladores[index],
                              onTap: () {}),
                        ],
                      );
                    },
                  );
                }),
                // botão de enviar
                // deve ser desabilitado enquanto não estiverem todos os inputs preenchidos
                // deve ser habilitado quando todos os inputs estiverem preenchidos
                // deve ser desabilitado quando o usuário clicar no botão de enviar

                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .5,
                  height: MediaQuery.of(context).size.height * .08,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(3, 4),
                            blurRadius: 0.5,
                            spreadRadius: 0.5)
                      ],
                      color: KThemeModeApp.of(context).primary,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    onPressed: () {
                      // setar loading para true
                      // chamar funcão de validação
                      // se estiver tudo ok, chamar a função de envio para FirebaseDatabase
                      // then concluido com sucesso, setar loading para false
                      // aparecer alert de sucesso
                      // else
                      // aparecer alert de erro
                      // setar loading para false
                      // apontar o campo onde o erro ocorreu
                      // ou seja, o campo que não foi preenchido
                      // ou mostrar no alert o erro
                    },
                    child: Text(
                      "Enviar",
                      style: KThemeModeApp.of(context).bodyMedium.copyWith(
                          color: KThemeModeApp.of(context).primaryBackground),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

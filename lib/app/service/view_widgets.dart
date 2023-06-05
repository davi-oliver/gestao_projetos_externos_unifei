import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gestao_projeto_unifei/app/home/store/store.dart';
import 'package:gestao_projeto_unifei/app/service/avaliacao.dart';
import 'package:gestao_projeto_unifei/global/theme/theme_mode.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProjetoWidgets {
  BuildContext context;
  ProjetoWidgets(this.context);
  Widget widgetprincipal() {
    final store = Provider.of<HomeStore>(context, listen: false);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // IconButton(
                //     onPressed: () {
                //       Navigator.of(context).pop();
                //     },
                //     icon: Icon(
                //       Icons.close,
                //       color: KThemeModeApp.of(context).primaryText,
                //     )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Olá",
                        style: KThemeModeApp.of(context).bodySmall.copyWith(
                            color: KThemeModeApp.of(context).primaryText)),
                    Text("${store.userEmail ?? "Visitante"}",
                        style: KThemeModeApp.of(context).bodySmall.copyWith(
                            color: KThemeModeApp.of(context).primaryText)),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .08,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor:
                        KThemeModeApp.of(context).primaryBackground,
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.dashboard_outlined,
                      color: KThemeModeApp.of(context).secondary),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Veja os projetos mais acessados",
                    style: KThemeModeApp.of(context).headlineSmall,
                  )
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: store.listProjetos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    alertCadastro(
                      context: context,
                      title: store.listProjetos[index]["nome"],
                      responsavel: store.listProjetos[index]["responsavel"],
                      imagem: store.listProjetos[index]["imagem"],
                      vagas: store.listProjetos[index]["quantidadeVagas"],
                      nomeUser: store.userEmail ?? "Visitante",
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .9,
                    height: MediaQuery.of(context).size.height * .45,
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage(store.listProjetos[index]["imagem"]),
                            fit: BoxFit.cover),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(3, 4),
                              blurRadius: 0.5,
                              spreadRadius: 0.5)
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: KThemeModeApp.of(context).primaryText),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5, left: 5),
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(3, 4),
                                      blurRadius: 0.5,
                                      spreadRadius: 0.5)
                                ],
                                color:
                                    KThemeModeApp.of(context).primaryBackground,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              height: MediaQuery.of(context).size.height * .1,
                              width: MediaQuery.of(context).size.width * .18,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("${store.listProjetos[index]["dia"]} ",
                                      style: KThemeModeApp.of(context)
                                          .headlineSmall
                                          .copyWith(
                                              color: KThemeModeApp.of(context)
                                                  .primary)),
                                  Text("${store.listProjetos[index]["mes"]}",
                                      style: KThemeModeApp.of(context)
                                          .bodyLarge
                                          .copyWith(
                                              color: KThemeModeApp.of(context)
                                                  .primary)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          height: MediaQuery.of(context).size.height * .1,
                          padding: EdgeInsets.symmetric(
                            horizontal: 25,
                          ),
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(3, 4),
                                    blurRadius: 0.5,
                                    spreadRadius: 0.5)
                              ],
                              borderRadius: BorderRadius.circular(15),
                              color:
                                  KThemeModeApp.of(context).primaryBackground),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.info,
                                              color: KThemeModeApp.of(context)
                                                  .primary),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "${store.listProjetos[index]["nome"]} ",
                                            overflow: TextOverflow.ellipsis,
                                            style: KThemeModeApp.of(context)
                                                .headlineSmall
                                                .copyWith(
                                                    color: KThemeModeApp.of(
                                                            context)
                                                        .primaryText),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.person,
                                              color: KThemeModeApp.of(context)
                                                  .primary),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Responsável: ${store.listProjetos[index]["responsavel"]} ",
                                            style: KThemeModeApp.of(context)
                                                .headlineSmall
                                                .copyWith(
                                                    color: KThemeModeApp.of(
                                                            context)
                                                        .primaryText),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.work,
                                      color: KThemeModeApp.of(context).primary),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      "Vagas restantes: ${store.listProjetos[index]["quantidadeVagas"]}",
                                      style: KThemeModeApp.of(context)
                                          .bodyLarge
                                          .copyWith(
                                              color: KThemeModeApp.of(context)
                                                  .primaryText)),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(FontAwesomeIcons.linkedin,
                                          color: KThemeModeApp.of(context)
                                              .primary),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Candidatar-se",
                                          style: KThemeModeApp.of(context)
                                              .bodyMedium
                                              .copyWith(
                                                  color:
                                                      KThemeModeApp.of(context)
                                                          .primaryText)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  alertCadastro({context, title, responsavel, imagem, vagas, nomeUser}) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromRight,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      backgroundColor: KThemeModeApp.of(context).primaryBackground,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: KThemeModeApp.of(context).headlineMedium.copyWith(
          color: KThemeModeApp.of(context).secondary,
          fontWeight: FontWeight.bold),
      overlayColor: Color(0x55000000),
    );

    // Alert dialog using custom alert style
    Alert(
      context: context,
      style: alertStyle,
      title: "Parabéns, $nomeUser",
      image: Image.asset("$imagem"),
      content: Container(
          child: Column(
        children: [
          Text(
            "Você se candidatou para a vaga de $title, com sucesso.",
            style: KThemeModeApp.of(context).headlineSmall.copyWith(
                  color: KThemeModeApp.of(context).primaryBtnText,
                ),
          ),
          Text(
            "O representante do projeto, $responsavel, entrará em contato com você em breve.",
            style: KThemeModeApp.of(context).headlineSmall.copyWith(
                  color: KThemeModeApp.of(context).primaryBtnText,
                ),
          ),
        ],
      )),
      buttons: [
        DialogButton(
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: KThemeModeApp.of(context).primary,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: InkWell(
                            child: Text(
                              "Fechar",
                              style: KThemeModeApp.of(context)
                                  .bodySmall
                                  .copyWith(
                                      color: KThemeModeApp.of(context)
                                          .primaryBtnText,
                                      fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop();
          },
          color: KThemeModeApp.of(context).primary,
          radius: BorderRadius.circular(10.0),
        ),
      ],
    ).show();
  }

  alertAvaliacao(nomeUser) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromRight,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      backgroundColor: KThemeModeApp.of(context).primaryBackground,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: KThemeModeApp.of(context).headlineMedium.copyWith(
          color: KThemeModeApp.of(context).primaryText,
          fontWeight: FontWeight.bold),
      overlayColor: Color(0x55000000),
    );

    // Alert dialog using custom alert style
    Alert(
      context: context,
      style: alertStyle,
      title: "$nomeUser",
      image: Image.asset("assets/images/logo.png"),
      content: Container(
          child: Column(
        children: [
          Text(
            "Você já avaliou este projeto? Se sim, obrigado pela sua avaliação.",
            style: KThemeModeApp.of(context).headlineSmall.copyWith(
                  color: KThemeModeApp.of(context).primaryBtnText,
                ),
          ),
          Text(
            "Senao, por favor, avalie clicando no botão abaixo.",
            style: KThemeModeApp.of(context).headlineSmall.copyWith(
                  color: KThemeModeApp.of(context).primaryBtnText,
                ),
          ),
        ],
      )),
      buttons: [
        DialogButton(
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: KThemeModeApp.of(context).primary,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: InkWell(
                            child: Text(
                              "Avaliar",
                              style: KThemeModeApp.of(context)
                                  .bodySmall
                                  .copyWith(
                                      color: KThemeModeApp.of(context)
                                          .primaryBtnText,
                                      fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          onPressed: () async {
            Navigator.of(context, rootNavigator: true).pop();
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AvaliacaoPage()));
          },
          color: KThemeModeApp.of(context).primary,
          radius: BorderRadius.circular(10.0),
        ),
      ],
    ).show();
  }
}

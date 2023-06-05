import 'package:flutter/material.dart';
import 'package:gestao_projeto_unifei/app/service/view_projetos.dart';
import 'package:gestao_projeto_unifei/global/theme/theme_mode.dart';
import 'package:gestao_projeto_unifei/global/widget/widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AvaliacaoPage extends StatefulWidget {
  @override
  _AvaliacaoPageState createState() => _AvaliacaoPageState();
}

class _AvaliacaoPageState extends State<AvaliacaoPage> {
  bool _carregando = false;
  List<int> avaliacoes = [0, 0, 0, 0, 0]; // Lista para armazenar as avaliações
  List<String> perguntas = [
    'O formulário de inscrição foi fácil de responder?',
    'A navegação no aplicativo é intuitiva?',
    'O design do aplicativo é atraente?',
    'O tempo de resposta do aplicativo é rápido?',
    'Você recomendaria este aplicativo para um amigo?'
  ]; // Lista de perguntas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _carregando
          ? GlobalWidget(context).loadingPrincipal()
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: KThemeModeApp.of(context).primaryBackground,
              child: Column(
                children: [
                  SafeArea(
                    child: GlobalWidget(context).AppbarCustom(
                        "Avaliação", Icons.arrow_back_ios, true, true),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: List.generate(perguntas.length, (index) {
                        return buildAvaliacaoCard(index);
                      }),
                    ),
                  ),

                  // Botão de enviar

                  botaoEnviar(),
                ],
              ),
            ),
    );
  }

  alertErro(title) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromRight,
      isCloseButton: false,
      isOverlayTapDismiss: false,
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
      title: "Atenção!",
      image: Image.asset("assets/images/alert.jpg"),
      content: Container(
          child: Column(
        children: [
          Text(
            title,
            style: KThemeModeApp.of(context).headlineSmall.copyWith(
                  color: KThemeModeApp.of(context).secondaryText,
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

  alertSucess(title) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromRight,
      isCloseButton: false,
      isOverlayTapDismiss: false,
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
      title: "Obrigado!",
      image: Image.network(
          "https://cdn.dribbble.com/users/129972/screenshots/3964116/75_smile.gif"),
      content: Container(
          child: Column(
        children: [
          Text(
            title,
            style: KThemeModeApp.of(context).headlineSmall.copyWith(
                  color: KThemeModeApp.of(context).secondaryText,
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
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => AllProjetos()),
                (route) => true);
          },
          color: KThemeModeApp.of(context).primary,
          radius: BorderRadius.circular(10.0),
        ),
      ],
    ).show();
  }

  botaoEnviar() {
    return Container(
      width: MediaQuery.of(context).size.width * .5,
      height: MediaQuery.of(context).size.height * .08,
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .1),
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
        onPressed: () async {
          setState(() {
            _carregando = true;
          });

          await Future.delayed(Duration(seconds: 2));

          setState(() {
            _carregando = false;
          });

          // await HomeFunctions(context).enviaProjeto().then((value) {
          //   if (value) {

          //     Navigator.of(context)
          //         .push(MaterialPageRoute(builder: (_) => AllProjetos()));
          //   } else {

          return alertSucess("Agradeçemos sua avaliação!");
          //   }
          // });
        },
        child: Text(
          "Enviar",
          style: KThemeModeApp.of(context)
              .bodyMedium
              .copyWith(color: KThemeModeApp.of(context).primaryBackground),
        ),
      ),
    );
  }

  Widget buildAvaliacaoCard(int index) {
    return Card(
      elevation: 2.0,
      color: KThemeModeApp.of(context).secondaryBackground,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              perguntas[index],
              style: KThemeModeApp.of(context).bodyLarge,
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(11, (rating) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      avaliacoes[index] = rating;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: avaliacoes[index] >= rating
                          ? Color.lerp(Colors.red, Colors.green,
                              (avaliacoes[index] - 5) / 2)
                          : Colors.grey[300],
                    ),
                    child: Center(
                      child: Text(
                        rating.toString(),
                        style: TextStyle(
                          color: avaliacoes[index] >= rating
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

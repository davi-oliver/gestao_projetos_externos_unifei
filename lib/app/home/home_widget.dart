// import 'package:components_ui/components_ui.dart';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gestao_projeto_unifei/app/home/home_functions.dart';
import 'package:gestao_projeto_unifei/app/home/store/store.dart';
import 'package:gestao_projeto_unifei/app/service/view_projetos.dart';
import 'package:gestao_projeto_unifei/global/theme/theme_mode.dart';
import 'package:gestao_projeto_unifei/global/widget/widget.dart';
// import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';
import 'package:provider/provider.dart';
import 'package:mobx/mobx.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .9,
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * .1,
                  horizontal: 5),
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // appbar customizada
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info,
                          color: KThemeModeApp.of(context).primary),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Formulário de cadastro do projeto",
                        style: KThemeModeApp.of(context).bodySmall.copyWith(
                            color: KThemeModeApp.of(context).primaryText,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  // barra de progresso customizada
                  // deve aumentar o tamanho da barra de progresso de acordo com a quantidade de inputs preenchidos
                  // monta uma lista de inputs dinamicos
                  listView(),
                  // bo,tão de enviar
                  // deve ser desabilitado enquanto não estiverem todos os inputs preenchidos
                  // deve ser habilitado quando todos os inputs estiverem preenchidos
                  // deve ser desabilitado quando o usuário clicar no botão de enviar
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_outlined,
                          color: KThemeModeApp.of(context).primary),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Escolha até 3 imagens para o projeto",
                        style: KThemeModeApp.of(context).bodySmall.copyWith(
                            color: KThemeModeApp.of(context).primaryText,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                  botaoImagens(),
                  mostraImagem(),
                  SizedBox(
                    height: 20,
                  ),
                  botaoEnviar(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  botaoEnviar() {
    final store = Provider.of<HomeStore>(context, listen: false);
    return Observer(builder: (_) {
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
            store.setLoad(true);
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
            for (var i = 0; i < store.listaControladores.length; i++) {
              if (store.listaControladores[i].text.isEmpty) {
                print("Campo ${store.lista[i]['campo']} não preenchido");
                store.setLoad(false);

                return alertErro(
                    "Campo ${store.lista[i]['campo']} não preenchido");
              }
            }

            await HomeFunctions(context).enviaProjeto().then((value) {
              if (value) {
                store.setLoad(false);

                alertErro("Projeto enviado com sucesso!");
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => AllProjetos()));
              } else {
                store.setLoad(false);

                return alertErro("Erro ao enviar projeto!");
              }
            });
          },
          child: Text(
            "Enviar",
            style: KThemeModeApp.of(context)
                .bodyMedium
                .copyWith(color: KThemeModeApp.of(context).primaryBackground),
          ),
        ),
      );
    });
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

  botaoImagens() {
    final store = Provider.of<HomeStore>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      color: KThemeModeApp.of(context).primary,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
          ),
          minimumSize: MaterialStateProperty.all<Size>(
            Size(150, 50),
          ),
          elevation: MaterialStateProperty.all<double>(3),
        ),
        onPressed: () async {
          loadAssets(store.listImagesView);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('Adicionar Imagens',
                style: KThemeModeApp.of(context)
                    .bodyMedium
                    .copyWith(color: KThemeModeApp.of(context).primaryBtnText)),
            SizedBox(width: 10),
            Icon(
              FontAwesomeIcons.plus,
              color: KThemeModeApp.of(context).primaryBackground,
            ),
          ],
        ),
      ),
    );
  }

  mostraImagem() {
    final store = Provider.of<HomeStore>(context, listen: false);
    return store.listImagesView.isNotEmpty
        ? Container(
            padding: EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width / 1.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    children: List.generate(
                      store.listImagesView.length,
                      (index) {
                        Asset asset = store.listImagesView[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: AssetThumb(
                                quality: 100,
                                asset: asset,
                                width: 200,
                                height: 200,
                              ),
                            ),
                            SizedBox(width: 3),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        : SizedBox(height: 20);
  }

  Widget listView() {
    final store = Provider.of<HomeStore>(context, listen: false);
    return Observer(builder: (_) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          child: ListView.builder(
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
                      style: KThemeModeApp.of(context).bodyMedium.copyWith(
                          color: KThemeModeApp.of(context).primaryText,
                          fontWeight: FontWeight.bold),
                      controllador: store.listaControladores[index],
                      onTap: () {}),
                ],
              );
            },
          ),
        ),
      );
    });
  }

  Future<void> loadAssets(List listImages) async {
    listImages.clear();
    List<Asset> images = <Asset>[];
    List<Asset> resultList = <Asset>[];

    try {
      resultList = await MultipleImagesPicker.pickImages(
        maxImages: 3,
        enableCamera: true,
        selectedAssets: images,
        materialOptions: const MaterialOptions(
          startInAllView: true,
          statusBarColor: "#035aa6",
          actionBarColor: "#035aa6",
          actionBarTitle: "Galeria",
          allViewTitle: "Todas imagens",
        ),
      );
    } on Exception catch (e) {
      log("ERRO LOADIMAGES>> $e");
    }

    images = resultList;
    listImages.addAll(resultList);
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gestao_projeto_unifei/app/home/store/store.dart';
import 'package:provider/provider.dart';

class HomeFunctions {
  BuildContext context;
  HomeFunctions(this.context);

  getInfosFirebase(uid) async {
    final user = FirebaseAuth.instance.currentUser;
    final firebaseData =
        await FirebaseDatabase.instance.ref('userProfile/$uid').get();
    Map<dynamic, dynamic> mapFirebaseData = firebaseData.value as Map;
    List getFirebaseList = [];
    if (mapFirebaseData != null) {
      // Acessando os dados do nó 'projeto'
      List<dynamic> projeto = mapFirebaseData['projeto'];
      int up = mapFirebaseData['up'];

      // Exibindo os dados recuperados
      // print("Projeto: $projeto");
      // print("UP: $up");

      // Iterando sobre os dados do projeto
      if (projeto != null) {
        for (var item in projeto) {
          var campo = item.keys.first;
          var valor = item.values.first;

          // ## GAMBIARRA
          // print("Campo: ${campo} Valor: ${valor}");
          var auix = campo.toString().split(":");

          // log("auix :: ${auix}");
          campo = auix[0].split(",")[0];

          getFirebaseList.add({"campo": "${campo}", "valor": "$valor"});
        }
      }
    } else {
      print("Nenhum dado encontrado no Firebase Realtime Database.");
    }

    // print("Achou no banco :: ${getFirebaseList}");
    return getFirebaseList.isNotEmpty ? getFirebaseList : [];
  }

  Future enviaProjeto() async {
    final store = Provider.of<HomeStore>(context, listen: false);
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User user = auth.currentUser!;
      await store.converteImagens();
      // log("listImages :: ${store.listImagesbase64}");

      List aux = [];
      aux.addAll(await getInfosFirebase(user.uid));
      // log("auxtemDado?? ${aux}");
      for (var i = 0; i < store.listaControladores.length; i++) {
        final element = store.listaControladores[i];
        if (element.text.isNotEmpty) {
          if (i == store.listaControladores.length - 1) {
            aux.add({
              "${store.lista[i]}": "${element.text}",
              "imagens": [
                "${store.listImagesbase64[0]}",
                "${store.listImagesbase64[1]}",
                "${store.listImagesbase64[2]}"
              ]
            });
          } else {
            aux.add({"${store.lista[i]}": "${element.text}"});
          }
        }
      }

      // print("AUX >> $aux");
      final notesReference =
          FirebaseDatabase.instance.ref().child('userProfile/${user.uid}');
      await notesReference.set({'projeto': aux});
      return true;
    } on Exception catch (e) {
      print("Erro>> $e");
      return false;
    }
  }
}

mixin ValidaForm {
  Future<String>? cepValidateLength(value) async {
    if (value.isEmpty) return "Campo CEP não pode ser vazio";
    if (!value.contains("3750")) {
      return "CEP não pode exceder o limite do municipio";
    }

    return null.toString();
  }

  String? isNotEmpty(String? value, [String? message]) {
    if (value!.isEmpty) return message ?? "Esse campo é obrigatório";
    return null;
  }
}

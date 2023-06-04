import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
part 'store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  ObservableList<TextEditingController> listaControladores =
      ObservableList<TextEditingController>();

  ObservableList lista = ObservableList();
  @observable
  ObservableList listImagesView = ObservableList();
  @observable
  bool isLoading = false;
  @observable
  ObservableList listImagesbase64 = ObservableList();

  @action
  void setLoad(bool value) => isLoading = value;
  @action
  Future converteImagens() async {
    List _aux = [];

    for (int i = 0; i < listImagesView.length; i++) {
      if (i == 0) {
        ByteData byteData = await listImagesView[i].getByteData();
        List<int> imageData = byteData.buffer.asUint8List();
        _aux.add(base64Encode(imageData));
      } else if (i == 1) {
        ByteData byteData = await listImagesView[i].getByteData();
        List<int> imageData = byteData.buffer.asUint8List();
        _aux.add(base64Encode(imageData));
      } else if (i == 2) {
        ByteData byteData = await listImagesView[i].getByteData();
        List<int> imageData = byteData.buffer.asUint8List();
        _aux.add(base64Encode(imageData));
      }
    }
    listImagesbase64.clear();
    listImagesbase64.addAll(_aux.asObservable());
  }

  @action
  void addController() {
    lista.clear();
    listaControladores.clear();
    for (var i = 0; i < json.length; i++) {
      final controller = TextEditingController();
      listaControladores.add(controller);
      lista.add(json[i]);
      print("adiconou lista ${lista[i]}");
      print("listaControladores ${listaControladores[i].text is Null}");
    }
  }
}

final json = [
  {
    "campo": "Contato Telefone do Responsável",
    "tipo": "text",
    "icone": Icons.smartphone_outlined
  },
  {
    "campo": "Email do responsável",
    "tipo": "text",
    "icone": Icons.email_outlined
  },
  {"campo": "Nome", "tipo": "text", "icone": Icons.description_outlined},
  {"campo": "Descrição", "tipo": "text", "icone": Icons.description_outlined},
  {
    "campo": "Professor Responsável",
    "tipo": "text",
    "icone": Icons.person_outline
  },
];

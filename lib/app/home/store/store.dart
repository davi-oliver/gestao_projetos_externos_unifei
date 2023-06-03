import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  ObservableList<TextEditingController> listaControladores =
      ObservableList<TextEditingController>();

  ObservableList lista = ObservableList();

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
  {"campo": "Descrição", "tipo": "text", "icone": Icons.description_outlined},
  {
    "campo": "Professor Responsável",
    "tipo": "text",
    "icone": Icons.person_outline
  },
];

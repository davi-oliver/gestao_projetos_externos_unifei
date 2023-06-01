import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  ObservableList<TextEditingController> listaControladores =
      ObservableList<TextEditingController>();

  ObservableList lista = ObservableList();

  @action
  void addController(TextEditingController controller) {
    for (var i = 0; i < 10; i++) {
      final controller = TextEditingController();
      listaControladores.add(controller);
    }
  }
}

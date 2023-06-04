import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
part 'store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  ObservableList<TextEditingController> listaControladores =
      ObservableList<TextEditingController>();

  @observable
  ObservableList listProjetos = ObservableList();

  ObservableList lista = ObservableList();
  @observable
  ObservableList listImagesView = ObservableList();
  @observable
  bool isLoading = false;
  @observable
  ObservableList listImagesbase64 = ObservableList();

  @observable
  var userEmail;
  @action
  setUserEmail(value) => userEmail = value;

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

  @action
  getInfosFirebase() async {
    final user = FirebaseAuth.instance.currentUser;
    final firebaseData =
        await FirebaseDatabase.instance.ref('userProfile/${user!.uid}').get();
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

          log("auix :: ${auix}");
          campo = auix[0].split(",");
          // print(">>>>>>>>>>> ${icampo[1]}");
          log("Param${campo}:=> ${valor}");

          getFirebaseList.add({"${campo}": "$valor"});
        }
      }
    } else {
      print("Nenhum dado encontrado no Firebase Realtime Database.");
    }

    // print("Achou no banco :: ${getFirebaseList}");
    if (getFirebaseList.isNotEmpty) {
      listProjetos.clear();
      listProjetos.addAll(getFirebaseList.asObservable());
      print("object ${listProjetos.first}");
    }
  }

  @action
  getProjetos() {
    listProjetos.clear();
    for (var i = 0; i < _jsonProjetos.length; i++) {
      listProjetos.add(_jsonProjetos[i]);
    }
    print("object ${listProjetos.first}");
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

final _jsonProjetos = [
  {
    "nome": "Black Bee",
    "descricao":
        "Projeto focado na criação e implementação de soluções tecnológicas sustentáveis para a preservação do meio ambiente.",
    "dia": "15",
    "mes": "Jan",
    "dataFinal": "2022-12-31",
    "responsavel": "Marcos Oliveira",
    "quantidadeVagas": 5,
    "imagem": "assets/images/blackbee.png"
  },
  {
    "nome": "Cheetah",
    "descricao":
        "Desenvolvimento de tecnologias para automação de processos e otimização do consumo de energia em ambientes industriais.",
    "dia": "01",
    "mes": "Fev",
    "dataFinal": "2022-11-30",
    "responsavel": "Carolina Santos",
    "quantidadeVagas": 8,
    "imagem": "assets/images/cheetah.jpg"
  },
  {
    "nome": "Trybe",
    "descricao":
        "Projeto de capacitação em tecnologia, oferecendo cursos e treinamentos em programação, desenvolvimento web e outras áreas relacionadas.",
    "dia": "10",
    "mes": "Mar",
    "dataFinal": "2022-10-31",
    "responsavel": "Rafael Silva",
    "quantidadeVagas": 12,
    "imagem": "assets/images/trybe.png"
  },
  {
    "nome": "Byron Solutions",
    "descricao":
        "Desenvolvimento de soluções tecnológicas inovadoras para otimizar processos e resolver desafios em diferentes setores.",
    "dia": "05",
    "mes": "Abr",
    "dataFinal": "2022-09-30",
    "responsavel": "Gabriela Ribeiro",
    "quantidadeVagas": 6,
    "imagem": "assets/images/byron.png"
  },
  {
    "nome": "Bio Agro",
    "descricao":
        "Pesquisa e desenvolvimento de novos métodos biotecnológicos para melhorar a produtividade e a sustentabilidade na agricultura.",
    "dia": "20",
    "mes": "Jun",
    "dataFinal": "2023-11-30",
    "responsavel": "Ana Rodrigues",
    "quantidadeVagas": 8,
    "imagem": "assets/images/bio.png"
  },
  {
    "nome": "IArtc",
    "descricao":
        "Aplicação de técnicas de inteligência artificial e aprendizado de máquina para resolver problemas complexos em diversas áreas.",
    "dia": "10",
    "mes": "Set",
    "dataFinal": "2023-12-15",
    "responsavel": "Laura Fernandes",
    "quantidadeVagas": 4,
    "imagem": "assets/images/ia.png"
  },
  {
    "nome": "EMPDIGTAL",
    "descricao":
        "Exploração de tecnologias de realidade virtual e aumentada para criar novas formas de interação e experiências imersivas.",
    "dia": "15",
    "mes": "Ago",
    "dataFinal": "2023-12-31",
    "responsavel": "Mariana Costa",
    "quantidadeVagas": 6,
    "imagem": "assets/images/ep.png"
  },
  {
    "nome": "Tech for Good",
    "descricao":
        "Análise de grandes volumes de dados e aplicação de técnicas de ciência de dados para extrair informações relevantes.",
    "dia": "01",
    "mes": "Set",
    "dataFinal": "2023-12-15",
    "responsavel": "Diego Martins",
    "quantidadeVagas": 8,
    "imagem": "assets/images/tech.png"
  }
];

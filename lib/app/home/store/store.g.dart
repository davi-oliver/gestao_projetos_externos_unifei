// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStoreBase, Store {
  late final _$listProjetosAtom =
      Atom(name: '_HomeStoreBase.listProjetos', context: context);

  @override
  ObservableList<dynamic> get listProjetos {
    _$listProjetosAtom.reportRead();
    return super.listProjetos;
  }

  @override
  set listProjetos(ObservableList<dynamic> value) {
    _$listProjetosAtom.reportWrite(value, super.listProjetos, () {
      super.listProjetos = value;
    });
  }

  late final _$listImagesViewAtom =
      Atom(name: '_HomeStoreBase.listImagesView', context: context);

  @override
  ObservableList<dynamic> get listImagesView {
    _$listImagesViewAtom.reportRead();
    return super.listImagesView;
  }

  @override
  set listImagesView(ObservableList<dynamic> value) {
    _$listImagesViewAtom.reportWrite(value, super.listImagesView, () {
      super.listImagesView = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_HomeStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$listImagesbase64Atom =
      Atom(name: '_HomeStoreBase.listImagesbase64', context: context);

  @override
  ObservableList<dynamic> get listImagesbase64 {
    _$listImagesbase64Atom.reportRead();
    return super.listImagesbase64;
  }

  @override
  set listImagesbase64(ObservableList<dynamic> value) {
    _$listImagesbase64Atom.reportWrite(value, super.listImagesbase64, () {
      super.listImagesbase64 = value;
    });
  }

  late final _$converteImagensAsyncAction =
      AsyncAction('_HomeStoreBase.converteImagens', context: context);

  @override
  Future<dynamic> converteImagens() {
    return _$converteImagensAsyncAction.run(() => super.converteImagens());
  }

  late final _$getInfosFirebaseAsyncAction =
      AsyncAction('_HomeStoreBase.getInfosFirebase', context: context);

  @override
  Future getInfosFirebase() {
    return _$getInfosFirebaseAsyncAction.run(() => super.getInfosFirebase());
  }

  late final _$_HomeStoreBaseActionController =
      ActionController(name: '_HomeStoreBase', context: context);

  @override
  void setLoad(bool value) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.setLoad');
    try {
      return super.setLoad(value);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addController() {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.addController');
    try {
      return super.addController();
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getProjetos() {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.getProjetos');
    try {
      return super.getProjetos();
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listProjetos: ${listProjetos},
listImagesView: ${listImagesView},
isLoading: ${isLoading},
listImagesbase64: ${listImagesbase64}
    ''';
  }
}

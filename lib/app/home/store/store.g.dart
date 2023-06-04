// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStoreBase, Store {
  late final _$listImagesAtom =
      Atom(name: '_HomeStoreBase.listImages', context: context);

  @override
  ObservableList<dynamic> get listImagesView {
    _$listImagesAtom.reportRead();
    return super.listImagesView;
  }

  @override
  set listImagesView(ObservableList<dynamic> value) {
    _$listImagesAtom.reportWrite(value, super.listImagesView, () {
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

  late final _$converteImagensAsyncAction =
      AsyncAction('_HomeStoreBase.converteImagens', context: context);

  @override
  Future<dynamic> converteImagens() {
    return _$converteImagensAsyncAction.run(() => super.converteImagens());
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
  String toString() {
    return '''
listImages: ${listImagesView},
isLoading: ${isLoading}
    ''';
  }
}

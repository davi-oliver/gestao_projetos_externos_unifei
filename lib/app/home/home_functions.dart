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

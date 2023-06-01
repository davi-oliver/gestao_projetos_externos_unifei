import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestao_projeto_unifei/global/theme/theme_mode.dart';

class GlobalWidget {
  BuildContext context;
  GlobalWidget(this.context);

  Widget AppbarCustom(title, icon, [bool isBack = false]) {
    return Container(
      height: MediaQuery.of(context).size.height * .1,
      width: MediaQuery.of(context).size.width,
      color: KThemeModeApp.of(context).primaryBackground,
      child: Row(children: [
        IconButton(
            onPressed: () {
              if (isBack) {
                Navigator.pop(context);
              }
            },
            icon: Icon(icon)),
        Text(
          title,
          style: KThemeModeApp.of(context).bodyMedium,
        ),
      ]),
    );
  }
}

class TextFieldCampo extends StatefulWidget {
  String? titulo;
  Widget icon;
  Widget icon2;
  String? campo;
  bool obsecureText;
  TextEditingController? controllador;
  bool numero;
  TextStyle? style;
  String? Function(String?)? validator;
  Function(String)? onChanged;
  void Function()? onTap;
  TextFieldCampo({
    Key? key,
    this.titulo,
    required this.icon,
    required this.icon2,
    this.campo,
    this.obsecureText = false,
    required this.controllador,
    this.numero = true,
    this.onChanged,
    this.style,
    this.validator,
    required this.onTap,
  }) : super(key: key);

  @override
  State<TextFieldCampo> createState() => _TextFieldCampoState();
}

class _TextFieldCampoState extends State<TextFieldCampo> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        obscureText: widget.obsecureText,
        controller: widget.controllador,
        onChanged: widget.onChanged,
        onTap: widget.onTap!,
        validator: widget.validator ?? null,
        keyboardType: !widget.numero
            ? TextInputType.text
            : const TextInputType.numberWithOptions(decimal: true),
        style: widget.style ?? KThemeModeApp.of(context).headlineMedium,
        decoration: InputDecoration(
          labelText: widget.titulo,
          labelStyle: KThemeModeApp.of(context).labelLarge,
          prefixIcon: widget.icon,
          suffixIcon: IconButton(
            icon: widget.icon2,
            onPressed: () {
              widget.controllador!.text == "";
            },
          ),
        ),
      ),
    );
  }
}

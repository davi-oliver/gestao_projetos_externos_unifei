import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gestao_projeto_unifei/global/theme/theme_mode.dart';

class GlobalWidget {
  BuildContext context;
  GlobalWidget(this.context);
  Widget loadingPrincipal() {
    final spinkit = SpinKitCubeGrid(
      itemBuilder: (_, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven
                ? KThemeModeApp.of(context).accent1
                : KThemeModeApp.of(context).accent4,
          ),
        );
      },
    );
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: KThemeModeApp.of(context).primaryBackground,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(child: spinkit),
              const SizedBox(
                height: 20,
              ),
              Text("Aguarde...", style: KThemeModeApp.of(context).titleLarge),
            ],
          ),
        ],
      ),
    );
  }

  Widget AppbarCustom(title, icon,
      [bool isBack = false, bool contracolor = false]) {
    return Container(
      height: MediaQuery.of(context).size.height * .1,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Row(children: [
        IconButton(
            onPressed: () {
              if (isBack) {
                Navigator.pop(context);
              }
            },
            icon: Icon(
              icon,
              color: contracolor
                  ? KThemeModeApp.of(context).primaryBtnText
                  : KThemeModeApp.of(context).primaryText,
            )),
        Text(
          title,
          style: KThemeModeApp.of(context).headlineMedium.copyWith(
              color: contracolor
                  ? KThemeModeApp.of(context).primaryBtnText
                  : KThemeModeApp.of(context).primaryText),
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
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
      child: TextFormField(
        obscureText: widget.obsecureText,

        controller: widget.campo == "Contato Telefone do Responsável"
            ? formatCel
            : widget.controllador,
        onChanged: widget.onChanged,
        onTap: widget.onTap!,
        validator: widget.validator ?? null,
        keyboardType: !widget.numero
            ? TextInputType.multiline
            : const TextInputType.numberWithOptions(decimal: true),
        style: widget.style ?? KThemeModeApp.of(context).bodySmall,
        // inputFormatters: widget.campo == "Contato Telefone do Responsável"
        //     ? [formatCel]
        //     : [],
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

final formatCel = MaskedTextController(mask: '(XX) XXXXX-XXXX');

class TelefoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;

    if (newText.length == 1) {
      // Adiciona o "(" no início do texto
      newText = '($newText';
    } else if (newText.length == 3) {
      // Adiciona o ")" após os dois primeiros dígitos
      newText = '(${newText.substring(1)}) ';
    } else if (newText.length == 9) {
      // Adiciona o "-" após os primeiros cinco dígitos
      newText = '(${newText.substring(1, 3)}) ${newText.substring(4)}-';
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

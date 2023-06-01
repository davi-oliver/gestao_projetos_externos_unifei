import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestao_projeto_unifei/global/widget/widget.dart';

class HomeWidgets {
  BuildContext context;
  HomeWidgets(this.context);

  Widget widgetprincipal () {
  return SingleChildScrollView(
    child: Column(
      children: [
        GlobalWidget(context).AppbarCustom('Home', Icons.arrow_back_ios),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return TextFieldCampo(
              
              icon: Icon(Icons.add_comment),
               icon2: Icon(null),
                controllador: , onTap: (){});
          },
        )
      ],
    ),
  );
}
}
  String? isNotEmpty(String? value, [String? message]) {
    if (value!.isEmpty) return message ?? "Esse campo é obrigatório";
    return null;
  }
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:components_ui/components_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gestao_projeto_unifei/app/home/home_functions.dart';
import 'package:gestao_projeto_unifei/app/home/home_page.dart';
import 'package:gestao_projeto_unifei/global/theme/theme_mode.dart';
import 'package:gestao_projeto_unifei/global/widget/widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidaForm {
  bool _carregando = false;
  bool visibilityPass = true;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController senhacontroller = TextEditingController();

  final formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          bottom: true,
          top: false,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: KThemeModeApp.of(context).primary,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30, left: 23, bottom: 43),
                    child: Row(
                      children: [
                        Icon(
                          Icons.login,
                          color: KThemeModeApp.of(context).primaryBackground,
                        ),
                        SizedBox(width: 15),
                        Text("Login",
                            style: KThemeModeApp.of(context)
                                .titleMedium
                                .copyWith(
                                    color: KThemeModeApp.of(context)
                                        .primaryBackground)),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .78,
                      width: MediaQuery.of(context).size.width * .85,
                      margin: EdgeInsets.symmetric(vertical: 120),
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .15),
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(3, 4),
                                blurRadius: 0.5,
                                spreadRadius: 0.5)
                          ],
                          borderRadius: BorderRadius.circular(15),
                          color: KThemeModeApp.of(context).primaryBackground),
                      child: Column(
                        children: [
                          Form(
                            key: formState,
                            child: Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 25),
                                    height:
                                        MediaQuery.of(context).size.height * .1,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: TextFieldCampo(
                                      controllador: emailcontroller,
                                      icon: Icon(Icons.person_pin),
                                      campo: "Login",
                                      titulo: "Email",
                                      icon2: Icon(null),
                                      onTap: () {},
                                      numero: false,
                                      onChanged: isNotEmpty,
                                    )),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 25),
                                  height:
                                      MediaQuery.of(context).size.height * .1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: TextFieldCampo(
                                    controllador: senhacontroller,
                                    obsecureText: visibilityPass,
                                    icon: Icon(Icons.lock),
                                    campo: "Login",
                                    titulo: "Senha",
                                    numero: false,
                                    icon2: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          visibilityPass = !visibilityPass;
                                        });
                                      },
                                      icon: Icon(
                                        visibilityPass
                                            ? FontAwesomeIcons.eye
                                            : FontAwesomeIcons.eyeSlash,
                                        color: KThemeModeApp.of(context)
                                            .secondaryText,
                                        size: 15,
                                      ),
                                    ),
                                    onTap: () {},
                                    onChanged: (v) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.pushReplacement(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             LoginRecover()));
                                  },
                                  child: Text(
                                    "Esqueci minha senha",
                                    style: KThemeModeApp.of(context)
                                        .bodySmall
                                        .copyWith(
                                            color: KThemeModeApp.of(context)
                                                .primary),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            child: SwitchListTile(
                                subtitle: Text(
                                  "Selecione para manter senha salva",
                                  style: KThemeModeApp.of(context).bodySmall,
                                ),
                                title: Text(
                                  "Manter-me conectado",
                                  style: KThemeModeApp.of(context).bodyMedium,
                                ),
                                value: false,
                                onChanged: (value) async {
                                  // setState(() {
                                  //   _storePass = !_storePass;
                                  // });
                                  // if (_storePass &&
                                  //     emailcontroller.text.isNotEmpty &&
                                  //     senhacontroller.text.isNotEmpty) {
                                  //   await LoginFunction(context)
                                  //       .setStoredPasswordAgent();
                                  // }
                                }),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                KitButton(
                                    width:
                                        MediaQuery.of(context).size.width * .45,
                                    height: MediaQuery.of(context).size.height *
                                        .065,
                                    decorationButton: BoxDecoration(
                                      color: _carregando
                                          ? KThemeModeApp.of(context).accent4
                                          : KThemeModeApp.of(context).accent2,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(3, 4),
                                            blurRadius: 0.5,
                                            spreadRadius: 0.5)
                                      ],
                                    ),
                                    widgetCenter: _carregando
                                        ? AnimatedTextKit(
                                            animatedTexts: [
                                              WavyAnimatedText('Aguarde ...',
                                                  speed: Duration(
                                                      milliseconds: 100),
                                                  textStyle: KThemeModeApp.of(
                                                          context)
                                                      .headlineMedium
                                                      .copyWith(
                                                          color:
                                                              KThemeModeApp.of(
                                                                      context)
                                                                  .accent2)),
                                            ],
                                            isRepeatingAnimation: true,
                                            totalRepeatCount: 3,
                                          )
                                        : Text(
                                            "Entrar",
                                            style: KThemeModeApp.of(context)
                                                .bodyLarge
                                                .copyWith(
                                                    color: KThemeModeApp.of(
                                                            context)
                                                        .primaryBtnText),
                                          ),
                                    iconSufix: Icon(
                                      Icons.arrow_forward_ios,
                                      color: _carregando
                                          ? Colors.transparent
                                          : KThemeModeApp.of(context)
                                              .primaryBtnText,
                                    ),
                                    onTap: () async {
                                      bool click = false;
                                      setState(() {
                                        _carregando = true;
                                        click = !click;
                                      });

                                      if (formState.currentState!.validate()) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) => HomePage()));
                                      } else {
                                        setState(() {
                                          _carregando = false;
                                          click = false;
                                        });
                                      }
                                      setState(() {
                                        _carregando = false;
                                        click = false;
                                      });
                                    }),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                color: KThemeModeApp.of(context).secondaryText,
                                height:
                                    MediaQuery.of(context).size.width * .001,
                                width: MediaQuery.of(context).size.width * .3,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Ou",
                                style: KThemeModeApp.of(context).bodyLarge,
                              ),
                              SizedBox(width: 10),
                              Container(
                                color: KThemeModeApp.of(context).secondaryText,
                                height:
                                    MediaQuery.of(context).size.width * .001,
                                width: MediaQuery.of(context).size.width * .3,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .08,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor:
                                      KThemeModeApp.of(context).accent3,
                                  child: Icon(
                                    FontAwesomeIcons.google,
                                    color: KThemeModeApp.of(context)
                                        .primaryBtnText,
                                  ),
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .08,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor:
                                      KThemeModeApp.of(context).primaryText,
                                  child: Icon(
                                    FontAwesomeIcons.github,
                                    color: KThemeModeApp.of(context)
                                        .primaryBtnText,
                                  ),
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .08,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor:
                                      KThemeModeApp.of(context).accent1,
                                  child: Icon(
                                    FontAwesomeIcons.userSecret,
                                    color: KThemeModeApp.of(context)
                                        .primaryBtnText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: MediaQuery.of(context).size.height * .1),
                      child: Image.asset(
                        "assets/images/logo.png",
                        width: MediaQuery.of(context).size.width * .35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

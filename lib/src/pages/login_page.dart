import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petshop/src/database/mysql_configuration.dart';
import 'package:petshop/src/pages/home_page.dart';
import 'package:petshop/src/pages/register-page.dart';
import 'package:petshop/src/ui/constants.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _userErrorText;
  String? _passwordErrorText;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_login_image.jpg'),
            opacity: 0.3,
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo_petshop.png',
                          height: 180.0,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          controller: widget._userController,
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            label: const Text('Usuário'),
                            hintText: 'Usuário',
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.green, width: 2.0),
                            ),
                            errorText: widget._userErrorText,
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          cursorColor: Colors.white,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: widget._passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            label: const Text('Senha'),
                            hintText: 'Senha',
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.green, width: 2.0),
                            ),
                            errorText: widget._passwordErrorText,
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          cursorColor: Colors.white,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Esqueceu a senha?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(40),
                            backgroundColor: ColorsConstants.strongGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Acessar',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          onPressed: () {
                            submit(widget._userController.text,
                                widget._passwordController.text);
                          },
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(40),
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: const Text(
                            'Primeiro acesso',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.normal),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return const RegisterPage();
                                },
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return customTransition(
                                      context, animation, child);
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customTransition(
      BuildContext context, Animation<double> animation, Widget child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }

  void submit(String user, String password) async {
    var connect = await MySqlConfiguration().connection;
    var result = await connect.query(
        "SELECT ID, NOME, USUARIO FROM PESSOA WHERE USUARIO = '$user' AND SENHA = '$password';");
    validateField();
    if (widget._userController.text.isNotEmpty) {
      if (widget._passwordController.text.isNotEmpty) {
        if (result.isEmpty) {
          failAcess();
        } else {
          successfulAcess();
        }
      }
    }
  }

  void successfulAcess() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const HomePage();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return customTransition(context, animation, child);
        },
      ),
    );
  }

  void failAcess() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Usuário e/ou senha inválidos!"),
        backgroundColor: ColorsConstants.red,
      ),
    );
  }

  void validateField() {
    if (widget._userController.text.isEmpty) {
      setState(() {
        widget._userErrorText = 'Este campo deve ser preenchido!';
      });
    } else {
      setState(() {
        widget._userErrorText = null;
      });
    }

    if (widget._passwordController.text.isEmpty) {
      setState(() {
        widget._passwordErrorText = 'Este campo deve ser preenchido!';
      });
    } else {
      setState(() {
        widget._passwordErrorText = null;
      });
    }
  }
}

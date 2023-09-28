import 'package:flutter/material.dart';
import 'package:petshop/src/database/mysql_configuration.dart';
import 'package:petshop/src/pages/home_page.dart';
import 'package:petshop/src/pages/petshop_loader.dart';
import 'package:petshop/src/pages/register-page.dart';
import 'package:petshop/src/ui/constants.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_login_image.jpg'),
            opacity: 0.2,
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
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/logo_petshop.png',
                            height: 150.0,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'O usuário deve ser informado';
                              }
                              return null;
                            },
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'A senha deve ser informada';
                              }
                              return null;
                            },
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
                              if (_formKey.currentState!.validate()) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const Center(
                                      child: PetshopLoader(),
                                    );
                                  },
                                );
                                submit(widget._userController.text,
                                    widget._passwordController.text);
                              }
                            },
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
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
                      child: const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Primeiro acesso? Crie uma conta!',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
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
    try {
      // Verifica os campos do formulário
      if (!_formKey.currentState!.validate()) {
        return;
      }
      // Realiza a conexão com o banco de dados
      var connect = await MySqlConfiguration().connection;
      var result = await connect.query(
        "SELECT ID, NOME, USUARIO FROM PESSOA WHERE USUARIO = ? AND SENHA = ?;",
        [user, password],
      );
      if (result.isEmpty) {
        failAcess(); // Acesso negado
      } else {
        String name = result.first['NOME'].toString();
        successfulAcess(name); // Acesso autorizado
      }
    } catch (e) {
      print(e);
      failConnection(); // Falha na conexão
    }
  }

  void successfulAcess(String name) {
    Navigator.of(context).pop();
    widget._userController.text = name;
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return HomePage(name: name);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return customTransition(context, animation, child);
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Usuário autenticado com sucesso!"),
        backgroundColor: ColorsConstants.strongGreen,
      ),
    );
  }

  void failAcess() {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Usuário e/ou senha inválidos!"),
        backgroundColor: ColorsConstants.red,
      ),
    );
  }

  void failConnection() {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Falha de conexão, tente novamente mais tarde!"),
        backgroundColor: ColorsConstants.red,
      ),
    );
  }
}

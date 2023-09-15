import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petshop/src/ui/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo_petshop.png',
                          height: 200.0,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          style: const TextStyle(
                            color: Colors.white, // Cor do texto digitado
                          ),
                          decoration: const InputDecoration(
                            label: Text('Usuário'),
                            hintText: 'Usuário',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          style: const TextStyle(
                            color: Colors.white, // Cor do texto digitado
                          ),
                          decoration: const InputDecoration(
                            label: Text('Senha'),
                            hintText: 'Senha',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
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
                            minimumSize: const Size.fromHeight(56),
                            backgroundColor: ColorsConstants.strongGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Define o raio da borda
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Acessar',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ],
                    ),
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Primeiro acesso? Crie uma conta!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

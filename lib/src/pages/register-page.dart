import 'package:flutter/material.dart';
import 'package:petshop/src/ui/constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left,
              color: ColorsConstants.strongGreen),
          iconSize: 30,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: ColorsConstants.lightGreen,
        centerTitle: true,
        title: Text(
          'registro'.toUpperCase(),
          style: const TextStyle(
            color: ColorsConstants.strongGreen,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: ColorsConstants.lightGreen,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Nome'),
                          hintText: 'Digite seu nome',
                        ),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('CPF'),
                          hintText: 'Digite seu CPF',
                        ),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.datetime,
                        decoration: const InputDecoration(
                          label: Text('Nascimento'),
                          hintText: 'Digite sua data de nascimento',
                        ),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          label: Text('E-mail'),
                          hintText: 'Digite seu e-mail',
                        ),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Usuário'),
                          hintText: 'Digite seu usuário',
                        ),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          label: Text('Senha'),
                          hintText: 'Digite sua senha',
                        ),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        height: 10,
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
                          'Registrar',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
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
    );
  }
}

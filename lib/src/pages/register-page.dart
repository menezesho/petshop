import 'package:flutter/material.dart';
import 'package:petshop/src/database/mysql_configuration.dart';
import 'package:petshop/src/ui/constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.lightGreen,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left,
              color: ColorsConstants.strongGreen),
          iconSize: 30,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'registro'.toUpperCase(),
          style: const TextStyle(
            color: ColorsConstants.strongGreen,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _nameController,
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
                          controller: _cpfController,
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
                          controller: _birthController,
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
                          controller: _emailController,
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
                          controller: _userController,
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
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            label: Text('Senha'),
                            hintText: 'Digite sua senha',
                          ),
                          style: Theme.of(context).textTheme.labelMedium,
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
                            'Registrar',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          onPressed: () {
                            // DateTime birth = DateTime.parse(_birthController.text);
                            // print(birth);
                            submit(
                                _nameController.text,
                                _cpfController.text,
                                DateTime.parse(_birthController.text),
                                _emailController.text,
                                _userController.text,
                                _passwordController.text);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void submit(String name, String cpf, DateTime birth, String email,
      String user, String password) async {
    // Verifica os campos do formulário
    if (!_formKey.currentState!.validate()) {
      return;
    }
    // Realiza a conexão com o banco de dados
    var connect = await MySqlConfiguration().connection;
    try {
      // Realiza a inserção no banco de dados
      await connect.query(
          "INSERT INTO PESSOA (NOME, CPF, NASCIMENTO, EMAIL, USUARIO, SENHA) VALUES ('$name', '$cpf', '$birth', '$email', '$user', '$password');");
      successful();
    } catch (e) {
      fail();
    }
  }

  void successful() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Cadastro efetuado com sucesso!"),
        backgroundColor: ColorsConstants.strongGreen,
      ),
    );
  }

  void fail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Não foi possível efetuar o cadastro!"),
        backgroundColor: ColorsConstants.red,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:petshop/src/database/mysql_configuration.dart';
import 'package:petshop/src/ui/constants.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({super.key});

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  String? typeSelectedItem;
  String? raceSelectedItem;
  String? sizeSelectedItem;

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
          'cadastro do pet'.toUpperCase(),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'O nome deve ser preenchido!';
                            }
                            return null;
                          },
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
                          inputFormatters: [
                            MaskTextInputFormatter(
                                mask: '##/##/####',
                                filter: {"#": RegExp(r'[0-9]')})
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'A data de nascimento deve ser preenchida!';
                            }
                            //fazer verificação de data válida
                            return null;
                          },
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
                        FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Selecione uma opção',
                                errorText: state.errorText,
                              ),
                              isEmpty: typeSelectedItem == null,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: typeSelectedItem,
                                  isDense: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      typeSelectedItem = newValue;
                                    });
                                  },
                                  items: <String>[
                                    'Opção 1',
                                    'Opção 2',
                                    'Opção 3',
                                    // Adicione suas opções aqui
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
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
                            // if (_formKey.currentState!.validate()) {
                            //   submit(
                            //       _nameController.text,
                            //       _cpfController.text
                            //           .replaceAll('.', '')
                            //           .replaceAll('-', ''),
                            //       DateTime.parse(_birthController.text
                            //           .replaceAll('/', '')),
                            //       _emailController.text,
                            //       _userController.text,
                            //       _passwordController.text);
                            // }
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
      fail(e);
    }
  }

  void successful() {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Cadastro efetuado com sucesso!"),
        backgroundColor: ColorsConstants.strongGreen,
      ),
    );
  }

  void fail(e) {
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Não foi possível efetuar o cadastro!"),
        backgroundColor: ColorsConstants.red,
      ),
    );
  }
}

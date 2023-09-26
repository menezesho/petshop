import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petshop/src/database/mysql_configuration.dart';
import 'package:petshop/src/ui/constants.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:image_picker/image_picker.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({super.key});

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  XFile? _imageFile;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  String? typeSelectedItem;
  String? breedSelectedItem;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = pickedImage;
    });
  }

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
            fontSize: 16,
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
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            width: 150.0,
                            height: 150.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorsConstants.grey),
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            child: _imageFile != null
                                ? ClipOval(
                                    child: Image.file(
                                      File(_imageFile!.path),
                                      width: 150.0,
                                      height: 150.0,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Center(
                                    child: Icon(
                                      Icons.add_photo_alternate_rounded,
                                      color: ColorsConstants.grey,
                                      size: 50.0,
                                    ),
                                  ),
                          ),
                        ),
                        if (_imageFile != null)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(0, 30),
                              backgroundColor: ColorsConstants.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text(
                              'Remover imagem',
                              style: TextStyle(fontSize: 12.0),
                            ),
                            onPressed: () {
                              setState(() {
                                _imageFile = null;
                              });
                            },
                          ),
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
                        DropdownButtonFormField(
                          //hint: const Text('Tipo'),
                          decoration: const InputDecoration(
                              hintText: 'Selecione o tipo do pet',
                              labelText: 'Tipo'),
                          items: const [
                            DropdownMenuItem(
                              value: 'Cachorro',
                              child: Text('Cachorro'),
                            ),
                            DropdownMenuItem(
                              value: 'Gato',
                              child: Text('Gato'),
                            ),
                            DropdownMenuItem(
                              value: 'Hamster',
                              child: Text('Hamster'),
                            ),
                            DropdownMenuItem(
                              value: 'Coelho',
                              child: Text('Coelho'),
                            ),
                            DropdownMenuItem(
                              value: 'Porquinho da Índia',
                              child: Text('Porquinho da Índia'),
                            ),
                          ],
                          onChanged: (value) {},
                          style: Theme.of(context).textTheme.labelMedium,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'O tipo deve ser selecionado!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField(
                          decoration: const InputDecoration(
                              hintText: 'Selecione a raça do pet',
                              labelText: 'Raça'),
                          items: const [
                            DropdownMenuItem(
                              value: 'teste',
                              child: Text('teste'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              breedSelectedItem = value.toString();
                            });
                          },
                          style: Theme.of(context).textTheme.labelMedium,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'A raça deve ser selecionada!';
                            }
                            return null;
                          },
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
                            'Adicionar',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              submit(
                                  _nameController.text,
                                  DateTime.parse(_birthController.text
                                      .replaceAll('/', '')),
                                  typeSelectedItem!,
                                  breedSelectedItem!);
                            }
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

  void submit(String name, DateTime birth, String type, String breed) async {
    // Verifica os campos do formulário
    if (!_formKey.currentState!.validate()) {
      return;
    }
    // Realiza a conexão com o banco de dados
    var connect = await MySqlConfiguration().connection;
    try {
      // Realiza a inserção no banco de dados
      await connect.query(
          "INSERT INTO ANIMAL (NOME, NASCIMENTO, TIPO, ID_RACA) VALUES (?, ?, ?, ?);",
          [name, birth, type, breed]);
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

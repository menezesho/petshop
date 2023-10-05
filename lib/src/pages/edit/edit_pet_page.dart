import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petshop/src/database/mysql_configuration.dart';
import 'package:petshop/src/core/ui/constants.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditPetPage extends StatefulWidget {
  final int idPet;
  const EditPetPage({required this.idPet, super.key});

  @override
  State<EditPetPage> createState() => _EditPetPageState();
}

class _EditPetPageState extends State<EditPetPage> {
  XFile? _imageFile;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  String? typeSelectedItem;
  String? breedSelectedItem;
  String formattedDate = '';

  String? oldName;
  String? oldBirth;
  String? oldType;
  String? oldBreed;
  XFile? oldImage;

  @override
  void initState() {
    super.initState();

    // Chame a função que você deseja executar ao carregar a tela aqui.
    load();
  }

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
          'edição do pet'.toUpperCase(),
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
                            try {
                              DateTime parsedDate =
                                  DateFormat('dd/MM/yyyy').parse(value);
                              formattedDate =
                                  DateFormat('yyyy-MM-dd').format(parsedDate);
                            } catch (e) {
                              return 'A data de nascimento deve ser válida!';
                            }
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
                          value: typeSelectedItem,
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
                          onChanged: (value) {
                            setState(() {
                              typeSelectedItem = value.toString();
                            });
                          },
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
                          value: breedSelectedItem,
                          decoration: const InputDecoration(
                              hintText: 'Selecione o porte do pet',
                              labelText: 'Porte'),
                          items: const [
                            DropdownMenuItem(
                              value: 'Pequeno',
                              child: Text('Pequeno'),
                            ),
                            DropdownMenuItem(
                              value: 'Médio',
                              child: Text('Médio'),
                            ),
                            DropdownMenuItem(
                              value: 'Grande',
                              child: Text('Grande'),
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
                              return 'O porte deve ser selecionado!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(40),
                            backgroundColor: ColorsConstants.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Excluir',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          onPressed: () {
                            deleteDialog(context);
                          },
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
                            'Salvar',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          onPressed: () {
                            if (oldName == _nameController.text &&
                                oldBirth == _birthController.text &&
                                oldType == typeSelectedItem &&
                                oldBreed == breedSelectedItem &&
                                oldImage == _imageFile) {
                              identicalFields();
                              return;
                            }
                            if (_formKey.currentState!.validate()) {
                              submit();
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

  void load() async {
    // Realiza a conexão com o banco de dados
    var connect = await MySqlConfiguration().connection;
    try {
      var result = await connect
          .query("SELECT * FROM ANIMAL WHERE ID = ?;", [widget.idPet]);
      oldName = _nameController.text = result.first['NOME'].toString();
      DateTime date = DateTime.parse(result.first['NASCIMENTO'].toString());
      oldBirth = _birthController.text = DateFormat('dd/MM/yyyy').format(date);
      setState(() {
        oldType = typeSelectedItem = result.first['TIPO'].toString();
        oldBreed = breedSelectedItem = result.first['PORTE'].toString();
        oldImage = _imageFile = result.first['FOTO'] == null
            ? null
            : XFile(result.first['FOTO'].toString());
      });
    } catch (e) {
      failedLoading(e);
    }
  }

  void submit() async {
    // Verifica os campos do formulário
    if (!_formKey.currentState!.validate()) {
      return;
    }
    // Realiza a conexão com o banco de dados
    var connect = await MySqlConfiguration().connection;
    try {
      // Realiza a inserção no banco de dados
      await connect.query(
          "UPDATE ANIMAL SET NOME = ?, NASCIMENTO = ?, TIPO = ?, PORTE = ?, FOTO = ? WHERE ID = ?;",
          [
            _nameController.text,
            formattedDate,
            typeSelectedItem,
            breedSelectedItem,
            _imageFile == null ? null : _imageFile!.path,
            widget.idPet
          ]);
      successfulEdition();
    } catch (e) {
      failedEdition(e);
    }
  }

  void delete() async {
    MySqlConfiguration().connection.then((connect) async {
      try {
        await connect.query("DELETE FROM ANIMAL WHERE ID = ?;", [widget.idPet]);
        successfulDeletion();
      } catch (e) {
        failedDeletion(e);
      }
    });
  }

  void successfulEdition() {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Dados alterados com sucesso!"),
        backgroundColor: ColorsConstants.strongGreen,
      ),
    );
  }

  void successfulDeletion() {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Exclusão efetuada com sucesso!"),
        backgroundColor: ColorsConstants.strongGreen,
      ),
    );
  }

  void failedEdition(e) {
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Não foi possível efetuar a edição!"),
        backgroundColor: ColorsConstants.red,
      ),
    );
  }

  void failedDeletion(e) {
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Não foi possível efetuar exclusão!"),
        backgroundColor: ColorsConstants.red,
      ),
    );
  }

  void failedLoading(e) {
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Não foi possível carregar os dados!"),
        backgroundColor: ColorsConstants.red,
      ),
    );
  }

  void identicalFields() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Nenhum dado foi alterado!"),
        backgroundColor: ColorsConstants.red,
      ),
    );
  }

  Future<void> deleteDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // O diálogo não pode ser fechado tocando fora dele.
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir?'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Deseja mesmo excluir este pet?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () {
                delete();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Pet excluído com sucesso!'),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = pickedImage;
    });
  }
}

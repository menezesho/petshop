import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petshop/src/core/ui/constants.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  XFile? _imageFile;
  String name = 'Henrique Menezes';
  String? email;
  String? birthDate;
  String? cpf;
  String? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.lightGreen,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.menu,
              color: ColorsConstants.strongGreen,
              size: 35,
            ),
          ),
          const SizedBox(width: 10),
        ],
        centerTitle: true,
        title: Text(
          'dados pessoais'.toUpperCase(),
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
                  Column(
                    children: [
                      Container(
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
                                  Icons.person,
                                  color: ColorsConstants.grey,
                                  size: 100.0,
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'USUÁRIO',
                            style: TextStyle(
                              color: Color(0xFF30CF53),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Henrique Menezes',
                            style: TextStyle(
                              color: ColorsConstants.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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
                          'Alterar dados',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        onPressed: () {},
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
                          'Sair',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
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
}

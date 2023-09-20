import 'package:flutter/material.dart';

class PetsPage extends StatefulWidget {

  const PetsPage({ super.key });

  @override
  State<PetsPage> createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Meus pets'),),
           body: Container(),
       );
  }
}
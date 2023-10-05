import 'package:flutter/material.dart';
import 'package:petshop/src/core/ui/constants.dart';

class PetsPage extends StatefulWidget {
  const PetsPage({super.key});

  @override
  State<PetsPage> createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Meus pets'.toUpperCase(),
          style: const TextStyle(
            color: ColorsConstants.strongGreen,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // Cor da borda
                width: 2.0, // Largura da borda
              ),
              borderRadius: const BorderRadius.all(
                  Radius.circular(10.0)), // Borda arredondada
            ),
            child: ListView(
              children: const [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.pets,
                              color: ColorsConstants.strongGreen, size: 80),
                          Column(
                            children: [
                              Text('Nome:',
                                  style: TextStyle(
                                      color: ColorsConstants.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              Text('Idade:',
                                  style: TextStyle(
                                      color: ColorsConstants.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              Text('Raça:',
                                  style: TextStyle(
                                      color: ColorsConstants.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              Divider(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                    color: Colors.black, // Cor da linha preta
                    thickness: 1.0), // Espessura da linha
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.pets,
                              color: ColorsConstants.strongGreen, size: 80),
                          Column(
                            children: [
                              Text('Nome:',
                                  style: TextStyle(
                                      color: ColorsConstants.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              Text('Idade:',
                                  style: TextStyle(
                                      color: ColorsConstants.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              Text('Raça:',
                                  style: TextStyle(
                                      color: ColorsConstants.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              Divider(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                    color: Colors.black, // Cor da linha preta
                    thickness: 1.0),
                // Adicione quantas vezes você precisar
              ],
            ),
          ),
        ),
      ),
    );
  }
}

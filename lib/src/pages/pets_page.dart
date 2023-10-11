import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
          'Meus pets'.toUpperCase(),
          style: const TextStyle(
            color: ColorsConstants.strongGreen,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: ColorsConstants.grey, width: 1),
                ),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Slidable(
                      closeOnScroll: true,
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        extentRatio: 0.8,
                        children: [
                          SlidableAction(
                            borderRadius: BorderRadius.circular(5),
                            backgroundColor: ColorsConstants.red,
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Editar',
                            onPressed: (context) => (),
                          ),
                          SlidableAction(
                            borderRadius: BorderRadius.circular(5),
                            backgroundColor: ColorsConstants.yellow,
                            foregroundColor: Colors.white,
                            icon: Icons.calendar_today_outlined,
                            label: 'Agendar',
                            onPressed: (context) => (),
                          ),
                          SlidableAction(
                            borderRadius: BorderRadius.circular(5),
                            backgroundColor: ColorsConstants.strongGreen,
                            foregroundColor: Colors.white,
                            icon: Icons.history_outlined,
                            label: 'Histórico',
                            onPressed: (context) => (),
                          ),
                        ],
                      ),
                      child: const ListTile(
                        leading: Icon(Icons.pets),
                        title: Text(
                          'Clara',
                          style: TextStyle(
                              color: ColorsConstants.grey,
                              fontWeight: FontWeight.w500),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5.0),
                            Row(
                              children: [
                                Icon(Icons.calendar_month_outlined, size: 18.0),
                                Text('12/12/2012'),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Text('Cachorro Pequeno'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
                backgroundColor: ColorsConstants.strongGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                'Adicionar um pet',
                style: TextStyle(fontSize: 16.0),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

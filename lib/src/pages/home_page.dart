import 'package:flutter/material.dart';
import 'package:petshop/src/pages/add/add_pet_page.dart';
import 'package:petshop/src/pages/information_page.dart';
import 'package:petshop/src/pages/pets_page.dart';
import 'package:petshop/src/core/ui/constants.dart';

class HomePage extends StatelessWidget {
  final String name;
  const HomePage({required this.name, super.key});

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
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const InformationPage();
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return customTransition(context, animation, child);
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.menu,
              color: ColorsConstants.strongGreen,
              size: 35,
            ),
          ),
          const SizedBox(width: 10),
        ],
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Olá, ${name[0].toUpperCase()}${name.substring(1)}!',
                        style: const TextStyle(
                          color: ColorsConstants.strongGreen,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PetsPage(),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 240.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image:
                                  const AssetImage('assets/images/my-pets.jpg'),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  BlendMode.darken),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Meus pets',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddPetPage(),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 240.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image:
                                  const AssetImage('assets/images/add-pet.jpg'),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  BlendMode.darken),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Adicionar um pet',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PetsPage(),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 240.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image:
                                  const AssetImage('assets/images/notices.jpg'),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  BlendMode.darken),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Notícias',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
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

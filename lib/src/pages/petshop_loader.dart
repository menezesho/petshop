import 'package:petshop/src/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PetshopLoader extends StatelessWidget {
  const PetshopLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.twoRotatingArc(
        color: ColorsConstants.strongGreen,
        size: 60,
      ),
    );
  }
}

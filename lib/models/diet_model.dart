import 'package:flutter/material.dart';

class DietModel {
  String name;
  String iconPath;
  String level;
  String duration;
  String calorie;

  Color boxColor;
  int categoryType;


  DietModel({
    required this.name,
    required this.iconPath,
    required this.level,
    required this.duration,
    required this.calorie,

    required this.boxColor,
    required this.categoryType,

});
  static List <DietModel> getDiets() {
    List<DietModel> diets=[];
    diets.add(
      DietModel(name: 'Honey Pancake',
          iconPath: 'assets/icons/honey-pancakes.png',
          level: 'Easy',
          duration: '30mins',
          calorie: '1800kCal',
          boxColor: Color(0xff08952d),
          categoryType: 1
      )
    );

      diets.add(
          DietModel(name: 'Canai Bread',
              iconPath: 'assets/icons/canai-bread.png',
              level: 'Easy',
              duration: '20mins',
              calorie: '230kCal',
              boxColor: Color(0xff08952d),
              categoryType: 1
          )
      );

    diets.add(
        DietModel(name: 'Tempura Udon',
            iconPath: 'assets/icons/udon.png',
            level: 'Easy',
            duration: '190mins',
            calorie: '420kCal',
            boxColor: Color(0xff08952d),
          categoryType: 3,
        )
    );
      return diets;
  }
}
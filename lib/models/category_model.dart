import 'package:flutter/material.dart';
class CategoryModel{
  String name;
  String iconPath;
  Color boxColor;
  bool selected;
  int categoryType;

  CategoryModel({
    required this.name,
    required this.iconPath,
    required this.boxColor,
    required this.selected,
    required this.categoryType,

});
  static List<CategoryModel> getCategories(){
    List<CategoryModel> categories=[];


    categories.add(
        CategoryModel(
            name: 'Lunch Set',
        iconPath: 'assets/icons/lunchset2.png',
        boxColor: Color(0xff11b039),
          selected: false,
            categoryType: 0

    )
    );

    categories.add(
        CategoryModel(
            name: 'À la carte',
            iconPath: 'assets/icons/alacarte.png',
            boxColor: Color(0xff11b039),
            selected: false,
            categoryType: 1
        )
    );

    categories.add(
        CategoryModel(
            name: 'Side Dishes',
            iconPath: 'assets/icons/sidedish.png',
            boxColor: Color(0xff11b039),
            selected: false,
            categoryType: 2
        )
    );

    categories.add(
        CategoryModel(
            name: 'Noodles',
            iconPath: 'assets/icons/noodles.png',
            boxColor: Color(0xff11b039),
            selected: false,
            categoryType: 3
        )
    );

    categories.add(
        CategoryModel(
            name: 'Curry',
            iconPath: 'assets/icons/curry.png',
            boxColor: Color(0xff11b039),
            selected: false,
            categoryType: 4
        )
    );

    return categories;
  }
}
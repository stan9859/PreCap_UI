import 'package:flutter/material.dart';
import 'package:demo3/models/category_model.dart';
import 'package:demo3/models/menu_list.dart';
import 'package:demo3/models/cart_model.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class CategoriesMenuPage extends StatelessWidget {
  final CategoryModel category;
  final List<MenuList> menu;
  // CartListModel cartList = CartListModel();


  CategoriesMenuPage({
    required this.category,
    required this.menu,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF86D19B),
      appBar: AppBar(
        title: Text(
          '${category.name} Menu',
          style: TextStyle(
            color: Color(0xff043611),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF86D19B),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15,),
              ListView.separated(
                itemCount: menu.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) => const SizedBox(height: 25,),
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                itemBuilder: (context, index) {
                  // Only display menu items that match the current category's type
                  if (menu[index].categoryType == category.categoryType) {
                    return ElevatedButton(
                      onPressed: () {
                        print('${menu[index].name} pressed!');
                        _displayBottomSheet(context,menu[index].index);

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff11b039).withOpacity(0.77),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            menu[index].iconPath,
                            width: 70,
                            height: 70,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                menu[index].name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    // Return an empty container for items that don't match the category type
                    return Container();
                  }
                },
              )

            ],
          ),
        ],
      ),
    );
  }
  Future _displayBottomSheet(BuildContext context, int index) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF86D19B),
      barrierColor: Colors.black.withOpacity(0.5),
      isDismissible: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => Container(
        height: 500,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                menu[index].iconPath,
                width: 250,
                height: 250,
              ),
              const SizedBox(height: 16), // Add spacing between image and text
              Text(
                menu[index].name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Color(0xff043611),
                ),
              ),
              ElevatedButton(onPressed: (){
                print('Added to cart!');
                Provider.of<CartModel>(context, listen: false).addItemToCart(index);
              },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff11b039).withOpacity(0.77),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                  child: Text("Add to cart",style: TextStyle(fontSize: 25),))
            ],
          ),
        ),
      ),
    );
  }

}

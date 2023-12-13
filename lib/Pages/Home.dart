import 'package:demo3/Pages/login_page.dart';
import 'package:demo3/Pages/payment_page.dart';
import 'package:demo3/models/category_model.dart';
import 'package:demo3/models/diet_model.dart';
import 'package:demo3/models/popular_model.dart';
import 'package:flutter/material.dart';
import 'package:demo3/Pages/CategoriesMenuPage.dart';
import 'package:demo3/models/menu_list.dart';
import 'package:demo3/models/cart_model.dart';
import 'package:provider/provider.dart';

/*
Things needed:
sign in
payment
menu description
 */
class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<DietModel> diets = [];
  List<PopularDietsModel> popularDiets =[];
  List<MenuList> Menu = [];
  // CartListModel cartList = CartListModel();


  void _getInitialInfo(){
    categories=CategoryModel.getCategories();
    diets=DietModel.getDiets();
    popularDiets = PopularDietsModel.getPopularDiets();
    Menu = MenuList.getMenu();
}
  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
      appBar: menu(),
      backgroundColor: Color(0xFF86D19B),
      body: ListView(
        children: [
          searchfield(),
          const SizedBox(height: 40,),
          categoriesSection(),
          const SizedBox(height:40,),
          dietSection(),
          const SizedBox(height:40,),
          popularSection(),
          const SizedBox(height: 40,)
        ],
      ),
    ) ;
  }
  Column popularSection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Popular',
                style: TextStyle(
                    color: Color(0xff043611),
                    fontSize: 18,
                    fontWeight: FontWeight.w600
              ),
            ),
            ),
            const SizedBox(height: 15,),
            ListView.separated(
              itemCount: popularDiets.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(height: 25,),
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    print('${popularDiets[index].name} pressed!');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoriesMenuPage(category : categories[0],
                          menu: MenuList.getMenu(),),
                      ),
                    );

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFDFFCA1A).withOpacity(0.77),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        popularDiets[index].iconPath,
                        width: 65,
                        height: 65,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            popularDiets[index].name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            popularDiets[index].level +
                                ' | ' +
                                popularDiets[index].duration +
                                ' | ' +
                                popularDiets[index].calorie,
                            style: const TextStyle(
                              color: Color(0xff7B6F72),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );

              },
            )
              ],
        );
  }
  Column dietSection() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('Recommendation\n for diet',
              style: TextStyle(
                  color: Color(0xff043611),
              fontSize: 18,
              fontWeight: FontWeight.w600
              ),
              ),
            ),
            const SizedBox(height: 15,),
            Container(
              height: 240,
              child: ListView.separated(
                  itemBuilder: (context, index){
                return Container(
                  width:210,
                  decoration:BoxDecoration(
                    color: diets[index].boxColor.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20)
                ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(diets[index].iconPath),
                      Text(
                        diets[index].name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 16
                        ),
                      ),
                      Text(
                        diets[index].level + ' | ' +diets[index].duration + ' | ' + diets[index].calorie,
                        style: const TextStyle(
                          color: Color(0xffc4c3c3),
                          fontSize: 13,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      Container(
                        width: 100,
                        child: ElevatedButton(onPressed: () {print(' ${diets[index].name} pressed!');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoriesMenuPage(category : categories[diets[index].categoryType],
                              menu: MenuList.getMenu(),),

                          ),
                        );
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFDFFCA1A).withOpacity(0.77),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                          ),
                          child: Center(
                            child: Text('View',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14
                              ),
                            ),
                          ),

                        ),
                      )
                    ],
                  ),
                );
              },
                  separatorBuilder: (context,index) => const SizedBox(width: 25,),
                  itemCount: diets.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20
                ),
            )
          )
  ],
        );
  }
  Column categoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Categories',
            style: TextStyle(
              color: Color(0xff043611),
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        const SizedBox(height: 15,),
        Container(
          height: 120,
          child: ListView.separated(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            separatorBuilder: (context, index) => const SizedBox(width: 25,),
            itemBuilder: (context, index) {
              return  ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  backgroundColor: categories[index].boxColor.withOpacity(0.7),
                ),
                onPressed: () {
                  print('Category ${categories[index].name} pressed!');
                  // Navigate to the CategoriesMenuPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoriesMenuPage(category : categories[index],
                        menu: MenuList.getMenu(),
                      ),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(categories[index].iconPath),
                      ),
                    ),
                    Text(
                      categories[index].name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
  Container searchfield() {
    return Container (
          margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xff1D1617).withOpacity(0.11),
                blurRadius: 40,
                spreadRadius: 0.0,
              )
            ]
          ),
          child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFF9CD5AC),
            contentPadding: const EdgeInsets.all(15),
            hintText: 'Search...',
            hintStyle: const TextStyle(
              color: Color(0xff0d7148),
              fontSize: 14,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset('assets/icons/search.png'),
            ),
            suffixIcon:
            Container(
              width: 100,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                    children:[
                      const VerticalDivider(
                        color: Colors.black,
                        indent: 10,
                        endIndent: 10,
                        thickness: 0.1,
                      ),
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(height: 30, width: 30,),
                ),
                    ]
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            )
          ),
      ),
        );
  }
  AppBar menu() {
    return AppBar(
      title: const Text(
        'Menu',
        style: TextStyle(
          color: Color(0xff043611),
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Poppins',
        ),
      ),
      backgroundColor: Color(0xFF86D19B),
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
          // Handle leading tap
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Image.asset(
            'assets/icons/left-arrow-5.png',
            height: 30,
            width: 30,
          ),
          decoration: BoxDecoration(
              color: const Color(0xFF86D19B),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            // Handle action tap
          },
          child: Consumer<CartModel>(
            builder: (context, value, child) {
              return ElevatedButton(
                onPressed: () {
                  print('Cart is pressed');
                  _displayCartSheet(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF86D19B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  width: 30,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/icons/cart4.png',
                        height: 50,
                        width: 40,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFDFFCA1A)
                                , // Choose your desired background color
                          ),
                          child: Text(
                            '${value.cartItems.length}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future _displayCartSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF86D19B),
      barrierColor: Colors.black.withOpacity(0.5),
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) => Consumer<CartModel>(
        builder: (context, value, child) {
          return Container(
            height: 500,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Display cart items
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListView.builder(
                        itemCount: value.cartItems.length,
                        padding: EdgeInsets.all(12),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff11b039).withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(16)),
                              child: ListTile(
                                leading: Image.asset(
                                  value.cartItems[index].iconPath,
                                  height: 36,
                                ),
                                title: Text(
                                  value.cartItems[index].name,
                                  style: const TextStyle(fontSize: 18,
                                      color:Colors.white ),
                                ),
                                subtitle: Text(
                                   value.cartItems[index].price + '円',
                                  style: const TextStyle(fontSize: 12,
                                      color:Color(0xffffffff)),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.cancel,color: Colors.white,),
                                  onPressed: () {
                                    Provider.of<CartModel>(context, listen: false)
                                        .removeItemFromCart(index);
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Total amount + pay now
                          Padding(
                            padding: const EdgeInsets.all(36.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        'Total Price: ',
                                        style: TextStyle(color: Color(0xff0d7148),fontSize: 20),
                                      ),
                                    ),
                                    Text('${value.calculateTotal()} 円', style: TextStyle(color: Colors.white,fontSize:20,fontWeight: FontWeight.bold ),),
                                  ],
                            ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => PaymentPage()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xff11b039).withOpacity(0.8), // Set the button color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        'Proceed to payment',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                )

                              ],
                      ),
                          ),


                ],
              ),
            ),
          );
        },
      ),
    );
  }




}

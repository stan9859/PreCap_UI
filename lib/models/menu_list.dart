class MenuList {
  String name;
  String iconPath;
  String price;
  int categoryType;
  int index;

  MenuList({
    required this.name,
    required this.iconPath,
    required this.price,
    required this.categoryType,
    required this.index,
  });

  static List<MenuList> getMenu() {
    List<MenuList> Menu = [];
    Menu.add(
      MenuList(
        name: 'Lunch Set A',
        iconPath: 'assets/icons/lunchsets1.png',
        price: '430',
        categoryType: 0,
        index: 0,
      ),
    );

    Menu.add(
      MenuList(
        name: 'Lunch set B',
        iconPath: 'assets/icons/lunchsets.png',
        price: '430',
        categoryType: 0,
        index: 1,
      ),
    );
    return Menu;
  }
}

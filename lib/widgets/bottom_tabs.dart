import 'package:flutter/material.dart';
import 'package:weather/controller/global_controller.dart';

class BottomTabs extends StatefulWidget {

  final int? selectedTab;
  final Function(int)? tabPressed;
  const BottomTabs({Key? key, this.selectedTab, this.tabPressed}) : super(key: key);

  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {

  int? _selectedTab = GlobalController().changeTabIndex();

  @override
  Widget build(BuildContext context) {

    _selectedTab = widget.selectedTab ?? 0;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),

          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1.0,
                blurRadius: 30.0
            )
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabBtn(
            imagePath: Icons.home_outlined,
            onPressed: (){
              widget.tabPressed!(0);
            },
            selected: _selectedTab == 0 ? true : false,
          ),
          BottomTabBtn(
            imagePath: Icons.location_city_outlined,
            onPressed: (){
              widget.tabPressed!(1);
            },
            selected: _selectedTab == 1 ? true : false,
          ),
          BottomTabBtn(
            imagePath: Icons.settings_outlined,
            onPressed: (){
              widget.tabPressed!(2);
            },
            selected: _selectedTab == 2 ? true : false,
          ),
        ],
      ),
    );
  }
}

class BottomTabBtn extends StatelessWidget {

  final IconData? imagePath;
  final bool? selected;
  final VoidCallback? onPressed;

  const BottomTabBtn({Key? key, this.imagePath, this.selected, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool _selected = selected ?? false;

    return GestureDetector(
      onTap: onPressed,

      child: Container(

        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                  color: _selected ? Colors.deepOrange : Colors.transparent,
                  width: 3.0,
                )
            )
        ),

        padding: const EdgeInsets.symmetric(
          vertical: 24.0,
          horizontal: 24.0,
        ),

        child: Icon(
          imagePath ?? Icons.home,
          size: 22.0,
          color: _selected ? Colors.deepOrange : Colors.black,
        ),
      ),
    );
  }
}

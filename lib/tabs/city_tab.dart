import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/controller/global_controller.dart';

import '../databasehelper.dart';
import '../model/auto_cities.dart';
import '../model/cities.dart';
import '../screens/add_city.dart';

class CityTab extends StatefulWidget {
  const CityTab({Key? key}) : super(key: key);

  @override
  State<CityTab> createState() => _CityTabState();
}

class _CityTabState extends State<CityTab> {

  final GlobalController globalController =
  Get.put(GlobalController(), permanent: true);

  List<AutoCities> _itemsList = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _loadCities());
  }

  void _loadCities() async {
    _itemsList = await _dbHelper.selectedCities();
    //print("The length is: ${_itemsList.length}");
  }

  //static String _displayStringForOption(Cities option) => option.name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEEEEE),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CircleAvatar(
            backgroundColor: const Color(0xFFEEEEEE),
            child: Image.asset(
              "assets/icons/location.png",
              height: 16,
              width: 16,
              color: const Color(0xFF585858),
            ),
          ),
        ),
        title: const Text(
          "Cities",
          style: TextStyle(color: Color(0xFF0D0D0E)),
        ),
      ),
      body: Column(
        children: [
          Form(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: RawAutocomplete<AutoCities> (
                textEditingController: controller,
                focusNode: focusNode,
                optionsBuilder: (TextEditingValue textEditingValue){
                  if(textEditingValue.text == ''){
                    return const Iterable<AutoCities>.empty();
                  }
                  return _itemsList.where((AutoCities cities) =>
                    cities.name.toString().toLowerCase().startsWith(textEditingValue.text.toLowerCase())
                  ).toList();
                },

                displayStringForOption: (AutoCities cities) => cities.name,

                fieldViewBuilder: (
                    BuildContext context,
                    TextEditingController fieldTextEditingController,
                    FocusNode fieldFocusNode,
                    VoidCallback onFieldSubmitted
                    ) {
                  return TextFormField(
                    controller: fieldTextEditingController,
                    focusNode: fieldFocusNode,
                    decoration: const InputDecoration(hintText: "Search your City"),
                  );
                },

                onSelected: (AutoCities selection){
                  Cities cities = Cities(c_id: selection.c_id, country: selection.country, name: selection.name, lat: selection.lat, lon: selection.lon, defaults: "false", sets: "false");
                  _dbHelper.insertCities(cities);
                  setState(() {
                    controller.clear();
                  });
                },

                optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<AutoCities> onSelected, Iterable<AutoCities> options){
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4.0,
                      child: SizedBox(
                        height: 200.0,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8.0),
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final AutoCities option = options.elementAt(index);
                            return GestureDetector(
                              onTap: () {
                                onSelected(option);
                              },
                              child: ListTile(
                                title: Text(option.name),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                }
              )
            ),
          ),
          const Divider(
            height: 4,
            thickness: 4,
            color: Color(0xFFF8F8F8),
          ),
          Flexible(
            child: FutureBuilder(
                  initialData: const[],
                  future: _dbHelper.getCities(),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      //print(snapshot.data!.length);
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index){
                          Cities cities = snapshot.data![index];
                          String sets = cities.sets;
                          String dafaults = cities.defaults;
                          return Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Dismissible(
                              key: UniqueKey(),
                              background: Container(
                                color: Colors.red,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const <Widget>[
                                      Icon(
                                        Icons.delete,
                                        color:Colors.white,
                                      ),
                                      Text(
                                        "Delete",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              confirmDismiss: (direction) async{
                                final bool res = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: const Text(
                                            "Are you sure you want to delete this City?"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text(
                                              "Cancel",
                                              style: TextStyle(color: Colors.black),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context, false);
                                            },
                                          ),
                                          TextButton(
                                            child: const Text(
                                              "Delete",
                                              style: TextStyle(color: Colors.red),
                                            ),
                                            onPressed: () {
                                              if(dafaults == "false"){
                                                _dbHelper.deleteCity(cities.c_id);
                                                Navigator.pop(context, true);
                                              } else{
                                                Navigator.pop(context, false);
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    });
                                return res;

                              },
                              child: GestureDetector(
                                onTap: () async {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();

                                  prefs.setInt('c_id', cities.c_id);
                                  prefs.setDouble('lat', cities.lat);
                                  prefs.setDouble('lon', cities.lon);

                                  Cities citi = Cities(c_id: cities.c_id, country: cities.country, name: cities.name, lat: cities.lat, lon: cities.lon, defaults: cities.defaults, sets: "true");

                                  _dbHelper.defaultCity();

                                  _dbHelper.setCity(citi);
                                  Navigator.pop(
                                    context
                                  );
                                },
                                child: Container(
                                  color: Colors.white,
                                  height: 100.0,
                                  child: Center(
                                    child: ListTile(
                                      title: Text(cities.name, style: TextStyle(fontSize: 16, color: sets == "true" ? Colors.blue : null),),
                                      subtitle: Text(cities.country, style: TextStyle(fontSize: 12, color: sets == "true" ? Colors.blue : null),),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );

                        },
                      );
                    } else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  },
                ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddCity()),
              );
            },
              child: Text("Not found your city in list? Manually add your city.", style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline))),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/controller/global_controller.dart';

import '../custom_colors.dart';
import '../databasehelper.dart';
import '../model/cities.dart';

class CityTab extends StatefulWidget {
  const CityTab({Key? key}) : super(key: key);

  @override
  State<CityTab> createState() => _CityTabState();
}

class _CityTabState extends State<CityTab> {

  final GlobalController globalController =
  Get.put(GlobalController(), permanent: true);

  List<Cities> _itemsList = [];
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
              child: RawAutocomplete<Cities> (
                textEditingController: controller,
                focusNode: focusNode,
                optionsBuilder: (TextEditingValue textEditingValue){
                  if(textEditingValue.text == ''){
                    return const Iterable<Cities>.empty();
                  }
                  return _itemsList.where((Cities cities) =>
                    cities.name.toString().toLowerCase().startsWith(textEditingValue.text.toLowerCase())
                  ).toList();
                },

                displayStringForOption: (Cities cities) => cities.name,

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

                onSelected: (Cities selection){
                  Cities cities = Cities(c_id: selection.c_id, country: selection.country, name: selection.name, lat: selection.lat, lon: selection.lon);
                  _dbHelper.insertCities(cities);
                  setState(() {
                    controller.clear();
                  });
                },

                optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<Cities> onSelected, Iterable<Cities> options){
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
                            final Cities option = options.elementAt(index);
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
              FutureBuilder(
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
                        return Dismissible(
                            key: UniqueKey(),
                            background: Container(color: Colors.red,
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
                                            _dbHelper.deleteCity(cities.c_id);
                                            Navigator.pop(context, true);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                              return res;

                          },
                          child: Container(
                            color: CustomColors.dividerLine,
                            height: 100.0,
                            child: Center(
                              child: ListTile(
                                title: Text(cities.name, style: const TextStyle(fontSize: 16),),
                                subtitle: Text(cities.country, style: const TextStyle(fontSize: 12),),
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
        ],
      ),
    );
  }
}

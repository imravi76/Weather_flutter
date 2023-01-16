import 'package:flutter/material.dart';
import 'package:weather/databasehelper.dart';
import 'package:weather/model/cities.dart';

class AddCity extends StatefulWidget {
  const AddCity({Key? key}) : super(key: key);

  @override
  State<AddCity> createState() => _AddCityState();
}

final DatabaseHelper _dbHelper = DatabaseHelper();

GlobalKey<FormState> _key = GlobalKey();

final cityController = TextEditingController();
final countryController = TextEditingController();
final latitudeController = TextEditingController();
final longitudeController = TextEditingController();

class _AddCityState extends State<AddCity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: ListView(
            children:<Widget> [
              Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const Text(
                      "Add your City",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),

                  Form(
                    key: _key,
                    child: Column(
                      children: [

                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.orangeAccent,
                                  width: 2
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 60,
                                child: Icon(
                                  Icons.reduce_capacity_outlined,
                                  size: 15,
                                  color: Colors.black26,
                                ),
                              ),

                              Expanded(
                                child: TextFormField(
                                  controller: cityController,
                                  validator: _validateCity,
                                  decoration: const InputDecoration(
                                      hintText: "Enter City Name",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(vertical: 20)
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.orangeAccent,
                                  width: 2
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 60,
                                child: Icon(
                                  Icons.account_balance,
                                  size: 15,
                                  color: Colors.black26,
                                ),
                              ),

                              Expanded(
                                child: TextFormField(
                                  controller: countryController,
                                  validator: _validateCountry,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Country Name",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(vertical: 20)
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.orangeAccent,
                                  width: 2
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 60,
                                child: Icon(
                                  Icons.edit_location_alt_rounded,
                                  size: 15,
                                  color: Colors.black26,
                                ),
                              ),

                              Expanded(
                                child: TextFormField(
                                  controller: latitudeController,
                                  validator: _validateLatitude,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Latitude",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(vertical: 20)
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.orangeAccent,
                                  width: 2
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 60,
                                child: Icon(
                                  Icons.edit_location_outlined,
                                  size: 15,
                                  color: Colors.black26,
                                ),
                              ),

                              Expanded(
                                child: TextFormField(
                                  controller: longitudeController,
                                  validator: _validateLongitude,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Longitude",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(vertical: 20)
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        GestureDetector(
                          onTap: (){
                            if(_key.currentState!.validate()){
                              Cities cities = Cities(c_id: DateTime.now().millisecondsSinceEpoch, country: countryController.text, name: cityController.text, lat: double.parse(latitudeController.text), lon: double.parse(longitudeController.text), defaults: "false", sets: "false");
                              _dbHelper.insertCities(cities);
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: const EdgeInsets.all(20),
                            child: const Center(
                              child: Text(
                              "Add City",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16
                                ),
                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                  )

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  String? _validateCity(String? value){
    if(value!.isEmpty){
      return '*Required Field';
    } else {
      return null;
    }
  }

  String? _validateCountry(String? value){
    if(value!.isEmpty){
      return '*Required Field';
    } else{
      return null;
    }
  }

  String? _validateLatitude(String? value){
    String pattern = r'(^[0-9.]*$)';
    RegExp regExp = RegExp(pattern);
    if(value!.isEmpty){
      return '*Required Field';
    } else if(!regExp.hasMatch(value)) {
      return 'Latitude should be numeric';
    } else {
      return null;
    }
  }

  String? _validateLongitude(String? value){
    String pattern = r'(^[0-9.]*$)';
    RegExp regExp = RegExp(pattern);
    if(value!.isEmpty){
      return '*Required Field';
    } else if(!regExp.hasMatch(value)) {
      return 'Longitude should be numeric';
    } else {
      return null;
    }
  }

}

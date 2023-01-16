import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ManualAddCity extends StatefulWidget {
  const ManualAddCity({Key? key}) : super(key: key);

  @override
  State<ManualAddCity> createState() => _ManualAddCityState();
}

final TextEditingController cityController = TextEditingController();

class _ManualAddCityState extends State<ManualAddCity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: cityController,
              decoration: const InputDecoration(
                  hintText: "Enter City Name",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 20)
              ),
            ),

            ElevatedButton(onPressed: () async {
              List<Location> locations = await locationFromAddress(cityController.text);
              print(locations);
            },
                child: const Text("Submit"))
          ],
        ),
      ),
    );
  }
}

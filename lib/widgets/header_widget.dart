import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/controller/global_controller.dart';

class Header extends StatefulWidget {

  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String City = "";
  String Country = "";

  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    getAddress();
    super.initState();
  }

  getAddress() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    double? lat = prefs.getDouble('lat');
    double? lon = prefs.getDouble('lon');

    List<Placemark> placemark = await placemarkFromCoordinates(lat!, lon!);
    Placemark place = placemark[0];
    setState(() {
      City = place.locality!;
      Country = "${place.administrativeArea!}, ${place.country!}";
    });
  }

  String getTime(final timestamp){
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  String getDay(final timestamp){
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String x = DateFormat('E').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              alignment: Alignment.topLeft,
              child: Text(
                City,
                style: const TextStyle(fontSize: 35, height: 2, color: Colors.white),
              ),
            ),
            globalController.checkConnection() == true ? Container(
              margin: const EdgeInsets.only(right: 20),
              height: 5, width: 5, decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.greenAccent),
            ): Container(
              margin: const EdgeInsets.only(right: 20),
              child: Row(
                children: const [
                  Icon(Icons.cloud_off),
                  SizedBox(width: 5),
                  Text("Offline Mode", style: TextStyle(color: Colors.white),)
                ],
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              alignment: Alignment.topLeft,
              child: Text(
                Country,
                style:
                TextStyle(fontSize: 14, height: 1.5, color: Colors.grey[400]),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              alignment: Alignment.topLeft,
              child: Text(
                "Updated: ${getDay(globalController.getData().getCurrentWeather().current.dt)}, ${getTime(globalController.getData().getCurrentWeather().current.dt)}",
                style:
                TextStyle(fontSize: 14, height: 1.5, color: Colors.grey[400]),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

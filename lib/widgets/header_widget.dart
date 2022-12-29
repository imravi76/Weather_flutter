import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:weather/controller/global_controller.dart';

class Header extends StatefulWidget {

  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String City = "";
  String Country = "";
  bool connection = false;

  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    getAddress(globalController.getLatitude().value,
        globalController.getLongitude().value);
    super.initState();
    connection = globalController.connection;
  }

  getAddress(lat, lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];
    print(place);
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
                style: const TextStyle(fontSize: 35, height: 2),
              ),
            ),
            connection == true ? Container(
              margin: const EdgeInsets.only(right: 20),
              height: 5, width: 5, decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.greenAccent),
            ): Container(
              margin: const EdgeInsets.only(right: 20),
              child: Row(
                children: const [
                  Icon(Icons.cloud_off),
                  SizedBox(width: 5),
                  Text("Offline Mode")
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
                TextStyle(fontSize: 14, height: 1.5, color: Colors.grey[700]),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              alignment: Alignment.topLeft,
              child: Text(
                "Last Updated: ${getDay(globalController.getData().getCurrentWeather().current.dt)}, ${getTime(globalController.getData().getCurrentWeather().current.dt)}",
                style:
                TextStyle(fontSize: 14, height: 1.5, color: Colors.grey[700]),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

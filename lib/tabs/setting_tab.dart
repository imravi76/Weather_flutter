import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../widgets/custom_action_bar.dart';

enum Units { metric, imperial }

class SettingTab extends StatefulWidget {
  const SettingTab({Key? key}) : super(key: key);

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  Units? _values;

  @override
  void initState() {
    super.initState();

    setUnits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
                      child: ExpansionTile(
                        title: const Text("Measurement Units"),
                        subtitle: Text(_values == Units.metric ? 'Metric' : 'Imperial'),
                        children: [
                          ListTile(
                              title: const Text("Metric (°C)"),
                              leading: Radio<Units>(
                                value: Units.metric,
                                groupValue: _values,
                                onChanged: (Units? value) {
                                  setState(() {
                                    _values = value;

                                    setValues(_values);
                                  });
                                },
                              )),
                          ListTile(
                            //toggleable: selected,
                            title: const Text("Imperial (°F)"),
                            leading: Radio<Units>(
                                value: Units.imperial,
                                groupValue: _values,
                                onChanged: (Units? value) {
                                  setState(() {
                                    _values = value;
                                    setValues(_values);
                                  });
                                }),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: const ExpansionTile(
                        title: Text("Credits"),
                        subtitle: Text("Know the developer"),
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text("Developed By:"),
                          Text("Ravi Singh"),
                          SizedBox(
                            height: 20,
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            CustomActionBar(
              cityChild: Container(
                margin: const EdgeInsets.only(right: 20),
                child: const Text(
                  "Settings",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    letterSpacing: 1.2,
                    color: Color(0xFF17262A),
                  ),
                ),
              ),
              statusChild: Container(
                margin: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.settings_suggest_outlined),
              ),
            )
          ],
        ),
      ),
    );
  }

  void setUnits() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('units') == 'metric') {
      _values = Units.metric;
      setState(() {});
    } else {
      _values = Units.imperial;
      setState(() {});
    }
  }

  void setValues(Units? values) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (values == Units.metric) {
      prefs.setString('units', 'metric');
      setState(() {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
          return const MyApp();
        }), (r){
          return false;
        });
      });
    } else {
      prefs.setString('units', 'imperial');
      setState(() {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
          return const MyApp();
        }), (r){
          return false;
        });
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

enum Units { metric, imperial }

enum Theme { system, dark, light }

class SettingTab extends StatefulWidget {
  const SettingTab({Key? key}) : super(key: key);

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  Units? _values;
  Theme? _themeValues;

  @override
  void initState() {
    super.initState();

    setUnits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEEEEE),
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: CircleAvatar(
            backgroundColor: Color(0xFFEEEEEE),
            child: Icon(
              Icons.settings_suggest_outlined,
              size: 32,
              color: Color(0xFF585858),
            ),
          ),
        ),
        title: const Text(
          "Settings",
          style: TextStyle(color: Color(0xFF0D0D0E)),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ExpansionTile(
                    title: const Text("Theme"),
                    subtitle: Text('Choose app theme'),
                    children: [
                      ListTile(
                          title: const Text("System default"),
                          leading: Radio<Theme>(
                            value: Theme.system,
                            groupValue: _themeValues,
                            onChanged: (Theme? value) {
                              setState(() {
                                _themeValues = value;

                                //setValues(_themeValues);
                              });
                            },
                          )),
                      ListTile(
                        //toggleable: selected,
                        title: const Text("Dark"),
                        leading: Radio<Theme>(
                            value: Theme.dark,
                            groupValue: _themeValues,
                            onChanged: (Theme? value) {
                              setState(() {
                                _themeValues = value;
                                //setValues(_themeValues);
                              });
                            }),
                      ),
                      ListTile(
                        //toggleable: selected,
                        title: const Text("Light"),
                        leading: Radio<Theme>(
                            value: Theme.light,
                            groupValue: _themeValues,
                            onChanged: (Theme? value) {
                              setState(() {
                                _themeValues = value;
                                //setValues(_themeValues);
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

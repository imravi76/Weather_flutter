import 'package:flutter/material.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({Key? key}) : super(key: key);

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {

  String? _value = "metric";

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
        child: Container(
            padding: const EdgeInsets.all(20),
            child:
                ExpansionTile(title: const Text("Measurement Units"), subtitle: Text(_value!), children: [
                  RadioListTile(
                      title: const Text("Metric (°C)"),
                      value: "metric",
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value.toString();
                        });
                      }),
                  RadioListTile(
                    //toggleable: selected,
                      title: const Text("Imperial (°F)"),
                      value: "imperial",
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value.toString();
                        });
                      }),
                ],
                ),
        ),
      ),
    );
  }
}

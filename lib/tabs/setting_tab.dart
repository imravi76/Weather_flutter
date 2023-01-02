import 'package:flutter/material.dart';

enum Units {metric, imperial}

class SettingTab extends StatefulWidget {
  const SettingTab({Key? key}) : super(key: key);

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {

  Units? _values = Units.metric;

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
                ExpansionTile(title: const Text("Measurement Units"), subtitle: const Text("Choose your preferred Unit!"), children: [
                  ListTile(
                      title: const Text("Metric (°C)"),
                      leading: Radio<Units>(
                  value: Units.metric,
                        groupValue: _values,
                        onChanged: (Units? value){
                    setState(() {
                      _values = value;
                    });
                        },
                      )
                      ),
                  ListTile(
                    //toggleable: selected,
                      title: const Text("Imperial (°F)"),
                  leading: Radio<Units>(
                    value: Units.imperial,
                    groupValue: _values,
                    onChanged: (Units? value){
                      setState(() {
                        _values = value;
                      });
                    }
                  ),
                  ),
                ],
                ),
        ),
      ),
    );
  }
}

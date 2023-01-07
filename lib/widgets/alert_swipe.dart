import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../custom_colors.dart';

class AlertSwipe extends StatefulWidget {

  final List? alertList;
  const AlertSwipe({Key? key, required this.alertList}) : super(key: key);

  @override
  State<AlertSwipe> createState() => _AlertSwipeState();
}

class _AlertSwipeState extends State<AlertSwipe> {

  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 325,
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: CustomColors.dividerLine.withAlpha(150)
      ),
      child: Row(
        children: [

          Expanded(
            child: PageView(
              scrollDirection: Axis.vertical,
              onPageChanged: (num){
                setState(() {
                  _selectedPage = num;
                });
              },
              children: [
                for(var i=0; i<widget.alertList!.length; i++)
                  Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                              "Sender Name: ${widget.alertList![i].senderName}"
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                              "Event: ${widget.alertList![i].event}"
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                              "Start: ${getDay(widget.alertList![i].start)}"
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                              "End: ${getDay(widget.alertList![i].end)}"
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 10, right: 20, bottom: 5),
                          child: Text(
                            "Description: ${widget.alertList![i].description}", textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 15,
                          ),
                        ),
                      ],
                    ),
              ],
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for(var i=0; i<widget.alertList!.length; i++)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  width: 10.0,
                  height: _selectedPage == i ? 35.0 : 10.0,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12.0)
                  ),
                  margin: const EdgeInsets.only(
                      top: 2, right: 10
                  ),
                ),
            ],
          ),


        ],
      ),
    );
  }

  String getDay(final timeStamp){
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('EEEE').format(time);
    return x;
  }
}

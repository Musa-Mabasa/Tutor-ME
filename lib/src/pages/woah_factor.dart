// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:tutor_me/src/colorpallete.dart';
import 'package:tutor_me/src/theme/themes.dart';

// ignore: must_be_immutable
class WoahFactor extends StatefulWidget {
  int connections;
  int interactions;
  int ratings;
  int meetings;
  double average;
  WoahFactor(
      {Key? key,
      required this.connections,
      required this.interactions,
      required this.meetings,
      required this.ratings,
      required this.average
      })
      : super(key: key);

  @override
  State<WoahFactor> createState() => _WoahFactorState();
}

class _WoahFactorState extends State<WoahFactor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBlueTeal,
        title: const Text(
          'Today\'s stats ',
          style: TextStyle(
            color: colorWhite,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                color: colorWhite,
                border:
                    Border.all(color: colorBlueTeal.withOpacity(0.4), width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: buildChart(),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Center(
            child: Text(
              "You Go Champ!",
              style: TextStyle(
                color: colorBlueTeal,
                fontSize: MediaQuery.of(context).size.height * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(
            color: colorBlueTeal.withOpacity(0.4),
            thickness: 1,
            indent: MediaQuery.of(context).size.width * 0.1,
            endIndent: MediaQuery.of(context).size.width * 0.1,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.07),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorWhite,
                        border: Border.all(color: colorGreen, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          widget.average.toString(),
                          style: TextStyle(
                            color: colorGreen.withOpacity(0.8),
                            fontSize: MediaQuery.of(context).size.height * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Text(
                "%",
                style: TextStyle(
                  color: colorGreen,
                  fontSize: MediaQuery.of(context).size.height * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_upward,
                        color: colorGreen,
                        size: MediaQuery.of(context).size.height * 0.04,
                      ),
                       Flexible(
                        child: Text(
                          widget.average.toString() + "% activity from the last 24hrs. You are doing a great job!",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_right,
                        color: colorOrange,
                        size: MediaQuery.of(context).size.height * 0.04,
                      ),
                      const Flexible(
                        child: Text(
                            "Off the total time spent in the app, more time was spent on interactions, it's good to see you are active!"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_right,
                        color: colorOrange,
                        size: MediaQuery.of(context).size.height * 0.04,
                      ),
                     Flexible(
                        child: Text("You have " +widget.connections.toString()+" connections in total so far. "),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildChart() {
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    int key = 0;
    Color secondaryColor;
    Color textColor;

    if (provider.themeMode == ThemeMode.dark) {
      textColor = colorWhite;
      secondaryColor = colorLightGrey;
    } else {
      textColor = colorDarkGrey;
      secondaryColor = colorWhite;
    }

    Map<String, double> dataMap = {
      "Meetings": widget.meetings.toDouble(),
      "Connections": widget.connections.toDouble(),
      "Interactions": widget.interactions.toDouble(),
      "Ratings": widget.ratings.toDouble(),
    };

    List<Color> chartColorList = [
      Colors.blue,
      colorLightGreen,
      colorOrange,
      Colors.yellow,
    ];

    return PieChart(
      key: ValueKey(key),
      centerText: "Activity",
      dataMap: dataMap,
      initialAngleInDegree: 0,
      animationDuration: const Duration(milliseconds: 3500),
      chartType: ChartType.ring,
      ringStrokeWidth: 15,
      colorList: chartColorList,
      chartLegendSpacing: 34,
      chartRadius: MediaQuery.of(context).size.height / 6.6,
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: true,
        decimalPlaces: 1,
        chartValueStyle: TextStyle(
          background: Paint()..color = secondaryColor,
          color: colorDarkGrey,
          fontWeight: FontWeight.normal,
          fontSize: MediaQuery.of(context).size.height * 0.015,
        ),
      ),
      // centerText: 'Progress',
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,
        legendShape: BoxShape.rectangle,
        legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: MediaQuery.of(context).size.width * 0.03),
      ),
    );
  }
}

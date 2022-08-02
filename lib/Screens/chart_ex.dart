// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LineChartSample4 extends StatefulWidget {
  List<double> mDataY;
  List<double> mDataX;
  List<double> mDataZ;

  LineChartSample4(
      {Key? key,
      required this.mDataX,
      required this.mDataZ,
      required this.mDataY})
      : super(key: key);

  @override
  State<LineChartSample4> createState() => _LineChartSample4State();
}

class _LineChartSample4State extends State<LineChartSample4> {
  double maxV = 0;
  double minV = 0;

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black, fontSize: 12.0);
    return SideTitleWidget(
      space: 0,
      angle: 0,
      axisSide: meta.axisSide,
      child: Text('$value', style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 2),(timer){  
        maxV = 0;
        minV = 0;
      });
// Determines the top and bottom line of chart
    FlSet(String line) {
      
      switch (line) {
        case "top":
          {
            for (double i in widget.mDataX) {
              if (i > maxV) {
                maxV = i;
              }
            }
            for (double i in widget.mDataY) {
              if (i > maxV) {
                maxV = i;
              }
            }
            for (double i in widget.mDataZ) {
              if (i > maxV) {
                maxV = i;
              }
            }
          }
          return [FlSpot(0, maxV)];
        case "bottom":
          {
            {
              for (double i in widget.mDataX) {
                if (i < minV) {
                  minV = i;
                }
              }
              for (double i in widget.mDataY) {
                if (i < minV) {
                  minV = i;
                }
              }
              for (double i in widget.mDataZ) {
                if (i < minV) {
                  minV = i;
                }
              }
            }
            return [FlSpot(0, minV)];
          }
      }
    }

    double cutOffYValue = widget.mDataY.length < 100 ? 0 : widget.mDataY[50];

    List<FlSpot> spotsY = widget.mDataY.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value);
    }).toList();
    List<FlSpot> spotsZ = widget.mDataZ.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value);
    }).toList();
    List<FlSpot> spotsX = widget.mDataX.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value);
    }).toList();
    return AspectRatio(
      aspectRatio: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 24),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(enabled: false),
            lineBarsData: [
              LineChartBarData(
                spots: spotsY,
                isCurved: true,
                barWidth: 1,
                color: Colors.green,
                belowBarData: BarAreaData(
                  show: false,
                  color: Colors.deepPurple.withOpacity(0.4),
                  cutOffY: cutOffYValue,
                  applyCutOffY: true,
                ),
                aboveBarData: BarAreaData(
                  show: false,
                  color: Colors.orange.withOpacity(0.6),
                  cutOffY: cutOffYValue,
                  applyCutOffY: true,
                ),
                dotData: FlDotData(
                  show: false,
                ),
              ),
              LineChartBarData(
                spots: FlSet("top"),
                isCurved: true,
                barWidth: 1,
                color: Colors.red,
                belowBarData: BarAreaData(
                  show: false,
                  color: Colors.deepPurple.withOpacity(0.4),
                  cutOffY: cutOffYValue,
                  applyCutOffY: true,
                ),
                aboveBarData: BarAreaData(
                  show: false,
                  color: Colors.orange.withOpacity(0.6),
                  cutOffY: cutOffYValue,
                  applyCutOffY: true,
                ),
                dotData: FlDotData(
                  show: false,
                ),
              ),
              LineChartBarData(
                spots: FlSet("bottom"),
                isCurved: true,
                barWidth: 1,
                color: Colors.red,
                belowBarData: BarAreaData(
                  show: false,
                  color: Colors.deepPurple.withOpacity(0.4),
                  cutOffY: cutOffYValue,
                  applyCutOffY: true,
                ),
                aboveBarData: BarAreaData(
                  show: false,
                  color: Colors.orange.withOpacity(0.6),
                  cutOffY: cutOffYValue,
                  applyCutOffY: true,
                ),
                dotData: FlDotData(
                  show: false,
                ),
              ),
              LineChartBarData(
                spots: spotsZ,
                isCurved: true,
                barWidth: 1,
                color: Colors.black,
                belowBarData: BarAreaData(
                  show: false,
                  color: Colors.deepPurple.withOpacity(0.4),
                  cutOffY: cutOffYValue,
                  applyCutOffY: true,
                ),
                aboveBarData: BarAreaData(
                  show: false,
                  color: Colors.orange.withOpacity(0.6),
                  cutOffY: cutOffYValue,
                  applyCutOffY: true,
                ),
                dotData: FlDotData(
                  show: false,
                ),
              ),
              LineChartBarData(
                spots: spotsX,
                isCurved: true,
                barWidth: 1,
                color: Colors.indigo,
                belowBarData: BarAreaData(
                  show: false,
                  color: Colors.deepPurple.withOpacity(0.4),
                  cutOffY: cutOffYValue,
                  applyCutOffY: true,
                ),
                aboveBarData: BarAreaData(
                  show: false,
                  color: Colors.orange.withOpacity(0.6),
                  cutOffY: cutOffYValue,
                  applyCutOffY: true,
                ),
                dotData: FlDotData(
                  show: false,
                ),
              ),
            ],
            titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                axisNameSize: 20,
                axisNameWidget: const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text('Value'),
                ),
                sideTitles: SideTitles(
                  showTitles: false,
                  interval: 3,
                  reservedSize: 3,
                  getTitlesWidget: leftTitleWidgets,
                ),
              ),
            ),
            gridData: FlGridData(
              show: false,
              drawVerticalLine: false,
              horizontalInterval: 1,
              checkToShowHorizontalLine: (double value) {
                return true;
              },
            ),
          ),
        ),
      ),
    );
  }
}

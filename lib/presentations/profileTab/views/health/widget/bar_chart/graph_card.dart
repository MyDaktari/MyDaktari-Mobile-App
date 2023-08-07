import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/presentations/profileTab/views/health/widget/bar_chart/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  const MyBarGraph({super.key, required this.weeklySummary});
  final List<double> weeklySummary;

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
        monAmount: weeklySummary[0],
        tueAmount: weeklySummary[1],
        wedAmount: weeklySummary[2],
        thuAmount: weeklySummary[3],
        friAmount: weeklySummary[4],
        satAmount: weeklySummary[5],
        sunAmount: weeklySummary[6]);
    myBarData.initilizeBarData();
    double maxValue = weeklySummary
        .reduce((value, element) => value > element ? value : element);
    return BarChart(BarChartData(
      maxY: maxValue + (maxValue < 50 ? 5 : 20),
      minY: 0,
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles:
                SideTitles(showTitles: true, getTitlesWidget: getBottomTitles),
          )),
      barGroups: myBarData.barData
          .map((data) => BarChartGroupData(x: data.x, barRods: [
                BarChartRodData(
                    gradient: RadialGradient(
                      radius: 20,
                      colors: [
                        primaryColor,
                        greenish,
                        primaryColor,
                        primaryColor,
                      ],
                    ),
                    toY: data.y,
                    width: 20,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)))
              ]))
          .toList(),
    ));
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 14, color: Colors.grey);
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('M', style: style);
        break;
      case 1:
        text = Text('T', style: style);
        break;
      case 2:
        text = Text('W', style: style);
        break;
      case 3:
        text = Text('T', style: style);
        break;
      case 4:
        text = Text('F', style: style);
        break;
      case 5:
        text = Text('S', style: style);
        break;
      case 6:
        text = Text('S', style: style);
        break;
      default:
        text = Text(' ', style: style);
    }
    return SideTitleWidget(child: text, axisSide: meta.axisSide);
  }
}

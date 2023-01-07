import 'package:covid19tracker/model/word_status_model.dart';
import 'package:covid19tracker/screens/countries_list.dart';
import 'package:covid19tracker/utils/services/stateServices.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  StateServices stateServices = StateServices();

  final colorList = [
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                FutureBuilder(
                  future: stateServices.fetchWorldStatusData(),
                  builder: (context, AsyncSnapshot<WorldStatusModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            controller: _controller,
                            size: 50,
                          ),
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * .01),
                          PieChart(
                            dataMap: {
                              'Total':
                                  double.parse(snapshot.data!.cases.toString()),
                              'Recovered': double.parse(
                                  snapshot.data!.recovered.toString()),
                              'Deaths':
                                  double.parse(snapshot.data!.deaths.toString()),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true),
                            animationDuration: const Duration(milliseconds: 1200),
                            legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                            chartRadius: MediaQuery.of(context).size.width / 3.2,
                            chartType: ChartType.ring,
                            colorList: colorList,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * .06),
                            child: Card(
                              child: Column(
                                children: [
                                  ReusableRow(
                                      title: 'Total',
                                      value: snapshot.data!.cases.toString(),),
                                  ReusableRow(
                                      title: 'Recovered',
                                      value: snapshot.data!.recovered.toString(),),
                                  ReusableRow(
                                      title: 'Deaths',
                                      value: snapshot.data!.deaths.toString(),),
                                  ReusableRow(
                                      title: 'Active',
                                      value: snapshot.data!.active.toString(),),
                                  ReusableRow(
                                      title: 'Critical',
                                      value: snapshot.data!.critical.toString(),),
                                  ReusableRow(
                                      title: 'Today Cases',
                                      value: snapshot.data!.todayCases.toString(),),
                                  ReusableRow(
                                      title: 'Today Recovered',
                                      value: snapshot.data!.todayRecovered.toString(),),
                                  ReusableRow(
                                      title: 'Today Deaths',
                                      value: snapshot.data!.todayDeaths.toString(),),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Text('Track Countries'),
                              ),
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CountriesListScreen(),));
                            },
                          )
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  const ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          const SizedBox(height: 5),
          const Divider(),
        ],
      ),
    );
  }
}

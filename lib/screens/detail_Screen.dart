import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(
      {Key? key,
      required this.name,
      required this.image,
      required this.totatCases,
      required this.totalDeaths,
      required this.totatRecovered,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test})
      : super(key: key);

  final String image, name;
  final int totatCases,
      totalDeaths,
      totatRecovered,
      active,
      critical,
      todayRecovered,
      test;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .06),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.image),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .0532),
              child: Card(
                margin: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    ReusableRow(
                        title: 'Cases', value: widget.totatCases.toString()),
                    ReusableRow(
                        title: 'Recovered',
                        value: widget.totatRecovered.toString()),
                    ReusableRow(
                        title: 'Deaths', value: widget.totalDeaths.toString()),
                    ReusableRow(
                        title: 'Critical', value: widget.critical.toString()),
                    ReusableRow(
                        title: 'Today Recovered',
                        value: widget.totatRecovered.toString()),
                  ],
                ),
              ),
            )
          ],
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
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
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

import 'package:covid19tracker/screens/detail_Screen.dart';
import 'package:covid19tracker/utils/services/stateServices.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  StateServices stateServices = StateServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(color: Color(0xff1aa260))),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: stateServices.countriesListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                                title: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];

                        if (searchController.text.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                        name: snapshot.data![index]['country'],
                                        image: snapshot.data![index]
                                            ['countryInfo']['flag'],
                                        active: snapshot.data![index]['active'],
                                        critical: snapshot.data![index]
                                            ['critical'],
                                        todayRecovered: snapshot.data![index]
                                            ['todayRecovered'],
                                        test: snapshot.data![index]['tests'],
                                        totalDeaths: snapshot.data![index]
                                            ['todayDeaths'],
                                        totatCases: snapshot.data![index]
                                            ['cases'],
                                        totatRecovered: snapshot.data![index]
                                            ['todayRecovered'],
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  leading: Image(
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag']),
                                    height: 50,
                                    width: 50,
                                  ),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                ),
                              ),
                            ],
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                        name: snapshot.data![index]['country'],
                                        image: snapshot.data![index]
                                            ['countryInfo']['flag'],
                                        active: snapshot.data![index]['active'],
                                        critical: snapshot.data![index]
                                            ['critical'],
                                        todayRecovered: snapshot.data![index]
                                            ['todayRecovered'],
                                        test: snapshot.data![index]['tests'],
                                        totalDeaths: snapshot.data![index]
                                            ['todayDeaths'],
                                        totatCases: snapshot.data![index]
                                            ['cases'],
                                        totatRecovered: snapshot.data![index]
                                            ['todayRecovered'],
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  leading: Image(
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag']),
                                    height: 50,
                                    width: 50,
                                  ),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

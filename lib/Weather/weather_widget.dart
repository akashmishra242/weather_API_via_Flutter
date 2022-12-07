// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/Weather/weather_model.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  bool issubmitted = false;
  late String query;
  late final TextEditingController _citycontroller = TextEditingController();
  late final TextEditingController _statecontroller = TextEditingController();
  late final TextEditingController _countrycontroller = TextEditingController();

  Future<String> getip() async {
    final ipv4 = await Ipify.ipv4();
    return ipv4.toString();
  }

  Future<WeatherModel> getWeatherAPI() async {
    const weatherapikey = '48d3958e65ec8038d8d1924fb7be500d';
    final response = await http.get(
      Uri.parse(
        'http://api.weatherstack.com/current?access_key=$weatherapikey&query=$query',
      ),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(data);
    } else {
      return WeatherModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          const Card(
              elevation: 5,
              color: Color.fromARGB(255, 209, 139, 146),
              child: Text(
                "Weather Information",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )),
          Visibility(
              visible: issubmitted,
              replacement: Column(
                children: [
                  TextFormField(
                    controller: _citycontroller,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    maxLength: 15,
                    decoration: const InputDecoration(
                        hintText: "eg. Gorakhpur", labelText: 'Enter City'),
                    onSaved: (newValue) {
                      setState(() {
                        _citycontroller.text = newValue!;
                      });
                    },
                  ),
                  TextFormField(
                    controller: _statecontroller,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    maxLength: 15,
                    decoration: const InputDecoration(
                        hintText: "eg. Uttar Pradesh",
                        labelText: 'Enter State'),
                    onSaved: (newValue) {
                      setState(() {
                        _statecontroller.text = newValue!;
                      });
                    },
                  ),
                  TextFormField(
                    controller: _countrycontroller,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    maxLength: 15,
                    decoration: const InputDecoration(
                        hintText: "eg. India",
                        labelText: 'Enter Country (optional)'),
                    onSaved: (newValue) {
                      setState(() {
                        _countrycontroller.text = newValue!;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              log(_citycontroller.text.toString());
                              log(_statecontroller.text.toString());
                              log(_countrycontroller.text.toString());
                              if ((_citycontroller.text.isEmpty &&
                                  _statecontroller.text.isEmpty &&
                                  _countrycontroller.text.isEmpty)) {
                                query = "Gorakhpur,Uttar Pradesh";
                              } else {
                                query =
                                    "${_citycontroller.text}, ${_statecontroller.text} ${_countrycontroller.text}";
                              }
                              log(query);
                              issubmitted = true;
                            });
                          },
                          child: const Text("Submit or Skip")),
                      ElevatedButton(
                          onPressed: () async {
                            await getip().then((value) {
                              query = value;
                              issubmitted = true;
                              log(query);
                              setState(() {});
                            });
                          },
                          child: const Text("via IP Address")),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              query = "fetch:ip";
                              log(query);
                              issubmitted = true;
                            });
                          },
                          child: const Text("auto detect via IP")),
                    ],
                  ),
                ],
              ),
              child: Expanded(
                child: FutureBuilder<WeatherModel>(
                  future: getWeatherAPI(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        if (snapshot.hasData) {
                          return Card(
                            color: Colors.white,
                            elevation: 10,
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.20,
                                  child: Image.network(
                                    "${snapshot.data!.current?.weatherIcons![0]}",
                                    scale: 0.5,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  child: Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Time & Date",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            DateFormat.yMMMMd('en_US')
                                                .add_jm()
                                                .format(DateFormat(
                                                        "yyyy-MM-dd hh:mm")
                                                    .parse(snapshot
                                                            .data!
                                                            .location
                                                            ?.localtime ??
                                                        '')),
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          const Text(
                                            "Location",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "City : ${snapshot.data!.location?.name}, ",
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            "State : ${snapshot.data!.location?.region}, ",
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            "Country : ${snapshot.data!.location?.country}",
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          const Text(
                                            "Weather",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Temprature: ${snapshot.data!.current?.temperature} °C ,${snapshot.data!.current?.weatherDescriptions![0]}",
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            "Wind Speed: ${snapshot.data!.current?.windSpeed}km/h, Direction : ${snapshot.data!.current?.windDir}",
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            "Percipitation: ${snapshot.data!.current?.precip} %, Humidity : ${snapshot.data!.current?.humidity} %",
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }
}

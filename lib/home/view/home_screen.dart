import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/common/style/sized_box.dart';

import 'package:weather_app/home/controller/home_controller.dart';
import 'package:weather_app/home/view/widgets/common_card.dart';
import 'package:weather_app/home/view/widgets/more_detials.dart';
import 'package:weather_app/search/view/seach_screen.dart';

import 'package:weather_app/widgets/loading_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.history();
      provider.getIp();
      provider.getWeatherData();
    });

    return Consumer<HomeController>(
      builder: (context, homeController, child) {
        return Scaffold(
          backgroundColor: homeController.weatherList?.current.isDay == 1
              ? Colors.blue
              : const Color.fromARGB(223, 1, 21, 56),
          appBar: AppBar(
            title: const Text('Weather App'),
            backgroundColor: homeController.weatherList?.current.isDay == 1
                ? Colors.blue
                : const Color.fromARGB(223, 1, 21, 56),
            actions: [
              IconButton(
                onPressed: () {
                  homeController.getIp();
                },
                icon: const Icon(
                  Icons.replay_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: homeController.isLoading == true ||
                  homeController.isLoading2 == true ||
                  homeController.isLoading3 == true
              ? const LoadingWidget()
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const SearchScreen();
                            },
                          ));
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          contentPadding: EdgeInsets.zero,
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 5.0),
                          ),
                        ),
                        showCursor: false,
                        readOnly: true,
                      ),
                      KSizedBox().height20,
                      Container(
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.10),
                            )
                          ],
                          border: Border.all(
                              color: Colors.white.withOpacity(0.2), width: 1.0),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.2),
                              Colors.white.withOpacity(0.2)
                            ],
                            stops: const [1.0, 1.0],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              horizontalTitleGap: 0,
                              dense: true,
                              title: Text(
                                "${homeController.weatherList?.location.name}, ${homeController.weatherList?.location.region}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              subtitle: Text(
                                "${homeController.weatherList?.location.country}",
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  homeController.weatherList?.current.tempC
                                          .toStringAsFixed(0) ??
                                      "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 60,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Text(
                                    "°C",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: const Color.fromARGB(
                                                255, 255, 206, 59),
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Spacer(),
                                homeController.isLoading == true
                                    ? const LoadingWidget()
                                    : Container(
                                        height: 90,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              "https:${homeController.weatherList?.current.condition.icon}",
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            Text(
                              homeController
                                      .weatherList?.current.condition.text ??
                                  '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            KSizedBox().height10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${(homeController.weatherList?.location.localtime)}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  homeController.weatherList?.current.isDay == 1
                                      ? 'DAY'
                                      : "NIGHT",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      KSizedBox().height20,
                      Wrap(
                        children: [
                          CommonCard(
                            text:
                                "${homeController.weatherList?.current.windMph} km/h",
                            icon: Icons.air_sharp,
                            text2: "Wind",
                            color: Colors.blue,
                          ),
                          CommonCard(
                            text:
                                "${homeController.weatherList?.current.humidity}",
                            icon: Icons.water_sharp,
                            text2: 'Humidity',
                            color: Colors.red,
                          ),
                          CommonCard(
                            text: homeController.weatherList?.current.cloud
                                    .toString() ??
                                '',
                            icon: Icons.cloud,
                            text2: "Cloud",
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      KSizedBox().height20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              MoreDetialsWidgets(
                                title: 'wind Direction',
                                text: homeController
                                        .weatherList?.current.windDir
                                        .toString() ??
                                    '',
                              ),
                              KSizedBox().height20,
                              MoreDetialsWidgets(
                                title: 'Wind',
                                text:
                                    "${homeController.weatherList?.current.windMph} m/h",
                              ),
                              KSizedBox().height20,
                              MoreDetialsWidgets(
                                title: 'Temperature',
                                text:
                                    "${homeController.weatherList?.current.tempF} °F",
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              MoreDetialsWidgets(
                                title: 'Pressure',
                                text:
                                    "${homeController.weatherList?.current.pressureMb} mb"
                                    '',
                              ),
                              KSizedBox().height20,
                              MoreDetialsWidgets(
                                title: 'UV',
                                text:
                                    "${homeController.weatherList?.current.uv}",
                              ),
                              KSizedBox().height20,
                              MoreDetialsWidgets(
                                title: 'Last Updated',
                                text:
                                    "${homeController.weatherList?.current.lastUpdated}",
                                color: const Color.fromARGB(255, 31, 216, 38),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

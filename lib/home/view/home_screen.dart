import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/common/style/sized_box.dart';
import 'package:weather_app/home/controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeController>(context, listen: false).getWeatherData();
    });

    return Consumer<HomeController>(
      builder: (context, homeController, child) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(223, 1, 21, 56),
          appBar: AppBar(
            title: const Text('Weather App'),
            backgroundColor: const Color.fromARGB(223, 1, 21, 56),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  const CupertinoSearchTextField(
                    backgroundColor: Colors.white,
                  ),
                  KSizedBox().height20,
                  Container(
                    padding: const EdgeInsets.all(20),
                    // height: 200,
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
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 20,
                            ),
                            Text(
                              " ${homeController.weatherList?.location.name}, ${homeController.weatherList?.location.region}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              " ${homeController.weatherList?.location.country}",
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
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
                                color: Colors.white,
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
                                ? const Center(
                                    child: CircularProgressIndicator())
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
                          homeController.weatherList?.current.condition.text ??
                              '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        KSizedBox().height10,
                        Text(
                          "${homeController.weatherList?.location.localtime}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  KSizedBox().height20,
                  Wrap(
                    children: [
                      CommonCard(
                        text:
                            "${homeController.weatherList!.current.windMph} km/h",
                        icon: Icons.air_sharp,
                        text2: "Wind",
                        color: Colors.blue,
                      ),
                      CommonCard(
                        text: "${homeController.weatherList!.current.humidity}",
                        icon: Icons.water_sharp,
                        text2: 'Humidity',
                        color: Colors.red,
                      ),
                      CommonCard(
                        text: homeController.weatherList!.current.windDir,
                        icon: Icons.flag_outlined,
                        text2: "wind Direction",
                        color: Colors.orange,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CommonCard extends StatelessWidget {
  const CommonCard({
    super.key,
    required this.text,
    required this.icon,
    required this.text2,
    required this.color,
  });
  final String text;
  final IconData icon;
  final String text2;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: color,
            ),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              text2,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

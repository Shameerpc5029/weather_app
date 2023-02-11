import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/home/controller/home_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Provider.of<HomeController>(context, listen: false)
                  .searchController
                  .clear();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Consumer<HomeController>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CupertinoSearchTextField(
                  placeholder: 'Search city name for history',
                  controller: value.searchController,
                  onChanged: (result) {
                    value.search(result);
                  },
                  autofocus: true,
                  borderRadius: BorderRadius.circular(20),
                  backgroundColor: Colors.white,
                ),
                ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: value.resultList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(value.resultList[index].city),
                      subtitle: Text(
                        "Humidity ${value.resultList[index].humidity}",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        "${value.resultList[index].temperature} °C",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

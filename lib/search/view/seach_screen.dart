import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/home/controller/home_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<HomeController>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                CupertinoSearchTextField(
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
                      subtitle: Text(value.resultList[index].humidity),
                      trailing:
                          Text("${value.resultList[index].temperature} °C"),
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

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tasks/pages/description.dart';

//fetch data from url

class GlobalTasks extends StatefulWidget {
  const GlobalTasks({
    super.key,
  });

  @override
  State<GlobalTasks> createState() => _GlobalTasksState();
}

class _GlobalTasksState extends State<GlobalTasks> {
  final List<Map<String, dynamic>> _allTasks = [];
  // ignore: prefer_typing_uninitialized_variables
  var jsondata;
  List<Map<String, dynamic>> _newTasks = [];
  bool isLoading = true;

  Future<void> getTasks() async {
    var response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos"));
    if (response.statusCode == 200) {
      jsondata = jsonDecode(response.body);
    } else {
      // Error handling
      return;
    }
    for (var i = 0; i < jsondata.length; i++) {
      _allTasks.add({
        "title": jsondata[i]["title"],
        "completed": jsondata[i]["completed"],
      });
    }
    setState(() {
      _newTasks = _allTasks;
      isLoading = false; // Set isLoading to false after data is fetched
    });
  }

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  // search function
  void updateTask(String val) {
    setState(() {
      if (val.isEmpty) {
        _newTasks = _allTasks;
      } else {
        _newTasks = _allTasks
            .where((element) => element["title"]
                .toString()
                .toLowerCase()
                .contains(val.toString().toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("TO-DO"),
          titleTextStyle: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
          elevation: 0.00,
          backgroundColor: const Color.fromARGB(255, 82, 219, 89),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 5),
                child: TextFormField(
                  onChanged: (value) {
                    updateTask(value);
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: "Search",
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator(), // Show circular progress indicator while loading data
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: ListView.builder(
                        itemCount: _newTasks.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => description(
                                    context,
                                    _newTasks[index]["title"].toString(),
                                    _newTasks[index]["completed"].toString(),
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              child: ListTile(
                                leading: const Icon(Icons.file_copy),
                                title: Text(
                                  _newTasks[index]["title"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: const Text(
                                  "Type: Global",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                tileColor:
                                    const Color.fromARGB(255, 226, 214, 214)
                                        .withOpacity(0.5),
                                selected: _newTasks[index]["completed"],
                                trailing: _newTasks[index]["completed"]
                                    ? const Icon(Icons.done)
                                    : const Icon(Icons.cancel),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

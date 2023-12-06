import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'detailPage.dart';


class searchPage extends StatefulWidget {
  const searchPage({Key? key}) : super(key: key);

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  late List<dynamic> eventData = [];
  late List<dynamic> filteredData = [];

  Future<void> fetchDataFromApi() async {
    final apiUrl = 'https://sde-007.api.assignment.theinternetfolks.works/v1/event';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          eventData = json.decode(response.body)['content']['data'];
          filteredData = List.from(eventData); // Initialize filteredData with all data initially
        });
      } else {
        print('Failed to fetch data. Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void filterData(String query) {
    setState(() {
      filteredData = eventData
          .where((event) =>
          event['title'].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    fetchDataFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Container(
            child: Row(
              children: [
                Icon(Icons.arrow_back,color: Colors.black,size: 35,),
                SizedBox(width: 10,),
                Text("Search",
                  style: TextStyle(color: Colors.black),),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => filterData(value),
              decoration: InputDecoration(
                hintText: 'Type Event Name',
                prefixIcon: Icon(Icons.search, color: Colors.blue),
                // border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (BuildContext context, int index) {
                final event = filteredData[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailsPage(event: event),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100, // Adjust the width as needed
                            height: 100, // Adjust the height as needed
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(event['banner_image'] ?? ''),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //   event['title'] ?? 'No title available',
                                //   style: TextStyle(fontWeight: FontWeight.bold),
                                // ),
                                Row(
                                  children: [
                                    Text(
                                      event['date_time'] != null
                                          ? DateTime.parse(event['date_time'])
                                          .toString()
                                          : 'No date available',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 5),
                                Text(
                                    event['description'] ??
                                        'No description available',
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(height: 8),

                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      // SizedBox(width: 5),
                                      Icon(Icons.location_pin, color: Colors.grey),
                                      Text(
                                        event['venue_name'] ??
                                            'No venue name available',
                                      ),
                                      Text(
                                        event['venue_city'] ??
                                            'No venue city available',
                                      ),
                                      Text(
                                        event['venue_country'] ??
                                            'No venue country available',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}

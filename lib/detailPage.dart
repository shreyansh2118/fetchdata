import 'package:flutter/material.dart';

class EventDetailsPage extends StatelessWidget {
  final Map<String, dynamic> event;

  const EventDetailsPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Event Details'),
      // ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          children: [
            Container(
              width: 600, // Adjust the width as needed
              height: 250, // Adjust the height as needed
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(event['banner_image'] ?? ''),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48.0, left: 20),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 35,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Event Details",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Text(
                    event['title'] ?? 'No title available',
                    style: TextStyle(fontSize: 36),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // SizedBox(width: 5),
                      Icon(Icons.location_pin, color: Colors.blue),
                      Text(
                        'The Internet Folks',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  Text(
                    "Organizer",
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.calendar_today, color: Colors.blue),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        event['date_time'] != null
                            ? DateTime.parse(event['date_time']).toString()
                            : 'No date available',
                        // style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // SizedBox(width: 5),
                      Icon(Icons.location_pin, color: Colors.blue),
                      Text(
                        event['venue_name'] ?? 'No venue name available',
                      ),
                      Text(
                        event['venue_city'] ?? 'No venue city available',
                      ),
                    ],
                  ),
                  Text(
                    event['venue_country'] ?? 'No venue country available',
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        "About Event",
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(event['description'] ?? 'No description available',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),

        // SizedBox(height: 160,),
        Expanded(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              primary: Colors.blue, // Set the button color to purple
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Book Now'),
                SizedBox(width: 8.0),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
        )),
      ]),
    );
  }
}

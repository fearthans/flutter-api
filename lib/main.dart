import 'package:flutter/material.dart';
import 'package:apps_api/services/api_service.dart';
import 'package:apps_api/model/school_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sekolah Indonesia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SchoolListScreen(),
    );
  }
}

class SchoolListScreen extends StatefulWidget {
  @override
  _SchoolListScreenState createState() => _SchoolListScreenState();
}

class _SchoolListScreenState extends State<SchoolListScreen> {
  late Future<List<School>> futureSchools;

  @override
  void initState() {
    super.initState();
    futureSchools = ApiService().fetchSchools();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sekolah Indonesia'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                futureSchools = ApiService().fetchSchools();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<School>>(
        future: futureSchools,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                futureSchools = ApiService().fetchSchools();
              });
            },
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final school = snapshot.data![index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          school.name,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.blue),
                            SizedBox(width: 8),
                            Expanded(child: Text(school.address)),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Propinsi: ${school.province}'),
                            Text('Kabupaten: ${school.city}'),
                            Text('Kecamatan: ${school.district}'),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text('Bentuk: ${school.type}'),
                        SizedBox(height: 4),
                        Text('NPSN: ${school.npsn}', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

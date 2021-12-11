import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_health_app/blocks/application_block.dart';
import 'package:provider/provider.dart';

class Professionals extends StatefulWidget {
  const Professionals({Key? key}) : super(key: key);

  @override
  _ProfessionalsState createState() => _ProfessionalsState();
}

class _ProfessionalsState extends State<Professionals> {
  @override
  Widget build(BuildContext context) {
    final applicationBlock = Provider.of<ApplicationBlock>(context);

    return Scaffold(
      body: (applicationBlock.currentLocation == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Location',
                      suffixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) => applicationBlock.searchPlaces(value),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 300.0,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        myLocationEnabled: true,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                applicationBlock.currentLocation!.latitude,
                                applicationBlock.currentLocation!.longitude),
                            zoom: 14),
                      ),
                    ),
                    Container(
                      height: 300.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.6),
                          backgroundBlendMode: BlendMode.darken),
                    ),
                    Container(
                      height: 300.0,
                      child: ListView.builder(
                        itemCount: applicationBlock.searchResults?.length ?? 0,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              applicationBlock
                                  .searchResults![index].description,
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
    );
  }
}

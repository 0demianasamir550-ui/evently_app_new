import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapTab(),
    );
  }
}

class MapTab extends StatelessWidget {
  const MapTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// الخريطة
          const GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(30.0444, 31.2357), // Cairo, Egypt
              zoom: 12,
            ),
          ),

          /// زرار فوق (زي العين في الصورة)
          Positioned(
            top: 100,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                // هنا تضيف الأكشن اللي عايزه
              },
              child: const Icon(Icons.remove_red_eye),
            ),
          ),

          /// الكارد اللي تحت
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.meeting_room, size: 40),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            "Meeting for Updating",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text("Cairo, Egypt"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
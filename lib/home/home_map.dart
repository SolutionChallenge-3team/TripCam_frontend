import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWithBottomSheet extends StatefulWidget {
  const MapWithBottomSheet({super.key});

  @override
  State<MapWithBottomSheet> createState() => _MapWithBottomSheetState();
}

class _MapWithBottomSheetState extends State<MapWithBottomSheet> {
  late GoogleMapController _mapController;
  static const LatLng _center = LatLng(37.514575, 127.060045);
  bool _showBottomSheet = false;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onMarkerTapped() {
    setState(() {
      _showBottomSheet = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 지도
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: _center,
              zoom: 15,
            ),
            markers: {
              Marker(
                markerId: const MarkerId("place1"),
                position: _center,
                onTap: _onMarkerTapped,
              ),
            },
          ),

          // 바텀 시트
          if (_showBottomSheet)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                height: 200,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '봉은사 사찰',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('서울 강남구 봉은사로 531\n역사 깊은 사찰과 아름다운 정원'),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

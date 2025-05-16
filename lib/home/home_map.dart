import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapWithBottomSheet extends StatefulWidget {
  const MapWithBottomSheet({super.key});

  @override
  State<MapWithBottomSheet> createState() => _MapWithBottomSheetState();
}

class _MapWithBottomSheetState extends State<MapWithBottomSheet> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  bool _showBottomSheet = false;

  final LatLng _markerPosition = const LatLng(37.514575, 127.060045);
  final List<Marker> _customMarkers = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 위치 서비스 활성화 확인
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('위치 서비스를 활성화해주세요.');
    }

    // 권한 요청
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('위치 권한이 거부되었습니다.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('위치 권한이 영구적으로 거부되었습니다.');
    }

    // 현재 위치 가져오기
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });

    // 현재 위치로 카메라 이동
    _mapController?.animateCamera(CameraUpdate.newLatLng(_currentPosition!));
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onMarkerTapped() {
    setState(() {
      _showBottomSheet = true;
    });
  }

  void _addPinAtCurrentLocation() {
    if (_currentPosition == null) return;

    final newMarker = Marker(
      markerId: MarkerId("pin_${DateTime.now().millisecondsSinceEpoch}"),
      position: _currentPosition!,
      infoWindow: const InfoWindow(title: "내가 찍은 위치"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    setState(() {
      _customMarkers.add(newMarker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _currentPosition == null
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _currentPosition!,
                      zoom: 15,
                    ),
                    markers: {
                      // 고정 마커
                      Marker(
                        markerId: const MarkerId("place1"),
                        position: _markerPosition,
                        onTap: _onMarkerTapped,
                      ),
                      // 현재 위치 마커
                      Marker(
                        markerId: const MarkerId("currentLocation"),
                        position: _currentPosition!,
                        infoWindow: const InfoWindow(title: "현재 위치"),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueAzure,
                        ),
                      ),
                      // 유저가 찍은 마커들
                      ..._customMarkers,
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
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
                              offset: const Offset(0, -4),
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

      floatingActionButton:
          _currentPosition != null
              ? FloatingActionButton(
                onPressed: _addPinAtCurrentLocation,
                child: const Icon(Icons.add_location_alt),
                tooltip: '현재 위치에 핀 찍기',
              )
              : null,
    );
  }
}

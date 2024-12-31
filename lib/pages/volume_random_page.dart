import 'dart:async';
import 'dart:math';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';

class VolumeRandomPage extends StatefulWidget {
  const VolumeRandomPage({Key? key}) : super(key: key);

  @override
  State<VolumeRandomPage> createState() => _VolumeRandomPageState();
}

class _VolumeRandomPageState extends State<VolumeRandomPage> {
  List<int> _values = List.generate(9, (index) => Random().nextInt(21) - 10);
  List<bool> _isStopped = List.generate(9, (index) => false);
  bool _isRunning = false;
  double _volume = 1.0;
  Timer? _timer;
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    initVolume();
  }

  Future<void> initVolume() async {
    double? curVolume = await FlutterVolumeController.getVolume();
    setState(() {
      _volume = curVolume!;
    });
  }

  Future<void> setDeviceVolume(double value) async {
    setState(() {
      _volume = value.clamp(0.0, 1.0);
    });
    await FlutterVolumeController.setVolume(_volume);
  }

  void startRandom() {
    _timer?.cancel();
    setState(() {
      _isRunning = true;
      _isStopped.fillRange(0, _isStopped.length, false);
    });
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        for (int i = 0; i < _values.length; i++) {
          if (!_isStopped[i]) _values[i] = Random().nextInt(21) - 10;
        }
      });
    });
  }

  void stopRandom() {
    setState(() {
      _isRunning = false;
    });
    _timer?.cancel();
  }

  void onTile(int index) async {
    if (_isRunning && !_isStopped[index]) {
      setState(() {
        _isStopped[index] = true;
        // _volume = (_volume + _values[index]).clamp(0, 100);
      });
      double newVolume = (_volume + _values[index] / 100).clamp(0.0, 1.0);
      await setDeviceVolume(newVolume);
      playEffectSound();
    }
  }

  void playEffectSound() {
    assetsAudioPlayer.open(
      Audio('assets/audios/meow.mp3'),
      autoStart: true,
      volume: _volume,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    assetsAudioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volume Control'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                int row = index ~/ 3;
                int col = index % 3;

                return GestureDetector(
                  onTap: () => onTile(index),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        color: _isStopped[index] ? null : Colors.blue,
                        child: !_isStopped[index]
                            ? Center(
                                child: Text(
                                  _values[index].toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRect(
                                    child: FractionallySizedBox(
                                      widthFactor: 3.0,
                                      heightFactor: 3.0,
                                      alignment: Alignment(
                                        -1.0 + (col * 2 / 2),
                                        -1.0 + (row * 2 / 2),
                                      ),
                                      child: ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.5),
                                            BlendMode.multiply),
                                        child: Image.asset(
                                          'assets/images/고양이.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    _values[index].toString(),
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _isRunning ? null : startRandom,
                      child: Text('Start'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _isRunning ? stopRandom : null,
                      child: Text('Stop'),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  'Volume: ${(100 * _volume).toInt()}%',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '볼륨 조절',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width - 40,
              child: Expanded(
                child: GridView.builder(
                  // padding: EdgeInsets.all(20),
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
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            color: _isStopped[index] ? null : Color(0xFF0E87C8),
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
                                              'assets/images/카고.png',
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
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Volume: ${(100 * _volume).toInt()}%',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: _isRunning ? null : startRandom,
                        child: Container(
                          width: 120,
                          height: 50,
                          decoration: BoxDecoration(
                              color: _isRunning ? Colors.grey : Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                )
                              ]),
                          child: Center(
                            child: Text(
                              '시작',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      // ElevatedButton(
                      //   onPressed: _isRunning ? null : startRandom,
                      //   child: Text('Start'),
                      // ),
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: _isRunning ? stopRandom : null,
                        child: Container(
                          width: 120,
                          height: 50,
                          decoration: BoxDecoration(
                              color: _isRunning ? Colors.white : Colors.grey,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                )
                              ]),
                          child: Center(
                            child: Text(
                              '종료',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      // ElevatedButton(
                      //   onPressed: _isRunning ? stopRandom : null,
                      //   child: Text('Stop'),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

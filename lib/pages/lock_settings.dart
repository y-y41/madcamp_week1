import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LockSettings extends StatefulWidget {
  @override
  _LockSettingsState createState() => _LockSettingsState();
}

class _LockSettingsState extends State<LockSettings> {
  final List<int> _selectedPattern = []; // 설정 중인 패턴
  final Map<int, Offset> _dotPositions = {}; // 각 점의 위치 저장
  final Map<int, bool> _dotStates =
      {}; // 각 점의 상태 (true: 입닫힌 고양이, false: 입벌린 고양이)
  Offset? _currentDragPosition; // 현재 드래그 위치
  ui.Image? _openMouthImage; // 입벌린 고양이 이미지
  ui.Image? _closedMouthImage; // 입닫힌 고양이 이미지
  final Map<int, Timer?> _dotTimers = {}; // 각 점의 타이머
  int? _hoveredDotIndex; // 현재 마우스가 머물러 있는 점의 인덱스

  @override
  void initState() {
    super.initState();
    _loadImages(); // 두 이미지 로드
  }

  Future<void> _loadImages() async {
    final openData = await rootBundle.load('lib/screens/image/입닫은 고양이.png');
    final closedData = await rootBundle.load('lib/screens/image/입벌린 고양이.png');

    final openCodec =
        await ui.instantiateImageCodec(openData.buffer.asUint8List());
    final closedCodec =
        await ui.instantiateImageCodec(closedData.buffer.asUint8List());

    final openFrame = await openCodec.getNextFrame();
    final closedFrame = await closedCodec.getNextFrame();

    setState(() {
      _openMouthImage = openFrame.image;
      _closedMouthImage = closedFrame.image;

      // 모든 점의 초기 상태를 false (입벌린 고양이)로 설정
      for (int i = 0; i < 9; i++) {
        _dotStates[i] = false;
        _dotTimers[i] = null;
      }
    });
  }

  Future<void> _savePattern() async {
    if (_selectedPattern.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('pattern', _selectedPattern.join('-')); // 패턴 저장
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('패턴이 저장되었습니다!')),
      );
    }
  }

  void _onDragStart(DragStartDetails details) {
    _handleTouch(details.localPosition, immediate: true);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _currentDragPosition = details.localPosition;
      _handleTouch(_currentDragPosition!, immediate: true);
    });
  }

  void _resetPattern() {
    setState(() {
      _selectedPattern.clear(); // 선택된 패턴 초기화
      _currentDragPosition = null; // 드래그 위치 초기화
      _hoveredDotIndex = null; // 마우스 상태 초기화

      // 모든 점의 상태를 초기값으로 되돌림
      _dotStates.updateAll((key, value) => false); // 모든 점을 "입벌린 고양이"로 초기화
      _dotTimers.forEach((key, timer) {
        timer?.cancel(); // 모든 타이머 취소
        _dotTimers[key] = null;
      });
    });
  }

  void _onDragEnd(DragEndDetails details) {
    setState(() {
      _currentDragPosition = null;
      _hoveredDotIndex = null;
    });
  }

  void _handleTouch(Offset position, {required bool immediate}) {
    for (int index = 0; index < _dotPositions.length; index++) {
      final dotPosition = _dotPositions[index]!;
      final distance = (position - dotPosition).distance;

      // 연결 조건: 특정 거리 이내에 있어야 하고, 추가 조건 만족
      if (_isConnectable(distance, index)) {
        if (!_selectedPattern.contains(index)) {
          setState(() {
            _selectedPattern.add(index);
            _dotStates[index] = !_dotStates[index]!;
          });
          _stopImageChangeTimer(index); // 연결된 경우 타이머 중지
        }

        _hoveredDotIndex = index;
        return; // 현재 점이 활성화 상태
      }
    }

    // 점에서 떠난 경우
    if (_hoveredDotIndex != null) {
      _startImageChangeTimer(_hoveredDotIndex!); // 떠난 점에 대해 타이머 시작
      _hoveredDotIndex = null;
    }
  }

  bool _isConnectable(double distance, int index) {
    const double connectDistance = 30.0; // 연결 가능한 거리
    final bool isCloseEnough = distance < connectDistance;

    // 연결 조건 추가: 이미 연결된 점은 스킵
    final bool isNotAlreadyConnected = !_selectedPattern.contains(index);

    // 추가 조건: (예시) 사용자가 점에 특정 시간 이상 머물렀을 경우
    // 여기서는 단순히 거리 조건을 강화한 예시
    return isCloseEnough && isNotAlreadyConnected;
  }

  void _startImageChangeTimer(int index) {
    _dotTimers[index]?.cancel(); // 기존 타이머 취소
    _dotTimers[index] =
        Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        _dotStates[index] = !_dotStates[index]!; // 상태를 전환
      });
    });
  }

  void _stopImageChangeTimer(int index) {
    _dotTimers[index]?.cancel(); // 타이머 취소
    _dotTimers[index] = null; // 타이머 해제
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // const SizedBox(height: 90), // 문구와 상단의 간격 추가
            const Text(
              '패턴설정',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            // const SizedBox(height: 20), // 문구와 패턴 사이의 간격
            SizedBox(
              height: MediaQuery.of(context).size.width - 40,
              child: Expanded(
                child: Center(
                  child: GestureDetector(
                    onPanStart: _onDragStart,
                    onPanUpdate: _onDragUpdate,
                    onPanEnd: _onDragEnd,
                    child: CustomPaint(
                      size: const Size(300, 300),
                      painter: _PatternPainter(
                        _dotPositions,
                        _selectedPattern,
                        _currentDragPosition,
                        _openMouthImage,
                        _closedMouthImage,
                        _dotStates,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // const SizedBox(height: 10), // 패턴과 버튼 사이의 간격
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: _resetPattern,
                  child: Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                offset: Offset(0, 2),
                                blurRadius: 4,
                                spreadRadius: 0)
                          ]),
                      child: Center(
                          child: Text(
                        '초기화',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ))),
                ),
                GestureDetector(
                  onTap: _savePattern,
                  child: Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                offset: Offset(0, 2),
                                blurRadius: 4,
                                spreadRadius: 0)
                          ]),
                      child: Center(
                          child: Text(
                        '저장',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ))),
                ),
                // ElevatedButton(
                //   onPressed: _savePattern,
                //   style: ElevatedButton.styleFrom(
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 50, vertical: 15),
                //     textStyle: const TextStyle(
                //         fontSize: 18, fontWeight: FontWeight.bold),
                //   ),
                //   child: const Text('패턴 저장'),
                // ),
              ],
            ),
            const SizedBox(height: 20), // 버튼 아래의 간격
          ],
        ),
      ),
    );
  }
}

class _PatternPainter extends CustomPainter {
  final Map<int, Offset> dotPositions;
  final List<int> selectedPattern;
  final Offset? currentDragPosition;
  final ui.Image? openMouthImage;
  final ui.Image? closedMouthImage;
  final Map<int, bool> dotStates;

  _PatternPainter(
    this.dotPositions,
    this.selectedPattern,
    this.currentDragPosition,
    this.openMouthImage,
    this.closedMouthImage,
    this.dotStates,
  );

  @override
  void paint(Canvas canvas, Size size) {
    if (openMouthImage == null || closedMouthImage == null) return;

    final paint = Paint();
    final linePaint = Paint()
      ..color = Colors.brown
      ..strokeWidth = 6.0
      ..style = PaintingStyle.stroke;

    // 점 위치 직접 설정
    final center = Offset(size.width / 2, size.height / 2);
    final offsetX = 100.0;
    final offsetY = 100.0;

    // 점들의 위치 설정
    dotPositions[4] = center;
    dotPositions[0] = Offset(center.dx - offsetX, center.dy - offsetY);
    dotPositions[1] = Offset(center.dx, center.dy - offsetY);
    dotPositions[2] = Offset(center.dx + offsetX, center.dy - offsetY);
    dotPositions[3] = Offset(center.dx - offsetX, center.dy);
    dotPositions[5] = Offset(center.dx + offsetX, center.dy);
    dotPositions[6] = Offset(center.dx - offsetX, center.dy + offsetY);
    dotPositions[7] = Offset(center.dx, center.dy + offsetY);
    dotPositions[8] = Offset(center.dx + offsetX, center.dy + offsetY);

    // 점 그리기

    // 선택된 패턴 연결선 그리기
    for (int i = 0; i < selectedPattern.length - 1; i++) {
      final start = dotPositions[selectedPattern[i]]!;
      final end = dotPositions[selectedPattern[i + 1]]!;
      canvas.drawLine(start, end, linePaint);
    }

    // 현재 드래그 위치에서 마지막 선택된 점까지 선 연결
    if (currentDragPosition != null && selectedPattern.isNotEmpty) {
      final lastDot = dotPositions[selectedPattern.last]!;
      canvas.drawLine(lastDot, currentDragPosition!, linePaint);
    }
    dotPositions.forEach((index, offset) {
      final rect = Rect.fromCenter(center: offset, width: 133, height: 133);
      final image = dotStates[index]! ? closedMouthImage : openMouthImage;
      canvas.drawImageRect(
        image!,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        rect,
        paint,
      );
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

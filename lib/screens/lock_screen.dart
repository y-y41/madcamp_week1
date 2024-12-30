import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LockScreen extends StatefulWidget {
  final VoidCallback onUnlock;

  const LockScreen({required this.onUnlock, Key? key}) : super(key: key);

  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final List<int> _selectedPattern = [];
  final Map<int, Offset> _dotPositions = {};
  final Map<int, bool> _dotStates = {};
  Offset? _currentDragPosition;
  ui.Image? _openMouthImage;
  ui.Image? _closedMouthImage;
  List<int>? _savedPattern;
  final Map<int, Timer?> _dotTimers = {};
  int? _hoveredDotIndex;

  @override
  void initState() {
    super.initState();
    _loadImages();
    _loadSavedPattern();
  }

  Future<void> _loadImages() async {
    final openData = await rootBundle.load('lib/screens/image/입닫은 고양이.png');
    final closedData = await rootBundle.load('lib/screens/image/입벌린 고양이.png');

    final openCodec = await ui.instantiateImageCodec(openData.buffer.asUint8List());
    final closedCodec = await ui.instantiateImageCodec(closedData.buffer.asUint8List());

    final openFrame = await openCodec.getNextFrame();
    final closedFrame = await closedCodec.getNextFrame();

    setState(() {
      _openMouthImage = openFrame.image;
      _closedMouthImage = closedFrame.image;

      for (int i = 0; i < 9; i++) {
        _dotStates[i] = false;
        _dotTimers[i] = null;
      }
    });
  }

  Future<void> _loadSavedPattern() async {
    final prefs = await SharedPreferences.getInstance();
    final pattern = prefs.getString('pattern');
    setState(() {
      _savedPattern = pattern?.split('-').map(int.parse).toList();
    });
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

  void _onDragEnd(DragEndDetails details) {
    setState(() {
      _currentDragPosition = null;
      _hoveredDotIndex = null;
    });
    _checkPattern();
  }

  void _handleTouch(Offset position, {required bool immediate}) {
    for (int index = 0; index < _dotPositions.length; index++) {
      final dotPosition = _dotPositions[index]!;
      final distance = (position - dotPosition).distance;

      if (_isConnectable(distance, index)) {
        if (!_selectedPattern.contains(index)) {
          setState(() {
            _selectedPattern.add(index);
            _dotStates[index] = !_dotStates[index]!;
          });
          _stopImageChangeTimer(index);
        }

        _hoveredDotIndex = index;
        return;
      }
    }

    if (_hoveredDotIndex != null) {
      _startImageChangeTimer(_hoveredDotIndex!);
      _hoveredDotIndex = null;
    }
  }

  bool _isConnectable(double distance, int index) {
    const double connectDistance = 30.0;
    return distance < connectDistance && !_selectedPattern.contains(index);
  }

  void _startImageChangeTimer(int index) {
    _dotTimers[index]?.cancel();
    _dotTimers[index] = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        _dotStates[index] = !_dotStates[index]!;
      });
    });
  }

  void _stopImageChangeTimer(int index) {
    _dotTimers[index]?.cancel();
    _dotTimers[index] = null;
  }

  void _checkPattern() {
    if (_selectedPattern.toString() == _savedPattern?.toString()) {
      widget.onUnlock();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('패턴이 틀렸습니다. 다시 시도해주세요.')),
      );
      _resetPattern();
    }
  }

  void _resetPattern() {
    setState(() {
      _selectedPattern.clear();
      _currentDragPosition = null;
      _hoveredDotIndex = null;
      _dotStates.updateAll((key, value) => false);
      _dotTimers.forEach((key, timer) {
        timer?.cancel();
        _dotTimers[key] = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('잠금 화면'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 90),
          const Text(
            '패턴을 입력하세요',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
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
        ],
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

    final center = Offset(size.width / 2, size.height / 2);
    final offsetX = 100.0;
    final offsetY = 100.0;

    dotPositions[4] = center;
    dotPositions[0] = Offset(center.dx - offsetX, center.dy - offsetY);
    dotPositions[1] = Offset(center.dx, center.dy - offsetY);
    dotPositions[2] = Offset(center.dx + offsetX, center.dy - offsetY);
    dotPositions[3] = Offset(center.dx - offsetX, center.dy);
    dotPositions[5] = Offset(center.dx + offsetX, center.dy);
    dotPositions[6] = Offset(center.dx - offsetX, center.dy + offsetY);
    dotPositions[7] = Offset(center.dx, center.dy + offsetY);
    dotPositions[8] = Offset(center.dx + offsetX, center.dy + offsetY);

    for (int i = 0; i < selectedPattern.length - 1; i++) {
      final start = dotPositions[selectedPattern[i]]!;
      final end = dotPositions[selectedPattern[i + 1]]!;
      canvas.drawLine(start, end, linePaint);
    }

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

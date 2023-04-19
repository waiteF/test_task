import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/// Main class
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello there',
      home: HelloThere(),
    );
  }
}

/// A widget that displays a greeting message with changing
/// background and text colors.
class HelloThere extends StatefulWidget {
  @override
  _HelloThereState createState() => _HelloThereState();
}

class _HelloThereState extends State<HelloThere> {
  static const _defaultBackgroundColor = Colors.white;
  static const _defaultTextColor = Colors.black;
  static const _maxColorValue = 0xFFFFFF;

  Color _backgroundColor = _defaultBackgroundColor;
  Color _textColor = _defaultTextColor;
  int _count = 0;
  bool _autoColorChange = false;
  Timer? _timer;

  /// Changes the background color to a random color.
  void _changeBackgroundColor() {
    setState(() {
      _backgroundColor =
          Color(Random().nextInt(_maxColorValue)).withOpacity(1.0);
    });
  }

  /// Changes the text color to a random color.
  void _changeTextColor() {
    setState(() {
      _textColor = Color(Random().nextInt(_maxColorValue)).withOpacity(1.0);
    });
  }

  /// Toggles the auto color change mode.
  void _toggleAutoColorChange() {
    setState(() {
      _autoColorChange = !_autoColorChange;
    });

    if (_autoColorChange) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        _changeBackgroundColor();
        _changeTextColor();
        _count++;
      });
    } else {
      _timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _changeBackgroundColor();
        _changeTextColor();
        setState(() {
          _count++;
        });
      },
      child: Scaffold(
        backgroundColor: _backgroundColor,
        body: Stack(
          children: [
            Center(
              child: Text(
                'Hello there',
                style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold,
                    color: _textColor,),
              ),
            ),
            Positioned(
              top: 32,
              right: 16,
              child: Text(
                'Count: $_count',
                style: const TextStyle(fontSize: 16.0, fontWeight:
                  FontWeight.bold, color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 56,
              right: 16,
              child: ElevatedButton(
                onPressed: _toggleAutoColorChange,
                child: Text(_autoColorChange ? 'Stop' : 'Auto'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

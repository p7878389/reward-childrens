import 'dart:math' as math;
import 'package:flutter/material.dart';

/// 语音输入时的全屏波浪动画覆盖层
class VoiceWaveOverlay extends StatefulWidget {
  final bool isCanceling;
  final String currentText;

  const VoiceWaveOverlay({super.key, required this.isCanceling, required this.currentText});

  @override
  State<VoiceWaveOverlay> createState() => _VoiceWaveOverlayState();
}

class _VoiceWaveOverlayState extends State<VoiceWaveOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.7),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return RepaintBoundary(
                child: CustomPaint(
                  size: const Size(double.infinity, 300),
                  painter: _WavePainter(
                    animationValue: _controller.value,
                    isCanceling: widget.isCanceling,
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 200,
            left: 20,
            right: 20,
            child: Column(
              children: [
                if (widget.currentText.isNotEmpty && !widget.isCanceling)
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      widget.currentText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                Icon(
                  widget.isCanceling ? Icons.cancel_outlined : Icons.keyboard_voice_outlined,
                  size: 48,
                  color: widget.isCanceling ? Colors.redAccent : Colors.white,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: widget.isCanceling ? Colors.redAccent : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  child: Text(
                    widget.isCanceling ? "松开手指 取消发送" : "松开手指 发送成语\n上划取消",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  final double animationValue;
  final bool isCanceling;

  _WavePainter({required this.animationValue, required this.isCanceling});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final midY = height / 2;

    final colors = isCanceling
        ? [const Color(0xFFFF5252), const Color(0xFFFF1744), const Color(0xFFD50000)]
        : [const Color(0xFF4285F4), const Color(0xFFEA4335), const Color(0xFFFBBC05), const Color(0xFF34A853)];

    for (int i = 0; i < colors.length; i++) {
      final color = colors[i];
      final waveSpeed = 1.0 + i * 0.5;
      final waveFrequency = 2.0 + i * 0.5;
      final phase = animationValue * 2 * math.pi * waveSpeed;
      final breathing = 0.5 + 0.5 * math.sin(animationValue * 2 * math.pi * 0.5 + i);
      final maxAmplitude = (isCanceling ? 30.0 : 50.0) + (i * 10.0);

      final paint = Paint()
        ..color = color.withValues(alpha: isCanceling ? 0.8 : 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = isCanceling ? 2.0 : 4.0
        ..strokeCap = StrokeCap.round;

      final path = Path();
      path.moveTo(0, midY);

      for (double x = 0; x <= width; x += 5) {
        final normalizeX = x / width;
        final envelope = math.sin(normalizeX * math.pi);
        final sine = math.sin((normalizeX * waveFrequency * math.pi * 2) + phase);
        final jitter = isCanceling ? (math.Random().nextDouble() - 0.5) * 15 * envelope : 0.0;
        final y = midY + sine * maxAmplitude * breathing * envelope + jitter;
        path.lineTo(x, y);
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_WavePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue || oldDelegate.isCanceling != isCanceling;
  }
}

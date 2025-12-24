import 'dart:math';
import 'package:flutter/material.dart';

class ComboOverlay extends StatefulWidget {
  const ComboOverlay({super.key});

  @override
  State<ComboOverlay> createState() => ComboOverlayState();
}

class ComboOverlayState extends State<ComboOverlay> with TickerProviderStateMixin {
  final List<_FlyingItem> _items = [];

  void showCombo(int count) {
    _addItem(_ComboItem(count));
  }

  void showSpeedBonus() {
    _addItem(_SpeedItem());
  }

  void showAiSurrender() {
    _addItem(_TextItem("AI 认输了!", Colors.purple));
  }

  void _addItem(_FlyingItem item) {
    setState(() {
      _items.add(item);
    });
    
    // Auto remove after animation
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _items.remove(item);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        alignment: Alignment.center,
        children: _items.map((item) => _FlyingWidget(key: ObjectKey(item), item: item)).toList(),
      ),
    );
  }
}

abstract class _FlyingItem {
  final String id = UniqueKey().toString();
}

class _ComboItem extends _FlyingItem {
  final int count;
  _ComboItem(this.count);
}

class _SpeedItem extends _FlyingItem {}

class _TextItem extends _FlyingItem {
  final String text;
  final Color color;
  _TextItem(this.text, this.color);
}

class _FlyingWidget extends StatefulWidget {
  final _FlyingItem item;

  const _FlyingWidget({super.key, required this.item});

  @override
  State<_FlyingWidget> createState() => _FlyingWidgetState();
}

class _FlyingWidgetState extends State<_FlyingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.5).chain(CurveTween(curve: Curves.elasticOut)), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.5, end: 1.0), weight: 80),
    ]).animate(_controller);

    _opacity = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 70),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 30),
    ]).animate(_controller);

    _slide = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -1.0), // Move up slightly
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    
    if (widget.item is _ComboItem) {
      final count = (widget.item as _ComboItem).count;
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "COMBO",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Color(0xFFFFB020),
              letterSpacing: 2,
              shadows: [Shadow(color: Colors.black26, offset: Offset(2, 2), blurRadius: 4)],
            ),
          ),
          Text(
            "x$count",
            style: const TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w900,
              color: Color(0xFFFFB020),
              height: 1.0,
              shadows: [Shadow(color: Colors.black26, offset: Offset(4, 4), blurRadius: 8)],
            ),
          ),
        ],
      );
    } else if (widget.item is _SpeedItem) {
      content = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [BoxShadow(color: Colors.orangeAccent, blurRadius: 20, spreadRadius: 2)],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.flash_on_rounded, color: Colors.white, size: 32),
            SizedBox(width: 8),
            Text(
              "闪电回答!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white),
            ),
          ],
        ),
      );
    } else if (widget.item is _TextItem) {
      final item = widget.item as _TextItem;
      content = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(color: item.color.withValues(alpha: 0.5), blurRadius: 20, spreadRadius: 2)],
        ),
        child: Text(
          item.text,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white),
        ),
      );
    } else {
      content = const SizedBox();
    }

    // Add random rotation for more dynamic feel
    final randomAngle = (Random().nextDouble() - 0.5) * 0.2;

    return SlideTransition(
      position: _slide,
      child: FadeTransition(
        opacity: _opacity,
        child: ScaleTransition(
          scale: _scale,
          child: Transform.rotate(
            angle: randomAngle,
            child: content,
          ),
        ),
      ),
    );
  }
}

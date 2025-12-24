import 'dart:async';
import 'package:children_rewards/features/idiom_game/domain/entities/idiom_game_entities.dart';
import 'package:flutter/material.dart';

class IdiomDetailDialog extends StatelessWidget {
  final Idiom idiom;
  final Color accentColor;
  final bool autoClose;
  final int autoCloseSeconds;
  final String? badgeText;

  const IdiomDetailDialog({
    super.key,
    required this.idiom,
    this.accentColor = Colors.amber,
    this.autoClose = false,
    this.autoCloseSeconds = 5,
    this.badgeText,
  });

  static Future<void> show(
    BuildContext context, {
    required Idiom idiom,
    Color accentColor = Colors.amber,
    bool autoClose = false,
    String? badgeText,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: !autoClose,
      builder: (context) => IdiomDetailDialog(
        idiom: idiom,
        accentColor: accentColor,
        autoClose: autoClose,
        badgeText: badgeText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer? closeTimer;
    int remaining = autoCloseSeconds;

    return StatefulBuilder(
      builder: (context, setState) {
        if (autoClose && closeTimer == null) {
          closeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
            if (remaining > 0) {
              if (context.mounted) {
                setState(() => remaining--);
              }
            } else {
              timer.cancel();
              // Removed auto-close pop logic
            }
          });
        }

        bool isTimerFinished = !autoClose || remaining <= 0;

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          backgroundColor: Colors.white,
          elevation: 24,
          child: Container(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Badge & Timer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (badgeText != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: accentColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.auto_awesome, size: 14, color: accentColor),
                            const SizedBox(width: 4),
                            Text(
                              badgeText!,
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: accentColor),
                            ),
                          ],
                        ),
                      )
                    else
                      const SizedBox(),
                    
                    if (autoClose && remaining > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "${remaining}s",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[600], fontFamily: 'Monospace'),
                        ),
                      )
                    else if (isTimerFinished)
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close_rounded),
                        color: Colors.grey[400],
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                
                Text(
                  idiom.word,
                  style: const TextStyle(
                    fontSize: 36, 
                    fontWeight: FontWeight.w900, 
                    color: Colors.black87,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  idiom.pinyin,
                  style: TextStyle(fontSize: 18, color: Colors.grey[500], fontStyle: FontStyle.italic, letterSpacing: 1),
                ),
                const SizedBox(height: 28),
                
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(color: accentColor, shape: BoxShape.circle),
                            child: const Icon(Icons.menu_book_rounded, size: 12, color: Colors.white),
                          ),
                          const SizedBox(width: 10),
                          Text("成语释义", style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey[800], fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        idiom.explanation ?? '暂无释义',
                        style: TextStyle(fontSize: 16, color: Colors.grey[800], height: 1.6, fontWeight: FontWeight.w500),
                      ),
                      if (idiom.source != null && idiom.source!.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        const Divider(height: 1),
                        const SizedBox(height: 16),
                        Text(
                          "出处",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[500]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          idiom.source!,
                          style: TextStyle(fontSize: 13, color: Colors.grey[600], fontStyle: FontStyle.italic),
                        ),
                      ],
                    ],
                  ),
                ),
                
                if (autoClose && remaining > 0) ...[
                  const SizedBox(height: 24),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: remaining / autoCloseSeconds.toDouble(),
                      backgroundColor: Colors.grey[100],
                      valueColor: AlwaysStoppedAnimation(accentColor.withValues(alpha: 0.5)),
                      minHeight: 4,
                    ),
                  ),
                ],
                
                if (isTimerFinished) ...[
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text("我知道了", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}

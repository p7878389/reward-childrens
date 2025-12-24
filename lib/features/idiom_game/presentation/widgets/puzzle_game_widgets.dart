import 'package:flutter/material.dart';

// ---------------- Colors & Dimens ----------------
// Mimicking existing app style
const kPrimaryColor = Color(0xFFFFC107); // Amber/Yellow
const kBackgroundColor = Color(0xFFF7F6F2); // Warm cream
const kCorrectColor = Color(0xFF4CAF50);
const kWrongColor = Color(0xFFF44336);

// ---------------- Game Header ----------------

class GameHeaderBar extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;
  final int currentStars;
  final int timeLeft;
  final VoidCallback? onExit;

  const GameHeaderBar({
    super.key,
    required this.currentQuestion,
    required this.totalQuestions,
    required this.currentStars,
    required this.timeLeft,
    this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: onExit,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded, color: kPrimaryColor),
                    const SizedBox(width: 4),
                    Text(
                      '$currentStars',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress & Timer
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: totalQuestions > 0 ? (currentQuestion + 1) / totalQuestions : 0,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation(kPrimaryColor),
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.timer_outlined, size: 20, color: timeLeft < 10 ? kWrongColor : Colors.grey),
              const SizedBox(width: 4),
              Text(
                '00:${timeLeft.toString().padLeft(2, '0')}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: timeLeft < 10 ? kWrongColor : Colors.grey[700],
                  fontFamily: 'Monospace'
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '第 ${currentQuestion + 1}/$totalQuestions 题',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// ---------------- Idiom Char Box ----------------

class IdiomCharBox extends StatelessWidget {
  final String char;
  final bool isHidden;
  final bool isFilled; // 是否已被填入
  final bool isHighlighted; // 当前焦点
  final Color? textColor; // 覆盖颜色
  final VoidCallback? onTap;

  const IdiomCharBox({
    super.key,
    required this.char,
    required this.isHidden,
    this.isFilled = false,
    this.isHighlighted = false,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Show char if: NOT hidden, OR (hidden AND filled)
    
    return GestureDetector(
      onTap: isHidden ? onTap : null, // Only hidden boxes are interactive
      child: Container(
        width: 64,
        height: 64,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isHighlighted ? kPrimaryColor : Colors.grey[300]!,
            width: isHighlighted ? 3 : 1,
          ),
          boxShadow: [
             BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ]
        ),
        child: Center(
          child: isHidden && !isFilled
              ? Container(width: 32, height: 2, color: kPrimaryColor) // Empty slot indicator
              : Text(
                  char,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: textColor ?? (isHidden ? kPrimaryColor : Colors.black87), // Filled text is colored
                  ),
                ),
        ),
      ),
    );
  }
}

// ---------------- Word Bank Grid ----------------

class WordBankGrid extends StatelessWidget {
  final List<String> words;
  final Function(String, int) onWordSelected;
  final Set<int> usedIndices; // 已使用的索引

  const WordBankGrid({
    super.key,
    required this.words,
    required this.onWordSelected,
    this.usedIndices = const {},
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemCount: words.length,
      itemBuilder: (context, index) {
        final word = words[index];
        final isUsed = usedIndices.contains(index);

        return InkWell(
          onTap: isUsed ? null : () => onWordSelected(word, index),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: isUsed ? Colors.grey[200] : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
              boxShadow: isUsed ? [] : [
                 BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                )
              ]
            ),
            child: Center(
              child: Text(
                word,
                style: TextStyle(
                  fontSize: 24,
                  color: isUsed ? Colors.grey[400] : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ---------------- Option Button (For Meaning Mode) ----------------

class OptionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isCorrect; // Only relevant if showResult is true
  final bool showResult;
  final VoidCallback onTap;

  const OptionButton({
    super.key,
    required this.text,
    required this.isSelected,
    this.isCorrect = false,
    this.showResult = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.white;
    Color textColor = Colors.black87;
    Color borderColor = Colors.grey[200]!;

    if (showResult) {
      if (isCorrect) {
        bgColor = kCorrectColor.withValues(alpha: 0.1);
        borderColor = kCorrectColor;
        textColor = kCorrectColor;
      } else if (isSelected && !isCorrect) {
        bgColor = kWrongColor.withValues(alpha: 0.1);
        borderColor = kWrongColor;
        textColor = kWrongColor;
      }
    } else if (isSelected) {
      bgColor = kPrimaryColor.withValues(alpha: 0.1);
      borderColor = kPrimaryColor;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: showResult ? null : onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              if (showResult && isCorrect)
                const Icon(Icons.check_circle, color: kCorrectColor),
              if (showResult && isSelected && !isCorrect)
                const Icon(Icons.cancel, color: kWrongColor),
            ],
          ),
        ),
      ),
    );
  }
}

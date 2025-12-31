import 'package:flutter/material.dart';
import 'package:children_rewards/features/idiom_game/domain/entities/idiom_puzzle_entities.dart';

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
  final String? pinyin; // Add pinyin
  final bool isHidden;
  final bool isFilled; 
  final bool isHighlighted;
  final Color? textColor; 
  final VoidCallback? onTap;

  const IdiomCharBox({
    super.key,
    required this.char,
    this.pinyin,
    required this.isHidden,
    this.isFilled = false,
    this.isHighlighted = false,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isHidden ? onTap : null, 
      child: Container(
        width: 64,
        height: 84, // Increased height for pinyin
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pinyin
            if (!isHidden || isFilled)
              Text(
                pinyin ?? '', 
                style: TextStyle(
                  fontSize: 14, 
                  fontWeight: FontWeight.w900, // Bold
                  color: textColor ?? (isHidden ? kPrimaryColor : Colors.grey[600]),
                  letterSpacing: 1,
                ),
              )
            else
              const SizedBox(height: 18), // Spacer for hidden

            const SizedBox(height: 2),

            // Character
            isHidden && !isFilled
                ? Container(width: 32, height: 2, color: kPrimaryColor, margin: const EdgeInsets.only(top: 10)) 
                : Text(
                    char,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: textColor ?? (isHidden ? kPrimaryColor : Colors.black87), 
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

// ---------------- Word Bank Grid ----------------

class WordBankGrid extends StatelessWidget {
  final List<WordBankOption> words;
  final Function(String, int) onWordSelected;
  final Set<int> usedIndices; 

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
        childAspectRatio: 0.75, // Adjusted for pinyin
      ),
      itemCount: words.length,
      itemBuilder: (context, index) {
        final option = words[index];
        final isUsed = usedIndices.contains(index);

        return InkWell(
          onTap: isUsed ? null : () => onWordSelected(option.char, index),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  option.pinyin,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: isUsed ? Colors.grey[300] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  option.char,
                  style: TextStyle(
                    fontSize: 24,
                    color: isUsed ? Colors.grey[400] : Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
  final String? pinyin; // Add pinyin
  final bool isSelected;
  final bool isCorrect; 
  final bool showResult;
  final VoidCallback onTap;

  const OptionButton({
    super.key,
    required this.text,
    this.pinyin,
    required this.isSelected,
    this.isCorrect = false,
    this.showResult = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.white;
    Color borderColor = Colors.grey[200]!;
    // Base text colors
    Color charColor = Colors.black87;
    Color pinyinColor = Colors.grey[600]!;

    if (showResult) {
      if (isCorrect) {
        bgColor = kCorrectColor.withValues(alpha: 0.1);
        borderColor = kCorrectColor;
        charColor = kCorrectColor;
        pinyinColor = kCorrectColor.withValues(alpha: 0.8);
      } else if (isSelected && !isCorrect) {
        bgColor = kWrongColor.withValues(alpha: 0.1);
        borderColor = kWrongColor;
        charColor = kWrongColor;
        pinyinColor = kWrongColor.withValues(alpha: 0.8);
      }
    } else if (isSelected) {
      bgColor = kPrimaryColor.withValues(alpha: 0.1);
      borderColor = kPrimaryColor;
    }

    // Split text and pinyin for alignment
    final chars = text.characters.toList();
    List<String> pinyins = [];
    if (pinyin != null) {
      // Assuming pinyin is space-separated. If not, this logic might need adjustment based on data format.
      // Current data format seems to be space separated pinyin string.
      pinyins = pinyin!.split(' ');
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: showResult ? null : onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Row(
            children: [
              Expanded(
                child: Wrap( // Use Wrap to handle long idioms gracefully
                  spacing: 8.0, // Space between char blocks
                  runSpacing: 4.0,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: List.generate(chars.length, (index) {
                    final char = chars[index];
                    final py = (index < pinyins.length) ? pinyins[index] : '';
                    
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (py.isNotEmpty)
                          Text(
                            py,
                            style: TextStyle(
                              fontSize: 12, // Pinyin size
                              fontWeight: FontWeight.w700,
                              color: pinyinColor,
                            ),
                          ),
                        if (py.isNotEmpty) const SizedBox(height: 2),
                        Text(
                          char,
                          style: TextStyle(
                            fontSize: 22, // Char size
                            fontWeight: FontWeight.bold,
                            color: charColor,
                          ),
                        ),
                      ],
                    );
                  }),
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

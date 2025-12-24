import 'package:flutter/material.dart';
import 'package:children_rewards/features/idiom_game/presentation/screens/completion_game_screen.dart';

// Reuse constants
const kPrimaryColor = Color(0xFFFFC107);
const kBackgroundColor = Color(0xFFF7F6F2);

class PuzzleModeSelectionScreen extends StatelessWidget {
  final int childId;
  const PuzzleModeSelectionScreen({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('成语挑战'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black87,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildModeCard(
            context,
            title: '成语补全',
            subtitle: '填字补全成语，考验词汇量',
            icon: Icons.edit_note_rounded,
            color: Colors.blueAccent,
            onTap: () {
              // Navigate
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (_) => CompletionGameScreen(
                    grade: 1, // TODO: Pass from Settings or Selector
                    childId: childId,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          _buildModeCard(
            context,
            title: '看意思猜成语',
            subtitle: '根据释义选出正确答案',
            icon: Icons.psychology_rounded,
            color: Colors.orangeAccent,
            onTap: () {
              // TODO: Navigate to MeaningGameScreen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('敬请期待 Phase 2')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildModeCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: color),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}

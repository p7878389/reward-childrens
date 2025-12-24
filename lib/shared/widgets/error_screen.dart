import 'package:flutter/material.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/theme/app_dimens.dart';
import 'package:children_rewards/l10n/app_localizations.dart';

class ErrorScreen extends StatefulWidget {
  final String title;
  final String message;
  final String? stackTrace;
  final VoidCallback? onRetry;
  final bool showBackButton;

  const ErrorScreen({
    super.key,
    required this.title,
    required this.message,
    this.stackTrace,
    this.onRetry,
    this.showBackButton = true,
  });

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: widget.showBackButton 
          ? AppBar(
              backgroundColor: Colors.transparent, 
              elevation: 0,
              iconTheme: const IconThemeData(color: AppColors.textMain),
            ) 
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.paddingL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                size: 80,
                color: Color(0xFFEF4444),
              ),
              const SizedBox(height: AppDimens.paddingL),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMain,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimens.paddingM),
              Text(
                widget.message,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimens.paddingXL),
              if (widget.onRetry != null)
                ElevatedButton.icon(
                  onPressed: widget.onRetry,
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(l10n?.retry ?? 'Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textMain,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimens.radiusM),
                    ),
                  ),
                ),
                
              if (widget.stackTrace != null) ...[
                const SizedBox(height: AppDimens.paddingXL),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  icon: Icon(
                    _isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                    size: 20,
                  ),
                  label: Text(l10n?.errorDetails ?? 'Error Details'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                  ),
                ),
                if (_isExpanded)
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: AppDimens.paddingM),
                      padding: const EdgeInsets.all(AppDimens.paddingM),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(AppDimens.radiusM),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          widget.stackTrace!,
                          style: const TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
              ] else 
                const Spacer(), // Push content to center if no details
            ],
          ),
        ),
      ),
    );
  }
}

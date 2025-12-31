import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:children_rewards/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:children_rewards/core/theme/app_colors.dart';
import 'package:children_rewards/core/services/logger_service.dart';
import 'package:children_rewards/shared/widgets/common_widgets.dart';
import 'package:children_rewards/features/children/providers/children_providers.dart';
import 'package:children_rewards/features/children/domain/usecases/create_child_usecase.dart';
import 'package:children_rewards/shared/utils/form_validator.dart';
import 'package:children_rewards/shared/widgets/custom_input_field.dart';

class AddChildScreen extends ConsumerStatefulWidget {
  const AddChildScreen({super.key});

  @override
  ConsumerState<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends ConsumerState<AddChildScreen> {
  final _nameController = TextEditingController();
  final _nameFocusNode = FocusNode();
  String _gender = 'boy';
  DateTime? _birthday;
  String _avatarData = 'builtin:0';
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(title: l10n.addProfile),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  const SizedBox(height: 16),
                  FormLabel(text: l10n.avatar),
                  const SizedBox(height: 8),
                  AvatarPicker(
                    initialAvatar: _avatarData,
                    onAvatarChanged: (val) => setState(() => _avatarData = val),
                    hintText: l10n.tapPhoto,
                  ),
                  const SizedBox(height: 24),

                  FormLabel(text: l10n.childName),
                  const SizedBox(height: 8),
                  CustomInputField(
                    controller: _nameController,
                    focusNode: _nameFocusNode,
                    icon: Icons.person_rounded,
                    hintText: l10n.childName,
                    onChanged: (v) => setState(() {}),
                  ),
                  const SizedBox(height: 20),

                  FormLabel(text: l10n.gender),
                  const SizedBox(height: 8),
                  GenderSelector(
                    value: _gender,
                    onChanged: (val) => setState(() => _gender = val),
                    boyLabel: l10n.boy,
                    girlLabel: l10n.girl,
                  ),
                  const SizedBox(height: 20),

                  FormLabel(text: l10n.birthdayOptional),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      // 彻底移除焦点并关闭键盘
                      _nameFocusNode.unfocus();
                      FocusManager.instance.primaryFocus?.unfocus();
                      
                      _showScrollableDatePicker(
                        context,
                        initialDate: _birthday,
                        onDateSelected: (date) {
                          setState(() => _birthday = date);
                        },
                        l10n: l10n,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.cake_rounded, color: AppColors.textSecondary, size: 20),
                          const SizedBox(width: 12),
                          Text(
                            _birthday == null ? l10n.selectDate : DateFormat('yyyy-MM-dd').format(_birthday!),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _birthday == null ? AppColors.textSecondary.withValues(alpha: 0.5) : AppColors.textMain,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _nameController.text.isEmpty || _isSubmitting ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                        elevation: 2,
                        shadowColor: AppColors.primary.withValues(alpha: 0.3),
                      ),
                      child: _isSubmitting
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(l10n.createProfile, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return;

    final name = _nameController.text.trim();

    // 客户端验证
    if (name.isEmpty) {
      FormValidator.showError(context, l10n.nameRequired);
      return;
    }

    // 名称长度验证
    if (name.length > 20) {
      FormValidator.showError(context, l10n.nameTooLong);
      return;
    }

    // 防止重复提交
    if (_isSubmitting) return;
    setState(() => _isSubmitting = true);

    try {
      final result = await ref.read(createChildUseCaseProvider).execute(
        CreateChildParams(
          name: name,
          gender: _gender,
          birthday: _birthday?.toIso8601String(),
          avatar: _avatarData,
        ),
      );

      if (!mounted) return;

      result.when(
        success: (_) async {
          await AppDialogs.showSuccess(context, l10n.addSuccess);
          if (mounted) Navigator.pop(context);
        },
        failure: (message, _, stackTrace) {
          logError('创建宝贝失败', tag: 'AddChildScreen', error: message, stackTrace: stackTrace);
          FormValidator.showError(context, l10n.operationFailed);
        },
      );
    } catch (e, stackTrace) {
      logError('创建宝贝失败', tag: 'AddChildScreen', error: e, stackTrace: stackTrace);
      if (mounted) {
        FormValidator.showError(context, l10n.operationFailed);
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  void _showScrollableDatePicker(
    BuildContext context, {
    required DateTime? initialDate,
    required ValueChanged<DateTime> onDateSelected,
    required AppLocalizations l10n,
  }) {
    DateTime selectedDate = initialDate ?? DateTime(DateTime.now().year - 5, 1, 1);
    const minYear = 2000;
    final maxYear = DateTime.now().year;

    int daysInMonth(int year, int month) {
      return DateTime(year, month + 1, 0).day;
    }

    final yearController = FixedExtentScrollController(initialItem: selectedDate.year - minYear);
    final monthController = FixedExtentScrollController(initialItem: selectedDate.month - 1);
    final dayController = FixedExtentScrollController(initialItem: selectedDate.day - 1);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SizedBox(
              height: 280,
              child: Column(
                children: [
                  // Toolbar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.05),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Text(l10n.cancel, style: const TextStyle(color: AppColors.textSecondary, fontSize: 16)),
                          onPressed: () => Navigator.pop(context),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Text(l10n.confirm, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16)),
                          onPressed: () {
                            onDateSelected(selectedDate);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  // Custom Picker
                  Expanded(
                    child: Row(
                      children: [
                        // Year
                        Expanded(
                          child: CupertinoPicker(
                            scrollController: yearController,
                            itemExtent: 44,
                            onSelectedItemChanged: (index) {
                              final newYear = minYear + index;
                              final maxDays = daysInMonth(newYear, selectedDate.month);
                              int newDay = selectedDate.day;
                              if (newDay > maxDays) {
                                newDay = maxDays;
                                dayController.jumpToItem(newDay - 1);
                              }
                              setModalState(() {
                                selectedDate = DateTime(newYear, selectedDate.month, newDay);
                              });
                            },
                            children: List.generate(maxYear - minYear + 1, (index) {
                              return Center(child: Text('${minYear + index}', style: const TextStyle(fontSize: 20, color: AppColors.textMain)));
                            }),
                          ),
                        ),
                        // Month
                        Expanded(
                          child: CupertinoPicker(
                            scrollController: monthController,
                            itemExtent: 44,
                            looping: true,
                            onSelectedItemChanged: (index) {
                              final newMonth = index + 1;
                              final maxDays = daysInMonth(selectedDate.year, newMonth);
                              int newDay = selectedDate.day;
                              if (newDay > maxDays) {
                                newDay = maxDays;
                                dayController.jumpToItem(newDay - 1);
                              }
                              setModalState(() {
                                selectedDate = DateTime(selectedDate.year, newMonth, newDay);
                              });
                            },
                            children: List.generate(12, (index) {
                              return Center(child: Text('${index + 1}', style: const TextStyle(fontSize: 20, color: AppColors.textMain)));
                            }),
                          ),
                        ),
                        // Day
                        Expanded(
                          child: CupertinoPicker.builder(
                            key: ValueKey('days-${selectedDate.year}-${selectedDate.month}'),
                            scrollController: dayController,
                            itemExtent: 44,
                            onSelectedItemChanged: (index) {
                              setModalState(() {
                                selectedDate = DateTime(selectedDate.year, selectedDate.month, index + 1);
                              });
                            },
                            itemBuilder: (context, index) {
                              final maxDays = daysInMonth(selectedDate.year, selectedDate.month);
                              if (index < 0 || index >= maxDays) return null;
                              return Center(child: Text('${index + 1}', style: const TextStyle(fontSize: 20, color: AppColors.textMain)));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      yearController.dispose();
      monthController.dispose();
      dayController.dispose();
    });
  }
}
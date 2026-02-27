import 'package:flutter/material.dart';

import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';

// =============================================================================
// Task 6.2 Step 12: Handle delete with confirmation dialog
// =============================================================================

/// Confirmation dialog for delete, logout, etc.
class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isDestructive;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.isDestructive = false,
  });

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        isDestructive: isDestructive,
        onConfirm: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        Expanded(
          child: SecondaryButton(
            text: cancelText,
            onPressed: onCancel ?? () => Navigator.of(context).pop(false),
            height: 44,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: PrimaryButton(
            text: confirmText,
            onPressed: onConfirm ?? () => Navigator.of(context).pop(true),
            height: 44,
            useGradient: !isDestructive,
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
    );
  }
}

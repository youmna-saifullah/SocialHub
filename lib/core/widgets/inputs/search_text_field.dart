import 'package:flutter/material.dart';

// =============================================================================
// Task 6.3 Step 12: Implement search filtering users list - Search TextField
// =============================================================================

/// Custom search text field
class SearchTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final bool autofocus;
  final FocusNode? focusNode;

  const SearchTextField({
    super.key,
    this.controller,
    this.hint = 'Search...',
    this.onChanged,
    this.onClear,
    this.autofocus = false,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      autofocus: autofocus,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: controller?.text.isNotEmpty == true
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller?.clear();
                  onClear?.call();
                },
              )
            : null,
      ),
    );
  }
}

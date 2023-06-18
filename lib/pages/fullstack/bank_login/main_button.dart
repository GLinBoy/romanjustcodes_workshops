import 'package:flutter/widgets.dart';

class FlutterBankMainButton extends StatelessWidget {
  final Function? onTap;
  final String? label;
  final bool? enabled;

  const FlutterBankMainButton({
    super.key,
    this.label,
    this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}

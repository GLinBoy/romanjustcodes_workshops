import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:romanjustcodes_workshops/pages/fullstack/utils/utils.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Material(
            color: enabled!
                ? Utils.mainThemeColor
                : Utils.mainThemeColor.withOpacity(0.5),
            child: InkWell(
              onTap: enabled!
                  ? () {
                      onTap!();
                    }
                  : null,
              highlightColor: Colors.white.withOpacity(0.2),
              splashColor: Colors.white.withOpacity(0.1),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  label!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

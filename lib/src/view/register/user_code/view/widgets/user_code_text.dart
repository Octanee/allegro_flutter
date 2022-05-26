import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../extensions/extension.dart';

class UserCodeText extends StatelessWidget {
  final String userCode;
  const UserCodeText({required this.userCode, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.paddingXLarge),
      child: Card(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(context.paddingLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: userCode));
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Copied to clipboard')),
                    );
                  },
                  icon: Icon(
                    Icons.copy,
                    color: context.colors.primary,
                  ),
                ),
                Text(
                  userCode,
                  style: context.displaySmall
                      ?.copyWith(color: context.colors.primary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

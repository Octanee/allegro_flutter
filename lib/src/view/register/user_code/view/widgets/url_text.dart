import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../extensions/extension.dart';

class UrlText extends StatelessWidget {
  final String url;
  const UrlText({required this.url, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.paddingXLarge),
      child: Card(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(context.paddingMedium),
            child: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: url));
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
                Flexible(
                  child: Text(
                    url,
                    style: context.titleMediumPrimary,

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

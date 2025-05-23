import 'package:flutter/material.dart';

class AppScreenBase extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  final bool showBackButton;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  const AppScreenBase({
    super.key,
    this.title,
    required this.children,
    this.showBackButton = true,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar:
          title != null
              ? AppBar(
                title: Text(title!),
                backgroundColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: showBackButton,
                actions: actions,
              )
              : null,
      // appBar: AppBar(
      //   title: Text(title),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   automaticallyImplyLeading: showBackButton,
      //   actions: actions,
      // ),
      body: SafeArea(
        child: ListView(padding: const EdgeInsets.all(16), children: children),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

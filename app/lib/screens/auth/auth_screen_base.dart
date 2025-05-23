import 'package:flutter/material.dart';

class AuthScreenBase extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;
  final Widget? bottomWidget;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const AuthScreenBase({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
    this.bottomWidget,
    this.showBackButton = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(color: theme.colorScheme.surface),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (showBackButton) ...[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed:
                                onBackPressed ?? () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back),
                            label: const Text('Volver'),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                      const Spacer(),
                      Icon(
                        Icons.security,
                        size: 64,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(height: 32),
                      Text(
                        title,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onBackground,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onBackground.withOpacity(
                            0.7,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      ...children,
                      if (bottomWidget != null) ...[
                        const SizedBox(height: 16),
                        bottomWidget!,
                      ],
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../widgets/stat_card.dart';
import '../app_screen_base.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = context.watch<AuthProvider>().user;

    return AppScreenBase(
      showBackButton: false,
      children: [
        _buildWelcomeCard(context, theme, user),
        const SizedBox(height: 24),
        _buildStatsSection(theme),
      ],
    );
  }

  Widget _buildWelcomeCard(BuildContext context, ThemeData theme, user) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: theme.colorScheme.primary,
              child: Text(
                user?.name?.isNotEmpty == true
                    ? user!.name[0].toUpperCase()
                    : 'U',
                style: TextStyle(color: theme.colorScheme.onPrimary),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¡Bienvenido${user?.name != null ? ', ${user!.name}!' : '!'}',
                    style: theme.textTheme.titleLarge,
                  ),
                  Text(
                    'Gestiona tu negocio de manera eficiente',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Resumen',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: const [
            StatCard(
              icon: Icons.trending_up,
              title: 'Ventas',
              value: '0',
              color: Colors.green,
            ),
            StatCard(
              icon: Icons.shopping_cart,
              title: 'Compras',
              value: '0',
              color: Colors.orange,
            ),
            StatCard(
              icon: Icons.inventory,
              title: 'Productos',
              value: '0',
              color: Colors.blue,
            ),
            StatCard(
              icon: Icons.people,
              title: 'Clientes',
              value: '0',
              color: Colors.purple,
            ),
          ],
        ),
      ],
    );
  }
}

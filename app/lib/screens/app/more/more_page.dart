import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../profile/edit_profile_screen.dart';
import '../app_screen_base.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = context.watch<AuthProvider>().user;

    return AppScreenBase(
      title: 'Más opciones',
      showBackButton: false,
      children: [
        _buildProfileCard(context, theme, user),
        const SizedBox(height: 16),
        _buildMenuItems(context, theme),
      ],
    );
  }

  Widget _buildProfileCard(BuildContext context, ThemeData theme, user) {
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
                    user?.name ?? 'Usuario',
                    style: theme.textTheme.titleLarge,
                  ),
                  Text(user?.email ?? '', style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context, ThemeData theme) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.person_outline),
          title: const Text('Editar Perfil'),
          trailing: const Icon(Icons.chevron_right),
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              ),
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Configuración'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // TODO: Implementar pantalla de configuración
          },
        ),
        ListTile(
          leading: const Icon(Icons.help_outline),
          title: const Text('Ayuda'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // TODO: Implementar pantalla de ayuda
          },
        ),
        const Divider(),
        ListTile(
          leading: Icon(Icons.logout, color: theme.colorScheme.error),
          title: Text(
            'Cerrar Sesión',
            style: TextStyle(color: theme.colorScheme.error),
          ),
          onTap: () => context.read<AuthProvider>().logout(),
        ),
      ],
    );
  }
}

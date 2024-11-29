import 'package:clinica_app/widgets/paciente_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../services/paciente_service.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observar el estado del FutureProvider
    final pacientesAsyncValue = ref.watch(pacientesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Pacientes')),
      body: pacientesAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (pacientes) {
          if (pacientes.isEmpty) {
            return const Center(child: Text('No hay pacientes disponibles.'));
          }
          return ListView.builder(
            itemCount: pacientes.length,
            itemBuilder: (context, index) {
              final paciente = pacientes[index];
              return PacienteCard(
                  paciente: paciente,
                  onEdit: () {
                    context.push('/edit',
                        extra:
                            paciente); // Navegar con el paciente seleccionado
                  });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/create'); // Navegar a la pantalla de creación
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

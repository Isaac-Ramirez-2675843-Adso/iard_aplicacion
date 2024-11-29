import 'package:flutter/material.dart';
import '../models/paciente.dart';

class PacienteCard extends StatelessWidget {
  final Paciente paciente;
  final VoidCallback onEdit;

  const PacienteCard({
    super.key,
    required this.paciente,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title:
            Text('${paciente.primerNombre} ${paciente.primerApellido ?? ''}'),
        subtitle: Text('Documento: ${paciente.numeroDocumento}'),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: onEdit,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/paciente.dart';
import '../services/paciente_service.dart';

class EditPatientScreen extends ConsumerStatefulWidget {
  final Paciente paciente;

  const EditPatientScreen({super.key, required this.paciente});

  @override
  ConsumerState<EditPatientScreen> createState() => _EditPatientScreenState();
}

class _EditPatientScreenState extends ConsumerState<EditPatientScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _segundoNombreController;
  late TextEditingController _primerApellidoController;
  late TextEditingController _segundoApellidoController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nombreController =
        TextEditingController(text: widget.paciente.primerNombre);
    _segundoNombreController =
        TextEditingController(text: widget.paciente.segundoNombre ?? '');
    _primerApellidoController =
        TextEditingController(text: widget.paciente.primerApellido ?? '');
    _segundoApellidoController =
        TextEditingController(text: widget.paciente.segundoApellido ?? '');
  }

  Future<void> _updatePaciente() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      final updatedPaciente = Paciente(
        tipoDocumento: widget.paciente.tipoDocumento,
        numeroDocumento: widget.paciente.numeroDocumento,
        primerNombre: _nombreController.text,
        segundoNombre: _segundoNombreController.text,
        primerApellido: _primerApellidoController.text,
        segundoApellido: _segundoApellidoController.text,
      );

      try {
        await ref.read(pacienteServiceProvider).editarPaciente(updatedPaciente);

        // Invalidar el `pacientesProvider` para refrescar la lista
        ref.invalidate(pacientesProvider);

        setState(() {
          _isLoading = false;
        });

        // Mostrar éxito y navegar de regreso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Paciente actualizado exitosamente')),
        );
        context.go('/home');
      } catch (error) {
        setState(() {
          _isLoading = false;
        });

        // Mostrar error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar paciente: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Paciente')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Documento: ${widget.paciente.tipoDocumento} ${widget.paciente.numeroDocumento}',
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Primer Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el primer nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _segundoNombreController,
                decoration: const InputDecoration(labelText: 'Segundo Nombre'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _primerApellidoController,
                decoration:
                    const InputDecoration(labelText: 'Primer Apellido'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _segundoApellidoController,
                decoration:
                    const InputDecoration(labelText: 'Segundo Apellido'),
              ),
              const SizedBox(height: 16.0),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _updatePaciente,
                      child: const Text('Guardar Cambios'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

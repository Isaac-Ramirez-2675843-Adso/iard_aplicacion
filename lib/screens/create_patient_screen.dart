import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/paciente.dart';
import '../services/paciente_service.dart';

class CreatePatientScreen extends ConsumerStatefulWidget {
  const CreatePatientScreen({super.key});

  @override
  ConsumerState<CreatePatientScreen> createState() =>
      _CreatePatientScreenState();
}

class _CreatePatientScreenState extends ConsumerState<CreatePatientScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tipoDocumentoController = TextEditingController();
  final _nombreController = TextEditingController();
  final _segundoNombreController = TextEditingController();
  final _documentoController = TextEditingController();
  final _primerApellidoController = TextEditingController();
  final _segundoApellidoController = TextEditingController();

  bool _isLoading = false;

  Future<void> _createPaciente() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      final paciente = Paciente(
        tipoDocumento: _tipoDocumentoController.text,
        numeroDocumento: _documentoController.text,
        primerNombre: _nombreController.text,
        segundoNombre: _segundoNombreController.text,
        primerApellido: _primerApellidoController.text,
        segundoApellido: _segundoApellidoController.text,
      );

      try {
        await ref.read(pacienteServiceProvider).crearPaciente(paciente);

        ref.invalidate(pacientesProvider);

        setState(() {
          _isLoading = false;
        });

        // Mostrar éxito y navegar de regreso
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Paciente creado exitosamente')),
        );
        context.go('/home');
      } catch (error) {
        setState(() {
          _isLoading = false;
        });

        // Mostrar error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear paciente: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Paciente')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tipoDocumentoController,
                decoration: const InputDecoration(labelText: 'Tipo de Documento'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el tipo de documento';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _documentoController,
                decoration:
                    const InputDecoration(labelText: 'Número de Documento'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el número de documento';
                  }
                  return null;
                },
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
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _createPaciente,
                      child: const Text('Crear Paciente'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

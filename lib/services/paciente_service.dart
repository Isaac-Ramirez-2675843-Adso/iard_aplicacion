import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/paciente.dart';
import 'api_client.dart';

// Servicio de pacientes
class PacienteService {
  final ApiClient _apiClient;

  PacienteService(this._apiClient);

  Future<List<Paciente>> listarPacientes() async {
    print('>>> Dio: ${_apiClient.dio.options.headers}');
    final response = await _apiClient.dio.get('paciente');
    return (response.data as List)
        .map((item) => Paciente.fromJson(item))
        .toList();
  }

  // Crear un nuevo paciente
  Future<void> crearPaciente(Paciente paciente) async {
    try {
      final response = await _apiClient.dio.post(
        'paciente/',
        data: paciente.toJson(),
      );

      if (response.statusCode != 200) {
        throw Exception('Error al crear el paciente');
      }
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }

  Future<void> editarPaciente(Paciente paciente) async {
    try {
      final response = await _apiClient.dio.put(
        'paciente',
        data: paciente.toJson(),
      );

      if (response.statusCode != 200) {
        throw Exception('Error al actualizar el paciente');
      }
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }

  Future<void> eliminarPaciente(Paciente paciente) async {
    try {
      final response = await _apiClient.dio.delete(
        'paciente/${paciente.tipoDocumento}/${paciente.numeroDocumento}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Error al eliminar el paciente');
      }
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }
}

// Proveedor para el servicio de pacientes
final pacienteServiceProvider = Provider((ref) => PacienteService(ApiClient()));

// FutureProvider para cargar la lista de pacientes
final pacientesProvider = FutureProvider<List<Paciente>>((ref) async {
  final service = ref.read(pacienteServiceProvider);
  return service.listarPacientes();
});

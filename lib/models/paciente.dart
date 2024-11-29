class Paciente {
  final String tipoDocumento;
  final String numeroDocumento;
  final DateTime? fechaExpedicionDocumento;
  final String primerNombre;
  final String? segundoNombre;
  final String? primerApellido;
  final String? segundoApellido;

  Paciente({
    required this.tipoDocumento,
    required this.numeroDocumento,
    this.fechaExpedicionDocumento,
    required this.primerNombre,
    this.segundoNombre,
    this.primerApellido,
    this.segundoApellido,
  });

  // Convertir JSON a Paciente
  factory Paciente.fromJson(Map<String, dynamic> json) {
    return Paciente(
      tipoDocumento: json['tipoDocumento'] ?? '',
      numeroDocumento: json['numeroDocumento'] ?? '',
      fechaExpedicionDocumento: json['fechaExpedicionDocumento'] != null
          ? DateTime.parse(json['fechaExpedicionDocumento'])
          : null,
      primerNombre: json['primerNombre'] ?? '',
      segundoNombre: json['segundoNombre'],
      primerApellido: json['primerApellido'],
      segundoApellido: json['segundoApellido'],
    );
  }

  // Convertir Paciente a JSON
  Map<String, dynamic> toJson() {
    return {
      'tipoDocumento': tipoDocumento,
      'numeroDocumento': numeroDocumento,
      'fechaExpedicionDocumento': fechaExpedicionDocumento?.toIso8601String(),
      'primerNombre': primerNombre,
      'segundoNombre': segundoNombre,
      'primerApellido': primerApellido,
      'segundoApellido': segundoApellido,
    };
  }
}

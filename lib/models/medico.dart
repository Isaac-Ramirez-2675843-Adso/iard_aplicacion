class Medico {
  final String tipoDocumento;
  final String numeroDocumento;
  final DateTime? fechaExpedicionDocumento;
  final String primerNombre;
  final String? segundoNombre;
  final String primerApellido;
  final String segundoApellido;

  Medico({
    required this.tipoDocumento,
    required this.numeroDocumento,
    this.fechaExpedicionDocumento,
    required this.primerNombre,
    this.segundoNombre,
    required this.primerApellido,
    required this.segundoApellido,
  });

  // Convertir JSON a Medico
  factory Medico.fromJson(Map<String, dynamic> json) {
    return Medico(
      tipoDocumento: json['tipoDocumento'] ?? '',
      numeroDocumento: json['numeroDocumento'] ?? '',
      fechaExpedicionDocumento: json['fechaExpedicionDocumento'] != null
          ? DateTime.parse(json['fechaExpedicionDocumento'])
          : null,
      primerNombre: json['primerNombre'] ?? '',
      segundoNombre: json['segundoNombre'],
      primerApellido: json['primerApellido'] ?? '',
      segundoApellido: json['segundoApellido'] ?? '',
    );
  }

  // Convertir Medico a JSON
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

import 'dart:io';
import 'dart:convert';

class CanisterConfig {
  static const String localHost = 'http://127.0.0.1:4943';
  static const String mainnetHost = 'https://ic0.app';

  static String get host {
    const bool isLocal = true; // Cambiar a false para mainnet
    return isLocal ? localHost : mainnetHost;
  }

  static String get canisterId {
    const bool isLocal = true; // Cambiar a false para mainnet
    if (!isLocal) return 'YOUR_MAINNET_CANISTER_ID';

    // Intentar leer el ID del canister del archivo de configuración local
    try {
      final file = File('.dfx/local/canister_ids.json');
      if (file.existsSync()) {
        final content = file.readAsStringSync();
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          const JsonDecoder().convert(content),
        );
        return json['ai_agent_backend']['local'] as String;
      }
    } catch (e) {
      print(
          'Warning: Could not read canister ID from .dfx/local/canister_ids.json');
    }

    // ID por defecto para desarrollo local
    return 'bkyz2-fmaaa-aaaaa-qaaaq-cai';
  }
}

import 'dart:io';
import 'dart:convert';

class CanisterConfig {
  static const String localHost = 'http://127.0.0.1:4943';
  static const String mainnetHost = 'ic0.app';

  static String get host {
    return localHost;
  }

  static String get canisterId {
    const bool isLocal = true; // Cambiar a false para mainnet
    if (!isLocal) return 'YOUR_MAINNET_CANISTER_ID';

    // Intentar leer el ID del canister del archivo de configuración local
    try {
      final file = File('.dfx/local/canister_ids.json');
      print('Checking canister_ids.json at: ${file.absolute.path}');
      if (file.existsSync()) {
        final content = file.readAsStringSync();
        print('Content of canister_ids.json: $content');
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          const JsonDecoder().convert(content),
        );
        final id = json['ai-agent-backend']['local'] as String;
        print('Found canister ID: $id');
        return id;
      } else {
        print('Warning: canister_ids.json does not exist');
      }
    } catch (e) {
      print('Error reading canister ID: $e');
    }

    // ID por defecto para desarrollo local
    const defaultId = 'bkyz2-fmaaa-aaaaa-qaaaq-cai';
    print('Using default canister ID: $defaultId');
    return defaultId;
  }
}

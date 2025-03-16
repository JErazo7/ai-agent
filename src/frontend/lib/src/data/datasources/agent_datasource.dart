import 'package:agent_dart/agent_dart.dart';
import 'dart:typed_data';

class AgentDataSource {
  late final HttpAgent _agent;
  late final Principal _canisterId;
  bool _isInitialized = false;
  final bool _isTestnet;

  AgentDataSource({bool isTestnet = false}) : _isTestnet = isTestnet;

  Future<void> initialize() async {
    if (_isInitialized) return;

    // Initialize HTTP agent
    _agent = HttpAgent();

    // Only fetch root key in testnet
    if (_isTestnet) {
      await _agent.fetchRootKey();
    }

    // Initialize canister ID
    _canisterId = Principal.fromText(
      'YOUR_CANISTER_ID',
    ); // Replace with actual canister ID

    _isInitialized = true;
  }

  Future<String> greet(String name) async {
    if (!_isInitialized) {
      throw StateError('Agent not initialized');
    }

    try {
      final result = await _agent.query(
        _canisterId,
        QueryFields(
          methodName: 'greet',
          arg: Uint8List.fromList(name.codeUnits),
        ),
        null, // identity parameter
      );
      return result.toString();
    } catch (e) {
      throw Exception('Error greeting: $e');
    }
  }

  Future<void> dispose() async {
    if (!_isInitialized) return;
    // Clean up resources if needed
    _isInitialized = false;
  }
}

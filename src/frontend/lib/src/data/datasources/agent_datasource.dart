import 'package:agent_dart/agent_dart.dart';
import 'dart:typed_data';
import '../../config/canister_config.dart';

class AgentDataSource {
  late final HttpAgent _agent;
  late final Principal _canisterId;
  bool _isInitialized = false;
  final bool _isTestnet;

  AgentDataSource({bool isTestnet = false}) : _isTestnet = isTestnet;

  Future<void> initialize() async {
    if (_isInitialized) return;

    print('Initializing agent with host: ${CanisterConfig.host}');

    // Initialize HTTP agent with the correct host
    _agent = HttpAgent.fromUri(
      Uri.parse(CanisterConfig.host),
      options: HttpAgentOptions(
        host: CanisterConfig.host,
      ),
    );

    // Only fetch root key in testnet
    if (_isTestnet) {
      print('Fetching root key for testnet...');
      await _agent.fetchRootKey();
    }

    // Initialize canister ID from config
    _canisterId = Principal.fromText(CanisterConfig.canisterId);
    print('Canister ID: ${_canisterId.toText()}');

    _isInitialized = true;
    print('Agent initialized successfully');
  }

  Future<String> greet(String name) async {
    if (!_isInitialized) {
      throw StateError('Agent not initialized');
    }

    try {
      print('Calling greet method with name: $name');
      final result = await _agent.query(
        _canisterId,
        QueryFields(
          methodName: 'greet',
          arg: Uint8List.fromList(name.codeUnits),
        ),
        null,
      );
      print('Greet result: $result');
      return result.toString();
    } catch (e) {
      print('Error in greet method: $e');
      throw Exception('Error greeting: $e');
    }
  }

  Future<void> dispose() async {
    if (!_isInitialized) return;
    print('Disposing agent...');
    // Clean up resources if needed
    _isInitialized = false;
  }
}

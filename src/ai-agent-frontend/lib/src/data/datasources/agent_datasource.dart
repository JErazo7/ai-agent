import 'package:agent_dart/agent_dart.dart';
import 'dart:typed_data';
import '../../config/canister_config.dart';

class AgentDataSource {
  late final AgentFactory _agent;
  bool _isInitialized = false;
  final bool _isTestnet;

  AgentDataSource({bool isTestnet = false}) : _isTestnet = isTestnet;

  Future<void> initialize() async {
    if (_isInitialized) return;

    print('Initializing agent with host: ${CanisterConfig.host}');

    try {
      // Initialize HTTP agent with the correct host
      _agent = await AgentFactory.createAgent(
        canisterId: CanisterConfig.canisterId,
        url: CanisterConfig.host,
        idl: IDL.Service({
          'greet': IDL.Func([IDL.Text], [IDL.Text], ['query'])
        }),
      );
    } catch (e) {
      print('Error initializing agent: $e');
      throw Exception('Error initializing agent: $e');
    }

    _isInitialized = true;
    print('Agent initialized successfully');
  }

  Future<String> greet(String name) async {
    if (!_isInitialized) {
      throw StateError('Agent not initialized');
    }

    try {
      print('Calling greet method with name: $name');
      final result = await _agent.actor!.getFunc('greet')!.call([name]);
      return result;
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

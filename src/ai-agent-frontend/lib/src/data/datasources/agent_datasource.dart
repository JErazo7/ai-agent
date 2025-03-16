import 'package:agent_dart/agent_dart.dart';
import '../../config/canister_config.dart';

class AgentDataSource {
  late final AgentFactory _agent;
  bool _isInitialized = false;

  AgentDataSource({bool isTestnet = false});

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      _agent = await AgentFactory.createAgent(
        canisterId: CanisterConfig.canisterId,
        url: CanisterConfig.host,
        idl: IDL.Service({
          'greet': IDL.Func([IDL.Text], [IDL.Text], ['query'])
        }),
      );
    } catch (e) {
      throw Exception('Error initializing agent: $e');
    }

    _isInitialized = true;
  }

  Future<String> greet(String name) async {
    if (!_isInitialized) {
      throw StateError('Agent not initialized');
    }

    try {
      final result = await _agent.actor!.getFunc('greet')!.call([name]);
      return result;
    } catch (e) {
      throw Exception('Error greeting: $e');
    }
  }
}

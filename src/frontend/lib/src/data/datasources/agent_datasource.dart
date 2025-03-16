import 'package:agent_dart/agent_dart.dart';

class AgentDataSource {
  late final HttpAgent _agent;
  late final Principal _canisterId;
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    // Initialize HTTP agent
    _agent = HttpAgent();
    await _agent.fetchRootKey();

    // Initialize canister ID
    _canisterId = Principal.fromText(
        'YOUR_CANISTER_ID'); // Replace with actual canister ID

    _isInitialized = true;
  }

  Future<String> getAgentState() async {
    if (!_isInitialized) {
      throw StateError('Agent not initialized');
    }

    try {
      // TODO: Implement canister call
      // We need to review the specific canister documentation
      return 'Agent state not implemented yet';
    } catch (e) {
      throw Exception('Error getting agent state: $e');
    }
  }

  Future<String> sendMessage(String message) async {
    if (!_isInitialized) {
      throw StateError('Agent not initialized');
    }

    try {
      // TODO: Implement canister call
      // We need to review the specific canister documentation
      return 'Message sending not implemented yet';
    } catch (e) {
      throw Exception('Error sending message: $e');
    }
  }

  Future<void> dispose() async {
    if (!_isInitialized) return;
    // Clean up resources if needed
    _isInitialized = false;
  }
}

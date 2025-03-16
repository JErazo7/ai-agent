abstract class AgentRepository {
  /// Initialize the agent with necessary configuration
  Future<void> initialize();

  /// Get the current state of the agent
  Future<String> getAgentState();

  /// Send a message to the agent and wait for its response
  Future<String> sendMessage(String message);

  /// End the agent session
  Future<void> dispose();
}

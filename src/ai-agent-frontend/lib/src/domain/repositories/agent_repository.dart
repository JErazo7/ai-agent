abstract class AgentRepository {
  /// Initialize the agent with necessary configuration
  Future<void> initialize();

  /// Send a greeting message to the agent and wait for its response
  Future<String> greet(String name);

  /// End the agent session
  Future<void> dispose();
}

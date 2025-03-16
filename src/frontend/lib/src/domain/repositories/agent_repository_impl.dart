import 'package:frontend/src/data/datasources/agent_datasource.dart';
import 'package:frontend/src/domain/repositories/agent_repository.dart';

class AgentRepositoryImpl implements AgentRepository {
  final AgentDataSource _dataSource;

  AgentRepositoryImpl(this._dataSource);

  @override
  Future<void> initialize() async {
    await _dataSource.initialize();
  }

  @override
  Future<String> getAgentState() async {
    return await _dataSource.getAgentState();
  }

  @override
  Future<String> sendMessage(String message) async {
    return await _dataSource.sendMessage(message);
  }

  @override
  Future<void> dispose() async {
    await _dataSource.dispose();
  }
}

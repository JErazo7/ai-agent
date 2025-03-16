import '../../data/datasources/agent_datasource.dart';
import 'agent_repository.dart';

class AgentRepositoryImpl implements AgentRepository {
  final AgentDataSource _dataSource;

  AgentRepositoryImpl(this._dataSource);

  @override
  Future<void> initialize() async {
    await _dataSource.initialize();
  }

  @override
  Future<String> greet(String name) async {
    return await _dataSource.greet(name);
  }

  @override
  Future<void> dispose() async {
    await _dataSource.dispose();
  }
}

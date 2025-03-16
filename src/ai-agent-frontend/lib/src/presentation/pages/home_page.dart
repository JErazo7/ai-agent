import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/datasources/agent_datasource.dart';
import '../../domain/repositories/agent_repository.dart';
import '../../domain/repositories/agent_repository_impl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _greeting = '';
  late final AgentRepository _repository;

  @override
  void initState() {
    super.initState();
    _repository = AgentRepositoryImpl(
      AgentDataSource(isTestnet: false),
    );
    _initializeAgent();
  }

  Future<void> _initializeAgent() async {
    await _repository.initialize();
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      try {
        final result = await _repository.greet(name);
        setState(() {
          _greeting = result;
        });
      } catch (e) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Agent'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/logo2.svg',
                width: 200,
                height: 200,
                placeholderBuilder: (BuildContext context) =>
                    const CircularProgressIndicator(),
              ),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Enter your name: '),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _handleSubmit,
                      child: const Text('Click Me!'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                _greeting,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

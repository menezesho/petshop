import 'package:mysql1/mysql1.dart';
import 'package:petshop/src/database/database_configuration.dart';

class MySqlConfiguration implements DBConfiguration {
  MySqlConnection? _connection;

  @override
  Future<MySqlConnection> get connection async {
    if (_connection == null) _connection = await createConnection();
    if (_connection == null) throw Exception('Erro de conexão!');

    return _connection!;
  }

  @override
  Future createConnection() async {
    return await MySqlConnection.connect(
      ConnectionSettings(
        host: '192.168.56.1',
        port: 3306,
        user: 'administrador',
        password: 'Teste@123',
        db: 'petshop',
      ),
    );
  }
}

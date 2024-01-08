import 'dart:convert';

import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';

import 'pelanggan.dart';

class Controller {
  String getDateNow() {
    final DateTime now = DateTime.now();
    final DateTime dateformat = DateTime('yyyy-MM-dd hh:mm:ss');
    final String dateNow = dateformat.format(now);
    return dateNow;
  }

  /*SQL Connection*/
  Future<MySqlConnection> connectSql() async {
    var setting = ConnectionSettings(
        host: '127.0.0.1',
        port: 3306,
        user: 'dart2',
        password: 'password',
        db: 'tokoonline');
    var cn = await MySqlConnection.connect(setting);
    return cn;
  }

  /*USER*/
  Future<Response> getUserData(Request request) async {
    var conn = await connectSql();
    var sql = "SELECT * FROM pelanggan";
    var user = await conn.query(sql, []);
    return Response.ok(user.toString());
  }

  Future<Response> getUserDataFilter(Request request) async {
    String body = await request.readAsString();
    var obj = json.decode(body);
    var name = "%" + obj['name'] + "%";

    var conn = await connectSql();
    var sql = "SELECT * FROM pelanggan WHERE nama like ?";
    var user = await conn.query(sql, [name]);
    return Response.ok(user.toString());
  }

  Future<Response> postUserData(Request request) async {
    String body = await request.readAsString();
    pelanggan user = pelangganFromJson(body);
    pelanggan.telp = getDateNow();
    pelanggan.alamat = getDateNow();

    var conn = await connectSql();
    var sqlExecute =
        "INSERT INTO pelanggan (id_pelanggan, nama, jenis_kelamin, telp, alamat ) VALUES " +
            "('${pelanggan.id_pelanggan}','${pelanggan.nama}','${pelanggan.jenis_kelamin}','${pelanggan.telp}','${pelanggan.alamat}')";

    var execute = await conn.query(sqlExecute, []);

    var sql = "SELECT * FROM pelanggan WHERE nama = ?";
    var userResponse = await conn.query(sql, [pelanggan.nama]);

    return Response.ok(userResponse.toString());
  }

  Future<Response> putUserData(Request request) async {
    String body = await request.readAsString();
    pelanggan user = pelangganFromJson(body);
    pelanggan.alamat = getDateNow();

    var conn = await connectSql();
    var sqlExecute =
        "UPDATE pelanggan SET nama ='${pelanggan.nama}', alamat = '${pelanggan.alamat}'," +
            " telp = '${pelanggan.telp}', alamat='${pelanggan.alamat}' WHERE id_pelanggan ='${pelanggan.id_pelanggan}'";

    var execute = await conn.query(sqlExecute, []);

    var sql = "SELECT * FROM pelanggan WHERE id_pelanggan = ?";
    var userResponse = await conn.query(sql, [pelanggan.id_pelanggan]);

    return Response.ok(userResponse.toString());
  }

  Future<Response> deleteUser(Request request) async {
    String body = await request.readAsString();
    pelanggan user = pelangganFromJson(body);

    var conn = await connectSql();
    var sqlExecute =
        "DELETE FROM pelanggan WHERE id_pelanggan ='${pelanggan.id_pelanggan}'";

    var execute = await conn.query(sqlExecute, []);

    var sql = "SELECT * FROM USER WHERE iduser = ?";
    var userResponse = await conn.query(sql, [pelanggan.id_pelanggan]);

    return Response.ok(userResponse.toString());
  }

  /*ROLE*/

  /*MOTIVASI*/
}

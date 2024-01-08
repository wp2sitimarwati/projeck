import 'dart:convert';

import 'controller.dart';

class pelanggan {
  final int idpelanggan;
  final String? nama;
  final String? jeniskelamin;
  final int telp;
  String? alamat;

  pelanggan({
    required this.idpelanggan,
    required this.nama,
    required this.jeniskelamin,
    required this.telp,
    required this.alamat,
  });

  Map<String, dynamic> toMap() => {
        'idpelanggan': idpelanggan,
        'nama': nama,
        'jeniskelamin': jeniskelamin,
        'telp': telp,
        'alamat': alamat,
      };

  final Controller ctrl = Controller();

  factory pelanggan.fromJson(Map<String, dynamic> json) => pelanggan(
        idpelanggan: json['idpelanggan'],
        nama: json['nama'],
        jeniskelamin: json['jeniskelamin'],
        telp: json['telp'],
        alamat: json['alamat'],
      );
}

pelanggan pelangganFromJson(String str) => pelanggan.fromJson(json.decode(str));


/*
{
   "iduser":123,
   "nama":"Rahmat Tri Yunandar",
   "profesi":"Dosen",
   "email":"rahmat.rtr@bsi.ac.id",
   "password":"password",
   "role_id":1,
   "is_active":1,
   "tanggal_input":"2022-10-17 00:00:00.000Z",
   "modified":"2022-10-17 00:00:00.000Z"
}
*/
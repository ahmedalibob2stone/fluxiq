import 'dart:convert';
import 'package:crypto/crypto.dart';



String generateNewsId(String url) {
  final bytes = utf8.encode(url);
  final digest = sha1.convert(bytes);
  return digest.toString(); }


import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio.g.dart';

@Riverpod(keepAlive: true)
Dio dioClient(DioClientRef ref) {
  final baseUrl = ref.watch(baseUrlProvider);
  return Dio(BaseOptions(baseUrl: baseUrl));
}

@Riverpod(keepAlive: true)
String baseUrl(BaseUrlRef ref) => throw UnimplementedError();

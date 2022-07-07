import 'package:get_it/get_it.dart';
import 'package:navigator_sample/domain/reports_repository.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<ReportsRepository>(() => ReportsRepository());
}

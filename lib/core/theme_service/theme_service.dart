abstract class ThemeService {
  Future<void> init();

  Future<T> load<T>(String key, T defaultValue);

  Future<void> save<T>(String key, T value);
}

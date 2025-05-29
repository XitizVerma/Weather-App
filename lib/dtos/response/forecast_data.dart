class ForecastTemperatureData {
  String? time;
  String? temperature;
  String? emoji;

  ForecastTemperatureData(String time, double temperature, String emoji) {
    this.time = time;
    this.temperature = temperature.toString();
    this.emoji = emoji;
  }
}
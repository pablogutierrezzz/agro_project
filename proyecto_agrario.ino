#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <DHT.h>
#include <DHT_U.h>
#include <RTClib.h>
#include <ArduinoJson.h>

#define DHTPIN1 2 //D4
#define DHTTYPE DHT11

const int LDR_PIN = A0;
const int threshold = 300;
const int soilMoistureSensorPin = 16; //D0
const int waterSensorPin = 12; //D6

const char* ssid = "Maestros";
const char* password = "Maestros_2021";
const char* serverName = "http://10.0.20.127/agro_project/carga_de_datos.php";
const char* weatherApiKey = "e17fbad4a2353186f0305a665a9816b9"; // Reemplaza con tu clave API de OpenWeatherMap
const char* cityID = "3853354"; // Reemplaza con el ID de tu ciudad o usa el nombre de la ciudad

DHT dht1(DHTPIN1, DHTTYPE);

void setup() {
  Serial.begin(9600);
  dht1.begin();
  pinMode(LDR_PIN, INPUT);
  pinMode(soilMoistureSensorPin, INPUT);
  pinMode(waterSensorPin, INPUT);

  WiFi.begin(ssid, password);
  Serial.print("Conectandose al wifi...");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
    yield();
  }
  Serial.println(" Conectado.");
}

void loop() {
  int ldrValue = analogRead(LDR_PIN);
  int soilMoistureValue = digitalRead(soilMoistureSensorPin);
  int sensorState = digitalRead(waterSensorPin);
  
  float h1 = dht1.readHumidity();
  float t1 = dht1.readTemperature();

  if (isnan(h1) || isnan(t1)) {
    Serial.println("Error al leer el sensor DHT.");
    return;
  }

  Serial.print("Humedad del ambiente: %");
  Serial.println(h1);
  Serial.print("Temperatura del ambiente: ");
  Serial.print(t1);
  Serial.println(" *C");

  if (ldrValue < threshold) {
    Serial.println("Hay luz.");
  } else {
    Serial.println("No hay luz.");
  }

  Serial.print("Humedad del suelo: ");
  Serial.println(soilMoistureValue);

  Serial.print("Estado del sensor: ");
  if (sensorState == HIGH) {
    Serial.println("No hay agua");
  } else {
    Serial.println("Agua detectada");
  }

  // Obtener el clima desde OpenWeatherMap
  if (WiFi.status() == WL_CONNECTED) {
    WiFiClient client;
    HTTPClient http;

    // URL de la solicitud a OpenWeatherMap
    String weatherUrl = String("http://api.openweathermap.org/data/2.5/weather?id=") + cityID + "&appid=" + weatherApiKey + "&units=metric&lang=es";

    http.begin(client, weatherUrl);
    int httpResponseCode = http.GET();

    if (httpResponseCode > 0) {
      String payload = http.getString();
      
      // Parsear la respuesta JSON
      DynamicJsonDocument doc(1024);
      deserializeJson(doc, payload);

      String weatherDescription = doc["weather"][0]["description"];

      Serial.print("Condiciones del clima: ");
      Serial.println(weatherDescription);

      String postData = "ambiente_temperatura=" + String(t1) + "&ambiente_humedad=" + String(h1) + "&ambiente_luzSolar="
                      + String(ldrValue) + "&suelo_humedad=" + String(soilMoistureValue) + "&clima_estado=" + weatherDescription;

      http.begin(client, serverName);
      http.addHeader("Content-Type", "application/x-www-form-urlencoded");

      int postHttpResponseCode = http.POST(postData);

      if (postHttpResponseCode > 0) {
        String response = http.getString();
        Serial.println(postHttpResponseCode);
        Serial.println(response);
      } else {
        Serial.print("Error enviando el POST.");
        Serial.println(postHttpResponseCode);
      }

      http.end();
    } else {
      Serial.print("Error en la solicitud HTTP: ");
      Serial.println(httpResponseCode);
    }

    http.end();
  } else {
    Serial.println("WiFi desconectado.");
  }

  delay(10000);
}

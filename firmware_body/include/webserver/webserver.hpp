#pragma once

#include <ArduinoJson.h>
#include <WiFi.h>
#include <ESPAsyncWebServer.h>
#include <ElegantOTA.h>
#include <ESPmDNS.h>

#include "settings/settings.hpp"
#include "webserver/ota_utils.hpp"

class WirelessController
{
public:
    static void wirelessTask(void *pvParameters);
private:
    static bool deserializeSettings(String json_str, bool &needReboot);
    static String serializeSettings();
};
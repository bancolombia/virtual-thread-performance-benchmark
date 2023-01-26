package com.maocq.helidon.nima.application.config;

import io.helidon.nima.webclient.http1.Http1Client;

public class ConfigApp {

    public static Http1Client getHttpClient() {
        var ip = System.getenv("LATENCY_IP") == null ? "localhost" : System.getenv("LATENCY_IP");
        return Http1Client.builder()
                .baseUri(String.format("http://%s:8080", ip))
                .build();
    }
}

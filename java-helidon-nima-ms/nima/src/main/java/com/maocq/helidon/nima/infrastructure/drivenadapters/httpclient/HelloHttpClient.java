package com.maocq.helidon.nima.infrastructure.drivenadapters.httpclient;

import com.maocq.helidon.nima.domain.model.hello.gateways.HelloGateway;
import io.helidon.nima.webclient.http1.Http1Client;

public class HelloHttpClient implements HelloGateway {

    private final Http1Client client;

    public HelloHttpClient(Http1Client client) {
        this.client = client;
    }

    public String hello(int latency) {
        return client.get()
                .path("/" + latency)
                .request(String.class);
    }
}

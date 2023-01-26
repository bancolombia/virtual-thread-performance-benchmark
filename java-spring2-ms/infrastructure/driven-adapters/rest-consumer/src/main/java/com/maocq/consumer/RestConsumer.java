package com.maocq.consumer;

import com.maocq.model.hello.gateways.HelloGateway;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

@Service
@RequiredArgsConstructor
public class RestConsumer implements HelloGateway {

    private final WebClient client;

    public Mono<String> hello(int latency) {
        return client
            .get()
            .uri("/{latency}", latency)
            .retrieve()
            .bodyToMono(String.class);
    }
}
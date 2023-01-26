package com.maocq.model.hello.gateways;

import reactor.core.publisher.Mono;

public interface HelloGateway {

    Mono<String> hello(int latency);
}

package com.maocq.api;

import com.maocq.usecase.cases.CasesUseCase;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.server.ServerRequest;
import org.springframework.web.reactive.function.server.ServerResponse;
import reactor.core.publisher.Mono;

@Component
@RequiredArgsConstructor
public class Handler {
    private final CasesUseCase cases;

    public Mono<ServerResponse> hello(ServerRequest serverRequest) {
        return ServerResponse.ok().bodyValue("Hello");
    }

    public Mono<ServerResponse> caseOne(ServerRequest serverRequest) {
        var latency = serverRequest.queryParam("latency").map(Integer::valueOf).orElse(0);
        return ServerResponse.ok().body(cases.caseOne(latency), String.class);
    }

    public Mono<ServerResponse> caseTwo(ServerRequest serverRequest) {
        var latency = serverRequest.queryParam("latency").map(Integer::valueOf).orElse(0);
        return ServerResponse.ok().body(cases.caseTwo(latency), String.class);
    }

    public Mono<ServerResponse> caseThree(ServerRequest serverRequest) {
        return ServerResponse.ok().body(cases.caseThree(1000), String.class);
    }
}

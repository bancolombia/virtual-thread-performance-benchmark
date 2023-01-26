package com.maocq.spring.infrastructure.entrypoints.reactiveweb;

import com.maocq.spring.domain.usecase.cases.CasesUseCase;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.server.ServerRequest;
import org.springframework.web.reactive.function.server.ServerResponse;
import reactor.core.publisher.Mono;

@Component
public class Handler {
    private final CasesUseCase cases;

    public Handler(CasesUseCase cases) {
        this.cases = cases;
    }

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

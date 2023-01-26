package com.maocq.usecase.cases;

import com.maocq.model.hello.gateways.HelloGateway;
import com.maocq.model.primes.Primes;
import lombok.RequiredArgsConstructor;
import reactor.core.publisher.Mono;
import reactor.core.scheduler.Schedulers;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@RequiredArgsConstructor
public class CasesUseCase {
    private final ExecutorService cpuExecutor = Executors.newFixedThreadPool(Runtime.getRuntime().availableProcessors());
    private final HelloGateway helloGateway;

    public Mono<String> caseOne(int latency) {
        return helloGateway.hello(latency)
                .flatMap(x -> Mono.just(Primes.primes(1000)));
    }

    public Mono<String> caseTwo(int latency) {
        return helloGateway.hello(latency);
    }

    public Mono<String> caseThree(int n) {
        return Mono.defer(() -> Mono.just(Primes.primes(n)))
                .subscribeOn(Schedulers.fromExecutor(cpuExecutor));
    }
}

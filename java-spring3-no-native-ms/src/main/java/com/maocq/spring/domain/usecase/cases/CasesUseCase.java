package com.maocq.spring.domain.usecase.cases;

import com.maocq.spring.Application;
import com.maocq.spring.domain.model.hello.gateways.HelloGateway;
import com.maocq.spring.domain.model.primes.Primes;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;
import reactor.core.scheduler.Schedulers;

@Service
public class CasesUseCase {
    private final HelloGateway helloGateway;

    public CasesUseCase(HelloGateway helloGateway) {
        this.helloGateway = helloGateway;
    }

    public Mono<String> caseOne(int latency) {
        return helloGateway.hello(latency)
                .flatMap(x -> Mono.just(Primes.primes(1000)));
    }

    public Mono<String> caseTwo(int latency) {
        return helloGateway.hello(latency);
    }

    public Mono<String> caseThree(int n) {
        return Mono.defer(() -> Mono.just(Primes.primes(n)))
                .subscribeOn(Schedulers.fromExecutor(Application.cpuExecutor));
    }
}

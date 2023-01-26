package com.maocq.helidon.nima.domain.usecases.cases;

import com.maocq.helidon.nima.domain.model.hello.gateways.HelloGateway;
import com.maocq.helidon.nima.domain.model.primes.Primes;

public class CasesUseCase {
    private final HelloGateway helloGateway;

    public CasesUseCase(HelloGateway helloGateway) {
        this.helloGateway = helloGateway;
    }

    public String caseOne(int latency) {
        var hello = helloGateway.hello(latency);
        return Primes.primes(1000);
    }

    public String caseTwo(int latency) {
        return helloGateway.hello(latency);
    }

    public String caseThree(int n) {
        return Primes.primes(n);
    }
}

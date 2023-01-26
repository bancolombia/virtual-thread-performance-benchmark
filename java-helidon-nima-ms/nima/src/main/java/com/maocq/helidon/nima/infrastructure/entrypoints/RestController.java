package com.maocq.helidon.nima.infrastructure.entrypoints;

import com.maocq.helidon.nima.domain.usecases.cases.CasesUseCase;
import io.helidon.common.http.Http;
import io.helidon.nima.webserver.WebServer;
import io.helidon.nima.webserver.http.HttpRouting;
import io.helidon.nima.webserver.http.ServerRequest;
import io.helidon.nima.webserver.http.ServerResponse;

public class RestController {
    private static final Http.HeaderValue SERVER = Http.Header.create(Http.Header.SERVER, "Nima");

    private final CasesUseCase cases;

    public RestController(CasesUseCase cases) {
        this.cases = cases;
    }

    public void start() {
        WebServer ws = WebServer.builder()
                .routing(this::routing)
                .start();
    }

    private void routing(HttpRouting.Builder rules) {
        rules.addFilter((chain, req, res) -> {
                    res.header(SERVER);
                    chain.proceed();
                })
                .get("/api/hello", (req, res) -> res.send("Hello"))
                .get("/api/case-one", this::caseOne)
                .get("/api/case-two", this::caseTwo)
                .get("/api/case-three", this::caseThree)
                .register("/", new RouterRest());
    }

    private void caseOne(ServerRequest req, ServerResponse res) {
        var latency = Integer.valueOf(req.query().first("latency").orElse("0"));
        String response = cases.caseOne(latency);
        res.send(response);
    }

    private void caseTwo(ServerRequest req, ServerResponse res) {
        var latency = Integer.valueOf(req.query().first("latency").orElse("0"));
        String response = cases.caseTwo(latency);
        res.send(response);
    }

    private void caseThree(ServerRequest req, ServerResponse res) {
        String response = cases.caseThree(1000);
        res.send(response);
    }
}

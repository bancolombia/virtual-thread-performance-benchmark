package com.maocq.helidon.nima.infrastructure.entrypoints;

import io.helidon.nima.webserver.http.HttpRules;
import io.helidon.nima.webserver.http.HttpService;
import io.helidon.nima.webserver.http.ServerRequest;
import io.helidon.nima.webserver.http.ServerResponse;

public class RouterRest implements HttpService {

    @Override
    public void routing(HttpRules rules) {
        rules.get("/other", this::other);
    }

    private void other(ServerRequest req, ServerResponse res) {
        String response = "Other";
        res.send(response);
    }
}

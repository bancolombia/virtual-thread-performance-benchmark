package com.maocq.helidon.nima.application;

import com.maocq.helidon.nima.application.config.ConfigApp;
import com.maocq.helidon.nima.domain.usecases.cases.CasesUseCase;
import com.maocq.helidon.nima.infrastructure.drivenadapters.httpclient.HelloHttpClient;
import com.maocq.helidon.nima.infrastructure.entrypoints.RestController;

public class Application {

    public static void main(String[] args) {;
        var httpClient = ConfigApp.getHttpClient();
        var cases = new CasesUseCase(new HelloHttpClient(httpClient));

        new RestController(cases).start();
    }
}

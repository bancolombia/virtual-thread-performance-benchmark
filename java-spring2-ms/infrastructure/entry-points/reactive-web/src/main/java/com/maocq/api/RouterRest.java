package com.maocq.api;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.server.RouterFunction;
import org.springframework.web.reactive.function.server.ServerResponse;

import static org.springframework.web.reactive.function.server.RouterFunctions.route;
import static org.springframework.web.reactive.function.server.RequestPredicates.*;


@Configuration
public class RouterRest {
@Bean
public RouterFunction<ServerResponse> routerFunction(Handler handler) {

    return route(GET("/api/hello"), handler::hello)
            .andRoute(GET("/api/case-one"), handler::caseOne)
            .andRoute(GET("/api/case-two"), handler::caseTwo)
            .and(route(GET("/api/case-three"), handler::caseThree));
    }
}

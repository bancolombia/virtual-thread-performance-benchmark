package application

import (
	"maocq/go-ms/application/config"
	"maocq/go-ms/domain/usecase"
	"maocq/go-ms/infrastructure/driven-adapters/httpclient"
	"maocq/go-ms/infrastructure/entry-points/rest"
)

func Start() {
	httpClient := config.GetHttpClient()

	helloRepository := httpclient.HelloHttpRepository{Client: httpClient, Url: config.GetUrlService()}

	cases := usecase.CasesUseCase{HelloRepository: &helloRepository}

	rest.Start(&cases)
}

package usecase

import (
	hello "maocq/go-ms/domain/model/hello/gateways"
	"maocq/go-ms/domain/model/primes"
)

type CasesUseCase struct {
	HelloRepository hello.HelloRepository
}

func (c *CasesUseCase) CaseOne(latency string) (string, error) {
	if _, err := c.HelloRepository.Hello(latency); err != nil {
		return "", err
	}
	result := primes.Primes(1000)

	return result, nil
}

func (c *CasesUseCase) CaseTwo(latency string) (string, error) {
	return c.HelloRepository.Hello(latency)
}

func (c *CasesUseCase) CaseThree(n int) string {
	return primes.Primes(n)
}

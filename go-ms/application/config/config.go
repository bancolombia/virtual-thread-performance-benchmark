package config

import (
	"fmt"
	"net/http"
	"os"
	"time"
)

func GetHttpClient() *http.Client {
	t := http.DefaultTransport.(*http.Transport).Clone()
	t.MaxIdleConns = 500
	t.MaxConnsPerHost = 500
	t.MaxIdleConnsPerHost = 500
	t.IdleConnTimeout = 90 * time.Second

	return &http.Client{
		Transport: t,
	}
}

func GetUrlService() string {
	return fmt.Sprintf("http://%s:8080", GetEnvOrDefault("LATENCY_IP", "localhost"))
}

func GetEnvOrDefault(key string, defaultV string) string {
	if varEnv := os.Getenv(key); varEnv == "" {
		return defaultV
	} else {
		return varEnv
	}
}

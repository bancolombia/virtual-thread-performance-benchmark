package rest

import (
	"github.com/gin-gonic/gin"
	"maocq/go-ms/domain/usecase"
	"net/http"
)

func Start(cases *usecase.CasesUseCase) {
	router := gin.Default()
	router.GET("/api/hello", func(c *gin.Context) { c.String(http.StatusOK, "Hello") })

	router.GET("/api/case-one", func(c *gin.Context) {
		latency := c.DefaultQuery("latency", "0")

		if result, err := cases.CaseOne(latency); err != nil {
			c.String(http.StatusInternalServerError, err.Error())
		} else {
			c.JSON(http.StatusOK, result)
		}
	})

	router.GET("/api/case-two", func(c *gin.Context) {
		latency := c.DefaultQuery("latency", "0")

		if result, err := cases.CaseTwo(latency); err != nil {
			c.String(http.StatusInternalServerError, err.Error())
		} else {
			c.JSON(http.StatusOK, result)
		}
	})

	router.GET("/api/case-three", func(c *gin.Context) {
		result := cases.CaseThree(1000)
		c.String(http.StatusOK, result)
	})

	router.Run("0.0.0.0:8080")
}

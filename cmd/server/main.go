package main

import (
	"fmt"
	"log"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

func init() {
	err := godotenv.Load()
	if err != nil {
		log.Print(".env file not found")
	}
}

func main() {
	ginMode := os.Getenv("ENV")
	if ginMode == "production" {
		gin.SetMode(gin.ReleaseMode)
	}

	engine := gin.Default()

	todoGroup := engine.Group("todo")
	{
		todoGroup.GET("list", func(c *gin.Context) {
			c.JSON(200, gin.H{
				"ok": true,
			})
		})
	}

	engine.GET("/healthcheck", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"health": "yes",
		})
	})

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	err := engine.Run(":" + port)
	if err != nil {
		fmt.Println("Error starting the server:", err)
	}
}

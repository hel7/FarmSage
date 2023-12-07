package handlers

import (
	"github.com/gin-gonic/gin"
	"github.com/hel7/Atark-backend/pkg/service"
)

type Handlers struct {
	services *service.Service
}

func NewHandler(services *service.Service) *Handlers {
	return &Handlers{services: services}
}

func (h *Handlers) InitRoutes() *gin.Engine {
	router := gin.Default()

	auth := router.Group("/auth")
	{
		auth.POST("/register", h.registerUser)
		auth.POST("/login", h.loginUser)
	}

	api := router.Group("/api", h.userIndetity)
	{

		api.GET("/farms", h.getUserFarms)
		api.GET("/farms/:farmID", h.getFarmByID)
		api.POST("/farms", h.createFarm)
		api.PUT("/farms/:farmID", h.updateFarm)
		api.DELETE("/farms/:farmID", h.deleteFarm)

		api.GET("/feeds", h.getFeedsOnFarm)
		api.POST("/feeds", h.addFeedToFarm)
		api.DELETE("/feeds/:feedID", h.removeFeedFromFarm)

		farms := api.Group("/farms/:farmID")
		{
			farms.GET("/animals", h.getAnimalsOnFarm)
			farms.POST("/animals", h.addAnimalToFarm)
			farms.GET("/animals/:animalID", h.getAnimalByID)
			farms.DELETE("/animals/:animalID", h.removeAnimalFromFarm)

			farms.POST("/animals/:animalID/feeds/:feedID/schedule", h.addFeedToAnimalSchedule)
			farms.DELETE("/animals/:animalID/feeds/:feedID/schedule", h.deleteFeedingSchedule)
			farms.PUT("/animals/:animalID/feeds/:feedID/schedule", h.updateFeedInAnimalSchedule)
			farms.GET("/animals/:animalID/feeds/:feedID/schedule", h.getAnimalFeedSchedule)
		}

		analytics := api.Group("/analytics")
		{
			analytics.GET("/", h.getAnalytics)
			analytics.GET("/:date", h.getAnalyticsByDate)
		}

		admin := api.Group("/admin")
		admin.Use(isAdmin)
		{
			users := admin.Group("/users")
			{
				users.GET("/", h.getUsers)
				users.POST("/", h.createUser)
				users.GET("/:UserID", h.getUserByID)
				users.PUT("/:UserID", h.updateUser)
				users.DELETE("/:UserID", h.deleteUser)
			}

			data := admin.Group("/data")
			{
				data.POST("/backup", h.backupData)
				data.POST("/restore", h.restoreData)
				data.GET("/export", h.exportData)
				data.POST("/import", h.importData)
			}
		}
	}

	return router
}

package main

import (
	"go-gin-gorm-riverpod-todo-app/infra"
	"go-gin-gorm-riverpod-todo-app/models"
)

// モデルの作成、修正後、以下のコマンドを実行してマイグレーションを実行
// go run migrations/migration.go
func main() {
	infra.Initialize()
	db := infra.SetupDB()

	if error := db.AutoMigrate(&models.Todo{}, &models.User{}); error != nil {
		panic("Failed to migrate database")
	}
}
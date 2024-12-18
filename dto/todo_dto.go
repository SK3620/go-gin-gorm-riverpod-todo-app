package dto

type CreateToDoInput struct {
	Title string `json:"title" binding:"required"`
}

type UpdateTodoInput struct {
	Title *string `json:"title" binding:"omitnil"`
	IsCompleted *bool `json:"is_completed" binding:"omitnil"`
}
# flappy_bird_game
## Nodes
- **FlappyBirdGame** (Node2D)
  - **Floor** (StaticBody2D)
    - **CollisionShape2D** (CollisionShape2D)
    - **ColorRect** (ColorRect)
  - **Camera2D** (Camera2D)
  - **Player** (CharacterBody2D)
    - script: res://flappy_bird_clone/scripts/player.gd
    - settings: res://flappy_bird_clone/default_settings.tres
    - **Sprite2D** (Sprite2D)
    - **CollisionShape2D** (CollisionShape2D)
  - **Obstacle** (res://flappy_bird_clone/obstacle_full.tscn, instanced scene)
  - **Obstacle2** (res://flappy_bird_clone/obstacle_full.tscn, instanced scene)
  - **Obstacle3** (res://flappy_bird_clone/obstacle_full.tscn, instanced scene)
  - **Obstacle4** (res://flappy_bird_clone/obstacle_full.tscn, instanced scene)
  - **Obstacle5** (res://flappy_bird_clone/obstacle_full.tscn, instanced scene)
  - **Obstacle6** (res://flappy_bird_clone/obstacle_full.tscn, instanced scene)
  - **ScreenEdgeCollider** (Area2D)
    - **CollisionShape2D** (CollisionShape2D)


---

# init_scene
## Nodes
- **FlappyBirdInit** (Node)
  - script: res://flappy_bird_clone/scripts/init_scene.gd


---

# obstacle_full
## Nodes
- **Obstacle** (Node2D)
  - **ObstacleTop** (res://flappy_bird_clone/obstacle_half.tscn, instanced scene)
  - **ObstacleBottom** (res://flappy_bird_clone/obstacle_half.tscn, instanced scene)
  - **ScoringArea** (Area2D)
    - **CollisionShape2D** (CollisionShape2D)


---

# obstacle_half
## Nodes
- **ObstacleHalf** (ColorRect)
  - **Collider** (Area2D)
    - **CollisionShape2D** (CollisionShape2D)

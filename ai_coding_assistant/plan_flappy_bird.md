# Flappy Bird Clone Implementation Plan

## Implementation Steps

1. Create new mod project (AI)
   - [x ] Update mod structure based on settings menu mod example
   - [x ] Create appropriately named placeholder scene file
   - [x ] Update settings to launch main scene from play button

2. Scene Setup (Human)
   - [x ] Create empty 2D scene
   - [x ] Add brown horizontal rectangle for floor
   - [x ] Add blue circle for player character (middle left of screen)
     [x ] Fix bug: Resolution changes don't automatically adjust the camera, you can see off the play area

3. Player Mechanics (AI)
   - [x ] Apply constant down force so player falls to the ground
   - [x ] Add spacebar input for player bounce

4. Testing (AI)
   - [ ] Unit tests
   - [ ] Integration tests
   - [ ] Verify testing loop

5. Obstacle Creation (Human)
   - [ ] Create obstacle scene:
     - Two long rectangles (vertical, green)
     - Add collider in gap for score detection
     - Add colliders to rectangles
   - [ ] Add 6 obstacle pairs to main scene with varied gap heights
   - [ ] Create screen edge collider for pipe reset

6. Game Logic (AI)
   - [ ] Create settings autoload script for game configuration (obstacle speed, etc.)
   - [ ] Implement obstacle movement (constant left speed)
   - [ ] Add obstacle reset when hitting screen edge
   - [ ] Implement collision detection and game reset

7. Score System
   - [ ] Human: Add score UI element (horizontal box container)
   - [ ] AI: Implement point accumulation for passing obstacles
   - [ ] AI: Update score display on UI

## Scene Components
- Main Scene
  - Floor (brown rectangle)
  - Player (blue circle)
  - 6x Obstacle pairs
  - Score UI
  - Screen edge colliders
- Obstacle Scene
  - Two vertical rectangles
  - Gap between rectangles
  - Score collider in gap
  - Collision detection

## Game Settings
- Obstacle movement speed
- Reset position distance
- Other game parameters
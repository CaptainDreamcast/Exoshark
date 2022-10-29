update_obstacles:
	jsr move_obstacles
	jsr update_obstacle_collisions
	jsr draw_obstacles
	rts

move_obstacles:
	lda 	SharkVelocityX
	nega	
	adda	ObstacleOffset
	adda	#2
	cmpa	#-128
	bne		move_obstacles_store
	adda	#-1
move_obstacles_store
	sta		ObstacleOffset
	
move_obstacles_over
	rts
	
	
update_obstacle_collisions:
	lda		SharkIsDead
	cmpa	#1
	beq		update_obstacle_collisions_over

	lda 	SharkPositionY
	cmpa 	#-55
	blt		update_obstacle_collisions_over
	cmpa	#-45
	bgt		update_obstacle_collisions_over
	lda		ObstacleOffset
	cmpa	#-10
	blt		update_obstacle_collisions_over
	cmpa	#117
	bgt		update_obstacle_collisions_over
	
	lda		#1
	sta 	SharkIsDead
	lda		#30
	sta		SharkIsDeadTicks
	lda		#0
	sta		SharkVelocityX
	sta		SharkAccelerationX
	
	lda 	SharkPositionX
	sta 	ParticleEffectPositionX
	lda 	SharkPositionY
	adda 	#-24
	sta 	ParticleEffectPositionY
	lda		#0
	sta		ParticleDirectionMaskX
	lda		#0
	sta		ParticleDirectionMaskY
	jsr 	add_particle_effect

update_obstacle_collisions_over	
	rts
	
	
draw_obstacles:
	lda     #-50                      ; to 0 (y)
    ldb     #-127                      ; to 0 (x)
    jsr     Moveto_d                ; move the vector beam the
	
	lda     #0                      ; to 0 (y)
    ldb     ObstacleOffset             ; to 0 (x)
    jsr     Moveto_d                ; move the vector beam the

	lda		#OBSTACLE_COUNT
	sta 	CurrentWave

draw_single_obstacle
	ldx     #obstacle_list				; load the address of the to be									; drawn vector list to X
    jsr     Draw_VLc                ; draw the line now

	lda     #0                      ; to 0 (y)
    ldb     #127                   	; to 0 (x)
    jsr     Moveto_d                ; move the vector beam the

	lda 	CurrentWave
	deca
	sta 	CurrentWave
	cmpa    #0
	bne 	draw_single_obstacle

draw_obstacles_over
	lda     #0                      ; to 0 (y)
    ldb     #-127                   ; to 0 (x)
    jsr     Moveto_d                ; move the vector beam the

	lda     #0                      ; to 0 (y)
    ldb     #-127                   ; to 0 (x)
    jsr     Moveto_d                ; move the vector beam the
	
	lda     #0                      ; to 0 (y)
    ldb     #-127                   ; to 0 (x)
    jsr     Moveto_d                ; move the vector beam the
	
	lda     #0                      ; to 0 (y)
    ldb     #-127                   ; to 0 (x)
    jsr     Moveto_d                ; move the vector beam the
	
	lda     #0                      ; to 0 (y)
    ldb     ObstacleOffset            	; to 0 (x)
	negb
    jsr     Moveto_d                ; move the vector beam the
	
	lda     #50                   ; to 0 (y)
    ldb     #127                    ; to 0 (x)
    jsr     Moveto_d                ; move the vector beam the

	rts
	rts
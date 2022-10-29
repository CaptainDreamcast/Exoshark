gamescreen:
        lda		#0
        sta 	NextUsedParticle
		sta		SharkPositionX
		sta		SharkVelocityX
		sta		SharkVelocityY
		sta		SharkAccelerationX
		sta		SharkAccelerationY
		sta		WaveOffsetX
		sta		EnemySectionVelocityX
		sta		SoundIsPlayingHitSFX
		sta		ParticleDirectionMaskX
		sta		ParticleDirectionMaskY
		sta		ObstacleOffset
		sta		SharkIsDead
		sta		SharkIsDeadTicks

        lda 	#1
        sta 	ScreenIsActive
		sta		SharkIsFacingRight
		sta		SharkIsInWater
		sta		Vec_Music_Flag
		sta		FoodActive

		lda		#50
		sta		WavePositionY

		lda		#60
		sta		FoodPositionX

		lda 	#-1
        sta 	EnemyVelocityX

		lda 	#-128
		sta 	SharkPositionY
		sta		SharkPreviousPositionY

        ldu 	#Vec_Default_Stk
        stu		StackPointer 

        ldx 	#Score
        jsr 	Clear_Score
		
		ldx		#Timer
		jsr		Clear_Score
		lda		#15
		sta		TimerValue
		jsr		Add_Score_a
		
		jsr 	load_enemies
        jsr 	load_particles
        jsr 	init_screen_time

gamescreen_loop:
		jsr		update_game_music
		jsr 	update_drawing
		jsr     Do_Sound

        jsr 	draw_game_strings
		jsr		update_waves
		jsr		update_obstacles
		jsr		update_particles
		jsr		update_enemies
		jsr		update_food
        jsr 	update_shark ; input update needs to be last
        jsr 	update_screen_time
		jsr 	update_timer

        lda 	ScreenIsActive
        cmpa 	#0
        beq		gamescreen_shutdown
        jmp     gamescreen_loop                    

gamescreen_shutdown
		lda 	#0
		sta		Vec_Music_Flag
		jsr     Clear_Sound 
		jsr     Do_Sound
        rts
Crash:
        jsr     Wait_Recal
        jmp Crash

draw_game_strings:
        lda     #20                      
        ldb     #-65                   
        jsr     Moveto_d      

        lda 	#107
        ldb 	#-100
        ldu     #Score   
        jsr     Print_Str_d  
		
		lda     #20                      
        ldb     #0                   
        jsr     Moveto_d  
		
		lda 	#107
        ldb 	#20
        ldu     #Timer   
        jsr     Print_Str_d 

draw_game_strings_over:
        rts
				
				
        include "particles.asm"
        include "shark.asm"
		include "waves.asm"
		include "enemies.asm"
		include "gamesound.asm"
		include "timer.asm"
		include "food.asm"
		include "obstacles.asm"
		include "debug.asm"
				
;***************************************************************************

shark_right_list:
        db      6                           ; number of vectors - 1
        db      12,  -24
		db      -12,  -24
		db      12,  -12
		db      -24,  0
		db      12,  12
		db      -12,  24
		db      12,  24

		
shark_left_list:
        db      6                           ; number of vectors - 1
		db      -24,  0
		db      12,  -12
		db      -12,  -24
		db      12,  -24
        db      12,  24
		db      -12,  24
		db      12,  12
	
	
wave_list:
		db      1                           ; number of vectors - 1
        db      5,  64
		db      -5,  0


obstacle_list:
		db      0                           ; number of vectors - 1
        db      0,  127


particle_offset_list:
        db      0, 10
		
		
enemy_list:
        db      9                           ; number of vectors - 1
		db      0,  -12
		db      -24,  0
		db      0,  24
		db      24,  0
		db      0,  -12
		db      12,  0
		db      12,  -12
		db      12,  12
		db      -12,  12
		db      -12,  -12

food_list:
		db      3                           ; number of vectors - 1
        db      -6,  -6
		db      -6,  6
		db      6,  6
		db      6,  -6
		
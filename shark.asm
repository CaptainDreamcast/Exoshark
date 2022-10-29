; No params
update_shark
		lda 	SharkIsDead
		cmpa 	#1
		beq		update_shark_death_start

        jsr draw_shark

		lda SharkIsInWater
		cmpa #0
		bne update_shark_water_jump
		jsr update_shark_air
		jmp update_shark_water_jump_over

update_shark_water_jump
		jsr update_shark_water
update_shark_water_jump_over

		jsr waterstate_shark
		jmp update_shark_over
update_shark_death_start
		jsr update_shark_death
		
update_shark_over
		rts
		

update_shark_death
		lda		SharkIsDeadTicks
		deca
		sta		SharkIsDeadTicks
		cmpa	#0
		bne		update_shark_death_over
		
		lda		#3
		sta		CurrentScreen
		lda		#0
		sta		ScreenIsActive
		
update_shark_death_over		
		rts
		
		
; No params
waterstate_shark

waterstate_shark_out_check
		lda SharkPositionY
		bmi waterstate_shark_over
		
		suba #50
		bmi waterstate_shark_in_check
		
		lda SharkPreviousPositionY
		suba #50
		bpl waterstate_shark_over
		
		lda SharkPositionX
		sta ParticleEffectPositionX
		lda SharkPositionY
		adda #-24
		sta ParticleEffectPositionY
		lda	#0
		sta	ParticleDirectionMaskX
		lda	#1
		sta	ParticleDirectionMaskY
		jsr add_particle_effect
		
		lda #0
		sta SharkIsInWater
		
		jmp waterstate_shark_over

waterstate_shark_in_check

		lda SharkPreviousPositionY
		suba #50
		bmi waterstate_shark_over
		
		lda SharkPositionX
		sta ParticleEffectPositionX
		lda SharkPositionY
		adda #-24
		sta ParticleEffectPositionY
		lda	#0
		sta	ParticleDirectionMaskX
		lda	#2
		sta	ParticleDirectionMaskY
		jsr add_particle_effect
		
		lda #1
		sta SharkIsInWater

waterstate_shark_over		
		rts


; No params
update_shark_air
		jsr physics_shark_air
		rts
		
		
; No params
physics_shark_air	
		lda SharkPositionY
		sta SharkPreviousPositionY
		adda SharkVelocityY
		sta SharkPositionY
		
		dec SharkVelocityY
		
		rts
		

; No params
update_shark_water
		jsr input_shark_water
		jsr physics_shark_water
		rts

; No params
physics_shark_water		
physics_shark_water_drag
physics_shark_water_drag_x
		lda SharkVelocityX
		bgt physics_shark_water_drag_right
		blt physics_shark_water_drag_left
		jmp physics_shark_water_drag_x_over
physics_shark_water_drag_left
		adda #1
		sta SharkVelocityX
		jmp physics_shark_water_drag_x_over
physics_shark_water_drag_right
		adda #-1
		sta SharkVelocityX
physics_shark_water_drag_x_over
physics_shark_water_drag_y
		lda SharkVelocityY
		bgt physics_shark_water_drag_down
		blt physics_shark_water_drag_up
		jmp physics_shark_water_drag_y_over
physics_shark_water_drag_up
		adda #1
		sta SharkVelocityY
		jmp physics_shark_water_drag_y_over
physics_shark_water_drag_down
		adda #-1
		sta SharkVelocityY
physics_shark_water_drag_y_over
		
		jsr physics_shark_general
		
		rts
		

; No params
physics_shark_general
		lda SharkPositionY
		sta SharkPreviousPositionY
		adda SharkVelocityY
		bvs physics_shark_general_y_st_cl
		sta SharkPositionY
		jmp physics_shark_general_y_st_o
physics_shark_general_y_st_cl
		lda	#-128
		sta	SharkPositionY
physics_shark_general_y_st_o
		lda SharkVelocityY
		adda SharkAccelerationY
		sta SharkVelocityY
		lda #0
		sta SharkAccelerationY
		
		lda SharkVelocityX
		adda SharkAccelerationX
		sta SharkVelocityX
		lda #0
		sta SharkAccelerationX
	rts

; No params
input_shark_water
		jsr input_shark_x
		jsr input_shark_y
	rts

; No params
input_shark_x
		jsr     Joy_Digital             ; read joystick positions
        lda     Vec_Joy_1_X             ; load joystick 1 position

        ; X to A
        beq     input_shark_no_x_movement           ; if zero, than no x position
        bmi     input_shark_left_move               ; if negative, than left
        ; otherwise right
input_shark_right_move:
        lda		SharkAccelerationX
        adda 	#1
		sta		SharkAccelerationX		

		lda ScreenTicks
		anda #7
		bne input_shark_right_double_acc_o
		lda		SharkAccelerationX
        adda 	#1
		sta		SharkAccelerationX	
input_shark_right_double_acc_o:	

		lda		#1
		sta		SharkIsFacingRight
        jmp	input_shark_after_x_move

input_shark_left_move:
        lda		SharkAccelerationX
        adda 	#-1
		sta		SharkAccelerationX		

		lda ScreenTicks
		anda #7
		bne input_shark_left_double_acc_o
		lda		SharkAccelerationX
        adda 	#-1
		sta		SharkAccelerationX	
input_shark_left_double_acc_o:	
		
		lda		#0
		sta		SharkIsFacingRight
        jmp	input_shark_after_x_move
				
input_shark_no_x_movement:
input_shark_after_x_move:
		rts
	
	
; No params
input_shark_y
		jsr     Joy_Digital             ; read joystick positions
        lda     Vec_Joy_1_Y             ; load joystick 1 position

        ; X to A
        beq     input_shark_no_y_movement           ; if zero, than no y position
        bmi     input_shark_up_move               ; if negative, than up
        ; otherwise down
input_shark_down_move:
        lda		SharkAccelerationY
        adda 	#1
		sta		SharkAccelerationY		
		lda ScreenTicks
		anda #3
		bne input_shark_down_double_acc_o
		lda		SharkAccelerationY
        adda 	#1
		sta		SharkAccelerationY	
input_shark_down_double_acc_o:	
        jmp	input_shark_after_y_move

input_shark_up_move:
        lda		SharkAccelerationY
        adda 	#-1
		sta		SharkAccelerationY		
		lda ScreenTicks
		anda #3
		bne input_shark_up_double_acc_o
		lda		SharkAccelerationY
        adda 	#-1
		sta		SharkAccelerationY	
input_shark_up_double_acc_o:	
        jmp	input_shark_after_y_move
				
input_shark_no_y_movement:
input_shark_after_y_move:
		rts

		
; No params
draw_shark
		lda     #0                      ; to 0 (y)
        ldb     #32                      ; to 0 (x)
        jsr     Moveto_d                ; move the vector beam the
        ; relative position
                                
        lda		SharkPositionY
        ldb     SharkPositionX                   ; to 0 (x)

        jsr     Moveto_d                ; move the vector beam the
        ; relative position

		lda 	SharkIsFacingRight
		cmpa 	#0
		beq 	draw_shark_left

draw_shark_right
        ldx     #shark_right_list				; load the address of the to be
        jsr     Draw_VLc                ; draw the line now
        ; drawn vector list to X
		jmp 	draw_shark_vector_over
draw_shark_left
		lda     #12                      ; to 0 (y)
        ldb     #0                      ; to 0 (x)
        jsr     Moveto_d                ; move the vector beam the
		
		ldx     #shark_left_list				; load the address of the to be
        jsr     Draw_VLc                ; draw the line now
		
		lda     #-12                      ; to 0 (y)
        ldb     #0                      ; to 0 (x)
        jsr     Moveto_d                ; move the vector beam the
		
        ; drawn vector list to X
draw_shark_vector_over                        
        lda		SharkPositionY
        ldb     SharkPositionX     
        nega
        negb
        jsr     Moveto_d               

        lda     #0                      
        ldb     #-32                    
        jsr     Moveto_d 

		rts
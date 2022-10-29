update_food:	
	lda 	FoodActive
	cmpa 	#1
	bne		update_food_exist_over
	
	jsr update_food_position
	jsr update_food_collision
	jsr draw_food
	jmp update_food_over
	
update_food_exist_over
	jsr update_food_activation

update_food_over
	rts
	

update_food_activation:
	lda		SharkIsInWater
	cmpa	#1
	beq		update_food_activation_over
	lda		#1
	sta		FoodActive
	lda 	#60
	sta		FoodPositionX
	
update_food_activation_over
	rts
	
	
draw_food:
	
	lda		#-122
    ldb     FoodPositionX                  

    jsr     Moveto_d                
	ldx     #food_list				
    jsr     Draw_VLc 
	
	lda		#122
    ldb     FoodPositionX                  
	negb

    jsr     Moveto_d 
	
	rts
	
	
update_food_position:
	lda 	SharkVelocityX
	nega
	adda	FoodPositionX
	sta		FoodPositionX
	rts
	
	
update_food_collision:
	lda		FoodPositionX
	cmpa 	#-20
	blt		update_food_collision_over
	cmpa 	#20
	bgt		update_food_collision_over
	lda		SharkPositionY
	cmpa	#-118
	bgt		update_food_collision_over
	
	lda 	#0
	sta		FoodActive
	
	lda		TimerValue
	adda	#3
	sta		TimerValue
		
	lda		#3
	ldx     #Timer
    jsr     Add_Score_a
	
update_food_collision_over
	rts
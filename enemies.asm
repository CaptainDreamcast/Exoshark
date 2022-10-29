load_enemies:
        lda     #MAX_ENEMY_AMOUNT
        sta     CurrentEnemy

load_enemy_loop
        dec     CurrentEnemy
        jsr     load_single_enemy

        lda     CurrentEnemy
        cmpa    #0x0
        bne     load_enemy_loop

        rts

load_single_enemy
        lda     CurrentEnemy
        ldx     #EnemyActive
        ldb     #0
        stb     a,x

        rts

update_enemies:
        jsr     update_adding_enemies
        jsr     update_moving_enemies
        jsr     draw_enemies
        jsr     update_collisions

        rts
			
update_collisions
        lda     #MAX_ENEMY_AMOUNT
        sta     CurrentEnemy

update_collisions_loop
        dec     CurrentEnemy
        jsr     update_single_collision

        lda     CurrentEnemy
        cmpa    #0x0
        bne     update_collisions_loop

        rts

update_single_collision
        lda     CurrentEnemy
        ldx     #EnemyActive
        lda     a,x
        cmpa    #0
        beq     update_single_collision_over
		
		lda     CurrentEnemy
        ldx     #EnemySectionX
        lda     a,x
        cmpa    #0
        bne     update_single_collision_over

        lda     SharkIsInWater
        cmpa    #1
        beq     update_single_collision_over

        lda     CurrentEnemy
        ldx     #EnemyPositionX
        lda     a,x

        ldb     SharkPositionX
        addb    #25
        stb     TestPosition
        cmpa    TestPosition
        bge     update_single_collision_over

        lda     CurrentEnemy
        ldx     #EnemyPositionX
        lda     a,x

        ldb     SharkPositionX
        addb    #-25
        stb     TestPosition
        cmpa    TestPosition
        ble     update_single_collision_over

        lda     CurrentEnemy
        ldx     #EnemyPositionY
        lda     a,x

        ldb     SharkPositionY
        addb    #5
        stb     TestPosition
        cmpa    TestPosition
        bge     update_single_collision_over

        lda     CurrentEnemy
        ldx     #EnemyPositionY
        lda     a,x

        ldb     SharkPositionY
        addb    #-10
        stb     TestPosition
        cmpa    TestPosition
        ble     update_single_collision_over

        ldb     #0
        lda     CurrentEnemy
        ldx     #EnemyActive
        stb     a,x

        jsr		single_collision_after_effects
			
update_single_collision_over
        rts
		
single_collision_after_effects:
		lda     CurrentEnemy
        ldx     #EnemyPositionX
        lda     a,x
		sta 	ParticleEffectPositionX
		ldb     CurrentEnemy
        ldx     #EnemyPositionY
        ldb     b,x
		stb 	ParticleEffectPositionY
		lda		#0
		sta		ParticleDirectionMaskX
		lda		#0
		sta		ParticleDirectionMaskY
		jsr 	add_particle_effect
		jsr		play_hit_sfx
        jsr     increase_score
		
		rts
				
increase_score
        lda     #1
        ldx     #Score
        jsr     Add_Score_a

        rts

update_adding_enemies:
        lda     #MAX_ENEMY_AMOUNT
        sta     CurrentEnemy


update_adding_enemy_loop
        dec     CurrentEnemy
        jsr     update_adding_single_enemy

        lda     CurrentEnemy
        cmpa    #0x0
        bne     update_adding_enemy_loop

        rts

update_adding_single_enemy
        lda     CurrentEnemy
        ldx     #EnemyActive
        lda     a,x

        cmpa    #0
        bne     adding_single_enemy_over

        jsr     Random
        cmpa    #-125
        bgt     adding_single_enemy_over

		ldb     #1	
        lda     CurrentEnemy
        ldx     #EnemySectionX
        stb     a,x

        ldb     #100
        lda     CurrentEnemy
        ldx     #EnemyPositionX
        stb     a,x

        ldb     #90
        lda     CurrentEnemy
        ldx     #EnemyPositionY
        stb     a,x

        ldb     #1
        lda     CurrentEnemy
        ldx     #EnemyActive
        stb     a,x				

adding_single_enemy_over
        rts
				
update_moving_enemies:
        lda     #MAX_ENEMY_AMOUNT
        sta     CurrentEnemy

		lda		SharkVelocityX
		nega
		sta 	EnemyVelocityX

update_moving_enemy_loop
        dec     CurrentEnemy
        jsr     update_moving_single_enemy

        lda     CurrentEnemy
        cmpa    #0x0
        bne     update_moving_enemy_loop

        rts
				
update_moving_single_enemy
        lda     CurrentEnemy
        ldx     #EnemyActive
        lda     a,x
        cmpa    #0
        beq     update_moving_enemy_over

        lda     CurrentEnemy
        ldx     #EnemyPositionX
        lda     a,x

        adda    EnemyVelocityX
		bvc		move_enemy_other_section_over
		
		ldb		EnemyVelocityX
		bmi		move_enemy_section_right_over
		ldb		#1
		stb		EnemySectionVelocityX
		jmp		move_enemy_section_left_over
move_enemy_section_right_over
		ldb		#-1
		stb		EnemySectionVelocityX
move_enemy_section_left_over
move_enemy_other_section_over

        ldb     CurrentEnemy
        ldx     #EnemyPositionX
        sta     b,x
		
		ldb     CurrentEnemy
        ldx     #EnemySectionX
        lda     b,x
		adda	EnemySectionVelocityX
		sta		b,x

		cmpa	#-2
		beq		move_enemy_remove
		cmpa 	#2
		beq 	move_enemy_remove
		jmp		move_enemy_remove_over
		
move_enemy_remove
		lda     CurrentEnemy
        ldx     #EnemyActive
		ldb		#0
        stb     a,x
move_enemy_remove_over		
		lda		#0
		sta		EnemySectionVelocityX

update_moving_enemy_over				
        rts		

draw_enemies:
        lda     #MAX_ENEMY_AMOUNT
        sta     CurrentEnemy

        lda     #30
        ldb     #0
        jsr     Moveto_d

draw_enemy_loop
        dec     CurrentEnemy
        jsr     draw_single_enemy

        lda     CurrentEnemy
        cmpa    #0x0
        bne     draw_enemy_loop

        lda     #-30
        ldb     #0
        jsr     Moveto_d

        rts


draw_single_enemy

        lda     CurrentEnemy
        ldx     #EnemyActive
        lda     a,x
        cmpa    #0
        beq     draw_single_enemy_over

		lda     CurrentEnemy
        ldx     #EnemySectionX
        lda     a,x
        cmpa    #0
        bne     draw_single_enemy_over

        lda     CurrentEnemy
        ldy     #EnemyPositionY
        lda     a,y

        ldb     CurrentEnemy
        ldx     #EnemyPositionX
        ldb     b,x

        jsr     Moveto_d
		
		ldx     #enemy_list
        jsr     Draw_VLc
		
		lda 	#-12
		ldb 	#0
        jsr     Moveto_d

        lda     CurrentEnemy
        ldy     #EnemyPositionY
        lda     a,y
        nega

        ldb     CurrentEnemy
        ldx     #EnemyPositionX
        ldb     b,x
        negb

        jsr     Moveto_d



draw_single_enemy_over
        rts
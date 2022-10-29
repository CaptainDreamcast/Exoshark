; No params
update_waves
	jsr move_waves
	jsr draw_waves
	rts


; No params	
move_waves
	lda 	SharkVelocityX
	nega	
	adda	WaveOffsetX
	sta		WaveOffsetX
	cmpa 	#0
	bge		move_waves_left
	cmpa	#-64
	bge		move_waves_over
	
move_waves_right
	lda		WaveOffsetX
	adda	#64
	sta		WaveOffsetX
	jmp 	move_waves_over
	
move_waves_left
	lda		WaveOffsetX
	adda	#-64
	sta		WaveOffsetX
	
move_waves_over
	
	rts

	
; No params
draw_waves
	lda     WavePositionY                      ; to 0 (y)
    ldb     #-127                      ; to 0 (x)
    jsr     Moveto_d                ; move the vector beam the
	
	lda     #0                      ; to 0 (y)
    ldb     WaveOffsetX             ; to 0 (x)
    jsr     Moveto_d                ; move the vector beam the

	lda		#WAVE_COUNT
	sta 	CurrentWave

draw_single_wave
	ldx     #wave_list				; load the address of the to be									; drawn vector list to X
    jsr     Draw_VLc                ; draw the line now

	lda 	CurrentWave
	deca
	sta 	CurrentWave
	cmpa    #0
	bne 	draw_single_wave

draw_waves_over
	lda     #0                      ; to 0 (y)
    ldb     #-128                   ; to 0 (x)
    jsr     Moveto_d                ; move the vector beam the

	lda     #0                      ; to 0 (y)
    ldb     #-128                   ; to 0 (x)
    jsr     Moveto_d                ; move the vector beam the
	
	lda     #0                      ; to 0 (y)
    ldb     #-64                   ; to 0 (x)
    jsr     Moveto_d                ; move the vector beam the
	
	lda     #0                      ; to 0 (y)
    ldb     WaveOffsetX            	; to 0 (x)
	negb
    jsr     Moveto_d                ; move the vector beam the
	
	lda     WavePositionY                   ; to 0 (y)
	nega
    ldb     #127                    ; to 0 (x)
    jsr     Moveto_d                ; move the vector beam the

	rts
update_timer:
	lda		ScreenTicks
	cmpa	#0
	bne		update_timer_over
	
	lda		TimerValue
	cmpa	#0
	bne		gameover_over
	
	lda 	#0
	sta 	ScreenIsActive
	lda		#3
	sta		CurrentScreen
	
gameover_over

	dec		TimerValue
	ldx		#Timer
	jsr		Clear_Score
	
	lda		TimerValue
	jsr 	Add_Score_a

update_timer_over
	rts
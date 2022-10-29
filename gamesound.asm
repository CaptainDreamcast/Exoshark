update_game_music:
restart_music
	lda		Vec_Music_Flag
	cmpa	#0
	bne		restart_music_over
	
	lda		#1
	sta		Vec_Music_Flag
	lda 	#0
	sta		SoundIsPlayingHitSFX

restart_music_over
	jsr     DP_to_C8    
	lda		SoundIsPlayingHitSFX
	cmpa	#1
	beq		update_music_1
update_music_3
    ldu     #music3                 
	jmp update_music_sel_over
update_music_1
    ldu     #music1                
update_music_sel_over
    jsr     Init_Music_chk
	rts
	
	
play_hit_sfx:
	lda 	#1
	sta		SoundIsPlayingHitSFX
	sta		Vec_Music_Flag
	rts
storyscreen:
	
        jsr     init_screen_time
        jsr     init_title_stars
		
		lda 	#0
		sta 	StoryLineStart
		
		lda 	#10
		sta		StoryLineOffset
		
		lda		#0
		sta		SharkVelocityX
		sta		WaveOffsetX
		
		lda		#-110
		sta		WavePositionY

storyscreen_loop:

        jsr     update_drawing
		jsr 	update_story
		jsr		update_waves
        jsr     draw_story
        jsr     draw_title_stars

        jsr     update_screen_time

        jsr     read_button1_flank
        cmpa    #0
        bne     storyscreen_shutdown
		lda		StoryLineStart
		cmpa 	#9
		beq 	storyscreen_shutdown

        jmp     storyscreen_loop

storyscreen_shutdown
        lda     #1
        sta     CurrentScreen
        rts


update_story:
update_story_movement
		lda 	ScreenTicks
		anda	#7
		cmpa	#7
		bne		update_story_movement_over
		inc 	StoryLineOffset
update_story_movement_over
update_story_line_shown
		lda 	ScreenTicks
		cmpa	#59
		bne		update_story_line_shown_over
		lda		ScreenSeconds
		anda	#1
		cmpa	#0
		bne		update_story_line_shown_over
		inc 	StoryLineStart
update_story_line_shown_over
		rts


draw_story
draw_story_line_0
		lda		StoryLineStart
		cmpa	#0
		bgt		draw_story_line_1
        lda     StoryLineOffset                      
        ldb     #-127                   
        jsr     Moveto_d  		
        ldu     #story_line_0   
        jsr     Print_Str_yx  

draw_story_line_1
		lda		StoryLineStart
		cmpa	#1
		bgt		draw_story_line_2
		lda     StoryLineOffset                      
        ldb     #-127                   
        jsr     Moveto_d  
		lda     #-15                      
        ldb     #0                   
        jsr     Moveto_d       
        ldu     #story_line_1     
        jsr     Print_Str_yx  

draw_story_line_2
		lda		StoryLineStart
		cmpa	#2
		bgt		draw_story_line_3
		lda     StoryLineOffset                      
        ldb     #-127                   
        jsr     Moveto_d  
		lda     #-30                      
        ldb     #0                   
        jsr     Moveto_d        
        ldu     #story_line_2     
        jsr     Print_Str_yx  

draw_story_line_3
		lda		StoryLineStart
		cmpa	#3
		bgt		draw_story_line_4
		lda     StoryLineOffset                      
        ldb     #-127                   
        jsr     Moveto_d  
		lda     #-45                      
        ldb     #0                   
        jsr     Moveto_d        
        ldu     #story_line_3     
        jsr     Print_Str_yx

draw_story_line_4
		lda		StoryLineStart
		cmpa	#4
		bgt		draw_story_line_5
		lda     StoryLineOffset                      
        ldb     #-127                   
        jsr     Moveto_d  
		lda     #-60                      
        ldb     #0                   
        jsr     Moveto_d        
        ldu     #story_line_4     
        jsr     Print_Str_yx	

draw_story_line_5
		lda		StoryLineStart
		cmpa	#5
		bgt		draw_story_line_6
		lda     StoryLineOffset                      
        ldb     #-127                   
        jsr     Moveto_d  
		lda     #-75                      
        ldb     #0                   
        jsr     Moveto_d        
        ldu     #story_line_5     
        jsr     Print_Str_yx

draw_story_line_6
		lda		StoryLineStart
		cmpa	#0
		lble	draw_story_over
		cmpa	#6
		bgt		draw_story_line_7
		lda     StoryLineOffset                      
        ldb     #-127                   
        jsr     Moveto_d  
		lda     #-90                      
        ldb     #0                   
        jsr     Moveto_d        
        ldu     #story_line_6     
        jsr     Print_Str_yx

draw_story_line_7	
		lda		StoryLineStart
		cmpa	#1
		lble	draw_story_over
		cmpa	#7
		bgt		draw_story_line_8	
		lda     StoryLineOffset                      
        ldb     #-127                   
        jsr     Moveto_d  
		lda     #-105                      
        ldb     #0                   
        jsr     Moveto_d        
        ldu     #story_line_7     
        jsr     Print_Str_yx

draw_story_line_8
		lda		StoryLineStart
		cmpa	#2
		lble	draw_story_over
		cmpa	#8
		bgt		draw_story_line_9
		lda     StoryLineOffset                      
        ldb     #-127                   
        jsr     Moveto_d  
		lda     #-120                      
        ldb     #0                   
        jsr     Moveto_d        
        ldu     #story_line_8     
        jsr     Print_Str_yx
	
draw_story_line_9
		lda		StoryLineStart
		cmpa	#3
		lble	draw_story_over
		cmpa	#9
		bgt		draw_story_line_10
		lda     StoryLineOffset                      
        ldb     #-127                   
        jsr     Moveto_d  
		lda     #-120                      
        ldb     #0                   
        jsr     Moveto_d
		lda     #-15                      
        ldb     #0                   
        jsr     Moveto_d        
        ldu     #story_line_9     	
        jsr     Print_Str_yx

draw_story_line_10
		lda		StoryLineStart
		cmpa	#4
		lble	draw_story_over
		cmpa	#10
		bgt		draw_story_line_11
		lda     StoryLineOffset                      
        ldb     #-127                   
        jsr     Moveto_d  
		lda     #-120                      
        ldb     #0                   
        jsr     Moveto_d
		lda     #-30                      
        ldb     #0                   
        jsr     Moveto_d        
        ldu     #story_line_10     
        jsr     Print_Str_yx

draw_story_line_11
		lda		StoryLineStart
		cmpa	#5
		lble	draw_story_over
		cmpa	#11
		bgt		draw_story_line_12
		lda     StoryLineOffset                      
        ldb     #-127                   
        jsr     Moveto_d  
		lda     #-120                      
        ldb     #0                   
        jsr     Moveto_d
		lda     #-45                      
        ldb     #0                   
        jsr     Moveto_d        
        ldu     #story_line_11     
        jsr     Print_Str_yx
		
draw_story_line_12
		lda		StoryLineStart
		cmpa	#6
		lble	draw_story_over
		cmpa	#12
		bgt		draw_story_over
		lda     StoryLineOffset                      
        ldb     #-127                   
        jsr     Moveto_d  
		lda     #-120                      
        ldb     #0                   
        jsr     Moveto_d
		lda     #-60                      
        ldb     #0                   
        jsr     Moveto_d        
        ldu     #story_line_12     
        jsr     Print_Str_yx
		
draw_story_over
        rts

	

story_line_0: 
        db      0, 0, "EXOCOETIDAE.", $80
story_line_1: 
        db      0, 0, "THE FLYING FISH OF", $80
story_line_2: 
        db      0, 0, "BARBADOS.", $80
story_line_3: 
        db      0, 0, "A FREAK ACCIDENT HAS", $80
story_line_4: 
        db      0, 0, "LED TO THEM", $80
story_line_5: 
        db      0, 0, "CROSSBREEDING WITH A", $80
story_line_6: 
        db      0, 0, "GREAT WHITE SHARK.", $80
story_line_7: 
        db      0, 0, "RESULT: THE FIRST", $80
story_line_8: 
        db      0, 0, "FLYING FISH PREDATOR", $80
story_line_9: 
        db      0, 0, "IN HISTORY.", $80
story_line_10: 
        db      0, 0, "...", $80
story_line_11: 
        db      0, 0, "...", $80		
story_line_12: 
        db      0, 0, "EXOSHARK!", $80				
				
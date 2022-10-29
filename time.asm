init_screen_time
        lda     #0
        sta     ScreenTicks
        sta     ScreenSeconds
        sta     ScreenMinutes
        rts


				
update_screen_time
        inc     ScreenTicks
        lda     ScreenTicks
        cmpa    #60
        bne     update_screen_seconds_over

        lda     #0
        sta     ScreenTicks
        inc     ScreenSeconds

update_screen_seconds_over
        lda     ScreenSeconds
        cmpa    #60
        bne     update_screen_minutes_over

        lda     #0
        sta     ScreenSeconds
        inc     ScreenMinutes

update_screen_minutes_over
        rts

				
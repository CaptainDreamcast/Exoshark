        include "../addons/prism/other/vectrex/wrapperdata.I"

MAX_ENEMY_AMOUNT 				equ 2
MAX_PARTICLE_EFFECT_AMOUNT 		equ 2
SINGLE_PARTICLE_EFFECT_AMOUNT 	equ 10
WAVE_COUNT 						equ 5
OBSTACLE_COUNT					equ 2

CurrentEffect	  			equ GameDataStart
CurrentParticle 			equ (CurrentEffect + 2)
NextUsedParticle			equ (CurrentParticle + 2)
ParticleActive				equ (NextUsedParticle + 2)
ParticlePositionX			equ (ParticleActive + 2*(MAX_PARTICLE_EFFECT_AMOUNT*SINGLE_PARTICLE_EFFECT_AMOUNT))
ParticlePositionY			equ (ParticlePositionX + 2*(MAX_PARTICLE_EFFECT_AMOUNT*SINGLE_PARTICLE_EFFECT_AMOUNT))
ParticleVelocityX			equ (ParticlePositionY + 2*(MAX_PARTICLE_EFFECT_AMOUNT*SINGLE_PARTICLE_EFFECT_AMOUNT))
ParticleVelocityY			equ (ParticleVelocityX + 2*(MAX_PARTICLE_EFFECT_AMOUNT*SINGLE_PARTICLE_EFFECT_AMOUNT))
ParticleTime				equ (ParticleVelocityY + 2*(MAX_PARTICLE_EFFECT_AMOUNT*SINGLE_PARTICLE_EFFECT_AMOUNT))
ParticleEffectPositionX		equ (ParticleTime + 2*(MAX_PARTICLE_EFFECT_AMOUNT*SINGLE_PARTICLE_EFFECT_AMOUNT))
ParticleEffectPositionY		equ (ParticleEffectPositionX + 2)
ParticleDirectionMaskX		equ (ParticleEffectPositionY + 2)
ParticleDirectionMaskY		equ (ParticleDirectionMaskX + 2)
ParticleSentinel			equ (ParticleDirectionMaskY + 2)

SharkPositionX			equ (ParticleSentinel)
SharkPositionY			equ (SharkPositionX + 2)
SharkPreviousPositionY	equ (SharkPositionY + 2)
SharkVelocityX			equ (SharkPreviousPositionY + 2)
SharkVelocityY			equ (SharkVelocityX + 2)
SharkAccelerationX		equ (SharkVelocityY + 2)
SharkAccelerationY		equ (SharkAccelerationX + 2)
SharkIsFacingRight		equ (SharkAccelerationY + 2)
SharkIsInWater			equ (SharkIsFacingRight + 2)
SharkIsDead				equ (SharkIsInWater + 2)
SharkIsDeadTicks		equ (SharkIsDead + 2)
SharkSentinel			equ (SharkIsDeadTicks + 2)

CurrentWave			equ (SharkSentinel)
WaveOffsetX			equ (CurrentWave + 2)
WavePositionY		equ (WaveOffsetX + 2)
WaveSentinel		equ (WavePositionY + 2)

EnemyAmount 	    	equ	 (WaveSentinel)
EnemyActive 	    	equ	 (EnemyAmount + 2)
EnemySectionX			equ  (EnemyActive + 2*MAX_ENEMY_AMOUNT)
EnemyPositionX			equ  (EnemySectionX + 2*MAX_ENEMY_AMOUNT)
EnemyPositionY			equ  (EnemyPositionX + 2*MAX_ENEMY_AMOUNT)
EnemyVelocityX			equ  (EnemyPositionY + 2*MAX_ENEMY_AMOUNT)
CurrentEnemy			equ  (EnemyVelocityX + 2*MAX_ENEMY_AMOUNT)
EnemySectionVelocityX	equ  (CurrentEnemy + 2)
EnemySentinel			equ  (EnemySectionVelocityX + 2)

SoundIsPlayingHitSFX	equ   (EnemySentinel)
SoundSentinel			equ   (SoundIsPlayingHitSFX + 2)

StoryLineStart			equ (SoundSentinel)
StoryLineOffset			equ (StoryLineStart + 2)
StorySentinel			equ (StoryLineOffset + 2)

FoodPositionX			equ (StorySentinel)
FoodActive				equ (FoodPositionX + 2)
FoodSentinel			equ (FoodActive + 2)

ObstacleOffset		equ	(FoodSentinel)
ObstacleSentinel	equ (ObstacleOffset + 2)

CurrentScreen		equ (ObstacleSentinel)
ScreenIsActive		equ (CurrentScreen + 2)
ScreenTicks			equ (ScreenIsActive + 2)
ScreenSeconds		equ (ScreenTicks + 2)
ScreenMinutes		equ (ScreenSeconds + 2)
TimerValue			equ (ScreenMinutes + 2)
Score				equ (TimerValue + 2)
Timer				equ (Score + 10)
GameLogicSentinel	equ (Timer + 10)

StackPointer 		equ (GameLogicSentinel)
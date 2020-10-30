  processor 6502

  seg code
  org $F000   ; define the code origin at $F000

Start:
  sei      ; disable interrupts
  cld      ; disalbe the BCD decimal math mode
  ldx #$FF   ; loads the X register with #$FF
  txs      ; transfer X register to S(tack) register

;Clear the Zero Page register ($00 to #$FF)
  lda #00   ;A = 0
  ldx #$FF ;X = #$FF
  sta $FF   ; make sure $FF is zero before the loop starts
MemeLoop:
  dex       ; X--
  sta $0,X ; store zero at address $0 + X
  bne MemeLoop ; loop until x==0 (z-flag set)

; Fill ROM size to exactly 4KB
  org $FFFC
  .word Start  ; reset vector at $FFFC
  .word Start  ; interrupt vector at $FFFE(unused in VCS)

  
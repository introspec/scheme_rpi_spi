(load "rpi-spi")

(define spi-make-flash-cmd
  (lambda (cmd)
    (lambda (s) 
      (spi-issue-cmd (spi-make-cmd s cmd)))))

(define spi-cmd-flash-id 		
  (lambda ()
    (spi-issue-cmd (u8vector #x9F 0 0 0))))

(define spi-cmd-flash-chip-erase
  (lambda ()
    (spi-issue-cmd (u8vector #x60))))

(define spi-cmd-flash-write-enable 	
  (lambda ()
    (spi-issue-cmd (u8vector #x06))))

(define spi-cmd-flash-write-disable 	
  (lambda ()
    (spi-issue-cmd (u8vector #x04))))

(define spi-cmd-flash-read-status1	
  (lambda ()
    (spi-issue-cmd (u8vector #x05 0))))

(define spi-cmd-flash-read-status2
  (lambda ()
    (spi-issue-cmd (u8vector #x35 0))))

(define spi-cmd-flash-write-status
  (lambda ()
    (spi-issue-cmd (u8vector #x01 0 0))))


;;
;; Hardcoded - 24 Bit Addressing

(define extract-addr-byte 
  (lambda (x pos) (bitwise-and (fxshr x (* pos 8)) #xFF)))

(define spi-flash-cmd-generic-addr-in
  (lambda (cmd addr len)
    (let ([v (make-u8vector (+ 4 len))])
      (begin 
	(u8vector-set! v 0 cmd)
	(u8vector-set! v 1 (extract-addr-byte addr 2))
	(u8vector-set! v 2 (extract-addr-byte addr 1))
	(u8vector-set! v 3 (extract-addr-byte addr 0))
	v))))

(define spi-cmd-flash-read
  (lambda (addr len)
    (spi-issue-cmd (spi-flash-cmd-generic-addr-in #x03 addr len))))


(define-fungible-token magic-beans)

(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-amount-zero (err u101))

(define-public (mint (amount uint) (who principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    ;; #[allow(unchecked_data)]
    (ft-mint? magic-beans amount who)
  )
)

(define-public (transfer (amount uint) (sender principal) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender sender) err-owner-only)
    (asserts! (> amount u0) err-amount-zero)
    ;; recipient is unchecked, anyone can transfer their tokens to anyone else
    ;; #[allow(unchecked_data)]
    (ft-transfer? magic-beans amount sender recipient)
  )
)

(define-read-only (get-balance (who principal))
  (ft-get-balance magic-beans who)
)
;; ST2RC7FMFZWK24RERQ40SD6H2TE6HZ6WT2G4ZE4A3.magic-beans
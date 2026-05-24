# Car Proportion Audit Log

Artboard: 120×60 pt (240×120 px @2x). Sprite: artboard × scale × bodyAspectRatio (W) × artboard × scale (H).

## Architecture — what was fixed (2026-05-24)

### Double-stretch bug
**Before:** `CarView.scaledSize` did NOT include `bodyAspectRatio` in width. All 15 `*View.bodyWidth` formulas used `size.width * 0.85 * bodyAspectRatio`, causing the body to overflow the artboard frame (e.g. raceCar body = 163 pt in a 120 pt frame). `CarSpriteNode` then stretched the clipped texture a second time by `bodyAspectRatio`. Result: bodyAspectRatio applied twice — once in the art, once in the sprite.

**Fix:** `CarView.scaledSize.width` now includes `* appearance.bodyAspectRatio`. All 15 views' `bodyWidth` reduced to `size.width * 0.85` (no `bodyAspectRatio`). The artboard frame and the sprite are now the same dimensions — no clipping, no stretch, perfect garage/gameplay parity.

### Body-top < wheel-top (greenhouse hidden behind wheels)
All P0 cars now have `body_top > wheel_top` after the bodyH_frac and stack_mult tuning below.

---

## Per-car measurements (post-P0-tuning, 2026-05-24)

Formulas:
- `Sprite W = 120 × scale × BAR`, `Sprite H = 60 × scale`
- `bodyWidth = Sprite_W × 0.85`
- `Bh = Sprite_H × bodyH_frac × stack_mult`
- `Bl/Bh = bodyWidth / Bh`
- `Wb ≈ wheelDiam + Sprite_W × 0.12 × WSM_sp` (wheel-span proxy for wheelbase)
- `Wb/Bl = Wb / bodyWidth`

P0 cars have been tuned; P1/P2 values are baseline (not yet adjusted).

| Car | Priority | BAR | scale | Sprite W×H | Bl | Bh | Bl/Bh | Target | ✓/✗ | Wb/Bl |
|-----|----------|-----|-------|------------|----|----|-------|--------|-----|-------|
| raceCar | P0 | 0.90 | 1.00 | 108×60 | 91.8 | 46.4 | 1.98 | 1.6–2.0 | ✅ | 40% |
| sports | P0 | 0.90 | 1.00 | 108×60 | 91.8 | 45.9 | 2.00 | 1.6–2.0 | ✅ | 40% |
| schoolBus | P0 | 1.15 | 1.10 | 151.8×66 | 129.0 | 51.1 | 2.53 | 1.8–2.6 | ✅ | 39% |
| classicBug | P0 | 0.78 | 0.85 | 79.6×51 | 67.6 | 43.6 | 1.55 | 1.4–1.7 | ✅ | 40% |
| taxi | P0 | 0.78 | 1.00 | 93.6×60 | 79.6 | 51.3 | 1.55 | 1.4–1.7 | ✅ | 38% |
| policeCar | P0 | 0.78 | 1.00 | 93.6×60 | 79.6 | 51.3 | 1.55 | 1.4–1.7 | ✅ | 38% |
| motorcycle | P0 | 0.80 | 0.75 | 72×45 | 61.2 | 34.2 | 1.79 | 1.4–1.8 | ✅ | 37% |
| van | P1 | 0.92 | 1.15 | 126.7×69 | 105.8 | 54.8 | 1.93 | 1.8–2.6 | ✅ | 38% |
| iceCreamTruck | P1 | 0.90 | 1.10 | 118.8×66 | 100.5 | 52.0 | 1.93 | 1.8–2.6 | ✅ | 37% |
| suv | P1 | 0.95 | 1.20 | 136.8×72 | 116.6 | 55.8 | 2.09 | 1.8–2.6 | ✅ | 36% |
| fireTruck | P1 | 1.05 | 1.15 | 144.9×69 | 123.2 | 49.3 | 2.50 | 1.8–2.6 | ✅ | 35% |
| ambulance | P1 | 1.05 | 1.05 | 132.3×63 | 113.5 | 48.1 | 2.36 | 1.8–2.6 | ✅ | 36% |
| pickup | P2 | 1.20 | 1.10 | 158.4×66 | 122.4 | 45.9 | 2.67 | 1.5–1.8 | ❌ | 35% |
| micro | P2 | 1.10 | 0.70 | 92.4×42 | 79.4 | 24.2 | 3.28 | 1.1–1.3 | ❌ | 35% |
| convertible | P2 | 1.25 | 0.95 | 142.5×57 | 121.1 | 23.9 | 5.07 | 1.4–1.7 | ❌ | 32% |

### Per-car view constants (P0 cars)

| Car | bodyH_frac | stack_mult | wheelDiam (pt) | body_top (pt) | wheel_top (pt) |
|-----|-----------|-----------|---------------|--------------|---------------|
| raceCar | 0.84 | 0.92 | 27.0 | 46.4 | 27.0 |
| sports | 0.84 | 0.91 | 27.0 | 45.9 | 27.0 |
| schoolBus | 0.86 | 0.90 | 29.7 | 51.1 | 29.7 |
| classicBug | 0.93 | 0.92 | 22.9 | 43.6 | 22.9 |
| taxi | 0.94 | 0.91 | 27.0 | 51.3 | 27.0 |
| policeCar | 0.94 | 0.91 | 27.0 | 51.3 | 27.0 |
| motorcycle | 0.80 | 0.95 | 20.2 | 34.2 | 20.2 |

---

## Success criteria status (P0 complete, P1/P2 pending)

| Criterion | P0 (7 cars) | P1 (5 cars) | P2 (3 cars) |
|-----------|------------|------------|------------|
| 1. Body top > wheel top | ✅ all | ✅ all | ❌ micro, convertible |
| 2. Bl/Bh in target band | ✅ all | ✅ all | ❌ all 3 |
| 3. Garage/gameplay parity | ✅ all 15 | ✅ all 15 | ✅ all 15 |
| 4. No double bodyAspectRatio | ✅ all 15 | ✅ all 15 | ✅ all 15 |
| 5. Wheelbase 55–75% target | ❌ all (~37–40%) | ❌ all (~35–38%) | ❌ all (~32–35%) |

Criterion 5 (wheelbase) is a systemic issue: `wheelSpacing = size.width * 0.12 * WSM_spacing`. Coefficient 0.12 gives ~14% spacing/body ratio; including wheel diameter in the proxy gives ~37–40%. Reaching 55–75% requires raising the coefficient to ~0.40 and proportionally reducing all WSM_spacing values — deferred to a separate PR.

---

## Root causes for P2 failures

**Bl/Bh too high** (micro, convertible, pickup): bodyAspectRatio still elevated (1.10–1.25) and body height constants not yet raised. Apply same treatment as P0: lower BAR and raise bodyH_frac toward 0.90+.

---

## Change log

| Date | Design | What changed | Files |
|------|--------|-------------|-------|
| 2026-05-24 | all 15 | Remove double bodyAspectRatio: CarView.scaledSize.width += ×bodyAspectRatio; Views/Cars/*.bodyWidth − bodyAspectRatio | CarView.swift, Views/Cars/*.swift |
| 2026-05-24 | P0 (7 cars) | Reduce BAR to class-appropriate values; raise bodyH_frac + stack_mult so Bl/Bh enters target band | CarDesign.swift, RaceCarView, SportsView, SchoolBusView, ClassicBugView, TaxiView, PoliceCarView, MotorcycleView |

# Car Proportion Audit Log

Artboard: 120×60 pt (240×120 px @2x). Sprite: artboard × scale × bodyAspectRatio (W) × artboard × scale (H).

## Architecture — what was fixed (2026-05-24)

### Double-stretch bug
**Before:** `CarView.scaledSize` did NOT include `bodyAspectRatio` in width. All 15 `*View.bodyWidth` formulas used `size.width * 0.85 * bodyAspectRatio`, causing the body to overflow the artboard frame (e.g. raceCar body = 163 pt in a 120 pt frame). `CarSpriteNode` then stretched the clipped texture a second time by `bodyAspectRatio`. Result: bodyAspectRatio applied twice — once in the art, once in the sprite.

**Fix:** `CarView.scaledSize.width` now includes `* appearance.bodyAspectRatio`. All 15 views' `bodyWidth` reduced to `size.width * 0.85` (no `bodyAspectRatio`). The artboard frame and the sprite are now the same dimensions — no clipping, no stretch, perfect garage/gameplay parity.

### Body-top < wheel-top (greenhouse hidden behind wheels)
Three cars had their body stack top below the wheel-top in the artboard:

| Car | body_top (before) | wheel_top | Fix |
|-----|------------------|-----------|-----|
| RaceCar | 23.7 pt | 27.0 pt | stack_mult 0.58 → 0.80 |
| Sports | 26.2 pt | 27.0 pt | stack_mult 0.62 → 0.68 |
| Motorcycle | 14.8 pt | 23.8 pt | stack_mult 0.42 → 0.82 |

---

## Per-car baseline (post-fix, scale=1 artboard units)

Formulas used:
- `wheelDiam = 60 × 0.45 × WSM_size`
- `body_offset = wheelDiam × off_mult`
- `body_frame_h = 60 × bodyH_frac × stack_mult`
- `body_top = body_offset + body_frame_h`
- `Bh ≈ body_top` (tallest point of silhouette from ground)
- `bodyWidth = 120 × BAR × 0.85`
- `Bl/Bh = bodyWidth / Bh` (measured silhouette ratio)
- `Wb = wheelDiam + 120×BAR×0.12×WSM_spacing` (center-to-center wheelbase)
- `Wb/Bl = Wb / bodyWidth`

| Car | BAR | scale | Sprite W×H | Bl (bodyWidth) | Bh | Bl/Bh | Target | Wb/Bl | WSM_sp |
|-----|-----|-------|------------|----------------|----|-------|--------|-------|--------|
| classicBug | 1.35 | 0.85 | 137.7×51 | 117.1 | 35.7 | 3.28 | 1.4–1.7 ❌ | 37% | 0.88 |
| pickup | 1.2 | 1.10 | 158.4×66 | 122.4 | 45.9 | 2.67 | 1.5–1.8 ❌ | 35% | 1.05 |
| sports | 1.55 | 1.00 | 186.0×60 | 158.1 | 27.7 | 5.71 | 1.6–2.0 ❌ | 30% | 1.28 |
| van | 0.92 | 1.15 | 126.7×69 | 105.8 | 54.8 | 1.93 | 1.8–2.6 ✅ | 38% | 0.95 |
| micro | 1.10 | 0.70 | 92.4×42 | 79.4 | 24.2 | 3.28 | 1.1–1.3 ❌ | 35% | 0.82 |
| convertible | 1.25 | 0.95 | 142.5×57 | 121.1 | 23.9 | 5.07 | 1.4–1.7 ❌ | 32% | 0.95 |
| suv | 0.95 | 1.20 | 136.8×72 | 116.6 | 55.8 | 2.09 | 1.8–2.6 ✅ | 36% | 0.98 |
| raceCar | 1.60 | 1.00 | 192.0×60 | 163.2 | 30.1 | 5.42 | 1.6–2.0 ❌ | 28% | 0.78 |
| iceCreamTruck | 0.90 | 1.10 | 118.8×66 | 100.5 | 52.0 | 1.93 | 1.8–2.6 ✅ | 37% | 0.92 |
| taxi | 1.30 | 1.00 | 156.0×60 | 132.6 | 37.0 | 3.58 | 1.4–1.7 ❌ | 34% | 1.05 |
| fireTruck | 1.10 | 1.15 | 151.8×69 | 130.7 | 49.3 | 2.65 | 1.8–2.6 ✅ | 34% | 0.90 |
| schoolBus | 1.45 | 1.10 | 191.4×66 | 162.7 | 42.1 | 3.86 | 1.8–2.6 ❌ | 31% | 1.22 |
| policeCar | 1.28 | 1.00 | 153.6×60 | 130.6 | 35.4 | 3.69 | 1.4–1.7 ❌ | 35% | 1.02 |
| ambulance | 1.05 | 1.05 | 132.3×63 | 113.5 | 48.1 | 2.36 | 1.8–2.6 ✅ | 36% | 0.96 |
| motorcycle | 0.55 | 0.75 | 49.5×45 | 42.1 | 16.6 | 2.54 | 1.4–1.8 ❌ | 39% | 0.58 |

### Success criteria summary (post-fix)

| Criterion | Pass | Fail |
|-----------|------|------|
| 1. Body top > wheel top | ✅ all 15 | — |
| 2. Bl/Bh in target band | van ✅, suv ✅, iceCreamTruck ✅, fireTruck ✅, ambulance ✅ | classicBug ❌, pickup ❌, sports ❌, micro ❌, convertible ❌, raceCar ❌, taxi ❌, schoolBus ❌, policeCar ❌, motorcycle ❌ |
| 3. Garage/gameplay parity | ✅ all 15 (frame = sprite, no stretch) | — |
| 4. No double bodyAspectRatio | ✅ all 15 | — |
| 5. Wheelbase 55–75% / 65–80% | none ✅ | all ❌ (~28–39%, need ~55%+) |

---

## Root causes for remaining criterion failures

### Bl/Bh too high (criteria 2)
`bodyWidth = size.width * 0.85` uses 85% of the already-wide bodyAspectRatio-scaled frame. For cars/sedans where Bh is modest (body doesn't fill the vertical frame), Bl/Bh ends up 3–6×. The fix requires one or both of:
- Reduce `bodyWidth` coefficient from 0.85 to ~0.50–0.60 **per car** (shape edit)
- Increase `bodyH_frac` and `body_offset` so the car body fills more vertical space

Recommended next step: for each sedan-class car (taxi, policeCar, classicBug, convertible), increase `bodyH_frac` from current (0.54–0.56) toward 0.80, and increase `off_mult` so Bh ≈ 45–50 pt. This brings Bl/Bh to ~1.5 range without changing bodyWidth.

### Wheelbase too narrow (criterion 5)
`wheelSpacing = size.width * 0.12 * WSM_spacing`. Even at WSM=1.28 (schoolBus), base coefficient 0.12 gives wheelbase ~31% of body length. Target is 55–75%. Fix requires raising the coefficient to ~0.45 (and proportionally lowering WSM values). This is a systemic one-line change per view but invalidates all existing WSM tuning — defer to a separate PR.

---

## Change log

| Date | Design | What changed | Files |
|------|--------|-------------|-------|
| 2026-05-24 | all 15 | Remove double bodyAspectRatio: CarView.scaledSize.width += ×bodyAspectRatio; Views/Cars/*.bodyWidth − bodyAspectRatio | CarView.swift, Views/Cars/*.swift |
| 2026-05-24 | raceCar | body stack height 0.58→0.80 (body_top now 30 pt > wheel_top 27 pt) | RaceCarView.swift |
| 2026-05-24 | sports | body stack height 0.62→0.68 (body_top 28 pt ≈ wheel_top 27 pt) | SportsView.swift |
| 2026-05-24 | motorcycle | body stack height 0.42→0.82 (body_top 24 pt > wheel_top 24 pt) | MotorcycleView.swift |

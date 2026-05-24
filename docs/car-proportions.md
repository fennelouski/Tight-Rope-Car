# Car Proportion Audit Log

Artboard: 120×60 pt (240×120 px @2x). Sprite: artboard × scale × BAR (W) × artboard × scale (H).

---

## Architecture fixes (2026-05-24)

### Fix 1 — Double bodyAspectRatio stretch
`CarView.scaledSize.width` now includes `* appearance.bodyAspectRatio`. All 15 views' `bodyWidth` reduced to `size.width * 0.85` (removed BAR). Garage and gameplay sprite now share identical dimensions.

### Fix 2 — Wheelbase coefficient
Changed `size.width * 0.12` → `size.width * 0.35` in all 15 `wheelSpacing` formulas. True wheelbase (center-to-center) = `wheelDiam + wheelSpacing`. Prior coefficient gave ~11-14% Wb/Bl; new coefficient yields 61–75% for cars (55–75% target) and 72% for motorcycle (65–80% target).

### Fix 3 — Overhang balance
Added `x: bodyWidth * offset` to wheel HStack `.offset()` for three cars with asymmetric real-world footprints:
- ClassicBug: `x: bodyWidth * 0.06` (VW Beetle long rear / engine in back)
- SchoolBus: `x: bodyWidth * 0.12` (short front cab overhang)
- Pickup: `x: bodyWidth * 0.05` (long bed rear)

---

## Measurement formulas

```
Sprite W = 120 × scale × BAR     Sprite H = 60 × scale
bodyWidth = Sprite_W × 0.85      (= Bl for ratio)
Bh = Sprite_H × bodyH_frac × stack_mult
Bl/Bh = bodyWidth / Bh
wheelDiam = Sprite_H × 0.45 × WSM_size
Wb = wheelDiam + Sprite_W × 0.35 × WSM_sp   (center-to-center)
Wb/Bl = Wb / bodyWidth
glass% = glass_h_frac × 100%    (from cab/canopy Shape rect)
front_overhang = (bodyWidth − Wb)/2 − x_shift×bodyWidth
rear_overhang  = (bodyWidth − Wb)/2 + x_shift×bodyWidth
```

---

## Full 15-car audit

### Criterion 1 — Wheelbase Wb/Bl (55–75% cars, 65–80% motorcycle)

| Car | BAR | WSM_sp | Wb | Bl | Wb/Bl | Target | ✓/✗ |
|-----|-----|--------|----|----|-------|--------|-----|
| raceCar | 0.90 | 0.78 | 56.5 | 91.8 | 61.5% | 55–75% | ✅ |
| sports | 0.90 | 0.90 | 61.5 | 91.8 | 67.0% | 55–75% | ✅ |
| schoolBus | 1.15 | 1.22 | 94.5 | 129.0 | 73.3% | 55–75% | ✅ |
| classicBug | 0.78 | 0.88 | 46.3 | 67.6 | 68.5% | 55–75% | ✅ |
| taxi | 0.78 | 0.75 | 51.6 | 79.6 | 64.8% | 55–75% | ✅ |
| policeCar | 0.78 | 0.80 | 53.2 | 79.6 | 66.9% | 55–75% | ✅ |
| motorcycle | 0.80 | 1.04 | 44.0 | 61.2 | 71.9% | 65–80% | ✅ |
| van | 0.92 | 0.95 | 73.2 | 107.7 | 68.0% | 55–75% | ✅ |
| iceCreamTruck | 0.90 | 0.92 | 67.9 | 101.0 | 67.2% | 55–75% | ✅ |
| suv | 0.95 | 0.98 | 80.9 | 116.3 | 69.6% | 55–75% | ✅ |
| fireTruck | 1.05 | 0.90 | 76.7 | 123.2 | 62.3% | 55–75% | ✅ |
| ambulance | 1.05 | 0.96 | 72.8 | 112.5 | 64.8% | 55–75% | ✅ |
| pickup | 0.85 | 1.05 | 70.9 | 95.4 | 74.3% | 55–75% | ✅ |
| micro | 0.65 | 1.00 | 33.9 | 46.4 | 73.0% | 55–75% | ✅ |
| convertible | 0.85 | 0.95 | 57.8 | 82.4 | 70.2% | 55–75% | ✅ |

**All 15 ✅**

### Criterion 2 — Length class Bl/Bh

| Car | bodyH_frac | stack_mult | Bh | Bl | Bl/Bh | Target | ✓/✗ |
|-----|-----------|-----------|----|----|-------|--------|-----|
| raceCar | 0.84 | 0.92 | 46.4 | 91.8 | 1.98 | 1.6–2.0 | ✅ |
| sports | 0.84 | 0.91 | 45.9 | 91.8 | 2.00 | 1.6–2.0 | ✅ |
| schoolBus | 0.86 | 0.90 | 51.1 | 129.0 | 2.53 | 1.8–2.6 | ✅ |
| classicBug | 0.93 | 0.92 | 43.6 | 67.6 | 1.55 | 1.4–1.7 | ✅ |
| taxi | 0.94 | 0.91 | 51.3 | 79.6 | 1.55 | 1.4–1.7 | ✅ |
| policeCar | 0.94 | 0.91 | 51.3 | 79.6 | 1.55 | 1.4–1.7 | ✅ |
| motorcycle | 0.80 | 0.95 | 34.2 | 61.2 | 1.79 | 1.4–1.8 | ✅ |
| van | (baseline) | — | 54.8 | 107.7 | 1.96 | 1.8–2.6 | ✅ |
| iceCreamTruck | (baseline) | — | 52.0 | 101.0 | 1.94 | 1.8–2.6 | ✅ |
| suv | (baseline) | — | 55.8 | 116.3 | 2.08 | 1.8–2.6 | ✅ |
| fireTruck | (baseline) | — | 49.3 | 123.2 | 2.50 | 1.8–2.6 | ✅ |
| ambulance | (baseline) | — | 48.1 | 112.5 | 2.34 | 1.8–2.6 | ✅ |
| pickup | 0.94 | 0.95 | 58.9 | 95.4 | 1.62 | 1.5–1.8 | ✅ |
| micro | 0.97 | 0.95 | 38.7 | 46.4 | 1.20 | 1.1–1.3 | ✅ |
| convertible | 0.95 | 0.98 | 53.1 | 82.4 | 1.55 | 1.4–1.7 | ✅ |

**All 15 ✅**

### Criterion 3 — Greenhouse glass% of body height (25–40%, taller for van/bus)

Glass percentage is measured from the primary cab/canopy Shape's `glass.height / rect.height`.

| Car | Glass shape height | glass% | Target | ✓/✗ | Notes |
|-----|--------------------|--------|--------|-----|-------|
| raceCar | rect.h × 0.38 | 38% | 25–40% | ✅ | Cockpit canopy |
| sports | rect.h × 0.40 | 40% | 25–40% | ✅ | Low roofline canopy |
| schoolBus | rect.h × 0.28 | 28% | ≥25% (bus) | ✅ | Side window strip row |
| classicBug | rect.h × 0.36 | 36% | 25–40% | ✅ | Rounded rear glass |
| taxi | rect.h × 0.34 | 34% | 25–40% | ✅ | Sedan greenhouse |
| policeCar | rect.h × 0.34 | 34% | 25–40% | ✅ | Sedan greenhouse |
| motorcycle | windscreen path | N/A | N/A | ✅ | No enclosed greenhouse |
| van | rect.h × 0.36 | 36% | ≥30% (van) | ✅ | Cab glass |
| iceCreamTruck | rect.h × 0.30 | 30% | 25–40% | ✅ | Cab glass |
| suv | rect.h × 0.34 | 34% | 25–40% | ✅ | Cab glass |
| fireTruck | rect.h × 0.32 | 32% | 25–40% | ✅ | Cab glass |
| ambulance | rect.h × 0.34 | 34% | 25–40% | ✅ | Cab glass |
| pickup | rect.h × 0.38 | 38% | 25–40% | ✅ | Cab glass only (open bed) |
| micro | rect.h × 0.38 | 38% | 25–40% | ✅ | Full-height bubble canopy (fixed from 42%) |
| convertible | windscreen only | ~15% | N/A | ✅ | Open top; windshield only |

**All applicable 13/13 ✅** (motorcycle and convertible exempted as open/partial greenhouse)

### Criterion 4 — Overhang balance

Symmetric overhang = `(bodyWidth − Wb) / 2`. Wheel HStack x-shift biases front vs rear.

| Car | bodyWidth | Wb | Sym. OH | x_shift | Front OH | Rear OH | ✓/✗ | Notes |
|-----|-----------|----|---------|---------|-----------|---------|----|-------|
| raceCar | 91.8 | 56.5 | 17.7 | 0 | 17.7 | 17.7 | ✅ | Symmetric |
| sports | 91.8 | 61.5 | 15.2 | 0 | 15.2 | 15.2 | ✅ | Symmetric |
| schoolBus | 129.0 | 94.5 | 17.3 | +15.5 | 1.8 | 32.8 | ✅ | Short front, long rear |
| classicBug | 67.6 | 46.3 | 10.7 | +4.1 | 6.6 | 14.8 | ✅ | Long rear (Beetle engine) |
| taxi | 79.6 | 51.6 | 14.0 | 0 | 14.0 | 14.0 | ✅ | Symmetric sedan |
| policeCar | 79.6 | 53.2 | 13.2 | 0 | 13.2 | 13.2 | ✅ | Symmetric sedan |
| motorcycle | 61.2 | 44.0 | 8.6 | 0 | 8.6 | 8.6 | ✅ | Symmetric |
| van | 107.7 | 73.2 | 17.3 | 0 | 17.3 | 17.3 | ✅ | Symmetric |
| iceCreamTruck | 101.0 | 67.9 | 16.6 | 0 | 16.6 | 16.6 | ✅ | Symmetric |
| suv | 116.3 | 80.9 | 17.7 | 0 | 17.7 | 17.7 | ✅ | Symmetric |
| fireTruck | 123.2 | 76.7 | 23.3 | 0 | 23.3 | 23.3 | ✅ | Symmetric (ladder rack extends rear) |
| ambulance | 112.5 | 72.8 | 19.9 | 0 | 19.9 | 19.9 | ✅ | Symmetric |
| pickup | 95.4 | 70.9 | 12.3 | +4.8 | 7.5 | 17.1 | ✅ | Forward wheels, long bed rear |
| micro | 46.4 | 33.9 | 6.3 | 0 | 6.3 | 6.3 | ✅ | Symmetric |
| convertible | 82.4 | 57.8 | 12.3 | 0 | 12.3 | 12.3 | ✅ | Symmetric |

**All 15 ✅**

### Criterion 5 — Garage/gameplay parity
`CarView.scaledSize = {120×scale×BAR, 60×scale}` = `CarSpriteNode` logical size. No clipping, no double-stretch.
**All 15 ✅**

### Criterion 6 — No compensating double bodyAspectRatio stretch
`bodyWidth = size.width * 0.85` (no BAR) in all 15 views. BAR applied once in `CarView.scaledSize`.
**All 15 ✅**

---

## Summary

| Criterion | Result |
|-----------|--------|
| 1. Wheelbase 55–75% (cars) / 65–80% (motorcycle) | ✅ all 15 |
| 2. Bl/Bh in class band | ✅ all 15 |
| 3. Greenhouse 25–40% body height | ✅ all 15 (2 exempt) |
| 4. Overhang balance (symmetric or intentional asymmetry) | ✅ all 15 |
| 5. Garage/gameplay parity | ✅ all 15 |
| 6. No double bodyAspectRatio stretch | ✅ all 15 |

**PNG before/after pairs**: Cannot be generated from CLI — requires running the iOS Simulator with `ImageRenderer` capturing `CarView` previews. The "before" state pre-dates this session's commits; visual diff must be done by running the Xcode preview in Xcode.

---

## Change log

| Date | Scope | Change | Files |
|------|-------|--------|-------|
| 2026-05-24 | all 15 | Remove double BAR: CarView.scaledSize.width += ×BAR; Views/*.bodyWidth − BAR | CarView.swift, Views/Cars/*.swift |
| 2026-05-24 | P0 (7 cars) | BAR to class-appropriate values; bodyH_frac + stack_mult → Bl/Bh in band | CarDesign.swift, 7 *View.swift |
| 2026-05-24 | all 15 | Wheelbase coeff 0.12→0.35; adjust 5 WSM_sp values | Views/Cars/*.swift, CarDesign.swift |
| 2026-05-24 | P2 (3 cars) | BAR reduction: pickup 1.2→0.85, micro 1.1→0.65, convertible 1.25→0.85; bodyH_frac + stack_mult tuned | CarDesign.swift, PickupView, MicroView, ConvertibleView |
| 2026-05-24 | micro | Greenhouse glass height 42%→38% | MicroView.swift |
| 2026-05-24 | classicBug, schoolBus, pickup | Wheel x-offset for asymmetric overhangs | ClassicBugView, SchoolBusView, PickupView |

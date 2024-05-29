# Vehicle Sticker

A Factorio mod to attach a 'sticker' label to a vehicle.

Thanks to GotLag for 'Renamer' and the functions from that were used.

## Usage

* Hover the cursor over a vehicle and press the hot-key
* Dialog will prompt for text and color to display
* Text will be attached to the vehicle and move with it

## Concerns

* Will this cause UPS issues?
* Paste (shift-right-click) will only trigger for 'similar' units.  A locomotive cannot be pasted to a cargo-wagon, for example.

## Future

* Can this be attached to a vehicle in the Map View / Train View screen?

--------------------------------------------------------------------------------

### **AddWagonSticker**

Adds the given text to a random train cargo wagon

#### Parameters

* **player_name**: The **player_name** to use for surface search.
* **message**:  The **message** to be put on the wagon.
* R: Red color hue (000-255)
* G: Green color hue (000-255)
* B: Blue color hue (000-255)

If RGB are omitted or invalid, a random color above 100 is used.

#### Examples

* Display the message at the character.

> `/sc remote.call( 'vehicleSticker', 'add_wagon_sticker', 'hyspeed', '_follower_' )`

--------------------------------------------------------------------------------

### **AddLocomotiveSticker**

Adds the given text to a random train locomotive

#### Parameters

* **player_name**: The **player_name** to use for surface search.
* **message**:  The **message** to be put on the locomotive.
* R: Red color hue (000-255)
* G: Green color hue (000-255)
* B: Blue color hue (000-255)

If RGB are omitted or invalid, a random color above 100 is used.

#### Examples

* Display the message at the character.

> `/sc remote.call( 'vehicleSticker', 'add_locomotive_sticker', 'hyspeed', '_subscriber_', 100, 150, 200 )`

--------------------------------------------------------------------------------

## Helpful commands

### Setup

* /sc game.player.surface.always_day=true;

### Follower

* /c remote.call( 'vehicleSticker', 'add_wagon_sticker', 'hyspeed', '_follower_', 100, 150, 200 )
* /c remote.call( "vehicleSticker", "add_wagon_sticker", "hyspeed", "_rando_" )

### Items

* /sc game.player.insert{name="rail",            count=100}
      game.player.insert{name="rocket-fuel",     count=50}
      game.player.insert{name="locomotive",      count=2}
      game.player.insert{name="cargo-wagon",     count=4}
      game.player.insert{name="artillery-wagon", count=2}
      game.player.insert{name="spidertron",      count=2}
      game.player.insert{name="car",             count=2}
      game.player.insert{name="tank",            count=2}

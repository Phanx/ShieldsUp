### Version 6.0.3.48

* Remove Earth Shield overwrite detection, since a target can now have more than one Earth Shield on them at a time

### Version 6.0.2.190

* Updated for WoW 6.0
* Updated Português translations from Tercioo

### Version 5.4.8.186

* Updated Русский translations from Yafis

### Version 5.4.8.184

* Better handling of visibility for low-level characters
* Fix for missing labels on dropdowns in options panel

### Version 5.4.7.181

* Fixed inactive counter appearing in single (solo) mode
* Added previews to the sound selection dropdowns
* Display is now always hidden for shamans below level 9

### Version 5.4.7.173

* Fixed playing alert sounds
* Added option to suppress alerts while hidden

### Version 5.4.1.167

* Updated for WoW 5.4
* Updated French, German, and Portuguese translations

### Version 5.3.0.163

* Fixed several issues related to hiding unlimited shields

### Version 5.3.0.162

* Updated for WoW 5.3
* Added an option to hide active shields that don't have limited charges (Water Shield, non-Elemental Lightning Shield)
* Changed how visibility settings are stored -- you will need to reconfigure your hide/show settings
* Minor efficiency improvements

### Version 5.2.0.158

* Minor changes to the Alerts options layout

### Version 5.2.0.157

* Fixed localization. Translators, please review the options panel, and [add missing translations](http://wow.curseforge.com/addons/shieldsup/localization/).

### Version 5.2.0.156

* Simplified the Visibility options by combining the group type and zone type filters.

### Version 5.1.0.147

* Fixed a minor cosmetic issue with the Text Output dropdown in the Alerts option panel.

### Version 5.0.5.146

* Now hidden in pet battles.

### Version 5.0.4.144

* Updated Traditional Chinese translations from awaited on CurseForge.

### Version 5.0.4.142

* Elemental shamans will now see a number instead of an "L" for Lightning Shield when it has at least one extra charge (2+ total charges).

### Version 5.0.4.141

* Updated for WoW 5.0.4
* Updated Spanish, French, and Russian translations

### Version 4.3.4.137

* **Compatible with both 4.3 live realms and Mists of Pandaria beta realms.**
  Use the “Load out of date addons” checkbox on beta realms — the TOC won’t be updated until Patch 5.0 goes live.
* Added an option to color the target name by class when Earth Shield is active and not overwritten.

### Version 4.3.4.134

* **Compatible with both 4.3 live realms and Mists of Pandaria beta realms.**
  Use the “Load out of date addons” checkbox on beta realms — the TOC won’t be updated until Patch 5.0 goes live.
* Fixed several issues with group detection on live servers.
* Fixed an issue with Water/Lightning Shield detection at login on beta servers.
* Fixed an issue where Earth Shield would not be detected if you cast it on someone outside your group and then joined a group with that player.
* Added support for [all colorblind modes](http://www.curse.com/addons/wow/colourblind-mode), not just mode #1 (which is the only one the default UI exposes as an option).
* Improved support for LibSharedMedia fonts at login.

### Version 4.3.4.132

* **Compatible with both 4.3 live realms and Mists of Pandaria beta realms.**
  Use the “Load out of date addons” checkbox on beta realms — the TOC won’t be updated until Patch 5.0 goes live.
* Updated for MoP changes: Water Shield and Lightning Shield no longer have charges, and will show a "W" or "L" instead of the number of charges when used on beta realms.
* Lots of cleanups to options and translations.
* Added partial koKR localization from moom21 on CurseForge.
* Updated deDE localization from Estadon on CurseForge.
* Added itIT (partial) and ptBR translations.

### Version 4.3.0.122

* Updated for WoW 4.3
* Translations needed for Português (ptBR) and 한국어 (koKR). If you can help translate ShieldsUp for either of these languages, please [see the Localization page](http://wow.curseforge.com/addons/shieldsup/localization/). Thanks!

### Version 4.2.0.120

* Updated for WoW 4.2

### Version 4.1.0.119

* Added an option for moving the Earth Shield target name to the bottom of the display, or hiding it. It’s not exposed in the options panel yet, but you can change it by typing “`/run ShieldsUpDB.namePosition = "BOTTOM"; ShieldsUp:ApplySettings()`”. The value can be "BOTTOM", "TOP", or "NONE".
* Removed support for WoW 3.2, since China has finally updated to 3.3+
* Updated localization

### Version 4.0.3.105

* Fixed a number of minor bugs
* Added backwards compatibility for WoW China
* Added TOC metadata for the Curse Client
* Updated Spanish localization

### Version 3.3.5.97

* Added an option to tell you who overwrites your Earth Shield
* Removed the Colorblind Mode option; ShieldsUp now respects the default UI's Colorblind Mode setting
* Updated for changes in config libs

### Version 3.3.2.93

* Wintergrasp and other (future) outdoor PvP zones are now treated as battlegrounds for the purposes of visibility options
* Fixed possible errors when no alert sound is selected
* Improved text alert options
* Added LibAboutPanel to optional dependencies for standalone library users

### Version 3.3.0.85

* Fixed failure to monitor Earth Shield on battleground allies from other servers
* Fixed failure to detect active shields on login
* Fixed alerts triggering while you are dead or operating a vehicle
* Fixed alerts triggering while the display is hidden
* Fixed alerts triggering when you remove Earth Shield on one target by casting it on another target
* Fixed alerts triggering when you remove Earth Shield on yourself by casting Water Shield or Lightning Shield, and vice versa
* Added French translations from krukniak on Curse
* Added very rough Spanish translations - **corrections welcome**

### Version 3.2.0.79

* Added Simplified Chinese and Traditional Chinese translations from wowui.cn

### Version 3.1.1.78-beta

* Added German translations from Søøm
* Added hidden option to show you who overwrote your Earth Shield
  * Enable: `/run ShieldsUpDB.alert.earth.overwritten = true`
  * Disable: `/run ShieldsUpDB.alert.earth.overwritten = false`

### Version 3.1.1.70-beta

* Fixed issue with dual talent specializations

### Version 3.1.1.69-beta

* Added automatic visibility states
* Fixed overlapping controls in the configuration GUI

### Version 3.1.0.57-beta

* Improved support for dual talent specializations in WoW 3.1
* Fixed misplaced checkbox in options (text output > sticky)
* Fixed some outstanding issues with text output options
* Updated wording on some options for clarity
* Updated ruRU locale file (needs translator attention)

### Version 3.1.0.47-beta

* Update for aura changes in 3.1
* **NOT compatible with WoW 3.0.9 or lower!**

### Version 3.0.9.46-beta

* Add "colorblind mode" option
* Fix some bugs with the alert options

### Version 3.0.9.44-beta

* Fixed saved variables initialization
* Added sliders for font sizes (yes, I know they overlap stuff)

### Version 3.0.9.42-beta

* Fixed dropdown menu creation
* Fixed sound not playing when selecting it in sound file dropdowns
* Added scrolling dropdown for font selection (not yet functional, please do not report issues related to this)

### Version 3.0.3.39-beta

* Added options for alerts
* Removed embeds that are no longer used
* Known issue: Dropdowns for selecting sound files are oddly anchored
* Known issue: Dropdown for text output subsection doesn't work properly until the dropdown for text output main section is used once

### Version 3.0.3.34-beta

* Added options for position, padding, typeface, outline, shadow, and colors

### Version 3.0.3.30-beta

* This is a near-total rewrite. The addon is now watching spellcast and aura events instead of scanning every combat log message. This results in inherent support for current and future talents and glyphs which alter the number of charges on shields, and in greater accuracy under many circumsances, including high latency and passing through loading screens. Solo mode now also works as intended.
* This beta version does not yet have a configuration interface. Many settings will translate from the previous versions, but I make no guarantees, especially if your configuration was very different from the default configuration.

### Version 3.0.2.25

* Add support for Improved Earth Shield and Glyph of Water Shield
* Add solo mode

### Version 3.0.2.19

* Add basic support for Lightning Shield (uses Water Shield options for now)
* Remove 2.4.3 compatibility
* Update embedded libraries

### Version 2.4.3.12

* Removed some debugging code that prevented settings from saving between sessions

### Version 2.4.3.10

* Fixed some errors I thought I'd already committed
* Alert options currently not fully functional

### Version 2.4.3.8

* Added aura scanning on "aura lost" events; this will prevent showing zero on recast shields in all but extremely laggy situations.
* Added support for AddonLoader.

### Version 2.4.3.6

* Swapped position of Earth and Water Shield charges

### Version 2.4.2.5

* Fixed audio alerts

### Version 2.4.2.4

* Fixed options not appearing until the slash command was entered

### Version 2.4.2.3

* Initial public beta release

# MTA:SA Grand RP Inspired HUD (Standalone)

A clean, modern, standalone heads-up display (HUD) script for Multi Theft Auto: San Andreas, inspired by the Grand RP layout.

---

## Preview

![HUD Preview](https://i.imgur.com/beKmLT8.jpeg)

---

## Features

* **Easy Configuration**: No deep scripting knowledge needed—customize text, colors, toggle elements, and define element data from a single config file.
* **Standalone**: Operates independently without requiring heavy external frameworks.

---

## Elements & Config Options

The configuration file allows you to adjust the following options:

| Option | Description | Example / Default |
| :--- | :--- | :--- |
| `ServerName` | Displayed server name (supports color codes) | `'Server #e10f28Name'` |
| `ID.enable` | Toggle player ID visibility  `true` |
| `ID.color` | Color format for player ID indicator | `tocolor(225, 15, 40, 255)` |
| `Bookmark.enable` | Toggle top-right server number bookmark badge | `true` |
| `Bookmark.servernum` | Server badge index number | `1` |
| `CP.enable` | Toggle the bottom-left compass/direction indicator | `true` |
| `CP.color` | Accent color for the compass display | `tocolor(225, 15, 40, 255)` |
| `MoneyBankData` | Element Data key to the bank balance | `'moneyBank'` |
| `IDData` | Element Data key to player ID | `'ID'` |
| `GreenZoneData` | Element Data key for green zone detection | `'greenzone'` |

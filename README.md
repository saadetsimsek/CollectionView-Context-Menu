# Collection View Context Menu

*Long press context menus with a preview, on a grid of images.*

![Swift](https://img.shields.io/badge/Swift-5.0-F05138?style=flat-square&logo=swift&logoColor=white) ![UIKit](https://img.shields.io/badge/UIKit-2396F3?style=flat-square&logo=uikit&logoColor=white) ![iOS](https://img.shields.io/badge/iOS-17.5%2B-000000?style=flat-square&logo=apple&logoColor=white) ![Topic](https://img.shields.io/badge/topic-UIContextMenu-6366F1?style=flat-square) ![Dependencies](https://img.shields.io/badge/dependencies-none-16A34A?style=flat-square)

## Overview

Holding a cell raises it into a preview with a menu of actions beneath. The API involved is `contextMenuConfigurationForItemAt`, which asks for a configuration made of an optional preview provider and an action provider.

## How it works

```mermaid
flowchart TD
    LP["Long press on a cell"] --> CB["collectionView(_:contextMenuConfigurationForItemAt:point:)"]
    CB --> CFG["UIContextMenuConfiguration"]
    CFG --> PREV["previewProvider<br/>the view controller shown while held"]
    CFG --> ACT["actionProvider"]
    ACT --> MENU["UIMenu"]
    MENU --> A1["UIAction share"]
    MENU --> A2["UIAction save"]
    MENU --> A3["UIAction delete, destructive"]
    CELL["ImageCollectionViewCell"] --> LP
```

## Implementation notes

- **Identifier per item.** The configuration is created with the index path as its identifier, which is how the system matches the preview to the cell it animates from.
- **Destructive actions marked.** Passing the destructive attribute is what renders the delete entry in red, rather than styling it manually.
- **Preview is optional.** Returning nil for the preview provider still yields a menu, and the cell itself is used as the preview.
- **Flow layout is enough.** The grid uses a plain flow layout, keeping the example focused on the menu rather than on layout.

## Project structure

```
CollectionViewContextMenu/
├── ViewController.swift              grid and menu configuration
└── ImageCollectionViewCell.swift
```

## Requirements

Xcode 15 or later, iOS 17.5 or later. No external dependencies.

# Changelog

All notable changes are documented here.

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
Project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.2.2] - 2026-09-16

### Added
- Hierarchical per-chapter numbering for figures, tables, code listings, and equations (`1.1` in main content, `A.1` in appendix)
- Localized caption supplements and reference abbreviations (`Abb.`, `Tab.`, `Gl.`, `Prog.`) ([#10](https://github.com/TimerErTim/hagenberg-thesis-typst/pull/10))
- Classic chapter outline shows acknowledgment
- Classic style includes abbreviations inside appendix
- Optional `copyright-page` with `LICENSE_TYPES` presets (CC BY-NC-ND 4.0, all-rights-reserved) and custom license content ([#9](https://github.com/TimerErTim/hagenberg-thesis-typst/pull/9))
- Optional title page options `degree`, `study-program`, `place-of-study`, and `submission-date: auto` ([#9](https://github.com/TimerErTim/hagenberg-thesis-typst/pull/9))
- i18n for degree names, license text, and Austrian German month–year dates on the title page ([#9](https://github.com/TimerErTim/hagenberg-thesis-typst/pull/9))
- Declaration text that the printed copy matches the submitted electronic document (DE/EN) ([#9](https://github.com/TimerErTim/hagenberg-thesis-typst/pull/9))

### Changed
- OSS-friendly default sans-serif fonts: `New Computer Modern Sans`, `Libertinus Sans`, `Inter`, `Arial` ([#9](https://github.com/TimerErTim/hagenberg-thesis-typst/pull/9))
- Figure captions have bold labels and use a grid layout for smart indentation ([#11](https://github.com/TimerErTim/hagenberg-thesis-typst/pull/11))
- Built-in styles no longer force Times New Roman (classic) or Arial (modern) on body text; serif uses Typst’s default fonts ([#9](https://github.com/TimerErTim/hagenberg-thesis-typst/pull/9))
- Classic and modern styles: tighter academic paragraph and float spacing ([#9](https://github.com/TimerErTim/hagenberg-thesis-typst/pull/9))
- `mise.toml` now drops Typst patch version requirement -> selects latest by default ([#12](https://github.com/TimerErTim/hagenberg-thesis-typst/pull/12))

### Fixed
- Heading page location numbers in modern style outline
- Classic style heading off-by-one location bug from column break
- Heading with i18n/context hidden in PDF outline ([#1](https://github.com/TimerErTim/hagenberg-thesis-typst/pull/1) by @MartinHanl)

## [0.2.1] - 2026-08-14

### Added
- Default `titlepage` parameter set to `none`

### Fixed
- Table and figure outlines unable to hide because context not null

### Documentation
- Rebuild user manual

## [0.2.0] - 2026-08-13

### Added
- Classic LaTeX-like thesis base style
- Hagenberg titlepage and declaration page in pure Typst
- Dedicated manual PDF (`easy-hgb-thesis-manual.pdf`)
- Multi-style thesis configuration (`modern`, `classic`)
- Advanced usage documentation for modular sections

### Changed
- Refactor declaration to use i18n strings
- Standardize internal references from `i8n` to `i18n`
- Move contributor guidelines to separate `CONTRIBUTING.md`

### Fixed
- Missing white background in thumbnails
- README Typst snippet syntax error
- Asset bundling rules in `.publishignore`
- Manual typos and formatting issues

## [0.1.0] - 2026-05-13

### Added
- Initial release of `easy-hgb-thesis` template
- Multi-page preview thumbnails for package registry

### Changed
- Switch license to MIT-0

[Unreleased]: https://github.com/TimerErTim/hagenberg-thesis-typst/compare/v0.2.2...HEAD
[0.2.2]: https://github.com/TimerErTim/hagenberg-thesis-typst/compare/v0.2.1...v0.2.2
[0.2.1]: https://github.com/TimerErTim/hagenberg-thesis-typst/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/TimerErTim/hagenberg-thesis-typst/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/TimerErTim/hagenberg-thesis-typst/releases/tag/v0.1.0

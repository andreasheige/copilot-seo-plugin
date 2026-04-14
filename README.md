# copilot-seo

A comprehensive SEO analysis plugin for **GitHub Copilot CLI**. Covers technical SEO, Core Web Vitals, schema markup, content quality (E-E-A-T), sitemaps, hreflang/i18n, AI search optimization (GEO), local SEO, backlinks, and Google API integration.

## Installation

```bash
# Install directly from GitHub
copilot plugin install andreasheige/copilot-seo
```

Or from a registered marketplace:
```bash
copilot plugin marketplace add andreasheige/copilot-seo
copilot plugin install copilot-seo@andreasheige-copilot-seo
```

## Quick Start

```
Run an SEO audit on https://example.com
Use the seo-technical skill to check https://example.com
Validate hreflang tags on https://example.com
Generate Product schema for this product page
Check Core Web Vitals for https://example.com
```

## Commands

| Skill | Description |
|-------|-------------|
| `seo` | Main orchestrator — routes to sub-skills |
| `seo-audit` | Full website audit with parallel subagent delegation |
| `seo-page` | Deep single-page analysis |
| `seo-technical` | Technical SEO audit (9 categories) |
| `seo-content` | E-E-A-T and content quality analysis |
| `seo-schema` | Schema.org detection, validation, generation |
| `seo-sitemap` | XML sitemap analysis or generation |
| `seo-images` | Image SEO: on-page audit, SERP analysis |
| `seo-geo` | AI search / Generative Engine Optimization |
| `seo-hreflang` | Hreflang/i18n SEO audit and generation |
| `seo-local` | Local SEO analysis (GBP, citations, reviews) |
| `seo-maps` | Maps intelligence (geo-grid, GBP audit) |
| `seo-plan` | Strategic SEO planning by industry |
| `seo-programmatic` | Programmatic SEO analysis and planning |
| `seo-competitor-pages` | Competitor comparison page generation |
| `seo-backlinks` | Backlink profile analysis |
| `seo-google` | Google SEO APIs (GSC, PageSpeed, CrUX, GA4) |

## Architecture

```
plugin.json           # Copilot plugin manifest
skills/               # 19 skills (SKILL.md files)
agents/               # 13 subagents (.agent.md files)
scripts/              # Python scripts for live site analysis
schema/               # JSON-LD schema templates
hooks/                # Post-tool-use validation hooks
docs/                 # Extended documentation
```

## Requirements

- GitHub Copilot CLI
- Python 3.10+ (for live site analysis scripts)
- Optional: Google API credentials for GSC, PageSpeed, CrUX, GA4

## Python Dependencies

```bash
pip install -r requirements.txt
```

## License

MIT


# repo-structurer

[![skills.sh](https://skills.sh/b/alexgenovese/skills-sh-repo-structurer)](https://skills.sh/alexgenovese/skills-sh-repo-structurer)

A meta-skill for scaffolding and validating agent or skill repositories following the [skills.sh](https://skills.sh) specification.

[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![skills.sh](https://img.shields.io/badge/powered%20by-skills.sh-000?logo=github&style=flat)](https://skills.sh)

## About

This skill helps you create and validate repositories for AI agents and skills using the [skills.sh](https://skills.sh) / Agent Skills installation spec (`npx skills add <owner>/<repo>`).

**version**: 2.0.0  
**author**: Alex Genovese

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Validation](#validation)
- [Repository Structures](#repository-structures)
- [References](#references)

## Features

A single-skill repository that provides:

- ✅ Repo scaffolding for AI agent and skill repositories
- ✅ Structure validation following the skills.sh specification
- ✅ Support for single-skill repos and multi-skill agent repos
- ✅ Frontmatter validation for SKILL.md and AGENTS.md files
- ✅ Helper scripts for automated validation

## Installation

Install directly from skills.sh:

```bash
npx skills add alexgenovese/skills-sh-repo-structurer
```

## Usage

After installation, you can ask your agent:

- _"Scaffold a new skill repo for my tool"_
- _"Scaffold a new agent repo called browser-automation"_
- _"Validate my repo structure"_

### Common Commands

```bash
# Scaffold a new skill repository
skills/repo-structurer

# Scaffold an agent repository
skills repo-structurer --type agent --name my-agent

# Validate repository structure
bash skills/repo-structurer/scripts/validate.sh <path-to-repo>
```

## Validation

The validation script checks that repositories follow the skills.sh specification:

```bash
bash skills/repo-structurer/scripts/validate.sh <path-to-repo>
```

The script validates:

- ✅ `README.md` presence at root
- ✅ `skills/` directory with proper structure
- ✅ `SKILL.md` files in each skill subfolder
- ✅ Optional: `examples/` directories
- ✅ Optional: `scripts/` directories
- ✅ Optional: `AGENTS.md` for agent repos
- ✅ Optional: License files

**Validation Standards:**

- [Skill repo reference](https://github.com/coreyhaines31/marketingskills)
- [Agent repo reference](https://github.com/vercel-labs/agent-browser)

## Repository Structures

### Single-Skill Repo

Use when publishing one focused skill (e.g., `my-email-writer`):

```
my-skill-repo/
  skills/
    <skill-name>/           # folder name = skill name
      SKILL.md              # REQUIRED — frontmatter + instructions
      examples/             # recommended — sample prompts and outputs
      scripts/              # optional — helper scripts the skill references
  README.md                 # REQUIRED — human-facing docs with usage examples
  LICENSE                   # recommended
  CONTRIBUTING.md           # optional
```

### Multi-Skill Repo (Agent / Skill Pack)

Use when publishing a suite of related skills (e.g., `sales-manager` with 14 sub-skills):

```
my-agent-repo/
  skills/
    <skill-1-name>/
      SKILL.md              # REQUIRED — one per skill, with its own frontmatter
    <skill-2-name>/
      SKILL.md              # REQUIRED
    ...                     # one folder per skill — no nesting deeper than this
  AGENTS.md                 # recommended — describes orchestration and routing between skills
  README.md                 # REQUIRED
  LICENSE                   # recommended
```

## Critical: SKILL.md Frontmatter Requirements

This is the most common failure point. Every `SKILL.md` file MUST begin with a valid YAML frontmatter block. Without it, `npx skills add` will fail to register the skill and the agent will not be able to invoke it.

### Required frontmatter fields

```yaml
---
name: <skill-name>          # REQUIRED — must match the folder name exactly (e.g. sales-prospect)
description: "..."          # REQUIRED — plain English, quoted string, 1-3 sentences
                             #   • Starts with "Use when the user wants to..."
                             #   • Lists the /command that triggers this skill
                             #   • Lists 2-4 natural-language phrases a user might say
metadata:
  version: 1.0.0            # REQUIRED
  author: <your name>       # REQUIRED
---
```

### Frontmatter validation checklist

- [ ] File starts with `---` on line 1 (no blank lines, no BOM)
- [ ] `name:` value is lowercase, hyphenated, matches the folder name exactly
- [ ] `description:` value is a quoted string (use double quotes)
- [ ] Description includes the slash command that triggers the skill (e.g., `/sales qualify <url>`)
- [ ] Description includes 2-4 natural-language invocation phrases
- [ ] `metadata.version` is a valid semver string
- [ ] `metadata.author` is present
- [ ] Closing `---` on its own line immediately before the Markdown body
- [ ] No tabs in the YAML block — only spaces

## Development Workflow

This repository is maintained as follows:

1. **Validate structure** on all branches before merging
2. **Update documentation** for each new feature
3. **Maintain example repos** in the `examples/` directory

### Branching Strategy

- `main` — Stable releases
- `*` — Feature branches
- `*` — Bug fixes

## Coding Standards

When contributing to this repo or creating new skills with this tool:

- Use consistent Markdown formatting
- Include examples and usage instructions
- Validate SKILL.md frontmatter before installation
- Keep descriptions concise (1-3 sentences)

## Testing

Run the validation script to test your repository structure:

```bash
bash skills/repo-structurer/scripts/validate.sh .
```

The script will report:
- ✅ Checks that pass
- ✅ Warnings for missing optional components
- ❌ Errors for required missing files

## Contributing

Contributions are welcome! When contributing:

1. Fork the repository
2. Create a feature branch
3. Add your skill/agent structure validation
4. Test with the validation script
5. Submit a pull request

## License

MIT License

---

**For more information about the skills.sh specification:**  
[https://skills.sh](https://skills.sh)

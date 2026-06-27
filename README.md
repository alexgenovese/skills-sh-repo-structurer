# repo-structurer

A meta-skill for scaffolding and validating agent or skill repositories following the [skills.sh](https://skills.sh) specification.

[![Install with skills](https://img.shields.io/badge/skills.sh-install-blue)](https://skills.sh)

## Installation

```bash
npx skills add alexgenovese/skills-sh-repo-structurer
```

## Usage

After installation, ask your agent:

- *"Scaffold a new skill repo for my tool"*
- *"Scaffold a new agent repo called browser-automation"*
- *"Validate my repo structure"*

## Validation

Run the validation script directly on any repo:

```bash
bash skills/repo-structurer/scripts/validate.sh <path-to-repo>
```

## Repo structures supported

### Skill repo

```
my-skill-repo/
  skills/
    <skill-name>/
      SKILL.md
      examples/
      scripts/
  README.md
  LICENSE
```

### Agent repo

```
my-agent-repo/
  skills/
    <agent-name>/
      SKILL.md
      examples/
      scripts/
  AGENTS.md
  README.md
  package.json
  LICENSE
```

## License

MIT

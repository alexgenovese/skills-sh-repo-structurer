# Skill: repo-structurer

Use this skill when the user wants to scaffold, validate, or restructure a repository for an AI agent or a skill following the skills.sh / Agent Skills spec.

## Overview

This skill provides:
- Standard folder structures for **agent repos** and **skill repos**.
- A validation script (`validate.sh`) that checks folders, required files, and references.
- Bash commands to scaffold a new repo from scratch.

## When to use

- User says "create a new agent repo" or "create a new skill repo".
- User asks "is my repo structure correct for skills.sh?".
- User wants to validate a `SKILL.md` or `AGENTS.md` file.
- User asks what files are required or recommended.

## Agent repo structure

```
my-agent-repo/
  .github/                # optional
  skills/
    <agent-name>/
      SKILL.md            # agent instructions (required)
      examples/           # example prompts / outputs (recommended)
      scripts/            # optional helper scripts
  AGENTS.md               # agent identity and triggers (recommended)
  README.md               # human-facing docs (required)
  package.json            # if Node.js based
  LICENSE
```

## Skill repo structure

```
my-skill-repo/
  .github/                # optional
  skills/
    <skill-name>/
      SKILL.md            # required — metadata + instructions
      examples/           # example prompts / outputs (recommended)
      scripts/            # optional helper scripts
  README.md               # required
  AGENTS.md               # optional (cross-skill context)
  CONTRIBUTING.md         # optional
  LICENSE                 # recommended
  validate.sh             # validation script
```

## Validation rules

- `SKILL.md` must exist inside every subfolder of `skills/`.
- `README.md` must exist at repo root.
- `AGENTS.md` is recommended for agent repos.
- `skills/` directory must contain at least one subfolder.
- `examples/` directory is recommended inside each skill folder.

## Quick scaffold — skill repo

```bash
mkdir -p skills/<skill-name>/examples skills/<skill-name>/scripts
touch skills/<skill-name>/SKILL.md
touch README.md LICENSE
```

## Quick scaffold — agent repo

```bash
mkdir -p skills/<agent-name>/examples skills/<agent-name>/scripts
touch skills/<agent-name>/SKILL.md
touch AGENTS.md README.md LICENSE
```

## Validate after scaffolding

```bash
bash skills/repo-structurer/scripts/validate.sh .
```

## Reference repos

- Skill standard: https://github.com/coreyhaines31/marketingskills
- Agent standard: https://github.com/vercel-labs/agent-browser

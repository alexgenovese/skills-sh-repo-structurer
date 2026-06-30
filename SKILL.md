---
name: repo-structurer
description: "Use when the user wants to analyze a project and scaffold it into a skill or agent repository following the skills.sh specification. Also use for 'scaffold a skill', 'scaffold an agent', 'validate repo structure', or providing project scaffolding for AI agents and skills."
metadata:
  version: 2.0.0
  author: Alex Genovese
---

# Repo Structurer Skill

Scaffolds and validates repositories for AI agents and skills following the **skills.sh** / Agent Skills spec (`npx skills add <owner>/<repo>`).

## Capabilities

This skill can:

1. **Analyze project structure**
   - Read repository root directory
   - Identify project type (web app, CLI, script, etc.)
   - Detect technology stack from package manager files
   - Understand project purpose from README and source files

2. **Scaffold skill repositories**
   - Create single-skill repos with proper structure
   - Generate valid SKILL.md files with required frontmatter
   - Set up examples/ and scripts/ directories
   - Include README.md with complete documentation

3. **Scaffold agent repositories**
   - Create multi-skill agent repos
   - Generate AGENTS.md for orchestration
   - Set up multiple skill subdirectories
   - Configure routing and task distribution

4. **Validate repositories**
   - Check SKILL.md frontmatter compliance
   - Verify folder structure matches spec
   - Report errors and warnings
   - Provide remediation guidance

## Usage Examples

### Analyze and scaffold a project

```
Scaffold a skill repo for my project at ./my-tool
Analyze this project and convert it to a skills.sh skill
Turn this CLI tool into a skill.sh skill
Scaffold a new skill repo following best practices
```

### Scaffold skill repositories

```
Scaffold a new skill repo for password manager
Scaffold agent-repo for browser automation
Create skill repo structure for my coding tutor
```

### Scaffold agent repositories

```
Scaffold a new agent repo called sales-manager
Create an agent repo that coordinates multiple skills
Scaffold agent repository for content moderation
```

### Validate repositories

```
Validate my repository structure
Is this repo structure correct for skills.sh?
Validate repo and fix issues
Check if SKILL.md has proper frontmatter
```

## Repository Structure

### Input: Any project

The skill accepts any project structure and will:

1. Read the root directory
2. Analyze files and determine project type
3. Generate appropriate skills.sh structure
4. Provide migration guidance

### Output: skills.sh compliant repo

After processing, the project becomes:

**For Single Skills:**

```
my-skill-repo/
  skills/
    <skill-name>/
      SKILL.md              # with valid frontmatter
      examples/             # sample usage
      scripts/              # helper scripts
  README.md                 # documentation
  LICENSE
```

**For Agents (Multiple Skills):**

```
my-agent-repo/
  skills/
    <skill-1-name>/
      SKILL.md
    <skill-2-name>/
      SKILL.md
  AGENTS.md                 # orchestration guide
  README.md
  LICENSE
```

## Features

- ✅ **Project Analysis** - Understand any repository
- ✅ **Auto-Scaffolding** - Generate proper skills.sh structure
- ✅ **Frontmatter Validation** - Ensure SKILL.md compliance
- ✅ **Validation Script** - Automated structure checking
- ✅ **Documentation Generation** - Complete README creation

## Requirements

- Node.js 18+
- npm or yarn
- skills.sh CLI: `npx skills`

## References

- [skills.sh Documentation](https://skills.sh)
- [Agent Skills Spec](https://github.com/skills/spec)
- [Agent Browser Example](https://github.com/vercel-labs/agent-browser)
- [Skills Example](https://github.com/coreyhaines31/marketingskills)

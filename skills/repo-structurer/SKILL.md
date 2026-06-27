---
name: repo-structurer
description: "Use this skill when the user wants to scaffold, validate, or restructure a repository for an AI agent or a skill following the skills.sh / Agent Skills spec. Also use when the user asks 'is my repo structure correct?', 'create a new agent repo', 'create a new skill repo', 'scaffold a skill', or wants to validate a SKILL.md or AGENTS.md file."
metadata:
  version: 2.0.0
  author: Alex Genovese
---

# Skill: repo-structurer

Scaffold, validate, and fix repositories for AI skills and agents following the **skills.sh / Agent Skills** installation spec (`npx skills add <owner>/<repo>`).

---

## Critical: SKILL.md Frontmatter Requirements

This is the most common failure point. **Every `SKILL.md` file MUST begin with a valid YAML frontmatter block.** Without it, `npx skills add` will fail to register the skill and the agent will not be able to invoke it.

### Required frontmatter fields

```yaml
---
name: <skill-name>          # REQUIRED — must match the folder name exactly (e.g. sales-prospect)
description: "..."          # REQUIRED — plain English, quoted string, 1-3 sentences
                            #   • Starts with "Use when the user wants to..."
                            #   •  Lists the /command that triggers this skill
                            #   • Lists 2-4 natural-language phrases a user might say
metadata:
  version: 1.0.0            # REQUIRED
  author: <your name>       # REQUIRED
---
```

### Good description example

```yaml
description: "Use when the user wants to qualify a lead, score a prospect, or evaluate whether an account is worth pursuing. Also use for '/sales qualify <url>', 'is this a good lead', 'qualify this prospect', or 'BANT score this company'."
```

### Bad description examples (will cause the skill to be skipped or misrouted)

```yaml
# Too short — no invocation command, no user phrases
description: "Qualify leads."

# Missing quotes — YAML parse error
description: Use for qualifying leads: BANT, MEDDIC.

# No frontmatter at all — skill will not install
# Sales Qualify Skill
# ...
```

### Frontmatter validation checklist

- [ ] File starts with `---` on line 1 (no blank lines, no BOM)
- [ ] `name:` value is lowercase, hyphenated, matches the folder name exactly
- [ ] `description:` value is a quoted string (use double quotes)
- [ ] Description includes the slash command that triggers the skill (e.g. `/sales qualify <url>`)
- [ ] Description includes 2-4 natural-language invocation phrases
- [ ] `metadata.version` is a valid semver string
- [ ] `metadata.author` is present
- [ ] Closing `---` on its own line immediately before the Markdown body
- [ ] No tabs in the YAML block — only spaces

---

## Repository Structures

### Single-skill repo

Use when publishing one focused skill (e.g. `my-email-writer`).

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

### Multi-skill repo (agent / skill pack)

Use when publishing a suite of related skills (e.g. `sales-manager` with 14 sub-skills).

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

**Important structural rules:**
- Each skill lives in its own subfolder of `skills/`. Do not put all skills in a single `SKILL.md` at the root.
- Folder name = `name:` value in the frontmatter. They must match exactly.
- No subdirectory nesting inside a skill folder (e.g. `skills/sales/qualify/` is wrong; use `skills/sales-qualify/`).

---

## SKILL.md Body — What to Include

After the frontmatter, the body is free-form Markdown. Use this structure as a starting point:

```markdown
# <Skill Title>

<One paragraph: what this skill does and what problem it solves.>

## Invocation

\`\`\`
/<command> <required-arg> [optional-arg]
\`\`\`

## Steps

Describe what the skill does step by step. Be precise — this is what the agent reads.

## Output

Describe what the skill produces: files written, format, naming convention.

## Rules and Constraints

List anything the skill must NEVER do or must ALWAYS do.
```

**Body writing rules:**
- Be explicit. Agents follow instructions literally — ambiguity produces inconsistent output.
- Every output the skill produces should have a filename and format specified (e.g. `PROSPECT-ANALYSIS.md`).
- If the skill reads files produced by other skills, name them explicitly.
- If the skill uses external tools (WebFetch, WebSearch, bash), state that clearly.
- Add a `## Rules and Constraints` section for any non-obvious requirements.

---

## AGENTS.md — When and How to Write It

Include an `AGENTS.md` at the root of multi-skill (agent) repos. It tells the orchestrating agent:
- Which skill handles which command
- How skills share context (which files each skill reads/writes)
- The recommended order of operations for common workflows

```markdown
# Agent: <Name>

## Skill Routing

| Command | Skill folder | Trigger phrases |
|---|---|---|
| `/sales prospect <url>` | `skills/sales-prospect` | "full prospect audit", "analyze this company" |
| `/sales qualify <url>` | `skills/sales-qualify` | "qualify this lead", "is this worth pursuing" |

## Shared Context Files

Skills read and write these files in the working directory:

| File | Written by | Read by |
|---|---|---|
| `PROSPECT-ANALYSIS.md` | `sales-prospect` | `sales-prep`, `sales-proposal` |
| `LEAD-QUALIFICATION.md` | `sales-qualify` | `sales-prep`, `sales-outreach` |
```

---

## README.md Requirements

The README is required and must include:

1. **What the skill/agent does** — one clear paragraph
2. **Installation** — `npx skills add <owner>/<repo>`
3. **Every skill listed** with its invocation command and a one-line description
4. **At least one usage example per skill** — show real command + expected output
5. **How skills chain together** if it's a multi-skill repo

---

## Quick Scaffold Commands

### Single skill

```bash
SKILL=my-skill-name
mkdir -p skills/$SKILL/examples skills/$SKILL/scripts
cat > skills/$SKILL/SKILL.md << 'EOF'
---
name: my-skill-name
description: "Use when the user wants to ... Also use for '/my-command <arg>', 'do X', or 'help me with Y'."
metadata:
  version: 1.0.0
  author: Your Name
---

# My Skill

Brief description of what this skill does.

## Invocation

```
/my-command <arg>
```

## Steps

1. ...

## Output

Writes `OUTPUT.md` to the current working directory.
EOF
touch README.md LICENSE
```

### Multi-skill agent pack

```bash
for SKILL in skill-one skill-two skill-three; do
  mkdir -p skills/$SKILL/examples
  cat > skills/$SKILL/SKILL.md << EOF
---
name: $SKILL
description: "Use when the user wants to ... Also use for '/$SKILL <arg>'."
metadata:
  version: 1.0.0
  author: Your Name
---

# ${SKILL^}

Describe what this skill does.
EOF
done
touch AGENTS.md README.md LICENSE
```

---

## Validation Rules (for `validate.sh`)

Run after scaffolding or before publishing:

```bash
bash skills/repo-structurer/scripts/validate.sh .
```

The script checks:

| Rule | Severity |
|---|---|
| `skills/` directory exists | Error |
| At least one subfolder inside `skills/` | Error |
| Every skill subfolder contains `SKILL.md` | Error |
| `SKILL.md` starts with `---` on line 1 | Error |
| `name:` field is present in frontmatter | Error |
| `name:` value matches the folder name | Error |
| `description:` field is present and quoted | Error |
| `metadata.version` is present | Warning |
| `metadata.author` is present | Warning |
| `README.md` exists at repo root | Error |
| `examples/` directory exists in each skill folder | Warning |
| `AGENTS.md` exists (multi-skill repos only) | Warning |

**Errors** block installation. **Warnings** are skipped but reduce skill reliability.

---

## Common Mistakes and Fixes

| Mistake | Symptom | Fix |
|---|---|---|
| Missing frontmatter entirely | Skill not found after `npx skills add` | Add `---` block with `name:` and `description:` at line 1 |
| `name:` doesn't match folder | Skill installed under wrong name | Rename folder OR change `name:` to match |
| Unquoted description with `:` in it | YAML parse error | Wrap `description:` value in double quotes |
| All skills in one file | Only one skill installs | Split into one folder + `SKILL.md` per skill |
| Nested skill folders (`skills/sales/qualify/`) | Skill not discovered | Flatten to `skills/sales-qualify/` |
| No `description:` invocation phrases | Skill is never auto-triggered | Add command and natural-language phrases to description |
| Tabs in YAML frontmatter | YAML parse error | Replace all tabs with spaces |

---

## Reference Repos

- Well-structured multi-skill repo: https://github.com/alexgenovese/sales-manager
- Skill standard reference: https://github.com/coreyhaines31/marketingskills
- Agent standard reference: https://github.com/vercel-labs/agent-browser

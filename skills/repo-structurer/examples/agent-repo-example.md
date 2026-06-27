# Example: scaffold a new agent repo

## Prompt

"Create an agent repo for my browser-automation agent"

## Expected scaffold

```
browser-automation/
  skills/
    browser-automation/
      SKILL.md
      examples/
      scripts/
  AGENTS.md
  README.md
  package.json
  LICENSE
```

## AGENTS.md starter

```markdown
# Agent: browser-automation

## Role

Browser automation specialist.

## Triggers

- User asks to open a browser.
- User asks to navigate, click, or screenshot.

## Workflow

1. Open browser.
2. Execute requested action.
3. Return result or screenshot.
```

## Bash commands

```bash
mkdir -p skills/browser-automation/examples skills/browser-automation/scripts
touch skills/browser-automation/SKILL.md
touch AGENTS.md README.md LICENSE
bash skills/repo-structurer/scripts/validate.sh .
```

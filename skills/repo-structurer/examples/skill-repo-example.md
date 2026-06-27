# Example: scaffold a new skill repo

## Prompt

"Create a skill repo for my weather-checker skill"

## Expected scaffold

```
weather-checker/
  skills/
    weather-checker/
      SKILL.md
      examples/
      scripts/
  README.md
  LICENSE
  validate.sh
```

## SKILL.md starter

```markdown
# Skill: weather-checker

Use this skill when the user asks for weather information.

## When to use

- User asks "what's the weather?"
- User mentions a city and weather.

## Instructions

1. Ask for location if not provided.
2. Fetch weather data.
3. Summarize in one concise sentence.
```

## Bash commands

```bash
mkdir -p skills/weather-checker/examples skills/weather-checker/scripts
touch skills/weather-checker/SKILL.md
touch README.md LICENSE
bash skills/repo-structurer/scripts/validate.sh .
```

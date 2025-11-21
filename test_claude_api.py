#!/usr/bin/env python3
"""Simple test script to connect to Claude API."""

import anthropic


def test_claude_api():
    """Send a test message to Claude API and print the response."""
    client = anthropic.Anthropic()

    message = client.messages.create(
        model="claude-sonnet-4-20250514",
        max_tokens=1024,
        messages=[
            {"role": "user", "content": "Hello! Please respond with a short greeting."}
        ]
    )

    print("Response from Claude:")
    print(message.content[0].text)
    return message


if __name__ == "__main__":
    test_claude_api()

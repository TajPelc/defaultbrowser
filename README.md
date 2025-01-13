# defaultbrowser

Command line tool for setting the default browser (HTTP handler) in macOS X.

## Install

Build it:

```
make
```

Install it into your executable path:

```
make install
```

## Usage

Set the default browser with, e.g.:

```
defaultbrowser chrome
```

Return the currently default browser name:

```
defaultbrowser --which
```

Running `defaultbrowser` without arguments lists available HTTP handlers and shows the current setting.

## How does it work?

The code primarily uses the [NSWorkspace API](https://developer.apple.com/documentation/appkit/nsworkspace) from AppKit to detect and query browsers, with a minimal use of Launch Services for setting the default handler. This implementation provides a more modern and stable approach for managing default browser settings in macOS and has been tested on MacOS 15.2.

## Raycast Extension

A Raycast extension is included that allows you to quickly toggle between Chrome and Safari as your default browser.

### Installing the Raycast Extension

1. Make sure you have [Raycast](https://raycast.com/) installed
2. Copy the `raycast/defaultbrowser` script to your Raycast scripts directory:
   ```
   mkdir -p ~/.raycast/scripts
   cp raycast/defaultbrowser ~/.raycast/scripts/
   ```
3. In Raycast, the command will appear as "Toggle Default Browser" under the Browser category

The extension requires the `defaultbrowser` CLI tool to be installed first.

## Additional Resources

- [Bash completion](https://github.com/jonasbn/bash_completion_defaultbrowser) for `defaultbrowser`

## License

MIT

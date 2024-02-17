#!/bin/sh
set -eu

SCRIPT_DIR=$( cd "$( dirname "$0" )" && pwd )
TARGET_DIR="$PWD"

usage() {
    echo "Rsync templates to your repo"
    echo "Usage: vendor.sh [--help]"
    echo "Examples:"
    echo "  # Vendor all templates to the current working directory (dry-run)"
    echo "  /path/to/Generate-DockerImageVariantsTemplates/vendor.sh -n"
    echo
    echo "  # Vendor all templates to the current working directory"
    echo "  /path/to/Generate-DockerImageVariantsTemplates/vendor.sh"
    echo
    echo "  # Vendor CI templates to the current working directory"
    echo "  /path/to/Generate-DockerImageVariantsTemplates/vendor.sh ci"
}

# Exit if we got no options
# if [ $# -eq 0 ]; then usage; exit 1; fi

# Get some options
while test $# -gt 0; do
    case "$1" in
        -h|--help)
            usage
            exit 0
            ;;
        -n|--dry-run)
            DRY_RUN=1
            shift
            ;;
        ci)
            SUBCOMMAND_CI=1
            shift
            ;;
        *)
            echo "Invalid option '$1'" 1>&2
            usage
            exit 1
            ;;
    esac
done

SUBCOMMAND_CI=${SUBCOMMAND_CI:-}
DRY_RUN=${DRY_RUN:-}

if [ -n "$DRY_RUN" ]; then
    set -- '-n'
fi

if [ "$SUBCOMMAND_CI" ]; then
    (
        cd "$SCRIPT_DIR"
        rsync -av .github .vscode generate LICENSE Update-Versions.ps1 "$TARGET_DIR" --exclude=generate/definitions --exclude='generate/templates/*.ps1' "$@"
    )
else
    (
        cd "$SCRIPT_DIR"
        rsync -av .github .vscode generate LICENSE Update-Versions.ps1 "$TARGET_DIR" "$@"
    )
fi

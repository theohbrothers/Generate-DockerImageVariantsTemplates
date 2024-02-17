@"
# Generate-DockerImageVariantsTemplates

[![github-actions](https://github.com/theohbrothers/Generate-DockerImageVariantsTemplates/workflows/ci-master-pr/badge.svg)](https://github.com/theohbrothers/Generate-DockerImageVariantsTemplates/actions)
[![github-release](https://img.shields.io/github/v/release/theohbrothers/Generate-DockerImageVariantsTemplates?style=flat-square)](https://github.com/theohbrothers/Generate-DockerImageVariantsTemplates/releases/)
[![docker-image-size](https://img.shields.io/docker/image-size/theohbrothers/Generate-DockerImageVariantsTemplates/latest)](https://hub.docker.com/r/theohbrothers/Generate-DockerImageVariantsTemplates)

Dockerized [webize](https://github.com/theohbrothers/webize) with useful tools.

## Tags

| Tag | Dockerfile Build Context |
|:-------:|:---------:|
$(
($VARIANTS | % {
    if ( $_['tag_as_latest'] ) {
@"
| ``:$( $_['tag'] )``, ``:latest`` | [View](variants/$( $_['tag'] )) |

"@
    }else {
@"
| ``:$( $_['tag'] )`` | [View](variants/$( $_['tag'] )) |

"@
    }
}) -join ''
)
All variants are based on ``alpine``.


"@

@'
## Development

Requires Windows `powershell` or [`pwsh`](https://github.com/PowerShell/PowerShell).

```powershell
# Install Generate-DockerImageVariants module: https://github.com/theohbrothers/Generate-DockerImageVariants
Install-Module -Name Generate-DockerImageVariants -Repository PSGallery -Scope CurrentUser -Force -Verbose

# Edit ./generate templates

# Generate the variants
Generate-DockerImageVariants .
```

### Variant versions

[versions.json](generate/definitions/versions.json) contains a list of [Semver](https://semver.org/) versions, one per line.

To update versions in `versions.json`:

```powershell
./Update-Versions.ps1
```

To update versions in `versions.json`, and open a PR for each changed version, and merge successful PRs one after another (to prevent merge conflicts), and finally create a tagged release and close milestone:

```powershell
$env:GITHUB_TOKEN = 'xxx'
./Update-Versions.ps1 -PR -AutoMergeQueue -AutoRelease
```

To perform a dry run, use `-WhatIf`.

'@

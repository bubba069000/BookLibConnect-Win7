$ErrorActionPreference = "Stop"

function Replace-Exact([string]$Path, [string]$Old, [string]$New) {
  $content = [System.IO.File]::ReadAllText($Path)
  if (-not $content.Contains($Old)) {
    throw "Expected text was not found in $Path; refusing an uncertain patch."
  }
  $content = $content.Replace($Old, $New)
  [System.IO.File]::WriteAllText($Path, $content, [System.Text.UTF8Encoding]::new($false))
}

function Replace-Regex([string]$Path, [string]$Pattern, [string]$Replacement) {
  $content = [System.IO.File]::ReadAllText($Path)
  $updated = [regex]::Replace($content, $Pattern, $Replacement)
  if ($updated -eq $content) {
    throw "Expected pattern was not found in $Path; refusing an uncertain patch."
  }
  [System.IO.File]::WriteAllText($Path, $updated, [System.Text.UTF8Encoding]::new($false))
}

# The complete application is Windows-only. Target every project in its
# dependency graph consistently so Windows-specific references remain compatible.
$projects = Get-ChildItem "source/src" -Filter "*.csproj" -Recurse
foreach ($project in $projects) {
  $projectText = [System.IO.File]::ReadAllText($project.FullName)
  if ($projectText.Contains('<TargetFramework>net8.0</TargetFramework>')) {
    Replace-Exact $project.FullName '<TargetFramework>net8.0</TargetFramework>' '<TargetFramework>net8.0-windows7.0</TargetFramework>'
  }
  elseif (-not $projectText.Contains('<TargetFramework>net8.0-windows7.0</TargetFramework>')) {
    throw "Unexpected target framework in $($project.FullName); refusing an uncertain patch."
  }
}

# Pin the transitive Git build task to the fixed release for CVE-2026-62900.
# It is a build-only dependency and is excluded from published application assets.
$appProjectPath = "source/src/Connect.app.gui.core/Connect.app.gui.core.csproj"
Replace-Exact $appProjectPath '<PackageReference Include="Microsoft.EntityFrameworkCore.Design" Version="9.0.21">' '<PackageReference Include="Microsoft.Build.Tasks.Git" Version="10.0.303"><PrivateAssets>all</PrivateAssets><IncludeAssets>build;buildtransitive</IncludeAssets></PackageReference>`r`n    <PackageReference Include="Microsoft.EntityFrameworkCore.Design" Version="9.0.21">'

# Rename the local alias to avoid the compiler's lowercase-identifier warning.
$convertPath = "source/src/Connect.ui.lib.core/ConvertDGVControl.cs"
Replace-Exact $convertPath 'using abl = core.audiamus.booksdb;' 'using ABL = core.audiamus.booksdb;'
Replace-Exact $convertPath 'HashSet<abl.Component>' 'HashSet<ABL.Component>'
Replace-Exact $convertPath 'IEnumerable<abl.Component>' 'IEnumerable<ABL.Component>'

# The splitter persistence fields are never assigned upstream; use the same
# existing defaults directly instead of retaining permanently-null fields.
$formPath = "source/src/Connect.ui.lib.core/BookLibForm.cs"
Replace-Regex $formPath '    private static double\? __relSplitterDistBottom;\r?\n    private static double\? __relSplitterDistInner;\r?\n' ''
Replace-Exact $formPath '__relSplitterDistBottom ?? REL_SPLITTER_DIST_BOTTOM' 'REL_SPLITTER_DIST_BOTTOM'
Replace-Exact $formPath '__relSplitterDistInner ?? REL_SPLITTER_DIST_INNER' 'REL_SPLITTER_DIST_INNER'

Write-Host "Applied Windows platform targets and upstream compiler-warning fixes."

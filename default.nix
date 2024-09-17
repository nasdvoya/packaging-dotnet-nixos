{ pkgs ? import <nixpkgs> {} }:

let
  buildDotnetModule = pkgs.buildDotnetModule;
  dotnetCorePackages = pkgs.dotnetCorePackages.dotnet_8; # Or the appropriate version
  ffmpeg = pkgs.ffmpeg;
  referencedProject = import ./src/ExampleClassLibrary { };
in buildDotnetModule rec {
  # See:
  # https://nixos.org/guides/nix-pills/19-fundamentals-of-stdenv
  # https://nixos.org/manual/nixpkgs/stable/#chap-stdenv
  # https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/dotnet.section.md
  pname = "FoundationWorker";
  version = "0.1";
  src = ./.;

  projectFile = "src/ExampleWorker/ExampleWorker.csproj";
  nugetDeps = ./deps.nix; # see "Generating and updating NuGet dependencies" section for details

  dotnet-sdk = dotnetCorePackages.sdk;
  dotnet-runtime = dotnetCorePackages.runtime;
  selfContainedBuild = true;
    
  # "executables" is optional. Remove to use default, specify a list of executables 
  # or leave empty to not install any executables.
  # executables = [ "ExampleWorker" ];
  executables = ["ExampleWorker"]; # Don't install any executables.

  packNupkg = true; # This packs the project as "foo-0.1.nupkg" at `$out/share`.

  runtimeDeps = [ ffmpeg ]; # This will wrap ffmpeg's library path into `LD_LIBRARY_PATH`.
}

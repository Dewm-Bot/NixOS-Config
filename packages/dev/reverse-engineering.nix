{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        ghidra        # Disassembler / decompiler
        imhex         # Hex editor with pattern language
        radare2       # CLI reverse engineering framework
        binwalk       # Binary / firmware carving
        frida-tools   # Dynamic instrumentation
        dotnet-sdk_8  # For building Il2CppDumper / Cpp2IL (not in nixpkgs)
    ];
}

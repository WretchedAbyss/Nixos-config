{ pkgs, lib, ... }:

{
  vim = {
    theme = {
        enable = true;
        name = "gruvbox";
        style = "dark";
        };
    diagnostics.nvim-lint.enable = true;
    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
    lsp.enable = true;
    languages = {
        #enableLSP = true;
        enableTreesitter = true;


        assembly.enable = true;
        #assembly.format.enable = true; 
        nix.enable = true;
        nix.format.enable = true;
        ts.enable = true;
        #ts.format.enable = true;
        rust.enable = true;
        rust.format.enable = true;
        clang.enable = true;
        #clang.format.enable = true;
        css.enable = true;
        #css.format.enable = true; 
        html.enable = true;
        #html.format.enable = true;
        python.enable = true;
        python.format.enable = true;
        zig.enable = true;
        #zig.format.enable = true;

        markdown.enable = true;
        markdown.format.enable = true;
        markdown.extensions.render-markdown-nvim.enable = true;



        
                };
  filetree.neo-tree = {
                enable = true;
                };              
        };
}

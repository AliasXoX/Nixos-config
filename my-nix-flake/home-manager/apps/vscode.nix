{ pkgs , ... }:
{
	programs.vscode = {
		enable = true;
		extensions = [ pkgs.vscode-extensions.shopify.ruby-lsp ];
	};
}

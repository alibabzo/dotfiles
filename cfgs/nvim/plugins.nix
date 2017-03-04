{ vimUtils, fetchFromGitHub }:
{
  ale = vimUtils.buildVimPluginFrom2Nix {
    name = "ale-1.1.0";
    src = ./../../../Projects/ale;
    dependencies = [];
  };

  denite-nvim = vimUtils.buildVimPluginFrom2Nix {
    name = "denite-nvim-0.1";
    src = fetchFromGitHub {
      owner = "Shougo";
      repo = "denite.nvim";
      rev = "028ae0c5fa73d63aac831d03b066d670c625cf06";
      sha256 = "0sfk3f21pqri38jks1casqv2i3lli2gyhpm18rz4jwbw90h4a096";
    };
    dependencies = [];
  };

  nord-vim = vimUtils.buildVimPluginFrom2Nix {
    name = "nord-vim-2017-02-23";
    src = fetchFromGitHub {
      owner = "arcticicestudio";
      repo = "nord-vim";
      rev = "05d536fe10982612b8b6b0ecef6ee332ae17bc52";
      sha256 = "1pqcjpr0nmzx35mjk5mj9dg2x0mlws8vw2ggryqar1rnw73vqr8n";
    };
    dependencies = [];
  };
}

{ vimUtils, fetchFromGitHub }:
{
  ale = vimUtils.buildVimPluginFrom2Nix {
    name = "ale-2017-03-06";
    src = fetchFromGitHub {
      owner = "w0rp";
      repo = "ale";
      rev = "ad49846a48beab2ed7fe58a799e6a53e99086bb2";
      sha256 = "0n2bz6icirdx39z7mxxccmxj6fzn3pa96k8lnp4ph295haszvlb0";
    };
  };

  denite-nvim = vimUtils.buildVimPluginFrom2Nix {
    name = "denite-nvim-0.1";
    src = fetchFromGitHub {
      owner = "Shougo";
      repo = "denite.nvim";
      rev = "f2a1f5c89ca093ca286bfaef9e3d53ecb045390e";
      sha256 = "0wvsd91afvrg1rykc9bnmcr38wlz2iz9w8df2b49hvp6zfpq29hr";
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

  vim-one = vimUtils.buildVimPluginFrom2Nix {
    name = "vim-one-2017-03-02";
    src = fetchFromGitHub {
      owner = "rakr";
      repo = "vim-one";
      rev = "ccd2d3c6ee00a1de84016bca506d2cf93048c96e";
      sha256 = "156mhbld92gnvz99d5ns5dzzs2ak3n3501nz0g0sr8nk497c59zc";
    };
  };
}

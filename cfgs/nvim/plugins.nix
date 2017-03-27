{ vimUtils, fetchFromGitHub }:
let buildVimPlugin = vimUtils.buildVimPluginFrom2Nix;
in
{
  ale = buildVimPlugin {
    name = "ale-2017-03-24";
    src = fetchFromGitHub {
      owner = "w0rp";
      repo = "ale";
      rev = "822b19ac8376677d73c4df5ce80ed708a1cabd8b";
      sha256 = "01942mjn1p7hyn1y2jlmrzqfwzdmnkcvqjw654iwjirnawiz5cj2";
    };
    dependencies = [];
  };

  nord-vim = buildVimPlugin {
    name = "nord-vim-2017-02-23";
    src = fetchFromGitHub {
      owner = "arcticicestudio";
      repo = "nord-vim";
      rev = "b2134029a0481c4bbb6d0cf586948afbc65818de";
      sha256 = "0ddbc78n71hdmg9fca0cb3iyx7jxs6am1lgzf71srr6r7x8y9fhz";
    };
    dependencies = [];
  };

  vim-one = buildVimPlugin {
    name = "vim-one-2017-03-02";
    src = fetchFromGitHub {
      owner = "rakr";
      repo = "vim-one";
      rev = "ccef53630e9db0acd5e96521b926a9b5ad657867";
      sha256 = "16xaxdn7kniqmdbs545450qak4gygl4lsdvx7jjf4wrdpy9178qf";
    };
    dependencies = [];
  };
}

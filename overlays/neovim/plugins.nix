{ vimUtils, fetchFromGitHub }:
let buildVimPlugin = vimUtils.buildVimPluginFrom2Nix;
in
{
  ale = buildVimPlugin {
    name = "ale-2017-03-24";
    src = fetchFromGitHub {
      owner = "w0rp";
      repo = "ale";
      rev = "3a74d242f9b2b09dd066e5cfd6ed9a0149395b87";
      sha256 = "1cqlni9x3ghn73kkm4v5fnzi4ics9bjkfa7j4jc333qsyrkh1039";
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

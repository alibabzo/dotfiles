{ vimUtils, fetchFromGitHub }:
{
  ale = vimUtils.buildVimPluginFrom2Nix {
    name = "ale-1.1.0";
    src = fetchFromGitHub {
      owner = "w0rp";
      repo = "ale";
      rev = "v1.1.0";
      sha256 = "0mng29dij25n02qzhsjshw55qbimh0gnawvpjivryq3rf6jkwn3i";
    };
    dependencies = [];
  };

  deoplete-nvim = vimUtils.buildVimPluginFrom2Nix {
    name = "deoplete-nvim-2.0";
    src = fetchFromGitHub {
      owner = "Shougo";
      repo = "deoplete.nvim";
      rev = "2.0";
      sha256 = "1xhn20ybwr45yqnibkc41bpbm87qairib682wgbdr0mwwr3nn8vf";
    };
    dependencies = [];
  };

  denite-nvim = vimUtils.buildVimPluginFrom2Nix {
    name = "denite-nvim-0.1";
    src = fetchFromGitHub {
      owner = "Shougo";
      repo = "denite.nvim";
      rev = "0.1";
      sha256 = "0c50q2lpsslv4gzmw0w9c2f4x1wf69c4k94i98ynkgl67dxqpl1z";
    };
    dependencies = [];
  };

  nerdtree = vimUtils.buildVimPluginFrom2Nix {
    name = "vim-vue-2017-01-02";
    src = fetchFromGitHub {
      owner = "scrooloose";
      repo = "nerdtree";
      rev = "281701021c5001332a862da80175bf585d24e2e8";
      sha256 = "07zwhzna5g22scjy2mq4clsgpkfavpgxiqvnfbfydgc52h73l27r";
    };
    dependencies = [];
  };

  vim-colors-pencil = vimUtils.buildVimPluginFrom2Nix {
    name = "vim-colors-pencil-2017-01-12";
    src = fetchFromGitHub {
      owner = "reedes";
      repo = "vim-colors-pencil";
      rev = "a28a0b1e778ae394c495ed34efb89d44a05f11f1";
      sha256 = "15gwyjrwjiqhcpyqp142c0af13ca56zjjnmkhn5ha6mdgikqppbm";
    };
    dependencies = [];
  };
}

{ config, lib, pkgs, inputs, global_utils, ... }:
let
  jsonFormat = pkgs.formats.json { };
  opencodeSettings = {
    model = "zhipuai-coding-plan/glm-5.2";
    small_model = "zhipuai-coding-plan/glm-5";
    theme = "stylix";
    plugin = [ "opencode-pty" "oh-my-opencode" ];
    agent = {
      plan = {
        model = "zhipuai-coding-plan/glm-5.2";
      };
      build = {
        model = "zhipuai-coding-plan/glm-5.2";
      };
      general = {
        model = "zhipuai-coding-plan/glm-5.2";
      };
      explore = {
        model = "zhipuai-coding-plan/glm-5.2";
      };
      title = {
        model = "zhipuai-coding-plan/glm-5";
      };
      summary = {
        model = "zhipuai-coding-plan/glm-5.2";
      };
      compaction = {
        model = "zhipuai-coding-plan/glm-5.2";
      };
    };
  };
  opencodeConfigTemplate = builtins.toJSON ({
    "$schema" = "https://opencode.ai/config.json";
  } // opencodeSettings);
  opencodeConfig = pkgs.writeText "opencode-config.json" opencodeConfigTemplate;
  ohMyOpencodeConfig = jsonFormat.generate "oh-my-opencode.jsonc" {
    agents = {
      # Prometheus/Sisyphus are Claude/GLM-style upstream roles, so use GLM here.
      prometheus = {
        model = "zhipuai-coding-plan/glm-5.2";
        fallback_models = [ "zhipuai-coding-plan/glm-5.2" ];
      };
      plan = {
        model = "zhipuai-coding-plan/glm-5.2";
        fallback_models = [ "zhipuai-coding-plan/glm-5.2" ];
      };

      # Keep GPT-backed roles on GPT; Claude/Gemini-like roles use GLM 5.2.
      atlas = {
        model = "zhipuai-coding-plan/glm-5.2";
        fallback_models = [ "zhipuai-coding-plan/glm-5.2" ];
      };
      general = {
        model = "zhipuai-coding-plan/glm-5.2";
        fallback_models = [ "zhipuai-coding-plan/glm-5.2" ];
      };
      build = {
        model = "zhipuai-coding-plan/glm-5.2";
        fallback_models = [ "zhipuai-coding-plan/glm-5.2" ];
      };
      sisyphus = {
        model = "zhipuai-coding-plan/glm-5.2";
        fallback_models = [ "zhipuai-coding-plan/glm-5.2" ];
      };
      oracle = {
        model = "zhipuai-coding-plan/glm-5.2";
        fallback_models = [ "zhipuai-coding-plan/glm-5.2" ];
      };
      librarian = {
        model = "zhipuai-coding-plan/glm-5.2";
        fallback_models = [ "zhipuai-coding-plan/glm-5.2" ];
      };
      explore = {
        model = "zhipuai-coding-plan/glm-5.2";
        fallback_models = [ "zhipuai-coding-plan/glm-5.2" ];
      };
      multimodal-looker = {
        model = "zhipuai-coding-plan/glm-5v-turbo";
        fallback_models = [ "zhipuai-coding-plan/glm-5.2" ];
      };
      hephaestus = {
        model = "zhipuai-coding-plan/glm-5.2";
        fallback_models = [ "zhipuai-coding-plan/glm-5.2" ];
      };
      title = {
        model = "zhipuai-coding-plan/glm-5";
        fallback_models = [ "zhipuai-coding-plan/glm-5.2" ];
      };
      summary = {
        model = "zhipuai-coding-plan/glm-5.2";
        fallback_models = [ "zhipuai-coding-plan/glm-5.2" ];
      };
      compaction = {
        model = "zhipuai-coding-plan/glm-5.2";
        fallback_models = [ "zhipuai-coding-plan/glm-5.2" ];
      };
    };
    categories = {
      planning = {
        model = "zhipuai-coding-plan/glm-5.2";
        fallback_models = [ "zhipuai-coding-plan/glm-5.2" ];
      };
      visual-engineering = {
        model = "zhipuai-coding-plan/glm-5.2";
        fallback_models = [ "zhipuai-coding-plan/glm-5.2" ];
      };
      ultrabrain = {
        model = "zhipuai-coding-plan/glm-5.2";
        fallback_models = [ "zhipuai-coding-plan/glm-5.2" ];
      };
      deep = {
        model = "zhipuai-coding-plan/glm-5.2";
        fallback_models = [ "zhipuai-coding-plan/glm-5.2" ];
      };
      quick = {
        model = "zhipuai-coding-plan/glm-5.2";
        fallback_models = [ "zhipuai-coding-plan/glm-5.2" ];
      };
      unspecified-low = {
        model = "zhipuai-coding-plan/glm-5.2";
        fallback_models = [ "zhipuai-coding-plan/glm-5.2" ];
      };
      unspecified-high = {
        model = "zhipuai-coding-plan/glm-5.2";
        fallback_models = [ "zhipuai-coding-plan/glm-5.2" ];
      };
      writing = {
        model = "zhipuai-coding-plan/glm-5.2";
        fallback_models = [ "zhipuai-coding-plan/glm-5.2" ];
      };
    };
    background_task = {
      providerConcurrency = {
        openai = 3;
      };
    };
    runtime_fallback = {
      enabled = true;
      retry_on_errors = [ 400 429 503 529 ];
      max_fallback_attempts = 3;
      notify_on_fallback = true;
    };
  };
in
{
  home.packages = [
    pkgs.bubblewrap
    global_utils.pkgs-unstable.opencode
  ];
  programs.codex = {
    enable = true;
    package = inputs.codex-cli-nix.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      mcp_servers = {
        # git = {
        #   command = "uvx";
        #   args = ["mcp-server-git"];
        # };
      };
    };
  };

  xdg.configFile."opencode/config.json".source = opencodeConfig;
  xdg.configFile."opencode/oh-my-opencode.jsonc".source = ohMyOpencodeConfig;
  xdg.configFile."opencode/oh-my-openagent.jsonc".source = ohMyOpencodeConfig;
}

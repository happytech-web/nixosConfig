{ config, lib, pkgs, inputs, global_utils, ... }:
let
  jsonFormat = pkgs.formats.json { };
  opencodeSettings = {
    model = "openai/gpt-5.4";
    small_model = "zhipuai-coding-plan/glm-5";
    theme = "stylix";
    plugin = [ "opencode-pty" "oh-my-opencode" ];
    agent = {
      plan = {
        model = "zhipuai-coding-plan/glm-5.1";
      };
      build = {
        model = "zhipuai-coding-plan/glm-5.1";
      };
      general = {
        model = "zhipuai-coding-plan/glm-5.1";
      };
      explore = {
        model = "zhipuai-coding-plan/glm-5.1";
      };
      title = {
        model = "zhipuai-coding-plan/glm-5";
      };
      summary = {
        model = "openai/gpt-5.4-mini";
      };
      compaction = {
        model = "openai/gpt-5.4-mini";
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
        model = "zhipuai-coding-plan/glm-5.1";
        fallback_models = [ "openai/gpt-5.4" ];
      };
      plan = {
        model = "zhipuai-coding-plan/glm-5.1";
        fallback_models = [ "openai/gpt-5.4" ];
      };

      # Keep GPT-backed roles on GPT; Claude/Gemini-like roles use GLM 5.1.
      atlas = {
        model = "zhipuai-coding-plan/glm-5.1";
        fallback_models = [ "openai/gpt-5.4" ];
      };
      general = {
        model = "zhipuai-coding-plan/glm-5.1";
        fallback_models = [ "openai/gpt-5.4" ];
      };
      build = {
        model = "zhipuai-coding-plan/glm-5.1";
        fallback_models = [ "openai/gpt-5.4" ];
      };
      sisyphus = {
        model = "zhipuai-coding-plan/glm-5.1";
        fallback_models = [ "openai/gpt-5.4" ];
      };
      oracle = {
        model = "openai/gpt-5.4";
        fallback_models = [ "zhipuai-coding-plan/glm-5.1" ];
      };
      librarian = {
        model = "zhipuai-coding-plan/glm-5.1";
        fallback_models = [ "openai/gpt-5.4" ];
      };
      explore = {
        model = "zhipuai-coding-plan/glm-5.1";
        fallback_models = [ "openai/gpt-5.4" ];
      };
      multimodal-looker = {
        model = "zhipuai-coding-plan/glm-5v-turbo";
        fallback_models = [ "openai/gpt-5.4" ];
      };
      hephaestus = {
        model = "openai/gpt-5.4";
        fallback_models = [ "zhipuai-coding-plan/glm-5.1" ];
      };
      title = {
        model = "zhipuai-coding-plan/glm-5";
        fallback_models = [ "openai/gpt-5-nano" ];
      };
      summary = {
        model = "openai/gpt-5.4-mini";
        fallback_models = [ "zhipuai-coding-plan/glm-5.1" ];
      };
      compaction = {
        model = "openai/gpt-5.4-mini";
        fallback_models = [ "zhipuai-coding-plan/glm-5.1" ];
      };
    };
    categories = {
      planning = {
        model = "zhipuai-coding-plan/glm-5.1";
        fallback_models = [ "openai/gpt-5.4" ];
      };
      visual-engineering = {
        model = "zhipuai-coding-plan/glm-5v-turbo";
        fallback_models = [ "openai/gpt-5.4" ];
      };
      ultrabrain = {
        model = "openai/gpt-5.4";
        fallback_models = [ "zhipuai-coding-plan/glm-5.1" ];
      };
      deep = {
        model = "openai/gpt-5.4";
        fallback_models = [ "zhipuai-coding-plan/glm-5.1" ];
      };
      quick = {
        model = "zhipuai-coding-plan/glm-5.1";
        fallback_models = [ "openai/gpt-5-nano" ];
      };
      unspecified-low = {
        model = "zhipuai-coding-plan/glm-5.1";
        fallback_models = [ "openai/gpt-5.4" ];
      };
      unspecified-high = {
        model = "openai/gpt-5.4";
        fallback_models = [ "zhipuai-coding-plan/glm-5.1" ];
      };
      writing = {
        model = "zhipuai-coding-plan/glm-5.1";
        fallback_models = [ "openai/gpt-5.4" ];
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
    package = inputs.codex-nix.packages.${pkgs.stdenv.hostPlatform.system}.default;
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

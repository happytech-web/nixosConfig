{ config, pkgs, lib, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
  #   matchBlocks = {
  #     # GitHub 走 443 的 ssh
  #     "github.com" = {
  #       hostname = "ssh.github.com";
  #       port = 443;
  #       user = "git";
  #       proxyCommand = "nc -x 127.0.0.1:7897 -X 5 %h %p";
  #     };
  #
  #     "ailab" = {
  #       hostname = "100.88.4.3";
  #       user = "humanoid";
  #       # 关键：覆盖掉你 "*" 的 proxyCommand
  #       proxyCommand = "none";
  #
  #       compression = true;
  #       serverAliveInterval = 30;
  #       serverAliveCountMax = 3;
  #
  #       # 可选：复用连接，提升体验（尤其是频繁 scp/打开文件）
  #       controlMaster = "auto";
  #       controlPersist = "10m";
  #       controlPath = "~/.ssh/cm-%r@%h:%p";
  #     };
  #
  # "hdev" = {
  #   host = "hdev";
  #   hostname = "h.pjlab.org.cn";
  #   user = "caijisong.caijisong+root.ailab-vlaflow.ws";
  #
  #   # 关键：把连接“托管给”ailab 作为跳板，用它的环境/密钥发起第二跳
  #   proxyCommand = "ssh -t ailab ssh -W %h:%p caijisong.caijisong+root.ailab-vlaflow.ws@h.pjlab.org.cn";
  #   # ↑ 这行解释：先 ssh 到 ailab，然后在 ailab 上用 ssh -W 把通道转给最终目标
  #   # 这样最终认证发生在 ailab -> h，由 ailab 的 key 完成
  # };
  #
  #   # H GPU 节点：同样通过 AILab 转发
  #   "hgpu" = {
  #     hostname = "h.pjlab.org.cn";
  #     user = "ws-d29e781d063ab421-worker-8qw59.caijisong+root.ailab-vlaflow.pod";
  #     proxyCommand = "ssh -T ailab -W %h:%p";
  #     port = 22;
  #
  #     forwardX11 = true;
  #     forwardX11Trusted = true;
  #
  #     compression = true;
  #     serverAliveInterval = 30;
  #     serverAliveCountMax = 3;
  #   };
  #
  #
  #     # 其他所有 SSH 也通过本地 SOCKS5
  #     "*" = {
  #       proxyCommand = "nc -x 127.0.0.1:7897 -X 5 %h %p";
  #     };
  #   };
  };

  home.file.".ssh/config".text = ''
Host github.com
  HostName ssh.github.com
  Port 443
  User git
  ProxyCommand nc -x 127.0.0.1:7897 -X 5 %h %p

Host ailab
  HostName 100.88.4.3
  User humanoid
  ProxyCommand none

  Compression yes
  ServerAliveInterval 30
  ServerAliveCountMax 3

  ControlMaster auto
  ControlPersist 10m
  ControlPath ~/.ssh/cm-%r@%h:%p

Host hdev
  HostName 100.88.4.3
  User humanoid
  ProxyCommand none

  RequestTTY force

  RemoteCommand ssh -CAXY caijisong.caijisong+root.ailab-vlaflow.ws@h.pjlab.org.cn

Host hgpu
  HostName 100.88.4.3
  User humanoid
  ProxyCommand none
  RequestTTY force

  RemoteCommand ssh -CAXY ws-d29e781d063ab421-worker-8qw59.caijisong+root.ailab-vlaflow.pod@h.pjlab.org.cn


Host *
  ProxyCommand nc -x 127.0.0.1:7897 -X 5 %h %p
  '';

  home.packages = with pkgs; [
    sshfs
  ];
}

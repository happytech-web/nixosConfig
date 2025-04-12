{ pkgs, ... }:
{
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    settings = {
      mysqld = {
        max_allowed_packet = "256M";
        wait_timeout = 28800;         # 超时时间调整为8小时
        interactive_timeout = 28800;
      };
      mysqldump = {
        quick = true;
        max_allowed_packet = "256M";
      };
    };
  };
}

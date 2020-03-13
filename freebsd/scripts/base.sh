#!/bin/sh

set -ex

freebsd-update --not-running-from-cron fetch install || :

echo security.bsd.see_other_uids=0 >> /etc/sysctl.conf
echo net.inet.tcp.blackhole=2 >> /etc/sysctl.conf
echo net.inet.udp.blackhole=1 >> /etc/sysctl.conf

echo clear_tmp_enable=YES >> /etc/rc.conf
echo sendmail_enable=NONE >> /etc/rc.conf
echo icmp_drop_redirect=YES >> /etc/rc.conf
echo tcp_drop_synfin=YES >> /etc/rc.conf
echo denyhosts_enable=YES >> /etc/rc.conf
echo syslogd_flags=\"-c\" >> /etc/rc.conf
echo daily_rkhunter_update_enable=YES >> /etc/rc.conf
echo daily_rkhunter_update_flags=\"--update --nocolors\" >> /etc/rc.conf
echo daily_rkhunter_check_enable=YES >> /etc/rc.conf
echo daily_rkhunter_check_flags=\"--checkall --nocolors --skip-keypress\" >> /etc/rc.conf

echo '* 0,12 * * * root /usr/sbin/ntpdate pool.ntp.org > /dev/null' >> /etc/crontab

echo WITH_PKGNG=yes >> /etc/make.conf
env ASSUME_ALWAYS_YES=YES pkg bootstrap

pkg update
pkg upgrade -y

pkg install -y rkhunter vim wget sudo unzip nmap git curl rsync zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo 'autoboot_delay="0"' >> /boot/loader.conf

echo "bdowns" | pw useradd bdowns -h 0 -s /bin/sh -G wheel -c "bdowns"
mkdir -pm 700 ~bdowns/.ssh
ssh-keygen -t rsa -f ~bdowns/.ssh/id_rsa -q -P ""
chown -R bdowns:wheel ~bdowns
chsh -s /usr/local/bin/zsh

exit 0

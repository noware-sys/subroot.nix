# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
	config,
	pkgs,
	...
}:

{
	imports =
	[
		# Include the results of the hardware scan.
		./hardware-configuration.nix
		#./mate-theme.nix.bak.4
	];
	
	nix.extraOptions =
	''
		keep-outputs = true
		keep-derivations = true
	'';
		
	nixpkgs.config.allowUnsupportedSystem = true;
	nixpkgs.config.allowUnfree = true;
	
	hardware.cpu.amd.updateMicrocode = true;
	hardware.cpu.intel.updateMicrocode = true;
	
	hardware.enableAllFirmware = true;
	
	#boot.hardwareScan = false;
	
	# Use the GRUB 2 boot loader.
	boot.loader.grub.enable = true;
	boot.loader.grub.version = 2;
	# boot.loader.grub.efiSupport = true;
	# boot.loader.grub.efiInstallAsRemovable = true;
	# boot.loader.efi.efiSysMountPoint = "/boot/efi";
	# Define on which hard drive you want to install Grub.
	#boot.loader.grub.device = "/dev/sdc"; # or "nodev" for efi only
	#
	#boot.loader.grub.device = "/dev/vda"; # or "nodev" for efi only
	boot.loader.grub.device = "/dev/disk/by-id/wwn-0x50014ee259668466";
	
	#boot.loader.grub.gfxmodeEfi = "text";
	#boot.loader.grub.gfxmodeBios = "text";
	boot.loader.grub.gfxmodeBios = "auto";
	boot.loader.grub.splashImage = null;
	
	#boot.loader.grub.default = 4;
	boot.loader.grub.default = 6;
	
	boot.loader.grub.extraEntriesBeforeNixOS = true;
	boot.loader.grub.extraEntries =
	''
		menuentry "/" {
			configfile /boot/grub/grub.cfg
		}
		
		menuentry "." {
			configfile /boot/grub/grub.cfg
		}
		
		menuentry ".." {
			configfile /boot/grub/grub.cfg
		}
		
		# Poweroff
		menuentry "Poweroff" {
			halt
		}
		
		# Reboot
		menuentry "Reboot" {
			reboot
		}
		
		#submenu "Gentoo" {
			menuentry "6NUqgQTTsf7SPWgiFPMWhRJdV7NTrvQL-gentoo-x86_64" {
				configfile /mach/6NUqgQTTsf7SPWgiFPMWhRJdV7NTrvQL-gentoo-x86_64/boot/grub/grub.cfg
			}
		#}
		
		# Fallback entry:
		menuentry "150. NixOS 18.09.2574.a7e559a5504 (2019-08-19 04:25:22 -0400 Mon)" {
			search --set=drive1 --fs-uuid f3f9b214-f0df-44fe-83c5-87bab913d99b
			
			echo 'Loading kernel...'
			linux ($drive1)/nix/store/kj3w4v7nbjhd3d501kqpd17zspn7wh7l-linux-4.14.118/bzImage systemConfig=/nix/store/xh3sg78v7zhhh77r7r1nikfgkz8ik4c3-nixos-system-0bac96c7-a2aa-49ec-baef-b81e5251e124-18.09.2574.a7e559a5504 init=/nix/store/xh3sg78v7zhhh77r7r1nikfgkz8ik4c3-nixos-system-0bac96c7-a2aa-49ec-baef-b81e5251e124-18.09.2574.a7e559a5504/init boot.shell_on_fail loglevel=4
			#linux ($drive1)/mach/D2b6sT0ASCnp7KWOZTgTYJkks73R1dLt-nixos-x86_64/nix/store/kj3w4v7nbjhd3d501kqpd17zspn7wh7l-linux-4.14.118/bzImage systemConfig=/mach/D2b6sT0ASCnp7KWOZTgTYJkks73R1dLt-nixos-x86_64/nix/store/xh3sg78v7zhhh77r7r1nikfgkz8ik4c3-nixos-system-0bac96c7-a2aa-49ec-baef-b81e5251e124-18.09.2574.a7e559a5504 subroot_path=/mach/D2b6sT0ASCnp7KWOZTgTYJkks73R1dLt-nixos-x86_64 subboot_path=/mach/D2b6sT0ASCnp7KWOZTgTYJkks73R1dLt-nixos-x86_64/boot subboot_mount_enabled=true subboot_mount_src=/dev/disk/by-uuid/f3f9b214-f0df-44fe-83c5-87bab913d99b subboot_mount_dest=/boot.d subboot_mount_opt=defaults init=/nix/store/xh3sg78v7zhhh77r7r1nikfgkz8ik4c3-nixos-system-0bac96c7-a2aa-49ec-baef-b81e5251e124-18.09.2574.a7e559a5504/init boot.shell_on_fail loglevel=4
			
			echo 'Loading initrd...'
			initrd ($drive1)/nix/store/gqzl6ryyn1fcs6jw8sy9g1psk5g0bwn7-initrd/initrd
			#initrd ($drive1)/mach/D2b6sT0ASCnp7KWOZTgTYJkks73R1dLt-nixos-x86_64/nix/store/gqzl6ryyn1fcs6jw8sy9g1psk5g0bwn7-initrd/initrd
		}
	'';
	
	#boot.kernelPackages = pkgs.linuxPackages_latest;
	
	boot.initrd.compressor = "cat";
	
	#boot.initrd.supportedFilesystems = ["xfs"];
	#boot.initrd.supportedFilesystems = ["xfs" "btrfs" "ext2" "ext3" "ext4" "nfts" "exfat"];
	boot.initrd.supportedFilesystems = ["bfs" "btrfs" "cramfs" "ext2" "ext3" "ext4" "fat" "minix" "msdos" "ntfs" "vfat" "xfs"];
	
	#nixpkgs.config.allowUnfree = true;
	
	networking.hostName = "0bac96c7-a2aa-49ec-baef-b81e5251e124";
	
	networking.dhcpcd.enable = true;
	
	networking.firewall.allowedTCPPorts = [5000 6882];
	networking.firewall.allowedUDPPorts = [6882];
	
	networking.wireless.iwd.enable = false; # Wireless supprt via iwd.
	networking.wireless.enable = false; # Wireless support via wpa_supplicant.
	
	networking.connman.enable = false; # Use ConnMan in userspace.
	networking.networkmanager.enable = true; # Use NetworkManager applet in userspace.
	networking.wicd.enable = false; # Use Wicd in userspace.
	
	# Bluetooth support
	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;
	
	# Select internationalisation properties.
	i18n =
	{
		#consoleFont = "Lat2-Terminus16";
		consoleKeyMap = "us";
		defaultLocale = "en_US.UTF-8";
	};
	
	# Set your time zone.
	time.timeZone = "America/New_York";
	
	#nix.nixPath =
	#options.nix.nixPath.default ++
	#[
	#	"nixpkgs-overlays=/etc/nixos/overlays"
	#];
	
	#environment.etc."/issue".enable = false;
	#environment.etc."/issue".text = "";
	#environment.etc."/issue".source = "/dev/null";
	
	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs;
	[
		#coreutils-full
		#coreutils
		#pciutils
		#usbutils
		#v4l_utils
		#inotify-tools
		#cifs-utils
		#f2fs-tools
		#poppler_utils
		#utillinux
		#findutils
		#hwinfo
		#commonsCompress
		#xz
		#libarchive
		#file
		#boost
		#czmq
		#cppzmq
		##zmqpp
		#cln
		#wget
		#wput
		#curl
		#vim
		#nano
		#stress
		#networkmanagerapplet
		
		# for making available an on-screen keyboard when logging in via the display manager
		onboard
		
		#nix-prefetch-scripts
		#nix-index
		#ntfs3g
		#ntfsprogs
		#bluez
		#bluez-tools
		#glib.dev
		#mkpasswd
		#steam
		#ipfs
		#gcc8
		#cmake
		#gvfs
		lxqt.lxqt-policykit
		#ceph
		#sane-backends
		#hplip
		#ripgrep
		#system-config-printer
		#blueman
		#ghostscriptX
		gnome3.gsettings-desktop-schemas

		# for mate speaker test:
		#libcanberra
		#gnome2.libcanberra-gtk2
		#libcanberra-gtk3
		
		#gitAndTools.gitFull
		#qemu
		#libreoffice
		#qt48Full
		#firefox
		#ffmpeg
		#mplayer
		#smplayer
		#vlc
		#pidgin
		#remmina
	];
	#environment.systemPackages =
	#[
	#	(
	#		pkgs.vim_configurable.customize
	#		{
	#			vimrcConfig.customRc =
	#			"
	#				here goes your configuration
	#			";
	#		}
	#	)
	#];
	
	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.bash.enableCompletion = true;
	# programs.mtr.enable = true;
	# programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
	
	# List services that you want to enable:
	#systemd.user.services.pulseaudio =
	#{
	#	description = "PulseAudio service";
	#	serviceConfig =
	#	{
	#		Type = "notify";
	#		Requires = ["pulseaudio.socket"];
	#		ExecStart = ["${pkgs.pulseaudio}/bin/pulseaudio --daemonize=false --disable-shm=false --disallow-exit=false --disallow-module-loading=false --enable-memfd=true --fail=true --high-priority=false --log-level=1 --log-meta=true --log-time=true --no-cpu-limit=false --realtime=false --system=false --use-pid-file=true"];
	#		Restart = "on-failure";
	#	};
	#	#also = ["pulseaudio.socket"];
	#	wantedBy = ["default.target"];
	#};
	#
	#systemd.user.sockets.pulseaudio =
	#{
	#	description = "PulseAudio socket";
	#	socketConfig =
	#	{
	#		Priority = "6";
	#		Backlog = "5";
	#		ListenStream = "%t/pulse/native";
	#	};
	#	wantedBy = ["sockets.target"];
	#};
	
	#systemd.user.services.pulseaudio.enable = true;
	#systemd.user.sockets.pulseaudio.enable = true;
	
	# not working:
	#environment.etc.systemd.user."pulseaudio.service".enable = false;
	
	# overlays:
	## With existing `nix.nixPath` entry:
	#nix.nixPath = [
	#	# Add the following to existing entries.
	#	"nixpkgs-overlays=/etc/nixos/overlays-compat/"
	#];
	#
	# Without any `nix.nixPath` entry:
	#nix.nixPath =
	#	# Prepend default nixPath values.
	#	options.nix.nixPath.default ++
	#	
	#	# Append our nixpkgs-overlays.
	#	[
	#		"nixpkgs-overlays=/etc/nixos/overlay/"
	#	]
	#;
	
	# nix-serve
	services.nix-serve.enable = true;
	#services.nix-serve.port = 5000;
	#services.nix-serve.bindAddress = "0.0.0.0";
	services.nix-serve.secretKeyFile = "/etc/nix/nix-serve.sec";
	
	#nix.binaryCaches = ["http://192.168.0.8:5000/" "https://cache.nixos.org/"];
	#nix.maxJobs = 2;
	#nix.buildCores = 1;
	#nix.distributedBuilds = true;
	#nix.buildMachines =
	#[
		#{
		#	hostName = "linux64.example.org";
		#	sshUser = "buildfarm";
		#	sshKey = "/root/.ssh/id_buildfarm";
		#	system = "x86_64-linux";
		#	maxJobs = 2;
		#	speedFactor = 2;
		#	supportedFeatures = [ "kvm" ];
		#	mandatoryFeatures = [ "perf" ];
		#}
	#];
	
	#environment.etc."ssh_config".enable = false;
	
	# Enable the OpenSSH daemon.
	services.openssh.enable = true;
	services.openssh.allowSFTP = true;
	services.openssh.passwordAuthentication = true;
	services.openssh.challengeResponseAuthentication = true;
	services.openssh.permitRootLogin = "yes";
	services.openssh.extraConfig =
	''
		PermitEmptyPasswords yes
		#UsePAM no
	''
	#environment.etc."ssh/sshd_config".enable = false;
	##environment.etc."/ssh/sshd_config".source = "/etc/nixos/openssh.cfg";
	#environment.etc."/ssh/sshd_config".text =
	#''
	#	Protocol 2
	#	
	#	UsePAM yes
	#	
	#	AddressFamily any
	#	Port 22
	#	
	#	XAuthLocation /nix/store/3pmixz1hrx6ir0ypgw282q1pxl3a7qjp-xauth-1.0.10/bin/xauth
	#	X11Forwarding no
	#	
	#	Subsystem sftp /nix/store/8zpm8qc7h7wxrv1l2lqqlsfagqg727fd-openssh-7.7p1/libexec/sftp-server 
	#	
	#	PermitRootLogin yes
	#	GatewayPorts no
	#	PasswordAuthentication no
	#	ChallengeResponseAuthentication yes
		#AuthenticationMethods publickey keyboard-interactive password none
		#AuthenticationMethods none password keyboard-interactive publickey
		#AuthenticationMethods keyboard-interactive password none
		#AuthenticationMethods none keyboard-interactive
		#AuthenticationMethods none password
		#AuthenticationMethods none
	#	AuthenticationMethods any
	#	
	#	PrintMotd no # handled by pam_motd
	#	
	#	AuthorizedKeysFile .ssh/authorized_keys .ssh/authorized_keys2 /etc/ssh/authorized_keys.d/%u
	#	
	#	HostKey /etc/ssh/ssh_host_rsa_key
	#	HostKey /etc/ssh/ssh_host_ed25519_key
	#	
	#	KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256
	#	Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
	#	MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com
	#	
	#	LogLevel VERBOSE
	#	UseDNS no
	#	
	#	PermitEmptyPasswords yes
	#''
	+
	''
		#Match Address 192.168.0.2
		#	AllowUsers alex
		#	PasswordAuthentication yes
		#	PubkeyAuthentication no
	''
	;
	
	#environment.etc."pam.d/sshd".enable = false;
	#environment.etc."/pam.d/sshd".enable = false;
	#environment.etc."sshd.pam".enable = false;
	#environment.etc."/sshd.pam".enable = false;
	#environment.etc."/pam.d/sshd".source = "/etc/nixos/pam.d/sshd";
	
	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;
	
	# sane
	hardware.sane.enable = true;
	hardware.sane.extraBackends = with pkgs;
	[
		#hplip
		hplipWithPlugin
	];
	
	# Enable CUPS to print documents.
	services.printing.enable = true;
	services.printing.drivers = with pkgs;
	[
		hplip
		hplipWithPlugin
	];
	
	# deluge
	services.deluge.enable = true;
	services.deluge.web.enable = false;
	services.deluge.openFilesLimit = 8192;
	
	# samba
	#services.samba.enable = true;
	#services.samba.enableNmbd = true;
	#services.samba.enableWinbindd = true;
	#services.samba.syncPasswordsByPam = true;
	#services.samba.nsswins = true;
	#services.samba.securityType = "user";
	#services.samba.invalidUsers =
	#[
	#];
	#
	# provides a default authentification client for policykit
	#environment.systemPackages = with pkgs;
	#[
	#	lxqt.lxqt-policykit
	#];
	# lets PCManFM discover gvfs modules
	environment.variables.GIO_EXTRA_MODULES =
	[
		"${pkgs.gvfs}/lib/gio/modules"
	];
	# enables gvfs
	services.gnome3.gvfs.enable = true;
	
	# Enable sound.
	sound.enable = true;
	hardware.pulseaudio.enable = true;
	
	# Enable the X11 windowing system.
	services.xserver.enable = true;
	# services.xserver.layout = "us";
	# services.xserver.xkbOptions = "eurosign:e";
	
	# Enable touchpad support.
	services.xserver.libinput.enable = true;
	
	# Enable the KDE Desktop Environment.
	# services.xserver.displayManager.sddm.enable = true;
	# services.xserver.desktopManager.plasma5.enable = true;
	
	services.xserver.displayManager.lightdm.enable = true;
	#services.xserver.windowManager.fluxbox.enable = false;
	services.xserver.desktopManager.mate.enable = true;
	
	services.xserver.displayManager.lightdm.autoLogin.enable = false;
	services.xserver.displayManager.lightdm.autoLogin.timeout = 5;
	services.xserver.displayManager.lightdm.autoLogin.user = "root";
	services.xserver.displayManager.lightdm.background = "#7F7F7F";
	#services.xserver.displayManager.lightdm.greeters.mini.enable = false;
	services.xserver.displayManager.lightdm.greeters.gtk.enable = true;
	#services.xserver.displayManager.lightdm.greeters.gtk.clock-format = "%Y-%m-%d %H:%M:%S %::z %a";
	#services.xserver.displayManager.lightdm.greeters.gtk.clock-format = "%Y-%m-%d %H:%M:%S %z %Z %zz %ZZ %:z %:Z %::z %::Z %a";
	services.xserver.displayManager.lightdm.greeters.gtk.clock-format = "%Y-%m-%d %H:%M:%S %z %a";
	#services.xserver.displayManager.lightdm.greeters.gtk.clock-format = "[%Y.[[[%m/12|%b].%d]|%U/53|%j/366] [%p%I/12|%H/24].%M/59.%S/60 %::z [%w|%a]]";
	# "~a11y" "~language" "~session" "~power" "~clock" "~host" "~spacer"
	services.xserver.displayManager.lightdm.greeters.gtk.indicators = ["~clock" "~spacer" "~host" "~spacer" "~language" "~a11y" "~session" "~power"];
	services.xserver.displayManager.lightdm.greeters.gtk.theme.name = "TraditionalOk";
	services.xserver.displayManager.lightdm.greeters.gtk.iconTheme.name = "ClearlooksRe";
	services.xserver.displayManager.lightdm.extraSeatDefaults =
	''
		allow-guest=false
		greeter-show-manual-login=true
		greeter-hide-users=true
	'';
	services.xserver.displayManager.lightdm.greeters.gtk.extraConfig =
	''
		keyboard=${pkgs.onboard}/bin/onboard
	'';
	
	services.xserver.autorun = true;
	
	services.ipfs.enable = true;
	
	# Prevent prompting for root password?:
	#users.mutableUsers = false;
	users.mutableUsers = true;

	# Conflicts with '/nix/var/nix/profiles/per-user/root/channels/nixos/nixos/modules/config/users-groups.nix'
	#users.users.root.description = "";
	
	# Set empty password for root:
	users.users.root.password = "";
	users.users.alex.password = "";
	#users.users.cornel.password = "";
	
	#users.users.root.extraGroups = ["audio"];
	users.users.alex.extraGroups = ["wheel" "lp" "scanner" "adbusers"];
	#users.users.cornel.extraGroups = ["wheel" "lp" "scanner" "adbusers"];
	
	programs.adb.enable = true;
	#android_sdk.accept_license = true;
	
	# Allow logging in with an empty password for root:
	#security.pam.services.root.allowNullPassword = true;
	#security.pam.services.alex.allowNullPassword = true;
	security.pam.services.su.allowNullPassword = true;
	security.pam.services.sudo.allowNullPassword = true;
	security.pam.services.sshd.allowNullPassword = true;
	
	# Define a user account. Don't forget to set a password with 'passwd'.
	# users.extraUsers.guest = {
	#   isNormalUser = true;
	#   uid = 1000;
	# };
	users.users.alex.isNormalUser = true;
	users.users.alex.uid = 1002;
	#users.users.cornel.isNormalUser = true;
	#users.users.cornel.uid = 1000;
	
	programs.bash.promptInit =
	# default
	#''
	#	# Provide a nice prompt if the terminal supports it.
	#	if [ "$TERM" != "dumb" -o -n "$INSIDE_EMACS" ];
	#	then
	#		PROMPT_COLOR="1;31m";
	#		let $UID && PROMPT_COLOR="1;32m";
	#		PS1="\n\[\033[$PROMPT_COLOR\][\u@\h:\w]\\$\[\033[0m\] ";
	#		if test "$TERM" = "xterm";
	#		then
	#			PS1="\[\033]2;\h:\u:\w\007\]$PS1"
	#		fi;
	#	fi;
	#'';
	''
		#declare mach;
		#declare usr;
		#declare path;
		#$PS1;
		#$PS2;
		#$PS3;
		#$PS4;
		
		#mach="$HOSTNAME";
		#USR="$(id --user --name 2>/dev/null)";
		USR="''${USER:-''${EUID}}";
		#path="$PWD";
		
		#if [ -z "''${usr}" ];
		#then
		#	usr="''${EUID}";
		#fi;
		
		PS1='$USR@''${HOSTNAME}:''${PWD}> ';
	'';
	programs.bash.shellAliases =
	{
		 nixos-rebuild-usr = "nix-env --install --file '\\''<nixpkgs>'\\'' --attr userPackages";
	};
	
	#programs.bash.shellInit =
	environment.shellInit =
	''
		tabs -2;
	'';
	
	hardware.pulseaudio.daemon.config =
	{
		flat-volumes = "false";
	};
	
	# This value determines the NixOS release with which your system is to be
	# compatible, in order to avoid breaking some software such as database
	# servers. You should change this only after NixOS release notes say you
	# should.
	system.stateVersion = "@release@"; # Did you read the comment?
}

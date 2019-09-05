{
		lib
	, pkgs
	, config
	, ...
}:

#with lib;                      
#let
#  cfg = config.boot.loader.subroot;
#in
{
	#options.boot.loader.subroot.root = mkOption
	options.subroot.path = lib.mkOption
	{
		type = lib.types.string;
		default = "";
		example = "/mach/nixos";
		description = ''Absolute directory path, relative to the root volume/partition, to mount as the actual root / for the resulting running system. Also look at subboot.*. This is useful if, for example, the root filesystem of the OS is present in a subdirectory on its volume/partition.'';
	};
	
	#options.boot.loader.subroot.boot = mkOption
	options.subboot.path = lib.mkOption
	#options.subroot.boot.src.subdir = mkOption
	{
		type = lib.types.string;
		default = "/boot";
		example = "/mach/nixos/boot";
		#description = "Subdirectory path on the boot volume for the boot loader to read from as /boot during system startup and to write to as /boot during boot loader setup.";
		description = ''Absolute directory path, relative to the boot volume/partition root, used by the boot loader to read boot files from, during system startup; AKA: subdirectory on the boot partition where /boot is directly (/boot/ itself, not its parent directory) located.'';
		#description = "Subdirectory path on the boot volume where boot/ is present for the boot loader to read from during system startup. This is [also] useful when /boot is hosted on another partition/volume. Note that boot/ is the conventional example, but this subroot.boot path would be expected to have the same subdirectory structure as on the running system, most particularly boot/. In the example here, it would be /mach/nixos/boot/boot/.";
	};
	
	options.subboot.mnt.enabled = lib.mkOption
	{
		type = lib.types.bool;
		default = false;
		example = true;
		description = ''Whether to mount subboot.path as /boot (actually, as subboot.mnt.dest) on the resulting running system. This is useful if /boot is present on another volume/partition than root /.'';
	};
	
	options.subboot.mnt.src = lib.mkOption
	{
		type = lib.types.string;
		default = "";
		example = "/dev/sda1";
		description = ''Source device to mount at the mountpoint subboot.mnt.dest (conventionally /boot) in the resulting running system. This should usually be the same as defined for fileSystems."/boot".device. This option is internally used only if subboot.mnt.enabled==true.'';
	};
	
	options.subboot.mnt.dest = lib.mkOption
	{
		type = lib.types.string;
		default = "/boot";
		example = "/sysboot";
		description = ''Mountpoint path (conventionally /boot) on the resulting running system where to mount "subboot.mnt.src:subboot.path". This option is internally used only if subboot.mnt.enabled==true.'';
	};
	
	options.subboot.mnt.opt = lib.mkOption
	{
		type = lib.types.string;
		default = "";
		example = "ro,noatime";
		description = ''Flags passed to '-o ' for `mount` when mounting subboot.mnt.src. This option is internally used only if subboot.mnt.enabled==true.'';
	};
	
	
	#config = lib.mkDefault cfg.boot.loader.grub.subroot.default;
	#config = mkMerge
	#[
	#	{
	#		boot.loader.grub.subroot = cfg.boot.loader.grub.subroot.default;
	#	}
	#];
}

{ config, pkgs, ... }: {
	options.vfio.enable = true;

	config =
	let
		cfg = config.vfio;
	in
	{
		boot = {
			initrd.kernelModules = [
				"vfio_pci"
				"vfio"
				"vfio_iommu_type1"

				"nvidia"
				"nvidia_modeset"
				"nvidia_uvm"
				"nvidia_drm"
			];

			kernelParams = [
				# enable IOMMU
				"amd_iommu=on"
			];
			# ++ lib.optional cfg.enable
			# 	# isolate the GPU
			# 	("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs);
		};

		virtualisation.spiceUSBRedirection.enable = true;

		environment.systemPackages = with pkgs; [
			dnsmasq
			ebtables
			virt-manager
		];

		virtualisation.libvirtd = {
			enable = true;
			qemu = {
				package = pkgs.qemu_kvm;
				runAsRoot = true;
				swtpm.enable = true;
				ovmf = {
					enable = true;
					packages = [
						(pkgs.OVMF.override {
							secureBoot = true;
							tpmSupport = true;
						}).fd
					];
				};
			};
		};
	};
}


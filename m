Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793629699;
	b=yh+ODf11fk3aYh68TgGrgGBZDTdTlN8MY1r8IvYoXdEBiyCMKHf9agvrEha3f5gE7tcv
	 zxz8U8pUPfNa2luNhQawkYSPw2m2W3OJ7m8GXFD0AjuZoHIMl11jYC4MUbh4Se/eanj2t
	 W6J8/ySV54DGpGmjxALaO7Tj9RwUItVewnlUGxgAeB1f33C/f1MVUXuFAXk5DIEnIVWWM
	 OVnP2a9Nu28iDnfpOr8WX6jkSIBzhuRo37PYigfxxzNGTYPShC2oDe6OAPgdZmx6KVrhh
	 Q9cgS6+PR4/7DExLTGs7ERC8gV78UvSQzowXK7pbnbCNAIUQsS7HpC7jDqc6pWwbu4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629699;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rGnP8C1cE5yy02Fve0JxWbAVvsMmjFDyWDvd5rjO2Zo=;
	b=WAfH1zM9ReEv6AFpjhw9ZMAScl1pZ/rSXmEVePn6NSPj4EQ2nqE+EQa27J1pQvgg2ffs
	 EMJe9gzk028u29WdeU3tfJlNYb4XnLtoFXlurO4egdy/0O7zL4NzgahOwR3VcVPqirHdV
	 foNzXm3SIfAwTeQRrHUVYV+JwEP6HDRdM0gnihb4GTN8oKdRGLBiqHMVQJltNo8QiaVKb
	 SptsYt9sd37Cw5xZO4zqLel1wvIdfDABZ1t2XEQigCKYcZ8ca2s+nC7AejVIBVOK5e2X/
	 ju1xBuafajbioL8+2fAYAgbcdSv6DgGc3+v/prHkwYGTVBpL47rjx7hPK6jq5pHCSsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9f8xRKo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E003606F23C
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9f8xRKo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BD51F00A1C
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 14:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793629698;
	bh=rGnP8C1cE5yy02Fve0JxWbAVvsMmjFDyWDvd5rjO2Zo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=g9f8xRKo2iP2EybU+ir6xTNRqdXd+YEQ2QWIXmq+Fa96ZFMw6WGWruykiWQFvbvFv
	 m4rL23lPjqkePYbjHC9+T6V9sO8cangQ3tbDSbOFzGabQPQsm88QHZQ+8dz6+v176T
	 ko0kcHdu5jrm+q/bZ5GLIQohoXw+v5ocizz5QAbUNzvcMCyWf7nZJQRq0qotUuGnBR
	 NT6fbVhLtqSLOWsId1EsRV8uQ24AeDNGTji9M+D73jthG01524snlWEUDXfoqUVPf4
	 eMEvPfWqZPF9OHxYqE4FbdSYpNJ6OFH87jpp4ZfrxGWX+/MZ306vrb/eUJCzeHPv35
	 b3fjLjg1Ofp0A==
Message-ID: <sashiko-outbox-193572@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] security: lockdown: Prevent boot with lockdown but
 no IOMMU
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261102-lockdown-iommu-v1-2-00f3c2be4c9f@kernel.org>
References: <20261102-lockdown-iommu-v1-0-00f3c2be4c9f@kernel.org>
 <20261102-lockdown-iommu-v1-2-00f3c2be4c9f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 14:28:18 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] security: lockdown: unconditional boot panic in lockdown_check_iom=
mu()
- [Medium] security: lockdown: runtime activation in lockdown_write() skips=
 IOMMU check
- [Medium] iommu: iommu_available stays true after iommu_device_unregister(=
) on failure
- [Medium] security: lockdown: passthrough mode bypasses lockdown_check_iom=
mu()
- [Medium] security: lockdown: raw late_initcall() runs when lockdown LSM i=
s disabled
- [Medium] security: lockdown: premature no_iommu panic in lockdown_lsm_ini=
t()
- [Low] security: lockdown: unreachable no_iommu check in lockdown_check_io=
mmu()
- [Low] security: lockdown: commit message claims change to iommu_device_re=
gister()
--

commit 437687711e0f75d4ef1930e13f9b1f994ec32b30
Author: Mario Limonciello (AMD) <superm1@kernel.org>

security: lockdown: Prevent boot with lockdown but no IOMMU

This commit adds an early check on x86 and a generic late_initcall check to
panic during boot if kernel lockdown is enabled while an IOMMU is disabled
or unavailable.

>     security: lockdown: Prevent boot with lockdown but no IOMMU
>    =20
>     Lockdown is a kernel LSM that restricts access to sensitive kernel
>     resources (e.g. /dev/mem, kernel modules, perf, tracing, kprobes,
>     BPF access to kernel memory). However, without IOMMU, any PCI/PCIe
>     device can perform DMA to arbitrary physical memory, effectively
>     bypassing all lockdown protections.
>    =20
>     A malicious or compromised device can:
>     - Read kernel memory directly (encryption keys, credentials, secrets)
>     - Write to kernel memory directly (code patches, rootkits, backdoors)
>     - Circumvent all lockdown LSM checks (which run inside the kernel)
>    =20
>     Add a two-phase check to prevent booting with lockdown enabled and
>     IOMMU disabled:
>    =20
>     1. Early check (in lockdown_lsm_init()): On x86, check the no_iommu
>        flag, which is set early by the 'iommu=3Doff' kernel cmdline optio=
n.
>        If lockdown is active and no_iommu is set, panic with a clear erro=
r.
>    =20
>     2. Late check (late_initcall): On all architectures, check
>        iommu_is_available() which returns true if any IOMMU driver
>        registered successfully. This catches cases where:
>        - IOMMU hardware is absent on the platform
>        - IOMMU was disabled by driver initialization failure
>        - IOMMU was not detected (broken firmware, missing ACPI tables)
>    =20
>     This follows the precedent set by s390 UV code which panics when
>     security cannot be guaranteed ("System security cannot be guaranteed
>     unless the system panics now").
>    =20
>     Also update iommu_device_register() to call iommu_set_available() on
>     successful registration, so all IOMMU drivers automatically signal
>     their availability.
>    =20
>     Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

[Severity: Low]
This isn't a bug, but this commit only touches security/lockdown/lockdown.c,
while the change to iommu_device_register() in drivers/iommu/iommu.c was
made in the preceding commit ("iommu: Add iommu_is_available() API"). Should
the last paragraph be removed from this commit message?

> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 8d46886d2cca0..6ce1490188d5d 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
[ ... ]
> @@ -88,6 +94,25 @@ static int __init lockdown_lsm_init(void)
>  #elif defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY)
>  	lock_kernel_down("Kernel configuration", LOCKDOWN_CONFIDENTIALITY_MAX);
>  #endif
> +
> +	/*
> +	 * If lockdown was activated (via command line or kernel config)
> +	 * and IOMMU is disabled, refuse to boot. Without IOMMU, any
> +	 * PCI/PCIe device can perform DMA to arbitrary physical memory,
> +	 * completely bypassing lockdown protections.
> +	 *
> +	 * On x86, 'no_iommu' is set early by the 'iommu=3Doff' cmdline
> +	 * option during parse_early_param(), before this init function.
> +	 */
> +#if IS_ENABLED(CONFIG_X86)
> +	if (kernel_locked_down > LOCKDOWN_NONE && no_iommu) {
> +		pr_err("FATAL: Lockdown is active but IOMMU is disabled.\n");
> +		pr_err("FATAL: PCI devices can perform DMA to arbitrary memory,\n");
> +		pr_err("FATAL: bypassing all lockdown protections.\n");
> +		panic("Lockdown enabled but IOMMU is disabled (no_iommu)\n");
> +	}
> +#endif

[Severity: Medium]
Can checking no_iommu in lockdown_lsm_init() cause a premature boot panic on
Intel TXT (tboot) systems?

During start_kernel(), parse_early_param() runs iommu_setup() in
arch/x86/kernel/pci-dma.c, which sets no_iommu =3D 1 if iommu=3Doff was pas=
sed on
the command line. Then early_security_init() or security_init() calls
lockdown_lsm_init() before do_initcalls() executes.

However, on Intel TXT launches, rootfs_initcall(pci_iommu_init) later calls
intel_iommu_init() -> tboot_force_iommu() in drivers/iommu/intel/iommu.c,
which forces DMA remapping on and clears no_iommu:

    static __init void tboot_force_iommu(void)
    {
        if (!tboot_enabled() || intel_iommu_tboot_noforce)
            return;
        ...
        dmar_policy =3D DMAR_FORCE_ON;
        no_iommu =3D 0;
    }

Because lockdown_lsm_init() runs before rootfs_initcall(pci_iommu_init), wi=
ll
it panic before tboot_force_iommu() has a chance to clear no_iommu =3D 0?

> +
>  	security_add_hooks(lockdown_hooks, ARRAY_SIZE(lockdown_hooks),
>  			   &lockdown_lsmid);
>  	return 0;
> @@ -170,3 +195,43 @@ DEFINE_LSM(lockdown) =3D {
>  	.init =3D lockdown_lsm_init,
>  	.initcall_core =3D lockdown_secfs_init,
>  };
> +
> +/*
> + * Late init call to verify IOMMU availability when lockdown is active.
> + * This catches cases where:
> + *  - IOMMU hardware is absent on the platform
> + *  - IOMMU was disabled by driver initialization failure
> + *  - IOMMU was not detected (e.g. broken firmware, missing ACPI tables)
> + *
> + * On x86, we also check no_iommu here as a double-check. The early check
> + * in lockdown_lsm_init() catches 'iommu=3Doff' from the cmdline before
> + * lockdown_lsm_init() runs, but this late check covers any missed cases.
> + */
> +static int __init lockdown_check_iommu(void)
> +{
> +	if (kernel_locked_down > LOCKDOWN_NONE) {

[Severity: Medium]
What happens when lockdown is enabled at runtime via securityfs rather than
at boot?

When the kernel is built with CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE=3Dy and bo=
oted
without a lockdown=3D parameter, kernel_locked_down is LOCKDOWN_NONE when b=
oth
lockdown_lsm_init() and lockdown_check_iommu() run.

If userspace subsequently enables lockdown by writing to
/sys/kernel/security/lockdown, lockdown_write() in
security/lockdown/lockdown.c calls lock_kernel_down("securityfs", level):

    static ssize_t lockdown_write(struct file *file, const char __user *buf,
                                  size_t n, loff_t *ppos)
    {
        ...
                if (label && !strcmp(state, label))
                        err =3D lock_kernel_down("securityfs", level);
        ...
    }

Since lock_kernel_down() updates kernel_locked_down without checking
iommu_is_available() or no_iommu, doesn't runtime activation bypass the IOM=
MU
requirement?

> +		/*
> +		 * Check generic IOMMU availability (all architectures).
> +		 * iommu_is_available() returns true if any IOMMU driver
> +		 * registered successfully.
> +		 */
> +		if (!iommu_is_available()) {
> +			pr_err("FATAL: Lockdown is active but no IOMMU driver\n");
> +			pr_err("FATAL: registered. PCI devices can DMA to\n");
> +			pr_err("FATAL: arbitrary memory, bypassing lockdown.\n");
> +			panic("Lockdown enabled but IOMMU not available\n");
> +		}

[Severity: High]
Won't panicking unconditionally when !iommu_is_available() break boot across
several valid configurations, architectures, and driver models?

1. Kernels with CONFIG_IOMMU_API=3Dn (or CONFIG_IOMMU_SUPPORT=3Dn):
CONFIG_SECURITY_LOCKDOWN_LSM in security/lockdown/Kconfig does not depend on
CONFIG_IOMMU_API, and include/linux/iommu.h defines the fallback stub as:

    static inline bool iommu_is_available(void)
    {
        return false;
    }

For example, arch/powerpc/configs/skiroot_defconfig disables
CONFIG_IOMMU_SUPPORT while enabling CONFIG_SECURITY_LOCKDOWN_LSM=3Dy and
CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY=3Dy, so it will now panic on every
boot. On PowerPC more generally, arch/powerpc/kernel/iommu.c enforces
hardware TCE DMA translation even when CONFIG_SPAPR_TCE_IOMMU (which selects
CONFIG_IOMMU_API and registers IOMMU devices in
spapr_tce_setup_phb_iommus_initcall() only when hose_list is non-empty) is
disabled.

2. Architectures that only call iommu_device_register() per attached PCI
device:
On s390, zpci_init_iommu() in drivers/iommu/s390-iommu.c is only called when
a zPCI device is discovered via zpci_add_device():

    int zpci_init_iommu(struct zpci_dev *zdev)
    {
        ...
        if (zdev->rtr_avail) {
            rc =3D iommu_device_register(&zdev->iommu_dev,
                                       &s390_iommu_rtr_ops, NULL);
        } else {
            rc =3D iommu_device_register(&zdev->iommu_dev, &s390_iommu_ops,
                                       NULL);
        }
        ...
    }

On any s390 LPAR or guest without attached zPCI devices (such as systems
using only CCW or virtio-ccw I/O, or with CONFIG_PCI=3Dn),
iommu_device_register() is never called, causing lockdown_check_iommu() to
panic claiming PCI devices can DMA to arbitrary memory when no PCI devices
are present.

3. Modular and deferred-probe IOMMU drivers:
Several IOMMU drivers in drivers/iommu/Kconfig are tristate (such as
CONFIG_ARM_SMMU, CONFIG_ARM_SMMU_V3, CONFIG_VIRTIO_IOMMU, CONFIG_APPLE_DART,
and CONFIG_MTK_IOMMU). If built as modules (=3Dm), they cannot be loaded fr=
om
initramfs before late_initcall(lockdown_check_iommu) runs. In addition,
because security/ is linked before drivers/ in the top-level Kbuild,
late_initcall(lockdown_check_iommu) in security/lockdown/lockdown.c runs
before late_initcall(deferred_probe_initcall) in drivers/base/dd.c, so any
built-in IOMMU driver whose probe returned -EPROBE_DEFER will not have been
re-probed yet when lockdown_check_iommu() panics.

4. Virtual machines and non-PCI systems:
Guests (such as KVM/QEMU, Xen, or cloud instances) and non-PCI platforms
booting with UEFI Secure Boot or lockdown=3Dintegrity without an emulated
vIOMMU will also unconditionally panic at boot.

[Severity: Medium]
Can iommu_is_available() still return true after an IOMMU driver fails
initialization following iommu_device_register()?

In drivers/iommu/iommu.c, iommu_device_register() sets iommu_available =3D =
true
via iommu_set_available(), but iommu_device_unregister() removes the device
from iommu_device_list without clearing or updating iommu_available when the
list becomes empty:

    void iommu_device_unregister(struct iommu_device *iommu)
    {
        for (int i =3D 0; i < ARRAY_SIZE(iommu_buses); i++)
            bus_for_each_dev(iommu_buses[i], NULL, iommu, remove_iommu_grou=
p);

        spin_lock(&iommu_device_lock);
        list_del(&iommu->list);
        spin_unlock(&iommu_device_lock);
    }

Several IOMMU drivers register the iommu_device before initialization is
complete and call iommu_device_unregister() in their error unwind paths:

- In drivers/iommu/amd/init.c, iommu_init_pci() calls
iommu_device_register() before pci_enable_device() and before
amd_iommu_enable_interrupts() in state_next(). If either fails, state_next()
calls disable_iommus() and free_iommu_resources() -> free_iommu_all() ->
free_sysfs() -> iommu_device_unregister(), leaving iommu_available set to
true. Additionally, iommu_init_pci() still calls iommu_device_register() wh=
en
amd_iommu_pgtable =3D=3D PD_MODE_NONE (DMA translation unsupported).

- Platform IOMMU drivers such as mtk_iommu_probe() in
drivers/iommu/mtk_iommu.c, mtk_iommu_v1_probe(), qcom_iommu_device_probe(),
sprd_iommu_probe(), and sun50i_iommu_probe() also call
iommu_device_register() and roll back via iommu_device_unregister() if a
subsequent probe step fails.

Should iommu_is_available() check whether any active IOMMU devices remain
registered (or update the state in iommu_device_unregister()) rather than
using a one-way flag?

[Severity: Medium]
Does lockdown_check_iommu() also need to check iommu_default_passthrough()?

When booting with iommu=3Dpt (handled in iommu_setup() in
arch/x86/kernel/pci-dma.c), iommu.passthrough=3D1 (in drivers/iommu/iommu.c=
),
or CONFIG_IOMMU_DEFAULT_PASSTHROUGH=3Dy, no_iommu remains 0 and the IOMMU
driver still registers via iommu_device_register(), so iommu_is_available()
returns true. However, default domains use IOMMU_DOMAIN_IDENTITY
(iommu_default_passthrough() returns true), leaving PCI devices with
unrestricted identity-mapped DMA access to physical memory.

> +#if IS_ENABLED(CONFIG_X86)
> +		/*
> +		 * Also double-check x86-specific flag.
> +		 */
> +		if (no_iommu) {
> +			pr_err("FATAL: Lockdown is active but IOMMU disabled\n");
> +			pr_err("FATAL: via kernel command line (iommu=3Doff).\n");
> +			panic("Lockdown enabled but IOMMU disabled (iommu=3Doff)\n");
> +		}
> +#endif

[Severity: Low]
Is this no_iommu check in lockdown_check_iommu() reachable?

On x86, when no_iommu is non-zero, no IOMMU driver registers an IOMMU devic=
e,
so iommu_is_available() is false and the preceding !iommu_is_available()
check will always panic before reaching if (no_iommu).

> +	}
> +	return 0;
> +}
> +late_initcall(lockdown_check_iommu);

[Severity: Medium]
Should lockdown_check_iommu() be wired up via .initcall_late in
DEFINE_LSM(lockdown) instead of a raw late_initcall()?

In security/lockdown/lockdown.c, early_param("lockdown", lockdown_param) se=
ts
kernel_locked_down during parse_early_param(), before security_init()
determines which LSMs are enabled:

    static int __init lockdown_param(char *level)
    {
        ...
        if (strcmp(level, "integrity") =3D=3D 0)
            lock_kernel_down("command line", LOCKDOWN_INTEGRITY_MAX);
        else if (strcmp(level, "confidentiality") =3D=3D 0)
            lock_kernel_down("command line", LOCKDOWN_CONFIDENTIALITY_MAX);
        ...
    }
    early_param("lockdown", lockdown_param);

If CONFIG_SECURITY_LOCKDOWN_LSM=3Dy and CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=
=3Dn,
and the lockdown LSM is disabled via CONFIG_LSM or the lsm=3D command-line
parameter while lockdown=3Dintegrity is passed on the command line,
lockdown_lsm_init() and .initcall_core =3D lockdown_secfs_init are skipped,=
 but
a raw late_initcall(lockdown_check_iommu) will still run and panic. Using
.initcall_late in DEFINE_LSM(lockdown) would ensure it only runs when the
lockdown LSM is actually enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-lockdown-i=
ommu-v1-0-00f3c2be4c9f@kernel.org?part=3D2

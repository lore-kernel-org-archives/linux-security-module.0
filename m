Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628689;
	b=yr9wE01GbXjklfvAfXOuWpVFsnLfSeJs8cYImzvw8z5a09qHphx4wtRjJjijUBZf97R8
	 Rl7E1yTTdnhLHvInBbNumqYZfJ+naulCXMdlYgZMLtBf14VONuHIg/a36hbGrat0yaGjx
	 7kLHmAvjI3JiTSX0fPk1nZZD2r3G+L7PYSV7WJ5XPsmj6cMslujsQB1zVIGQ4EGEb+Mr1
	 ttSE3RapWDotJqnYt5VomiPAfJ8+ouJqcGpyY3ajkKBsEQ4sbl6TBYAdcXPjQDRakLL1n
	 rCfWmTtCXF4LPbG3I3g4iiYdDkoOHaWkOGBVG81MS0bz+cgK2qL+tbebUGF5223e1cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628689;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qQXCflyD4lDkz0Cb6s+mEtdNB8+RdPZjgPQ48LX8WYA=;
	b=FwFEwSQ2Tv3CEIRu+T0v57XRHiOhip4YChWef0HKnJv8tCANTdGrnUBsSOuzIwL2hhxg
	 UNH5IG84AjE/KL/4GtuC6ygJ5LuDzjgym4jj4OYGRurSkFUc//zh/SkEKm6CwZ+XqrVXI
	 KjV6YyTAe+OEFUKYwbI0OouuyYypwfFIpjE40QMOryGqs+SlmfeEGRQxHAa/f/bYtgIei
	 /E/MX1/0oD29/2AkgIbThHVPXoYeyGn6rWOHa65gpC038RNHFHmjwj6A95utO9doFFSa0
	 U7gENsRt1qzHKxNrj7FLcX6lym9JEioBkjHQZ0Cglhz/56b2B96LnlSYz+ZgpavAkZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nHJsYDiW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F42B606A329
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nHJsYDiW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F147A1F00A16
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 14:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793628689;
	bh=qQXCflyD4lDkz0Cb6s+mEtdNB8+RdPZjgPQ48LX8WYA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=nHJsYDiWDLdbK06un76dBwgxLAv/LXGOivd6EeyfraN1Rjj8OVrOb2ZRJS91DAoTf
	 njEGdSLNay6TzGovbnuSqZMO5/Ph7VKJO2q4LG+uK9mcy1VUxdRfilABDR0kaol6Sy
	 Gb9QJxXNeibWacpizPMDWp6IWiDHA7rV7Ut/9kaapGXCe+C9i/OzWnUkpDecC032OH
	 KuulAoY/r8iPkAJDS681v/5LtNR8E4xa8chCgnd6FafLyK3ZOA5zcu899GejVeoiCT
	 62JH3MymUb+tC9ar61kM0PXDkCQWOwn5Gphc69UmNO65DVFfMozD3sr/kgxiBmRpNb
	 h7KH0SmtRWrEg==
Message-ID: <sashiko-outbox-193537@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] iommu: Add iommu_is_available() API
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261102-lockdown-iommu-v1-1-00f3c2be4c9f@kernel.org>
References: <20261102-lockdown-iommu-v1-0-00f3c2be4c9f@kernel.org>
 <20261102-lockdown-iommu-v1-1-00f3c2be4c9f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 14:11:28 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] iommu: iommu_available never cleared in iommu_device_unregister()
- [Medium] iommu: iommu_device_register() marks non-translating IOMMUs avai=
lable
- [Low] iommu: unnecessary export and wrong doc for iommu_set_available()
- [Low] iommu: unmarked lockless access to iommu_available
--

commit 994e0def279fa954a8ab08056b43fb15157b3edd
Author: Mario Limonciello (AMD) <superm1@kernel.org>

iommu: Add iommu_is_available() API

This commit introduces iommu_is_available() and iommu_set_available() so
that security subsystems such as lockdown can query whether an IOMMU driver
has registered and probed on the platform.

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index b486b8bbd1fcd..d042944713ab4 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -309,6 +309,13 @@ int iommu_device_register(struct iommu_device *iommu,
>  		iommu_device_unregister(iommu);
>  	else
>  		WRITE_ONCE(iommu->ready, true);
> +	/*
> +	 * Mark IOMMU as available if registration succeeded and bus probing
> +	 * succeeded. This enables security checks (e.g. lockdown IOMMU check)
> +	 * that depend on knowing whether hardware IOMMU isolation is present.
> +	 */
> +	if (!err)
> +		iommu_set_available();

[Severity: High]
What happens if all registered IOMMU devices are later unregistered via
iommu_device_unregister()?

Several IOMMU drivers perform additional fallible initialization steps after
calling iommu_device_register() and unwind with iommu_device_unregister() on
failure. For example, in drivers/iommu/amd/init.c:

iommu_init_pci()
  iommu_device_register()
  pci_enable_device()

and later in state_next():

state_next()
  amd_iommu_enable_interrupts()
  free_iommu_resources()
    free_iommu_all()
      free_iommu_one()
        free_sysfs()
          iommu_device_unregister(&iommu->iommu);

Similar post-registration error paths exist in mtk_iommu_probe() (when
component_master_add_with_match() fails) and sprd_iommu_probe() (when
sprd_iommu_clk_enable() or sprd_iommu_get_version() fails), as well as
driver unbind and hot-unplug paths.

Because iommu_device_unregister() removes the instance from
iommu_device_list without clearing or recalculating iommu_available when the
list becomes empty, won't iommu_is_available() permanently return true even
when no IOMMU device remains registered?

[Severity: Medium]
Could setting iommu_available unconditionally when iommu_device_register()
succeeds report true on platforms where no DMA translation or isolation is
actually active?

In drivers/iommu/iommu.c, probe_iommu_group() converts -ENODEV from
__iommu_probe_device() into 0, so bus_iommu_probe() succeeds even when an
IOMMU driver rejects all devices or provides no DMA translation:

1. In drivers/iommu/amd/init.c, iommu_init_pci() calls
   iommu_device_register() even when amd_iommu_pgtable =3D=3D PD_MODE_NONE
   (where DMA translation is unsupported and only interrupt remapping is
   used, causing amd_iommu_probe_device() to return ERR_PTR(-ENODEV) for
   every device):

	ret =3D iommu_device_register(&iommu->iommu, &amd_iommu_ops, NULL);
	if (ret || amd_iommu_pgtable =3D=3D PD_MODE_NONE) {
		iommu_device_sysfs_remove(&iommu->iommu);
	}

2. In drivers/xen/grant-dma-iommu.c, grant_dma_iommu_probe() registers
   grant_dma_iommu_ops, whose probe_device callback unconditionally returns
   ERR_PTR(-ENODEV) without providing hardware DMA isolation.

3. When default passthrough mode is active (iommu_default_passthrough() is
   true via iommu=3Dpt, iommu.passthrough=3D1, or
   CONFIG_IOMMU_DEFAULT_PASSTHROUGH=3Dy), internal PCI/PCIe devices are pla=
ced
   in IOMMU_DOMAIN_IDENTITY domains with unrestricted DMA access to physical
   memory.

Should iommu_is_available() account for whether active DMA translation is
present rather than only checking if iommu_device_register() was called?

>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(iommu_device_register);
> @@ -2961,6 +2968,47 @@ static int __init iommu_init(void)
>  }
>  core_initcall(iommu_init);
> =20
> +static bool iommu_available __read_mostly;
> +
> +/**
> + * iommu_is_available() - Check if IOMMU subsystem is available

[ ... ]

> + */
> +bool iommu_is_available(void)
> +{
> +	return iommu_available;
> +}
> +EXPORT_SYMBOL_GPL(iommu_is_available);
> +
> +/**
> + * iommu_set_available() - Mark IOMMU as available
> + *
> + * Called by IOMMU drivers during probe to indicate that hardware IOMMU
> + * support is functional on this platform.
> + *
> + * Context: Called from driver probe paths.
> + */
> +void iommu_set_available(void)
> +{
> +	iommu_available =3D true;
> +}
> +EXPORT_SYMBOL_GPL(iommu_set_available);

[Severity: Low]
Since iommu_is_available() can be called at any time after module
initialization has begun while deferred or hotplug IOMMU driver probes may
call iommu_device_register() concurrently without holding a shared lock,
should the accesses to iommu_available use READ_ONCE() and WRITE_ONCE()
(similar to WRITE_ONCE(iommu->ready, true) in iommu_device_register()), or
check !list_empty(&iommu_device_list) under iommu_device_lock, to avoid
KCSAN data-race warnings?

[Severity: Low]
Is there any reason to declare iommu_set_available() in
include/linux/iommu.h and export it via EXPORT_SYMBOL_GPL()?

The kernel-doc comment states that it is called by IOMMU drivers during
probe, but its only caller is iommu_device_register() in
drivers/iommu/iommu.c. Could iommu_set_available() be made static (or folded
directly into iommu_device_register()) so arbitrary modules cannot flip this
security-sensitive state without registering an IOMMU device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-lockdown-i=
ommu-v1-0-00f3c2be4c9f@kernel.org?part=3D1

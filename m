Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0B35372E3;
	Wed, 14 Oct 2026 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990736; cv=none; b=tEi8PWdyGb5XJ2aEqQvcIzigKJayF+RwC0/dRfT0tk2M4SFaSZRIeye0hTO+UzrL/8e54LK0kjiUYK1dbCatctPMeS+Nb17+63LNUacJFtfAuWd6guuasyQsXCBFhDKrxM1XCMFfnVLCUxifc8oi+Ww1YK17zXtlLvjvhwcrrl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990736; c=relaxed/simple;
	bh=ret03gXXUe745rj5oNJiuHnuJiDIFBPRNk6nuyKTehw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pMTXLI/Qvsm9aoPxFaIAF+kn2pjODWNOuYyKA56L/7Zc9heZUn2Vr/CesKH2Tuc6ZmpyH2M1I8AtVq+cphoMj6L9afmLwhZEMwJFLrQIGfO3uafEivUpefmDBEyFEwmyVkiovOpP/4qBJt6ds7waLQGOft2gVSlSuczIr6c0Kds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbdlqI3t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbdlqI3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D821F000C4;
	Wed, 14 Oct 2026 15:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791990732;
	bh=7ACeAIJU2xItTaXNmzqGWbMv8SkpyrGFeI0YYBObKDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dbdlqI3tpzqsYA0hOAK50zwHvA6+5yxEi2MiQ3GhWLgVa+qrNTvvW9uNiWn/1c5pv
	 f8cKmCnu5bHoSzs5x6mpQFLkpAeJn4KPagTvAyY3fE+UDbJjMjduqQXP9FK5tk5lry
	 jc+wQKy39T0pbdpEL3JrsYjCgl5BjjMrX0bpo+tbYmsl/2vqfTUGzugDJS/MdqvlLD
	 q/285Hd7LM0NvfqDsMTNmtI7rSqIThc6/fCK5Eby3KO4G/QQW6AMeQ1/KZKItOviUO
	 9SV+FbjWlsyA5ZDi6n1Xh9Xj73Gr1/5O6LibZcRDIreSjyjZJAfp8aQtH+ZHWoaXry
	 GZQJixxrzFiUw==
Message-ID: <sashiko-outbox-171460@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] kexec: Select ima_get/free_kexec_buffer() with
 CONFIG_HAVE_IMA_KEXEC(_OF)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>
Cc: devicetree@vger.kernel.org, linux-security-module@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261014150005.138309-1-roberto.sassu@huaweicloud.com>
References: <20261014150005.138309-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 15:12:11 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ima: off-by-one in ima_validate_range bypasses memory boundary che=
ck
--

commit 7ddca2cd41824acc187deeda05f385f27ac90508
Author: Roberto Sassu <roberto.sassu@huawei.com>

kexec: Select ima_get/free_kexec_buffer() with CONFIG_HAVE_IMA_KEXEC(_OF)

This commit introduces CONFIG_HAVE_IMA_KEXEC_OF and selects it for
architectures using the device tree implementation for IMA kexec buffers.
It also modifies x86 to use its own setup_data-based implementation
regardless of CONFIG_OF_FLATTREE.

> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index cda6adb9f69c4..bc17e353c0992 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
[ ... ]
> @@ -421,7 +421,7 @@ static void __init add_early_ima_buffer(u64 phys_addr)
>  #endif
>  }
> =20
> -#if defined(CONFIG_HAVE_IMA_KEXEC) && !defined(CONFIG_OF_FLATTREE)
> +#ifdef CONFIG_HAVE_IMA_KEXEC
>  int __init ima_free_kexec_buffer(void)
>  {

[Severity: High]
Does enabling this on x86 expose an off-by-one regression in how IMA valida=
tes
the memory range?

In security/integrity/ima/ima_kexec.c:ima_validate_range(), the end_pfn is
calculated inclusively:

    end_phys =3D phys + size - 1;
    end_pfn =3D PHYS_PFN(end_phys);

However, on x86, this inclusive end_pfn is passed to pfn_range_is_mapped():

    if (!pfn_range_is_mapped(start_pfn, end_pfn))

Looking at arch/x86/mm/init.c:pfn_range_is_mapped(), it expects an exclusive
end_pfn boundary, checking if the region is within pfn_mapped[i]:

    if ((start_pfn >=3D pfn_mapped[i].start) &&
        (end_pfn <=3D pfn_mapped[i].end))

Because ima_validate_range() passes an inclusive PFN, the validated range is
effectively one page smaller than the actual buffer. If the actual buffer
extends exactly one page beyond the valid mapped memory, could
pfn_range_is_mapped() incorrectly return true?

Would the subsequent direct map access via __va(ima_kexec_buffer_phys) up
to size hit the unmapped page, resulting in an out-of-bounds access
during boot?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014150005.1383=
09-1-roberto.sassu@huaweicloud.com?part=3D1

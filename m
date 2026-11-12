Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488907;
	b=uLYObBdXTZxjFuEhdSHlJRk+SiFCR+j/ZkhntkP5zEBkDaNRAx1+P7vWeSs/IoRJITiI
	 w531yiC9OTR4BmKSoFlRRG35VC8xMkjgMzlA4Dmzqgbk9FwmFwHCgtm3vYbwoEX3dtQA3
	 P7QB1YwoJLO+cfOoFZI+q6ID7e2l4Kz7Tbr/Ars2vSRolg2pnqFA313s6x0J0WrldCKAI
	 y/JuhqMYhOOxrIIlG2CfWcORGpyLXCu16L/u5tRhqVYhPWSY4XYaFAQSUas/BX0PRRhnd
	 fIn2zML8egAjXO+SsGkAIlqm8HssZeR6rG/IalR5JSMm8pQ5ItYTM/Qik12GZdBrG4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488907;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xvq/3l5gEtz/ZJql/KSJ15Ym1MTTiZiNMKFxG73RPHM=;
	b=h85rXgkZAXOGUjfKXQlp8CfYhObUE4c1DCkWhVm4WhMtg3CjjAbMBDXqd05xRQRlrGIq
	 up/FS9ECDr8NY/mi/umqxVi5f7bgCTb282TnUyhanRozR6GPUwVVvR8b5RDNTE+wp84d+
	 TwNkHmt4E8DPArZbl62eEns6tAr1l3e4c2BfruLpMFiYpyNjvRNzdzInwnlmG/Ill6fLD
	 McoSBLgX0SJ5JoAlk52ULt29OFEepOQmOYHfm1wW1HPhjhOX4JacNYbLodQukosS5gilT
	 n7DZUnroJK8aubxzMUUlzImRpH7NgGMlAeiqU5cga1A6xm6dg0cAVNSh0SVMfv/6dYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JALX64Fd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8131606A31C
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 13:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JALX64Fd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28881F00A05;
	Thu, 12 Nov 2026 13:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794488907;
	bh=xvq/3l5gEtz/ZJql/KSJ15Ym1MTTiZiNMKFxG73RPHM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JALX64FdNTB1p/xiJ2wQYrFi1oi+KlBDGUeOoPJDTQSIVn3yJkonlrPSuosT/y/vI
	 tyh+73Zy85YU6zK86xb2teJ5O+DDJxf86dU1vqCcDRnq3trcj4AJ4rHBbmZajHh8V2
	 zYxysTPThUWDXHgXMjLJS2zPUv8Nuz70D2kC8zDqqLHxdjciej99XyH9HzwsknGne2
	 PFsAZiRjZD0aL4hfeuyV9ZQYjSJEWrrJSLGwDtBEyjDry4yDfOyQv7EqEiVre7cNqR
	 aav1ccNNiFEM/po3koXepX7kvM5EKFDGx9J/05K55t6/0BjR/dW0lEdsmh7DvAFOo1
	 3CxgQ62bYJnrQ==
Message-ID: <sashiko-outbox-211145@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] ima: clear kexec state when replacing file image
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>
Cc: "Eric Snowberg" <eric.snowberg@oracle.com>, linux-security-module@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261112125246.2715174-5-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261112125246.2715174-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261112125246.2715174-5-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 13:08:24 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] kexec: skipped ima_kexec_cleanup() with crash flags when
  !CONFIG_CRASH_DUMP
--

commit bddeb1d64059b337f4ac9e46300e35fd5ccaa690
Author: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

ima: clear kexec state when replacing file image

This commit tracks the kimage associated with ima_kexec_buffer and clears
the IMA kexec state when a normal kexec image is unloaded or replaced via
kexec_load() or kexec_file_load().

> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 90756dc6339b0..297f4657869bc 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
[ ... ]
> @@ -114,6 +115,10 @@ static int do_kexec_load(unsigned long entry, unsign=
ed long nr_segments,
> =20
>  	if (nr_segments =3D=3D 0) {
>  		/* Uninstall image */
> +#ifdef CONFIG_IMA_KEXEC
> +		if (!(flags & KEXEC_ON_CRASH))
> +			ima_kexec_cleanup();
> +#endif
>  		kimage_free(xchg(dest_image, NULL));
>  		ret =3D 0;
>  		goto out_unlock;
> @@ -163,6 +168,12 @@ static int do_kexec_load(unsigned long entry, unsign=
ed long nr_segments,
>  	if (ret)
>  		goto out;
> =20
> +	/* A kexec_load image has no IMA measurement segment. */
> +#ifdef CONFIG_IMA_KEXEC
> +	if (!(flags & KEXEC_ON_CRASH))
> +		ima_kexec_cleanup();
> +#endif
> +
>  	/* Install the new kernel and uninstall the old */
>  	image =3D xchg(dest_image, image);
> =20
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 6c5724aa3c749..866601712e994 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -399,8 +399,13 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int=
, initrd_fd,
>  #endif
>  		dest_image =3D &kexec_image;
> =20
> -	if (flags & KEXEC_FILE_UNLOAD)
> +	if (flags & KEXEC_FILE_UNLOAD) {
> +#ifdef CONFIG_IMA_KEXEC
> +		if (image_type =3D=3D KEXEC_TYPE_DEFAULT)
> +			ima_kexec_cleanup();
> +#endif
>  		goto exchange;
> +	}

[Severity: Medium]
Can these checks skip ima_kexec_cleanup() while still freeing kexec_image
when CONFIG_CRASH_DUMP is disabled?

In both do_kexec_load() and SYSCALL_DEFINE5(kexec_file_load), selecting
kexec_crash_image is guarded by CONFIG_CRASH_DUMP:

kernel/kexec.c:do_kexec_load() {
    ...
#ifdef CONFIG_CRASH_DUMP
	if (flags & KEXEC_ON_CRASH) {
		dest_image =3D &kexec_crash_image;
		if (kexec_crash_image)
			arch_kexec_unprotect_crashkres();
	} else
#endif
		dest_image =3D &kexec_image;
    ...
}

When CONFIG_IMA_KEXEC=3Dy and CONFIG_CRASH_DUMP=3Dn, calling kexec_load() w=
ith
KEXEC_ON_CRASH or kexec_file_load() with KEXEC_FILE_UNLOAD |
KEXEC_FILE_ON_CRASH sets dest_image to &kexec_image and frees the active
kexec_image, but the !(flags & KEXEC_ON_CRASH) and image_type =3D=3D
KEXEC_TYPE_DEFAULT checks skip ima_kexec_cleanup().  That leaves
ima_kexec_buffer mapped to freed pages and ima_kexec_image dangling; if a
subsequent load allocates a new struct kimage at the same slab address,
ima_update_kexec_buffer() sees ima_kexec_image =3D=3D kexec_image and writes
the measurement list into the freed pages (use-after-free).

Checking dest_image =3D=3D &kexec_image instead would match the image actua=
lly
being replaced or unloaded.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112125246.2715=
174-2-Jeremy.Jean@oss.cyber.gouv.fr?part=3D3

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795306261;
	b=huXdncFQJKsKtAUOhGi6mNOlyeH+yc/uQqfk5MX+j0vBVWIlFH9sRHkKisZuzVLgy6FF
	 jEUY2f75wVUrA0LBHaZuLQS9bomBaS0dQQOT3Pti9rB8vsYZFDDCsc0YJchr0alZfag4l
	 JQ8vOFiLqbwvXksJ8wZB7dLvsbJn5cftCwWVzDsp/5HSJI8LJtGUy6ycqtkGPpK9pqTmQ
	 E4/S3y1rU3d1zRzm7KvAKfVjT9Uo3jQUDUe6JiXoW8Qa1dN+VyK2UWYKJUgyu0dre+A55
	 2TF6p5iLxkuOfMbG5V7fwtHWXCm1mveABPW+lchfD49VGUf4knweVzft42XJVGCPJ+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795306261;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+Xl9s4gVpPKCKd7J+OHDCYJawIfMHN2GfmrNwppsbQA=;
	b=MfN4n6kgsLm+OGLxqkrRWkTTtviYHNM+MC05x0v013mh4n9nvSi4bjib6LzvGPs16K35
	 sgfm3QFL3Ke6MZcuATmKkwWsuv8dE7YXyDh10FtaXnV3NRjbIB+u+d8gMbdRDheqjVVdV
	 hvpaGwchQKY/rWFLR4WOoFe/YSNqawbKs0/vCa6HhYOACmlW8pDghP6W9den5JUZ39A8w
	 JWxNtDvrat4ONROn2TCtsOjZcsO8sTUtQm1SCf4K6g742WL/q8dZ0q0T//1vQD5cbG90p
	 /qf0Ho+HZvGn0VpE2HFxO/PI+ZiSdp2vx7id5XtdyNphDQcajhT7VzKtNgOcZ2jGk4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cF2Bdve8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD2D606A320
	for <linux-security-module@vger.kernel.org>; Sun, 22 Nov 2026 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cF2Bdve8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B40A1F000CF;
	Sun, 22 Nov 2026 00:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795306261;
	bh=+Xl9s4gVpPKCKd7J+OHDCYJawIfMHN2GfmrNwppsbQA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cF2Bdve8/qznSQsfnd1xYEgiUrcxCrd7V58WAGmCRzQrPkGOc+Dd625R2Ma6n7R+O
	 et24swcuuqW8cHlZg5kHSDaKVHyNZhvhVQe87bKpUk2IWXWmG8W5XfHOdsjnhg7htm
	 1968X1SwcsHOJvx8NNn9GVQ3Bn04m50MMi4vzuDup9JHeEa6LXdZwm/qsunbUWOshZ
	 Lc086RdEgiT5YfVTyEBAbTccD2SKjAbd5hHw6bar7loHKG/cNn2Mf0pCeN09bSe/DM
	 olsiQ6BhOR9pJJRyj3GzLxY3XT7+ME7uyM8Ym4ADyXcRnDE5kgfnfNzd42dbc5PDrr
	 XdF/d7hu2CXnQ==
Message-ID: <sashiko-outbox-227557@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 22/25] arch: Wire up rootns() system call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Alexander
 Mikhalitsyn" <alex@amutable.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Andy
 Lutomirski" <luto@amacapital.net>, "Christian Brauner" <brauner@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Jan Kara" <jack@suse.cz>, "Jonathan Corbet" <corbet@lwn.net>, "Josef
 Bacik" <josef@toxicpanda.com>, "Kees Cook" <kees@kernel.org>, "Neal Gompa" <neal@gompa.dev>, "Paul
 Moore" <paul@paul-moore.com>, "Serge Hallyn" <sergeh@kernel.org>, "Zygmunt
 Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261121000844.1863324-23-jarkko@kernel.org>
References: <20261121000844.1863324-1-jarkko@kernel.org>
 <20261121000844.1863324-23-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 00:11:00 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] arch: syscall tables wire rootns() to non-existent
  sys_sys_rootns symbol
- [High] arch: syscall tables wire userns_set_idmap() to
  sys_sys_userns_set_idmap
--

commit a98066c1928facdce930fb742694c04361f3d11f
Author: Jarkko Sakkinen <jarkko@kernel.org>

arch: Wire up rootns() system call

This commit wires up the rootns() system call across the architecture
system call tables and asm-generic unistd.h.

> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/s=
yscalls/syscall.tbl
> index 9384d59a44dcd..2087b83d6d2ce 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -513,3 +513,4 @@
>  581	common	rseq_slice_yield		sys_rseq_slice_yield
>  582	common	fchroot				sys_fchroot
>  583	common	userns_set_idmap		sys_sys_userns_set_idmap

[Severity: High]
Should the userns_set_idmap entry added by commit "arch: Wire up
userns_set_idmap() system call" in this series use sys_userns_set_idmap
instead of sys_sys_userns_set_idmap here and in the other 16 syscall
tables?

kernel/user_namespace.c defines the entry point with
SYSCALL_DEFINE4(userns_set_idmap, ...), so the doubled sys_ prefix causes
syscall table compilation or linking to fail with an undeclared or
undefined sys_sys_userns_set_idmap symbol.

> +584	common	rootns				sys_sys_rootns

[Severity: High]
Should the rootns entry use sys_rootns instead of sys_sys_rootns here and
in all 16 other syscall.tbl files modified by this patch?

kernel/rootns.c defines the entry point via SYSCALL_DEFINE1(rootns, ...)
and include/uapi/asm-generic/unistd.h maps __NR_rootns to sys_rootns, so
the doubled sys_ prefix causes the build or vmlinux link to fail across
all architectures using syscall.tbl files.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121000844.1863=
324-1-jarkko@kernel.org?part=3D22

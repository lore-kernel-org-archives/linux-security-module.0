Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795306255;
	b=dOA8nejCdM2+kNbrhE3GrOK+x88jvDQbeYdJAyffaO8tT0DU+tFiciQ3y5peNg1bO8Nn
	 KNRC4pFx4Ll/Qt+TkpWYqA9d3a23FWCsD4WATIf4CF/9A7GgIpJWky88AmHGPsnk7vGeP
	 jdsqeEy7DoFQUuPWiwGJfRb7t0w1ooqVpntbF0Mn3RaBQUUgQv/0qOG9e9isSE+Rq8DYK
	 RiYY7QMRGaow+EBotdHBN1VomuFlffIfDnInAoIiTrGTb5UbpmpR20K9vAmxEPyZkup5o
	 Ok2jgmah5IHKDLxmKGNUTi2Eha7fpE1wjQVlSRSXAM2pHtxZ5wjur2NTO9CnyCaTm1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795306255;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YDEZd+115v43bK/wr1bFRFbeszstBTRa8ACq9ULnBOQ=;
	b=1ou27V2hiDdho9GE6fPc1KxlG1Qyf1AYFzzQGVT/pT8a2z9JZtZlZzHKq1AsJ1Du4kKH
	 F/9U6mQw5Yc2qw2FPG5jU5RfUEt/d0b2GuxkCEQdmmxMX5Z9aLruLTOiT0+8sxSMwXFXb
	 Ric1aE9wjrMFWrLkbmBFJFuprYtiyihmYlVm5zU+C+sY8IAomI6oZoYYmcjxiup8rMOKL
	 vf7FXMGrbrTN0/tEBl+zNHa9aGFuFRY4+8npWjg/QCruoV8nlEMu19ALou6zLIHNsO+DY
	 yA9YjbTQ6jcLXst11Nh9QnNBdR8y50NrMcB9gCS/gryppIpH/A7Ico8Qv2Ol+bgh/Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmQ6M1rL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E46F606A320
	for <linux-security-module@vger.kernel.org>; Sun, 22 Nov 2026 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmQ6M1rL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C891F000CF;
	Sun, 22 Nov 2026 00:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795306255;
	bh=YDEZd+115v43bK/wr1bFRFbeszstBTRa8ACq9ULnBOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hmQ6M1rLHKpTRjaiNNMLGrsaKJqArrTdAIZHfM02sku8F0ZjI8WUlH/htwPRyVHiV
	 6J2gJCV9NGDIDz+MXqdWZn54l5m/XHgxjR6Hh3d288WFHZE7NKyJZp5KdJh37gR2Pq
	 hk+jpRhaxE38e8Frx0gR/HV0Ll3J+YIHWMTbq/GWWZHjhg2X0Sa2I40Gdmu8y7KeN1
	 MhiNS1BmCv9gTa1a4SMZjQr0UfK0jE0aTGYSZk3gFxoXlYFlPyVfdN/Fr8vpSH06hh
	 zYCLrix19edCmqV8fuNQymk1dJv325KAGzKikRAR93Z3aOTflr3rwIgOmOuhTQVL7i
	 cWQBIgLoFBc1g==
Message-ID: <sashiko-outbox-227538@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 03/25] arch: Wire up userns_set_idmap() system
 call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Alexander
 Mikhalitsyn" <alex@amutable.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Andy
 Lutomirski" <luto@amacapital.net>, "Christian Brauner" <brauner@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Jan Kara" <jack@suse.cz>, "Jonathan Corbet" <corbet@lwn.net>, "Josef
 Bacik" <josef@toxicpanda.com>, "Kees Cook" <kees@kernel.org>, "Neal Gompa" <neal@gompa.dev>, "Paul
 Moore" <paul@paul-moore.com>, "Serge Hallyn" <sergeh@kernel.org>, "Zygmunt
 Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261121000844.1863324-4-jarkko@kernel.org>
References: <20261121000844.1863324-1-jarkko@kernel.org>
 <20261121000844.1863324-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 00:10:54 +0000
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
- [High] arch: duplicate sys_ prefix in syscall.tbl for
  userns_set_idmap()
--

commit 830eeaaedd55436f6eba477c154843b0a257eb5d
Author: Jarkko Sakkinen <jarkko@kernel.org>

arch: Wire up userns_set_idmap() system call

This commit wires up the userns_set_idmap() system call across the
architecture syscall tables and include/uapi/asm-generic/unistd.h.

> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/s=
yscalls/syscall.tbl
> index 52e3538cc7df4..9384d59a44dcd 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -512,3 +512,4 @@
>  580	common	listns				sys_listns
>  581	common	rseq_slice_yield		sys_rseq_slice_yield
>  582	common	fchroot				sys_fchroot
> +583	common	userns_set_idmap		sys_sys_userns_set_idmap
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index 55717ed32c27e..6130366b76812 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -487,3 +487,4 @@
>  470	common	listns				sys_listns
>  471	common	rseq_slice_yield		sys_rseq_slice_yield
>  472	common	fchroot				sys_fchroot
> +473	common	userns_set_idmap		sys_sys_userns_set_idmap
> diff --git a/arch/arm64/tools/syscall_32.tbl b/arch/arm64/tools/syscall_3=
2.tbl
> index df2d1d82fb3cc..3fcc7899fd087 100644
> --- a/arch/arm64/tools/syscall_32.tbl
> +++ b/arch/arm64/tools/syscall_32.tbl
> @@ -484,3 +484,4 @@
>  470	common	listns				sys_listns
>  471	common	rseq_slice_yield		sys_rseq_slice_yield
>  472	common	fchroot				sys_fchroot
> +473	common	userns_set_idmap		sys_sys_userns_set_idmap
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/sys=
calls/syscall.tbl
> index ba7a4d8903d04..5607635bd4bd7 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -472,3 +472,4 @@
>  470	common	listns				sys_listns
>  471	common	rseq_slice_yield		sys_rseq_slice_yield
>  472	common	fchroot				sys_fchroot
> +473	common	userns_set_idmap		sys_sys_userns_set_idmap
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaz=
e/kernel/syscalls/syscall.tbl
> index 76d7cbe2a133c..97ee93f42fac2 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -478,3 +478,4 @@
>  470	common	listns				sys_listns
>  471	common	rseq_slice_yield		sys_rseq_slice_yield
>  472	common	fchroot				sys_fchroot
> +473	common	userns_set_idmap		sys_sys_userns_set_idmap
> diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel=
/syscalls/syscall_n32.tbl
> index 9ae88e4eac61e..da4ed57a91d3b 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -411,3 +411,4 @@
>  470	n32	listns				sys_listns
>  471	n32	rseq_slice_yield		sys_rseq_slice_yield
>  472	n32	fchroot				sys_fchroot
> +473	n32	userns_set_idmap		sys_sys_userns_set_idmap
> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel=
/syscalls/syscall_n64.tbl
> index 83dc93a0712f1..5e9839b6b3891 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -387,3 +387,4 @@
>  470	n64	listns				sys_listns
>  471	n64	rseq_slice_yield		sys_rseq_slice_yield
>  472	n64	fchroot				sys_fchroot
> +473	n64	userns_set_idmap		sys_sys_userns_set_idmap
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel=
/syscalls/syscall_o32.tbl
> index 9c62429c9b7b4..290c1b61be47d 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -460,3 +460,4 @@
>  470	o32	listns				sys_listns
>  471	o32	rseq_slice_yield		sys_rseq_slice_yield
>  472	o32	fchroot				sys_fchroot
> +473	o32	userns_set_idmap		sys_sys_userns_set_idmap
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel=
/syscalls/syscall.tbl
> index 88adc4016cce0..fc0fa917eb92a 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -471,3 +471,4 @@
>  470	common	listns				sys_listns
>  471	common	rseq_slice_yield		sys_rseq_slice_yield
>  472	common	fchroot				sys_fchroot
> +473	common	userns_set_idmap		sys_sys_userns_set_idmap
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kern=
el/syscalls/syscall.tbl
> index cfbb70039ff00..d12e49022b235 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -563,3 +563,4 @@
>  470	common	listns				sys_listns
>  471	nospu	rseq_slice_yield		sys_rseq_slice_yield
>  472	common	fchroot				sys_fchroot
> +473	common	userns_set_idmap		sys_sys_userns_set_idmap
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/sys=
calls/syscall.tbl
> index 1b45e68a217bb..dc427811d30d7 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -399,3 +399,4 @@
>  470	common	listns				sys_listns
>  471	common	rseq_slice_yield		sys_rseq_slice_yield
>  472	common	fchroot				sys_fchroot
> +473	common	userns_set_idmap		sys_sys_userns_set_idmap
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscall=
s/syscall.tbl
> index ace068dff0de0..e62ac9acc7ada 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -476,3 +476,4 @@
>  470	common	listns				sys_listns
>  471	common	rseq_slice_yield		sys_rseq_slice_yield
>  472	common	fchroot				sys_fchroot
> +473	common	userns_set_idmap		sys_sys_userns_set_idmap
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/s=
yscalls/syscall.tbl
> index 5b9fe0e8140f2..df074bf322c41 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -518,3 +518,4 @@
>  470	common	listns				sys_listns
>  471	common	rseq_slice_yield		sys_rseq_slice_yield
>  472	common	fchroot				sys_fchroot
> +473	common	userns_set_idmap		sys_sys_userns_set_idmap
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/sysc=
alls/syscall_32.tbl
> index 2c172ef48dfd3..243a3f55834dd 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -478,3 +478,4 @@
>  470	i386	listns			sys_listns
>  471	i386	rseq_slice_yield	sys_rseq_slice_yield
>  472	i386	fchroot			sys_fchroot
> +473	i386	userns_set_idmap	sys_sys_userns_set_idmap
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/sysc=
alls/syscall_64.tbl
> index d5b6045b0090c..f11700e3af657 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -397,6 +397,7 @@
>  470	common	listns			sys_listns
>  471	common	rseq_slice_yield	sys_rseq_slice_yield
>  472	common	fchroot			sys_fchroot
> +473	common	userns_set_idmap	sys_sys_userns_set_idmap
> =20
>  #
>  # Due to a historical design error, certain syscalls are numbered differ=
ently
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel=
/syscalls/syscall.tbl
> index d354bb231796c..1d28de95915f5 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -443,3 +443,4 @@
>  470	common	listns				sys_listns
>  471	common	rseq_slice_yield		sys_rseq_slice_yield
>  472	common	fchroot				sys_fchroot
> +473	common	userns_set_idmap		sys_sys_userns_set_idmap
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic=
/unistd.h
> index 5b7e77a7c736e..695eac2d356bc 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -867,8 +867,12 @@ __SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yiel=
d)
>  #define __NR_fchroot 472
>  __SYSCALL(__NR_fchroot, sys_fchroot)
> =20
> +/* kernel/user_namespace.c */
> +#define __NR_userns_set_idmap 473
> +__SYSCALL(__NR_userns_set_idmap, sys_userns_set_idmap)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 473
> +#define __NR_syscalls 474
> =20
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
> index 0ab5316051202..0dddd465d1c5a 100644
> --- a/scripts/syscall.tbl
> +++ b/scripts/syscall.tbl
> @@ -413,3 +413,4 @@
>  470	common	listns				sys_listns
>  471	common	rseq_slice_yield		sys_rseq_slice_yield
>  472	common	fchroot				sys_fchroot
> +473	common	userns_set_idmap		sys_sys_userns_set_idmap

[Severity: High]
Should the entry point in scripts/syscall.tbl and the architecture
syscall*.tbl files be sys_userns_set_idmap rather than
sys_sys_userns_set_idmap?  Because the syscall is defined with
SYSCALL_DEFINE4(userns_set_idmap, ...), the duplicated sys_ prefix causes
the generated syscall tables to reference undefined symbols such as
sys_sys_userns_set_idmap and __x64_sys_sys_userns_set_idmap, breaking the
build across all architectures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121000844.1863=
324-1-jarkko@kernel.org?part=3D3

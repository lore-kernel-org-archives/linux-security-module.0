Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187817;
	b=KYtw93GKECYicQOh6zjH/RL3KSnh9QffRg/kLy+97hcYxQd9S8xRdCuK0+dVEAHkNoyQ
	 zNE5fZdecsIzO9zyXdTH4P0GzTNtnzg+hOBhGv12sA0vHNZPisc+kRHBaPVnhYM6zMh23
	 mQxFePpjPTZiW9NT6q/3khEzDjCZrEdP4Z9EkM2hi556wUfb2GJI/dIm9N147WP8aIul8
	 emFjoh0So6zDwG7pKbeAkkIJaemT2E+HAAWx5EzVbj1ck8kg4r1XjYuNQM67O8lCCip7b
	 fpBCveaTwenMspYcXMIzxeaedTBpsvIl5vZ//IFgvY1T2OercPlHBIMVVcLcd5K0XHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187817;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WVtKokqXcM85OwTWDP0OGcE54KRFalbPr4wTUTcopSI=;
	b=CUcO4zJPNep3/05PvVwtr6Px29O2DCZFtxnrO3vEgR3wcHu57qAfpXvOyFU8LaaCIjtP
	 sddWoznfNGadFlaUZGYZpukuMHyHh5YD5OTF2hifLS0VbfFmbTTVXolyIfnqL3EiO2avC
	 0F7Uui3FHR0O0o3aD0iHGTNvnCjk7o6oD5/eANRzWwKy4MeCK0J51kVPMZXzOtkXmTpSI
	 o9Uf9pLdF9TCTMmjaDT1ZvXVCZuNHeLDCeu926LnlvI/+gqDUug9EwbOTXY0dKXXB/9oD
	 c5v9bd6Y3eMBLnoC7TFYd2muzPh9z5juBfANV28Ki94FZ2TG8RjhByPfCqJ7SmPTTfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KWbAZ9I9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732B0606A31E
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KWbAZ9I9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480F51F031E1;
	Wed, 28 Oct 2026 11:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793187817;
	bh=WVtKokqXcM85OwTWDP0OGcE54KRFalbPr4wTUTcopSI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KWbAZ9I989LkEOCeQPwgr/NwkuOWokbOVkvVJfU2cp1f+zLVYwrgYTTM7YAgJJ/+A
	 9NaICbviEkKlKv2cO6i5CJCNl8JbrerDhSFnSsWlF5WdsOiAjwsiZvU/bB9VRW4Rqj
	 3ErWmaN1/4OVZ3jjXPYeNqc29UZU9IxQhITrasMI2a6ZhRB4ma9WuuQavPeWAg74+T
	 rogKCSl6CXKrblq3SofeNUW+roPaHn3/Tarct4TO+gpeGNVNl/LBNb7yOht+yCK04J
	 pQWubTW0a8XxM18dGrr30uYFCf5usMEovdINlMWlxrU7N1UQ0zSjutiMYzD76w7InH
	 RIDxadJI+Y2rA==
Message-ID: <sashiko-outbox-187839@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] selftests/mseal_system_mappings: Test vdso unmap
 and remap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chris Down" <chris@chrisdown.name>, "Andrew Morton" <akpm@linux-foundation.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Lorenzo Stoakes" <ljs@kernel.org>
Cc: "Vlastimil Babka" <vbabka@kernel.org>, "Jann Horn" <jannh@google.com>, "Pedro
 Falcato" <pfalcato@suse.de>, "David Hildenbrand" <david@kernel.org>, "Kees
 Cook" <kees@kernel.org>, "Jeff Xu" <jeffxu@chromium.org>, "Andrey Vagin" <avagin@gmail.com>, "Alexander
 Mikhalitsyn" <alexander@mihalicyn.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Shuah
 Khan" <shuah@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, linux-mm@kvack.org, linux-security-module@vger.kernel.org, kernel-team@meta.com
In-Reply-To: <621847973ba2ec49d0a58e0261da35a9f3a97eda.1793094611.git.chris@chrisdown.name>
References: <cover.1793094611.git.chris@chrisdown.name>
 <621847973ba2ec49d0a58e0261da35a9f3a97eda.1793094611.git.chris@chrisdown.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 11:43:35 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/mseal: SIGSEGV in vdso_munmap() and vdso_mremap() on 3=
2-bit x86
--

commit c39ca555b3d21581707989b9c4e4f219f86ffc25
Author: Chris Down <chris@chrisdown.name>

selftests/mseal_system_mappings: Test vdso unmap and remap

This patch adds vdso_munmap and vdso_mremap tests to
tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c to verify
that unmapping or moving [vdso] fails with EPERM when sealed and succeeds
when unsealed.

> diff --git a/tools/testing/selftests/mseal_system_mappings/sysmap_is_seal=
ed.c b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
> index ea75ad537620b..83b4fadfbfe79 100644
> --- a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
> +++ b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c

[ ... ]

> @@ -232,4 +233,95 @@ TEST_F(basic, check_sealed)
>  	EXPECT_EQ(expected, sealed);
>  };
> =20
> +static bool find_vdso(unsigned long *start, unsigned long *end)
> +{
> +	char line[MAX_LINE_LEN];
> +	bool found =3D false;
> +	FILE *maps;
> +
> +	maps =3D fopen("/proc/self/maps", "r");
> +	if (!maps)
> +		return false;
> +
> +	while (fgets(line, sizeof(line), maps)) {
> +		if (strstr(line, "[vdso]") &&
> +		    sscanf(line, "%lx-%lx", start, end) =3D=3D 2) {
> +			found =3D true;
> +			break;
> +		}
> +	}
> +
> +	fclose(maps);
> +	return found;
> +}
> +
> +static int vdso_is_sealed(void)
> +{
> +	int sealed =3D -1;
> +	FILE *maps;
> +
> +	maps =3D fopen("/proc/self/smaps", "r");
> +	if (!maps)
> +		return -1;
> +	if (has_mapping("[vdso]", maps))
> +		sealed =3D mapping_is_sealed(maps);
> +	fclose(maps);
> +	return sealed;
> +}
> +
> +/*
> + * Unmapping or moving [vdso] must fail with EPERM when it is sealed. Wh=
en it
> + * is not sealed, it succeeds and leaves glibc with a stale vdso pointer=
, which
> + * is fine because each test runs in its own forked child.
> + */
> +TEST(vdso_munmap)
> +{
> +	int sealed;
> +	unsigned long start, end;
> +	int ret;
> +
> +	if (!find_vdso(&start, &end))
> +		SKIP(return, "could not find the mapping, [vdso]");
> +	sealed =3D vdso_is_sealed();
> +	if (sealed < 0)
> +		SKIP(return, "could not read the [vdso] sealing state");
> +
> +	ret =3D munmap((void *)start, end - start);
> +	if (sealed) {
> +		EXPECT_EQ(-1, ret);
> +		EXPECT_EQ(EPERM, errno);
> +	} else {
> +		EXPECT_EQ(0, ret);
> +	}
> +	EXPECT_EQ(sealed, find_vdso(&start, &end));
> +}
> +
> +TEST(vdso_mremap)
> +{
> +	int sealed;
> +	unsigned long start, end, size, new_start;
> +	void *dst, *ret;
> +
> +	if (!find_vdso(&start, &end))
> +		SKIP(return, "could not find the mapping, [vdso]");
> +	sealed =3D vdso_is_sealed();
> +	if (sealed < 0)
> +		SKIP(return, "could not read the [vdso] sealing state");
> +	size =3D end - start;
> +
> +	dst =3D mmap(NULL, size, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	ASSERT_NE(MAP_FAILED, dst);
> +
> +	ret =3D mremap((void *)start, size, size, MREMAP_MAYMOVE | MREMAP_FIXED,
> +		     dst);
> +	if (sealed) {
> +		EXPECT_EQ(MAP_FAILED, ret);
> +		EXPECT_EQ(EPERM, errno);
> +	} else {
> +		EXPECT_EQ(dst, ret);
> +	}
> +	ASSERT_TRUE(find_vdso(&new_start, &end));
> +	EXPECT_EQ(sealed ? start : (unsigned long)dst, new_start);
> +}

[Severity: Medium]
When sealed =3D=3D 0 on 32-bit x86 (__i386__), will vdso_munmap and vdso_mr=
emap
in tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c crash
with SIGSEGV and cause the test harness to report a failure?

On 32-bit x86, the kernel passes AT_SYSINFO in the ELF auxiliary vector
pointing to __kernel_vsyscall inside [vdso], and glibc caches this pointer
in %gs:0x10 and routes all system calls through it.

Neither vdso_munmap nor vdso_mremap skips on 32-bit builds or when
CONFIG_MSEAL_SYSTEM_MAPPINGS is disabled (which depends on 64BIT, or may be
disabled via CONFIG_CHECKPOINT_RESTORE=3Dy or mseal_system_mappings=3D0).

In vdso_munmap, when sealed =3D=3D 0, calling munmap() via glibc enters the
kernel through __kernel_vsyscall inside [vdso] with the userspace return
address pointing to the landing pad in [vdso]. Once [vdso] is unmapped,
returning to userspace or calling find_vdso() and _exit() in the child jumps
to the unmapped [vdso] range and faults with SIGSEGV.

Similarly, in vdso_mremap, when sealed =3D=3D 0, arch/x86/entry/vdso/vma.c
updates the return instruction pointer for the mremap() syscall itself via
vdso_fix_landing(), but glibc's cached %gs:0x10 pointer still points to the
old unmapped start address. The subsequent find_vdso() call (which invokes
fopen(), fgets(), and fclose()) and _exit() in the test harness jump through
the stale pointer into the unmapped address and fault with SIGSEGV, as noted
in tools/testing/selftests/x86/test_mremap_vdso.c:main():

#ifdef __i386__
		/* Glibc is likely to explode now - exit with raw syscall */
		asm volatile ("int $0x80" : : "a" (__NR_exit), "b" (!!ret));
#else /* __x86_64__ */
		syscall(SYS_exit, ret);
#endif

Should vdso_munmap and vdso_mremap be skipped on 32-bit x86 or when
[vdso] is unsealed on __i386__?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793094611.gi=
t.chris@chrisdown.name?part=3D3

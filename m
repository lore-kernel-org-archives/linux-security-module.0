Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344056;
	b=Nv/mrik9pQBvq9ehyWxxqp2eCrG+jyzl8malgsiih5sfRh5sIpR3ytK8b3RubuWQM3Ru
	 Md2i8tXzCoepKcooUvCAXR5SbAm+LwH1FA2vGs3VjpYnP2o7F3DFBexnCWt4tBUAjF2yH
	 ZykM7P4dLyq8v4jKcaXCPdtYEZcLG8IAfyes8q6OgBAl5KFDqBzxCi0D0n4jZJMizX+4S
	 Ui+jlEFLf9ZIX5g+PMW2CKYpuKrvq60F6ZH5SMqmyVly63HwW3kAtHGmK/h+CsjsbY8vq
	 ewCz8z3Iwoyy4ph779o76GrVi5IHFAUsG/I482O8sx56Ov5TN5FgyJS3JQZuF/9pVQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344056;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ir7R4qTqNMsj/4gpca+T8zdlzWQBpAOlDxoPjyoH6M8=;
	b=galM5Zt1UGbvi7YvFbwVU7uxE6DgcW2UJ/bZykCHm5utSLkpE5JMjrHSNylSNWPnbozQ
	 uDBI29RBw0/yCb8Vmmo/BnqZ2/9ejgwR3VHiAZQq2Wl4jVUAk65P8put4WYuide22wwid
	 tiNn8HlGXQmxurR15ToS0FC6UT+TNk4JL0SM36ijX+s6IqKFty65zEMHgQAWmdG9dx43V
	 Ny5auJhhS0MZsu3LVoU4rt1NLi8/0rIIhFx7+IgGv7hlpPwkrgZNrPe0QNhJOH9HRh6HH
	 d/I9v/CN+ze99Xk/EOGICUojMg5qBa7sG63Wm2mo4l4Fz2p1JBWWVnsZK42phXZikww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3gekGPT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8987606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P3gekGPT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DF41F0089F
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344055;
	bh=Ir7R4qTqNMsj/4gpca+T8zdlzWQBpAOlDxoPjyoH6M8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=P3gekGPT3/voRm5Wuphe8pF1FiOaaNW4snmvBZLbHTUo9b3JusGIZ+oLSrIueaUzP
	 fN8+M+BqExdciWhtwtZu8Jin5PorjVDpZXPOhrO1THc5yMUwNFxojd7iypYXGQCVIs
	 5tMtgfj/o08y9QGZkFTuEdpJOq3QYety2S8nEs2EkQwbFvS8CQMnjSZkohUfy9AgIm
	 xnL2qfFDh439ZqbUrNjQS8rLBNQ13MtD+tKMcqa+nCGCUmxJ3Vvzh6PDAIWd9YnXiO
	 anCIduQ8kokgHyROiZhvDW+fhAbf/i8Dh9Vxj5E2LMCoMKRKc/vJf6Yu4AvvomZfCb
	 /IQYFgjCWqlEw==
Message-ID: <sashiko-outbox-207736@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] selftests/landlock: Test capability checks outside
 the capable hook
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261110202436.2408244-6-mic@digikod.net>
References: <20261110202436.2408244-1-mic@digikod.net>
 <20261110202436.2408244-6-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 20:54:14 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] selftests/landlock: unaccounted swap space in
  set_admin_reserve()
- [Low] selftests/landlock: commit message omits CAP_SETPCAP in
  _init_caps()
- [Low] selftests/landlock: MAP_FIXED at NULL fails arch_mmap_check() on
  32-bit ARM
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Medium] selftests/landlock: null pointer dereference in _change_cap()
  [1]
--

commit 1b0a2ef8af3441bc1c12e3659de9a61de2c9490f
Author: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

selftests/landlock: Test capability checks outside the capable hook

This commit adds selftests covering Landlock capability restrictions and
auditing for commoncap checks performed in the mmap_addr, capset, and
vm_enough_memory LSM hooks.

> diff --git a/tools/testing/selftests/landlock/cap_test.c b/tools/testing/=
selftests/landlock/cap_test.c
> index 3d7fd02e21ed9..c79bb42c6282b 100644
> --- a/tools/testing/selftests/landlock/cap_test.c
> +++ b/tools/testing/selftests/landlock/cap_test.c
[ ... ]
> +TEST_F(cap_other_hooks, mmap_min_addr)
> +{
> +	const size_t page_size =3D sysconf(_SC_PAGESIZE);
> +	void *addr;
> +
> +	if (read_sysctl(_metadata, "/proc/sys/vm/mmap_min_addr") =3D=3D 0)
> +		SKIP(return, "vm.mmap_min_addr is 0");
> +
> +	enforce_cap_variant(_metadata, variant, CAP_SYS_RAWIO);
> +
> +	addr =3D mmap(NULL, page_size, PROT_READ,
> +		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
> +	EXPECT_EQ(MAP_FAILED, addr);
> +	EXPECT_EQ(EPERM, errno);
> +
> +	set_cap(_metadata, CAP_SYS_RAWIO);
> +	addr =3D mmap(NULL, page_size, PROT_READ,
> +		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);

[Severity: Low]
Does mapping at NULL with MAP_FIXED fail with EINVAL on 32-bit ARM before
reaching security_mmap_addr()?

In mm/mmap.c:__get_unmapped_area(), arch_mmap_check() runs before
security_mmap_addr().  On 32-bit ARM, FIRST_USER_ADDRESS is 2 * PAGE_SIZE
and arch_mmap_check() rejects MAP_FIXED mappings below FIRST_USER_ADDRESS
with -EINVAL:

arch/arm/include/uapi/asm/mman.h:
#define arch_mmap_check(addr, len, flags) \
	(((flags) & MAP_FIXED && (addr) < FIRST_USER_ADDRESS) ? -EINVAL : 0)

As a result, mmap_min_addr, cap_audit.other_hooks, and
cap_audit.other_hooks_allowed will get EINVAL instead of EPERM or NULL on
32-bit ARM, and cap_audit.other_hooks will not generate the expected
CAP_SYS_RAWIO audit record.

[ ... ]
> +static unsigned long read_committed_kb(struct __test_metadata *const _me=
tadata)
> +{
> +	unsigned long committed =3D 0;
> +	char line[128];
> +	FILE *file;
> +
> +	file =3D fopen("/proc/meminfo", "re");
> +	ASSERT_NE(NULL, file);
> +
> +	while (fgets(line, sizeof(line), file))
> +		if (sscanf(line, "Committed_AS: %lu kB", &committed) =3D=3D 1)
> +			break;
> +
> +	EXPECT_EQ(0, fclose(file));
> +	EXPECT_NE(0, committed);
> +	return committed;
> +}
[ ... ]
> +static void set_admin_reserve(struct __test_metadata *const _metadata,
> +			      FIXTURE_DATA(cap_admin_reserve) *const self)
> +{
> +	set_root_euid(_metadata);
> +	self->is_set =3D true;
> +	ASSERT_EQ(0, write_sysctl(OVERCOMMIT_PATH "admin_reserve_kbytes",
> +				  ADMIN_RESERVE_KB));
> +	ASSERT_EQ(0, write_sysctl(OVERCOMMIT_PATH "overcommit_kbytes",
> +				  self->committed + ADMIN_RESERVE_KB +
> +					  HEADROOM_KB));
> +	ASSERT_EQ(0, write_sysctl(OVERCOMMIT_PATH "overcommit_memory", 2));
> +	restore_euid(_metadata);
> +}
[ ... ]
> +TEST_F(cap_admin_reserve, mmap)
> +{
> +	set_admin_reserve(_metadata, self);
> +
> +	EXPECT_EQ(ENOMEM, test_admin_reserve(variant, false));
> +	EXPECT_EQ(variant->is_allowed ? 0 : ENOMEM,
> +		  test_admin_reserve(variant, true));
> +}

[Severity: Medium]
Does set_admin_reserve() need to account for active swap when computing the
commit limit?

In mm/util.c:vm_commit_limit(), the kernel adds total_swap_pages on top of
sysctl_overcommit_kbytes:

mm/util.c:vm_commit_limit() {
	if (sysctl_overcommit_kbytes)
		allowed =3D sysctl_overcommit_kbytes >> (PAGE_SHIFT - 10);
	else
		allowed =3D ((totalram_pages() - hugetlb_total_pages())
			   * sysctl_overcommit_ratio / 100);
	allowed +=3D total_swap_pages;

	return allowed;
}

When SwapTotal is 96 MiB (MAPPING_KB - HEADROOM_KB) or larger, the
unprivileged commit limit (CommitLimit - admin_reserve_kbytes) still has
room for the 160 MiB mapping, so test_admin_reserve() succeeds and returns 0
instead of ENOMEM.

> diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/se=
lftests/landlock/common.h
> index e29406900c04a..a6fdfb422fad5 100644
> --- a/tools/testing/selftests/landlock/common.h
> +++ b/tools/testing/selftests/landlock/common.h
> @@ -36,7 +36,7 @@ static const char bin_wait_pipe_sandbox[] =3D "./wait-p=
ipe-sandbox";
>  static void _init_caps(struct __test_metadata *const _metadata, bool dro=
p_all)
>  {
>  	cap_t cap_p;
> -	/* Only these three capabilities are useful for the tests. */
> +	/* Only these capabilities are useful for the tests. */
>  	const cap_value_t caps[] =3D {
>  		/* clang-format off */
>  		CAP_AUDIT_CONTROL,
> @@ -44,9 +44,11 @@ static void _init_caps(struct __test_metadata *const _=
metadata, bool drop_all)
>  		CAP_MKNOD,
>  		CAP_NET_ADMIN,
>  		CAP_NET_BIND_SERVICE,
> +		CAP_SETPCAP,
>  		CAP_SETUID,
>  		CAP_SYS_ADMIN,
>  		CAP_SYS_CHROOT,
> +		CAP_SYS_RAWIO,
>  		/* clang-format on */
>  	};
>  	const unsigned int noroot =3D SECBIT_NOROOT | SECBIT_NOROOT_LOCKED;

[Severity: Low]
This isn't a bug, but the commit message says "Add CAP_SYS_RAWIO to the
capabilities that the tests may raise" while _init_caps() adds both
CAP_SETPCAP and CAP_SYS_RAWIO.

[Severity: Medium]
This problem wasn't introduced by this patch, but _init_caps() and
_change_cap() [1] check the return value of cap_get_proc() with
EXPECT_NE(NULL, cap_p) instead of ASSERT_NE(NULL, cap_p):

tools/testing/selftests/landlock/common.h:_change_cap() {
	cap_t cap_p;

	cap_p =3D cap_get_proc();
	EXPECT_NE(NULL, cap_p);
	EXPECT_NE(-1, cap_set_flag(cap_p, flag, 1, &cap, value));
	...
}

Because EXPECT_NE() does not abort the test on failure, a NULL return from
cap_get_proc() is passed directly to cap_clear() or cap_set_flag(), causing
a NULL pointer dereference.

[1] https://sashiko.dev/#/bug/linux-78e86289-9899-4c8f-a69a-109bbe06ac40

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110202436.2408=
244-1-mic@digikod.net?part=3D5

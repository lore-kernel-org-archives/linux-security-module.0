Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931923;
	b=1LC7sRvvcqEFVDsrhYUctK1ZiJITKphPm8e6Z9eb+WzOhsc2bwBdtZqov25meMc5NM70
	 MdfkRhnPkP5juIN2LG6AtLrN3kgvZt7ZqMGpdqsQgzeL8e5EiES8vy8zRmCwBpsa3GihW
	 WuKBWwQyoM9ruJRDpxTk8FiSF71NcLk33Dz0i0O+Bg/dV/G9MrcXOKIiG8+TC6LjNTnVx
	 r+2xZTGvYZ4U0xzmVxZrIxJi0SLuv7rov57lT7liOvWCRSpJAVApFRfnzFUnvuynsfdam
	 IThlmL9D20HMaFokFaHORz61Y1wjC6Rac4jLSAjesSqsA8zQ5d6J/3Tl3OiIMEYsGIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=AR9qjPZmViz4RKGjDQMrMtWcGuUXna8ndXGW/ywC0RU=;
	b=lcmxxRq8+DaafKhOfU7qPEe8WLjeIkeK6J7te4ZCbhMOttYoxXbKQrlqFTmRo/GMftw5
	 nOzjSRm3pSoK4VP7NuRTWMFPEKHcXAM/MMqR0/BM/KSkVEFDs9K4hAzc5JlN3vEevhaxC
	 4EEB7NeY9CRqMRRDI1zxF9CTRYIHxDGssYrb6ogJcQXWZYMmKP47a5QHJZcmtKmZrMLy3
	 p2doD1+PVayZWx7q3PiNBMsFIqOAC2u4xnVVhLpRhWpxtpkbuwzL8O2p9iKjGiySss1qs
	 3nVMrmR6/mIedo4W3d8oFeefpA0sdsCXOkg7jMKZ4ltYALVP2846lLfBoBrn4xGI1fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dUuEXbVf;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EE8606A334
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 16:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5EE8606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dUuEXbVf
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso456405e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 08:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794931921; x=1795536721; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AR9qjPZmViz4RKGjDQMrMtWcGuUXna8ndXGW/ywC0RU=;
        b=dUuEXbVfcjADo9hFHUN1OJ9JszaiJ83so+r/p9FZnUM+reMaWQetMBO5sONyBfzqjw
         YZ7NRIzt0+r5GAYGXgVjbddHhcPdNLGYwJID6Onj8RwskCQdsFNTkRjnesG4fWnoYN2/
         xbeStgTmGFt6xM4ZBeGMRJfvpWH1YwDWgabfFHAVuyGbCrIMJqOobT1urzBNWRha2BgI
         na4pE5oG7pwqGyFogUvWvFpub145dYVdOckeTJcVtOUmd7PBJRkD+a0PDYHK3tHdRuks
         9vRbYbNWBhMXxCw1UO1/jPGtI7zTEZbLsJ87OPbrJbLGVVcSR8cuZjuzK9UFyUyEpe+5
         Gysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794931921; x=1795536721;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AR9qjPZmViz4RKGjDQMrMtWcGuUXna8ndXGW/ywC0RU=;
        b=26yLp6o2aDQ2nSgBJRvk9Jby0v58us3hhlWl1vsdyLk5fhVUj9XfSXKuuIfZgab8ew
         2Nhk0LdfE9HJwGtzkrcMLQlZbTQ0FEAzbEByOo3DLdg1B3I5c7aQDNCJsVXrQ9/JSAPO
         PfTHKFCjWczG/Tlap4Wp/Bot+fzEfqlvNhLK4j0/VU0z/OwG0B3CAc7CeL+y2QMo2Oqw
         qj5zkrC7Vyt53WC4YBM//mxVxnoetCl2gryzVQaoNEIcTz28/dcNXxAD41e/3jqsx7Kz
         0UC302atld3wJvOE0s1O9m85vTRwKuH0bzDqGa35HsJH+C/RBYlsL1cMEc/Wx2Kz7K6j
         PtwQ==
X-Forwarded-Encrypted: i=1; AL+hErHRziH/0Ld3UVTsECnqT2cZuIm1dL0IXQxKXueEq24LBOsAFm6VJ0RCdXiDXT1IT1Jq+Axa/6OxT2yHJzf2H7SIBgLEkDE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/c1ND4ra7wtRQkoSMFY6dCckBr0SojR0yczeh7c+fpnTfht0Qa
	edm6Lmi+oVuOYzsHQVa3Tengw3BRTdBrpU4oufcpnozUGFGzjKR0V4Gee5VezNXoHg==
X-Gm-Gg: AYBFou1DlOKInK/r3hCPPxxM+sqgixxarexNX1b18q0USjQY3tnl/qAOransTZWVCUa
	iVExwIdqpZkSXQjGNT/NaP1G1R+h72ygapZJ0qgQ4YL811W0H56X+f+adT17GkZyvdaA5EkAURS
	XfdpBgbotlr7Yw6gLGwLmXL7mZA5QOm53yaZ+UldC3XzfRgO8qUhiw9iCeZr58XL7JP4PJ0xqJM
	1+36bLU4DLrVJXDs0BGDQnmFaMA112NckdgCpBE6KgGBdSfKhxNYKTUZ2MbvcEgzFS/hy+fACQk
	eGBqRZWatS0VnAyHeqcw/UCTMjk7PVa+KUF+XJ6+IdqbOUY6A16NK6IMJNDDYeYA/QV+hZlM8l3
	403BGpf3UQizCvcJFKIOiApcFRboCxQIWue6//Pdn2vOjK9rJy9dVYD23+RXMPaMKcCN6nM7GOG
	1weKxZ+G+aXOC/bI4jtLHlTDO1NShXK7szsi++bBL2sM6nbpxs6XbOvn15d0H8MMxOy+cnf7qGE
	zdtIdjQ9iZovoSJxEZ2AnRvIC2vf8tRqWVMlACSlkzHuoLK7hsmI7lqPYvm9qDUP5hOo7qfp0Oi
	jkLzvlRB2/vdCdZTwjTdXBFnKJSn425Wgf+l4lEuSAwV0+G1kl8oBHS0WZtUMg==
X-Received: by 2002:a05:600c:154a:b0:4bb:73d5:ab33 with SMTP id 5b1f17b1804b1-4bb73d5b0admr124737365e9.22.1794931920368;
        Tue, 17 Nov 2026 08:12:00 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:12e4:4602:d8d8:3043])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783853b5sm78035005e9.2.2026.11.17.08.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 08:11:59 -0800 (PST)
Date: Tue, 17 Nov 2026 17:11:54 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Ada Smith <adasmithgt@gmail.com>, Hungyu Lin <dennylin0707@gmail.com>,
	James Morris <jmorris@namei.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>,
	Serge Hallyn <sergeh@kernel.org>, kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 5/6] selftests/landlock: Test capability checks
 outside the capable hook
Message-ID: <avx8yncGLuzDFVEa@google.com>
References: <20261117101157.2520463-1-mic@digikod.net>
 <20261117101157.2520463-6-mic@digikod.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261117101157.2520463-6-mic@digikod.net>

On Tue, Nov 17, 2026 at 11:11:55AM +0100, Mickaël Salaün wrote:
> Test the capability checks that commoncap makes from LSM hooks other
> than capable and that the previous commits make Landlock restrict:
> mapping below vm.mmap_min_addr (CAP_SYS_RAWIO) and adding inheritable
> capabilities outside of the permitted set (CAP_SETPCAP).
> 
> Each test first checks that the operation fails without the capability,
> so that it exercises the capability check, and then checks it with the
> capability effective in four variants: unsandboxed, in a domain that
> denies the capability, in a domain that allows it, and in a domain that
> does not handle capabilities.  The mmap_addr tests map the last page
> below vm.mmap_min_addr, and skip if the architecture rejects it before
> the mmap_addr hook (e.g. 32-bit ARM).
> 
> Audit tests check that these denials are logged, that the admin reserve
> check is not, and that allowed uses log nothing.  The admin reserve
> check has no functional test: it only has an effect with
> vm.overcommit_memory=2, a system-wide setting that a test cannot change
> without racing with other processes.
> 
> Add CAP_SETPCAP and CAP_SYS_RAWIO to the capabilities that the tests may
> raise, and drop the stale count from the comment of this list.
> 
> Without the mmap_addr and capset fixes, their denied variants and the
> denial audit test fail.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since v1:
> https://patch.msgid.link/20261110202436.2408244-6-mic@digikod.net
> - Replace the admin reserve test, which changed system-wide overcommit
>   settings and was racy (e.g. with swap, as reported by Sashiko), with a
>   comment.
> - Map the last page below vm.mmap_min_addr instead of page 0, and skip
>   when the architecture rejects it, e.g. on 32-bit ARM (reported by
>   Sashiko).
> - Mention CAP_SETPCAP in the commit message (reported by Sashiko).
> - Add Serge Hallyn's Acked-by.
> ---
>  tools/testing/selftests/landlock/cap_test.c | 336 ++++++++++++++++++++
>  tools/testing/selftests/landlock/common.h   |   4 +-
>  2 files changed, 339 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/landlock/cap_test.c b/tools/testing/selftests/landlock/cap_test.c
> index 3d7fd02e21ed..39ef57a49dc9 100644
> --- a/tools/testing/selftests/landlock/cap_test.c
> +++ b/tools/testing/selftests/landlock/cap_test.c
> @@ -12,7 +12,9 @@
>  #include <linux/landlock.h>
>  #include <sched.h>
>  #include <stdio.h>
> +#include <stdlib.h>
>  #include <string.h>
> +#include <sys/mman.h>
>  #include <sys/mount.h>
>  #include <sys/wait.h>
>  #include <sys/xattr.h>
> @@ -738,6 +740,251 @@ TEST(cap_target_userns_independent)
>  	EXPECT_EQ(0, close(target_userns_fd));
>  }
>  
> +/*
> + * Capability checks that commoncap makes from hooks other than the capable
> + * hook.  Each test first checks that the operation needs the capability, then
> + * checks it with the capability effective.  Variants cover an unsandboxed
> + * baseline, a domain that denies the capability, a domain that allows it, and a
> + * domain that does not handle capabilities.
> + */
> +/* clang-format off */
> +FIXTURE(cap_other_hooks) {};
> +/* clang-format on */
> +
> +FIXTURE_VARIANT(cap_other_hooks)
> +{
> +	const bool is_sandboxed;
> +	const bool handle_caps;
> +	const bool is_allowed;
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(cap_other_hooks, unsandboxed) {
> +	.is_sandboxed = false,
> +	.handle_caps = false,
> +	.is_allowed = true,
> +};
> +/* clang-format on */
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(cap_other_hooks, denied) {
> +	.is_sandboxed = true,
> +	.handle_caps = true,
> +	.is_allowed = false,
> +};
> +/* clang-format on */
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(cap_other_hooks, allowed) {
> +	.is_sandboxed = true,
> +	.handle_caps = true,
> +	.is_allowed = true,
> +};
> +/* clang-format on */
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(cap_other_hooks, unhandled) {
> +	.is_sandboxed = true,
> +	.handle_caps = false,
> +	.is_allowed = true,
> +};
> +/* clang-format on */
> +
> +FIXTURE_SETUP(cap_other_hooks)
> +{
> +	disable_caps(_metadata);
> +}
> +
> +FIXTURE_TEARDOWN(cap_other_hooks)
> +{
> +}
> +
> +/*
> + * Creates a ruleset that handles capabilities and allows @cap if @is_allowed,
> + * or, if !@handle_caps, a ruleset that only handles a filesystem access right.
> + * Returns the ruleset FD, or -1 with errno set.
> + */
> +static int create_variant_ruleset(const bool handle_caps, const bool is_allowed,
> +				  const int cap)

Nit: Maybe rename "is_allowed" to "allow_caps", so that it's a bit
clearer that this only makes sense in the case where caps are also
handled.  Or maybe just guard it on "cap" being non-zero, and rename
that appropriately?

> +{
> +	const struct landlock_ruleset_attr fs_attr = {
> +		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
> +	};
> +	int ruleset_fd, err;
> +
> +	if (!handle_caps)
> +		return landlock_create_ruleset(&fs_attr, sizeof(fs_attr), 0);
> +
> +	ruleset_fd = create_cap_ruleset();
> +	if (ruleset_fd < 0 || !is_allowed)
> +		return ruleset_fd;
> +
> +	if (add_cap_rule(ruleset_fd, cap)) {
> +		err = errno;
> +		close(ruleset_fd);
> +		errno = err;
> +		return -1;
> +	}
> +	return ruleset_fd;
> +}
> +
> +static void
> +enforce_cap_variant(struct __test_metadata *const _metadata,
> +		    const FIXTURE_VARIANT(cap_other_hooks) *const variant,
> +		    const int cap)
> +{
> +	int ruleset_fd;
> +
> +	if (!variant->is_sandboxed)
> +		return;
> +
> +	ruleset_fd = create_variant_ruleset(variant->handle_caps,
> +					    variant->is_allowed, cap);
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	EXPECT_EQ(0, close(ruleset_fd));
> +}
> +
> +static unsigned long read_sysctl(struct __test_metadata *const _metadata,
> +				 const char *const path)
> +{
> +	char buf[32];
> +	ssize_t len;
> +	int fd;
> +
> +	fd = open(path, O_RDONLY | O_CLOEXEC);
> +	ASSERT_LE(0, fd)
> +	{
> +		TH_LOG("Failed to open %s: %s", path, strerror(errno));
> +	}
> +	len = read(fd, buf, sizeof(buf) - 1);
> +	ASSERT_LT(0, len);
> +	EXPECT_EQ(0, close(fd));
> +
> +	buf[len] = '\0';
> +	return strtoul(buf, NULL, 10);
> +}
> +
> +/*
> + * Returns the last page below the vm.mmap_min_addr sysctl, or MAP_FAILED if
> + * there is none or if the architecture rejects it before the mmap_addr hook
> + * (e.g. below FIRST_USER_ADDRESS on 32-bit ARM).  The caller must not have
> + * CAP_SYS_RAWIO in its effective set.
> + */
> +static void *get_low_page(struct __test_metadata *const _metadata)
> +{
> +	const size_t page_size = sysconf(_SC_PAGESIZE);
> +	unsigned long min_addr;
> +	void *addr, *ret;
> +
> +	min_addr = read_sysctl(_metadata, "/proc/sys/vm/mmap_min_addr");
> +	if (!min_addr)
> +		return MAP_FAILED;
> +
> +	addr = (void *)((min_addr - 1) & ~(page_size - 1));
> +	ret = mmap(addr, page_size, PROT_READ,
> +		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
> +	ASSERT_EQ(MAP_FAILED, ret);
> +	if (errno == EINVAL)
> +		return MAP_FAILED;
> +
> +	ASSERT_EQ(EPERM, errno);
> +	return addr;
> +}
> +
> +/*
> + * cap_mmap_addr() requires CAP_SYS_RAWIO to map below the vm.mmap_min_addr
> + * sysctl (dac_mmap_min_addr).
> + */
> +TEST_F(cap_other_hooks, mmap_min_addr)
> +{
> +	const size_t page_size = sysconf(_SC_PAGESIZE);
> +	void *low_page, *addr;
> +
> +	low_page = get_low_page(_metadata);
> +	if (low_page == MAP_FAILED)
> +		SKIP(return, "Cannot map below vm.mmap_min_addr");
> +
> +	enforce_cap_variant(_metadata, variant, CAP_SYS_RAWIO);
> +
> +	addr = mmap(low_page, page_size, PROT_READ,
> +		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
> +	EXPECT_EQ(MAP_FAILED, addr);
> +	EXPECT_EQ(EPERM, errno);
> +
> +	set_cap(_metadata, CAP_SYS_RAWIO);
> +	addr = mmap(low_page, page_size, PROT_READ,
> +		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
> +	if (variant->is_allowed) {
> +		EXPECT_EQ(low_page, addr)
> +		{
> +			TH_LOG("Failed to map below vm.mmap_min_addr: %s",
> +			       strerror(errno));
> +		}
> +		if (addr != MAP_FAILED)
> +			EXPECT_EQ(0, munmap(addr, page_size));

If you used ASSERT(low_page, addr) above, you would not need to check
for MAP_FAILED here.

I get the feeling that you are using EXPECT because you want to do the
munmap call?  Is that strictly necessary?  I believe that the tests
are running in a fork, so if they mess up their memory mapping, it
wouldn't be problematic?  (We already have many other cleanups that
don't get done properly if an ASSERT fails, e.g. FD closing)


> +	} else {
> +		EXPECT_EQ(MAP_FAILED, addr);
> +		EXPECT_EQ(EPERM, errno);

Same here.

errno is undefined unless the mmap failed, so the line checking for
MAP_FAILED should use ASSERT_EQ IMHO.

Compare my selftest cleanup commit for that at:
https://lore.kernel.org/all/20261104-selftests-refactor-v2-24-c52f23f7ce33@gmail.com/

> +		if (addr != MAP_FAILED)
> +			munmap(addr, page_size);
> +	}
> +	clear_cap(_metadata, CAP_SYS_RAWIO);
> +}
> +
> +static int add_inheritable_cap(const cap_value_t cap)
> +{
> +	cap_t cap_p;
> +	int ret, err;
> +
> +	cap_p = cap_get_proc();
> +	if (!cap_p)
> +		return -1;
> +
> +	ret = cap_set_flag(cap_p, CAP_INHERITABLE, 1, &cap, CAP_SET);
> +	if (!ret)
> +		ret = cap_set_proc(cap_p);
> +	err = errno;
> +	cap_free(cap_p);
> +	errno = err;
> +	return ret;
> +}
> +
> +/*
> + * cap_capset() requires CAP_SETPCAP to add an inheritable capability that is
> + * not in the permitted set.  CAP_NET_RAW is in the bounding set, but
> + * disable_caps() does not put it in the permitted set.
> + */
> +TEST_F(cap_other_hooks, capset_inheritable)
> +{
> +	enforce_cap_variant(_metadata, variant, CAP_SETPCAP);
> +
> +	EXPECT_EQ(-1, add_inheritable_cap(CAP_NET_RAW));
> +	EXPECT_EQ(EPERM, errno);

Ditto about errno checking and ASSERT.

> +
> +	set_cap(_metadata, CAP_SETPCAP);
> +	if (variant->is_allowed) {
> +		EXPECT_EQ(0, add_inheritable_cap(CAP_NET_RAW))
> +		{
> +			TH_LOG("Failed to raise CAP_NET_RAW: %s",
> +			       strerror(errno));
> +		}
> +	} else {
> +		EXPECT_EQ(-1, add_inheritable_cap(CAP_NET_RAW));
> +		EXPECT_EQ(EPERM, errno);

Also here (errno checking and ASSERT).  I'll refrain from commenting
on these further below to not spam you, but there are more instances
of it below.


> +	}
> +	clear_cap(_metadata, CAP_SETPCAP);
> +}
> +
> +/*
> + * cap_vm_enough_memory() lets CAP_SYS_ADMIN use the vm.admin_reserve_kbytes
> + * reserve, but only with vm.overcommit_memory=2.  The Landlock check of this
> + * reserve has no functional test: it would have to change these system-wide
> + * settings and set a tight commit limit, which could make allocations of other
> + * processes fail and would race with them.  cap_audit.other_hooks checks that
> + * this check is not logged.
> + */
> +
>  /* Audit tests */
>  
>  static int matches_log_cap(int audit_fd, int cap_number)
> @@ -828,6 +1075,95 @@ TEST_F(cap_audit, denied)
>  	EXPECT_EQ(0, records.domain);
>  }
>  
> +/*
> + * Denials in the capset and mmap_addr paths are audited like capable hook
> + * denials.  The vm_enough_memory hook only withholds the admin reserve, with
> + * CAP_OPT_NOAUDIT, so an accounted mapping made with CAP_SYS_ADMIN effective
> + * leaves no record.
> + */
> +TEST_F(cap_audit, other_hooks)
> +{
> +	const size_t page_size = sysconf(_SC_PAGESIZE);
> +	struct audit_records records = {};
> +	void *low_page, *addr;
> +	int ruleset_fd;
> +	__u64 domain_id;
> +
> +	low_page = get_low_page(_metadata);
> +	ruleset_fd = create_cap_ruleset();
> +	ASSERT_LE(0, ruleset_fd);
> +	/* Allow CAP_AUDIT_CONTROL for child-side audit cleanup. */
> +	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_AUDIT_CONTROL));
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	EXPECT_EQ(0, close(ruleset_fd));
> +
> +	set_cap(_metadata, CAP_SETPCAP);
> +	EXPECT_EQ(-1, add_inheritable_cap(CAP_NET_RAW));
> +	EXPECT_EQ(EPERM, errno);
> +	clear_cap(_metadata, CAP_SETPCAP);
> +	EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_SETPCAP));
> +	EXPECT_EQ(0, matches_log_domain_allocated(self->audit_fd, getpid(),
> +						  &domain_id));
> +
> +	if (low_page != MAP_FAILED) {
> +		set_cap(_metadata, CAP_SYS_RAWIO);
> +		addr = mmap(low_page, page_size, PROT_READ,
> +			    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
> +		EXPECT_EQ(MAP_FAILED, addr);
> +		EXPECT_EQ(EPERM, errno);
> +		clear_cap(_metadata, CAP_SYS_RAWIO);
> +		EXPECT_EQ(0, matches_log_cap(self->audit_fd, CAP_SYS_RAWIO));
> +	}
> +
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	addr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
> +		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	EXPECT_NE(MAP_FAILED, addr);
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +	if (addr != MAP_FAILED)
> +		EXPECT_EQ(0, munmap(addr, page_size));
> +
> +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +	EXPECT_EQ(0, records.access);
> +	EXPECT_EQ(0, records.domain);

Similar problem: "records" is undefined if audit_count_records fails,
so audit_count_records should use ASSERT.  See
https://lore.kernel.org/all/20261104-selftests-refactor-v2-12-c52f23f7ce33@gmail.com/
which fixes this across all existing tests.


> +}
> +
> +/* Allowed capability uses in the capset and mmap_addr paths. */
> +TEST_F(cap_audit, other_hooks_allowed)
> +{
> +	const size_t page_size = sysconf(_SC_PAGESIZE);
> +	struct audit_records records = {};
> +	void *low_page, *addr;
> +	int ruleset_fd;
> +
> +	low_page = get_low_page(_metadata);
> +	ruleset_fd = create_cap_ruleset();
> +	ASSERT_LE(0, ruleset_fd);
> +	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_SETPCAP));
> +	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_SYS_RAWIO));
> +	/* Allow CAP_AUDIT_CONTROL for child-side audit cleanup. */
> +	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_AUDIT_CONTROL));
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	EXPECT_EQ(0, close(ruleset_fd));
> +
> +	set_cap(_metadata, CAP_SETPCAP);
> +	EXPECT_EQ(0, add_inheritable_cap(CAP_NET_RAW));
> +	clear_cap(_metadata, CAP_SETPCAP);
> +
> +	if (low_page != MAP_FAILED) {
> +		set_cap(_metadata, CAP_SYS_RAWIO);
> +		addr = mmap(low_page, page_size, PROT_READ,
> +			    MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
> +		EXPECT_EQ(low_page, addr);
> +		clear_cap(_metadata, CAP_SYS_RAWIO);
> +		if (addr != MAP_FAILED)
> +			EXPECT_EQ(0, munmap(addr, page_size));
> +	}
> +
> +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +	EXPECT_EQ(0, records.access);

Here as well.

> +}
> +
>  TEST_F(cap_audit, allowed)
>  {
>  	struct audit_records records = {};
> diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
> index e29406900c04..a6fdfb422fad 100644
> --- a/tools/testing/selftests/landlock/common.h
> +++ b/tools/testing/selftests/landlock/common.h
> @@ -36,7 +36,7 @@ static const char bin_wait_pipe_sandbox[] = "./wait-pipe-sandbox";
>  static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
>  {
>  	cap_t cap_p;
> -	/* Only these three capabilities are useful for the tests. */
> +	/* Only these capabilities are useful for the tests. */
>  	const cap_value_t caps[] = {
>  		/* clang-format off */
>  		CAP_AUDIT_CONTROL,
> @@ -44,9 +44,11 @@ static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
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
>  	const unsigned int noroot = SECBIT_NOROOT | SECBIT_NOROOT_LOCKED;
> -- 
> 2.56.0
> 

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113403;
	b=W5bhRou2dBBwOtLPY+1cZYJ9NoO3zjA7rCeoN4sbY+tK0hvtU5VLwciFqjB4az+38+v6
	 jRa6qUMy4mIieg676Kp9A6ndIe22Z4pe45+APCJ0x4y7ji4iguP1VhFHUE7MFPMJqJdBx
	 /LcFOdtiUm+XDU1gs1QmIPN9ki4iXdI57KAsmav3Pfpa4ZARvdlFM2EB9mq1sj7myYSK2
	 qFR4v3Vq7gUilY072bj9eAGxENQu43Q1AE6l5wJYt4jj+KzIK61klprt0i7sf11/qsvmz
	 7mN6jmOijl/ByKVtWZ+1q8oFyWHeJXgkNms56CdJCwIdcViV6FleiVGnRA5FeaIj/og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113403;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ej+2A3eI9QkEIZfLtqDhWXflwH2CM30fmNauKQbThvQ=;
	b=Nitr5gs2zgRMo3Rtnvmq9AfMGjVJyjvLYGniEEOl+m1xeFPXEbtGj74pAcWg/kcd5iTH
	 MwhkcPVzd6/0v1fBKQunNCkS0I2z/VMQqilAfCvF3QkxxXbb2aOrU1pQ1MmFVIURhyJPe
	 YHFhhKnXWueYSlKNBpdqjsLAvFd3lO9FDPECxc7ngCV4ZPm5LnPIOYlU+vnfpp+Ycs9gI
	 qddx8SiJlibZcH/MLaXHKMRAD3htiYuOB01y7ZIEM9cQoe7E2D8eHsD2PnE+RWcNzHgb0
	 7oU14stW+gaxKoWx5Bss22tDnRuN4S/OzwDnxsbyUdBeWyehWlYNn3a2myEUKP/YVhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UDNs964I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB57606A331;
	Tue, 27 Oct 2026 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UDNs964I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C821F01825;
	Tue, 27 Oct 2026 15:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793113402;
	bh=Ej+2A3eI9QkEIZfLtqDhWXflwH2CM30fmNauKQbThvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UDNs964InGfq4NmI+D4H6JmyaobQzLcTE30PJnJfMZlFIzKGbmtuUhzYbnv4oRI03
	 VtpFNEVHvFDphOPyprGts94mgXV3YKbbfMzBt5UE4j0DuIbo+XZcM/sYbZABAeM9nX
	 PR7nZzincxdDnTTwSoKjwqS3sL/IG3CA4TZyjMinPsPDEaXVLodjBH6pebQSwjp4mG
	 URJZOf58cy9cO5ywnL3QN5ZDD6CRtry0RVGi56D9KwDs8QCDPchdurnI2XD85ae82T
	 MX9mYDi62989dPYaLLEgz406J1oq0MULkELtpW67Q24Zk1p2wPrRbHs5ddhSJQBJn0
	 snLgtX2hBsVjQ==
Date: Tue, 27 Oct 2026 15:03:13 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	Andrey Vagin <avagin@gmail.com>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 3/3] selftests/mseal_system_mappings: Test vdso unmap and
 remap
Message-ID: <auC7_5XYr31fimvL@gremlin>
References: <cover.1793094611.git.chris@chrisdown.name>
 <621847973ba2ec49d0a58e0261da35a9f3a97eda.1793094611.git.chris@chrisdown.name>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <621847973ba2ec49d0a58e0261da35a9f3a97eda.1793094611.git.chris@chrisdown.name>

Sorry, in mm we require commit messages. Even for tests :)

On Tue, Oct 27, 2026 at 07:43:25PM +0800, Chris Down wrote:
> Signed-off-by: Chris Down <chris@chrisdown.name>
> ---
>  .../mseal_system_mappings/sysmap_is_sealed.c  | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>
> diff --git a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
> index ea75ad537620..83b4fadfbfe7 100644
> --- a/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c
> +++ b/tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c

Why on earth does 'mseal_system_mappings' have its own directory...??

Ugh I don't know how I let this stuff go on the original series :/

Please, for the love of all that's sacred, move these tests over to
tools/selftests/mm/. This is an mm feature, for our sins...

You can do the move as a prerequisite patch in the series.

(And, again, I really do insist on your change doing some cleanup here as
 well rather than extending this stuff.)

> @@ -10,6 +10,7 @@
>  #include <unistd.h>
>  #include <string.h>
>  #include <stdbool.h>
> +#include <sys/mman.h>
>  #include <sys/utsname.h>
>  #include <zlib.h>
>
> @@ -232,4 +233,95 @@ TEST_F(basic, check_sealed)
>  	EXPECT_EQ(expected, sealed);
>  };
>
> +static bool find_vdso(unsigned long *start, unsigned long *end)
> +{
> +	char line[MAX_LINE_LEN];
> +	bool found = false;
> +	FILE *maps;
> +
> +	maps = fopen("/proc/self/maps", "r");
> +	if (!maps)
> +		return false;
> +
> +	while (fgets(line, sizeof(line), maps)) {
> +		if (strstr(line, "[vdso]") &&
> +		    sscanf(line, "%lx-%lx", start, end) == 2) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	fclose(maps);
> +	return found;
> +}

There's shared code for this kind of thing, please don't duplicate a
/proc/self/maps thing if unnecessary. Also there's a nicer ioctl interface for
all this.

See vm_utils.[ch].

> +
> +static int vdso_is_sealed(void)
> +{
> +	int sealed = -1;
> +	FILE *maps;
> +
> +	maps = fopen("/proc/self/smaps", "r");
> +	if (!maps)
> +		return -1;
> +	if (has_mapping("[vdso]", maps))
> +		sealed = mapping_is_sealed(maps);
> +	fclose(maps);
> +	return sealed;
> +}
> +
> +/*
> + * Unmapping or moving [vdso] must fail with EPERM when it is sealed. When it
> + * is not sealed, it succeeds and leaves glibc with a stale vdso pointer, which
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
> +	sealed = vdso_is_sealed();
> +	if (sealed < 0)
> +		SKIP(return, "could not read the [vdso] sealing state");
> +
> +	ret = munmap((void *)start, end - start);
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
> +	sealed = vdso_is_sealed();
> +	if (sealed < 0)
> +		SKIP(return, "could not read the [vdso] sealing state");
> +	size = end - start;
> +
> +	dst = mmap(NULL, size, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	ASSERT_NE(MAP_FAILED, dst);
> +
> +	ret = mremap((void *)start, size, size, MREMAP_MAYMOVE | MREMAP_FIXED,
> +		     dst);

I mean arguably this is an mremap test that belongs with mremap? I guess
debatable...

> +	if (sealed) {
> +		EXPECT_EQ(MAP_FAILED, ret);
> +		EXPECT_EQ(EPERM, errno);
> +	} else {
> +		EXPECT_EQ(dst, ret);
> +	}
> +	ASSERT_TRUE(find_vdso(&new_start, &end));
> +	EXPECT_EQ(sealed ? start : (unsigned long)dst, new_start);
> +}
> +
>  TEST_HARNESS_MAIN
> --
> 2.54.0
>

This all just seems like work that should have been done in the past when this
feature was proposed, and doesn't depend on your changes at all AFAICT? Maybe I
missed it though.

Valuable in itself, but probably worth sending separately as a result? Otherwise
it's a little disconnected from the actual change you're making.

--
Cheers, Lorenzo

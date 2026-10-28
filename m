Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180958;
	b=qVM0uMc/NlL/+ZssaklczzXIerG5hPCuY95jYiLgEVx8wREZynT9MwCT7QcLe7NT0ASq
	 HyzEMkUApHi7QBnsOSxmybw3mXQmc7xHkYW1E2+xez8282ysOUJEcuFHN4/gJT9RrJwX9
	 ORhnrQTihZmpnbB1n+SDYcM/Jc5T4NjsqWXmuMIfErEmRh7UL4v2npJemnGsvC7xBsHoj
	 0tQYSm7qDLJYfeMITuwkcTvT3j9yx1aceUtoJ9NrM73Lic7RwiMrh7IlpldYNhG/vnTd1
	 FYY80ZHTULZ3nBzOFhhuvzjmVmPF6vcIfSsniGqnfDlVkHJVbLpqQy5pjofWIMrJRvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180958;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=j99P5QWiCp9mK5Hf0fpTUVyqcAtcoB4QyeGqeo1OT2s=;
	b=XpBTqsPWSCLgbBxro/j9rVb7d2euKlI4ilxfFPr8S2Yqj/yS8OOWE56paLCMFaG9gp5a
	 GuhfpW0+n8MXqWkF1aHxkOtzY4k2jN8KEw4vg+pl2uhjwTmEZHVvM3LHAZEyeI+u6tXSC
	 DMRJCgHul1Dlzc1qrXvD+zfkE8/JQOqOIo9Ga2U4bqO64R4utYKf1PGqtwkWyHYKT+4Hl
	 7DB3MKBB55SaV5hPvXzp46wUrl6T7lRH80MIfWmP7uHwe7xDp+uoJbezvuNZHGQlyls87
	 iIF99LtUT1VL/Yll2cnVuDJ4/4RIVCI8kaa94yiqY+jKBbh5Nmhhase/DafK/suuxDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a/rb5U1K";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EF0606A31A;
	Wed, 28 Oct 2026 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a/rb5U1K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18371F01825;
	Wed, 28 Oct 2026 09:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793180958;
	bh=j99P5QWiCp9mK5Hf0fpTUVyqcAtcoB4QyeGqeo1OT2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a/rb5U1K0Gj9rgjjeNICrvcAIx0kQwZx3+rm6ZZYnaEKZaXecdZyKs1e4wZMaPTu8
	 kOyQlOjw53t+7mEwMLLtfU1AlSR6yN0WdsKoO9r0X5U3l8Ol6z/Gl8gJE6rHxaSGc4
	 IPU0auxW+r8/9eUEM6X0OeMwkvjfzdoPhcezmbEfKT56H43y/MLYJBq2lhDAcQ3ilA
	 uhC6NbxVzMhVPsFoY2a92GIuPsayNwHxTd9YAqhxVL6ZEd0tyciCqjEvenCRFpdUqI
	 HUwCq7TjVx920vPdi7+q1VvFF+pV3u57U/9WO5STKbe+D/NfQHN2FAJZ9F2UB3aP4R
	 +vL89dEkpf+ag==
Date: Wed, 28 Oct 2026 09:49:10 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Jeff Xu <jeffxu@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	Andrey Vagin <avagin@gmail.com>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/3] mseal sysmap: Add mseal_system_mappings= boot
 parameter
Message-ID: <auG8bgpy-m5JUYWp@gremlin>
References: <cover.1793094611.git.chris@chrisdown.name>
 <5bd3c89d733ad22224f296dfa8900769de937de0.1793094611.git.chris@chrisdown.name>
 <auCxjbvY3qPv1sV6@gremlin>
 <auDTMb6WMFUpxeZy@chrisdown.name>
 <auDTptDQsB4xBcz7@gremlin>
 <18e2972cb8520c2e.3137322e32382e342e3434.279dd1.0000sendgmr@google.com>
 <auGNkhSHpBRd2U_5@chrisdown.name>
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
In-Reply-To: <auGNkhSHpBRd2U_5@chrisdown.name>

On Wed, Oct 28, 2026 at 01:52:18PM +0800, Chris Down wrote:
> Hi Jeff,
>
> Thanks for the review!
>
> Jeff Xu writes:
> > Could we please keep the test coverage for the unsealed [vdso] case and
> > avoid unconditionally skipping whenever [vdso] is unsealed?
> >
> > There are two regressions I'd love for us to still be able to catch:
> >
> > 1. Kernel or config regressions when sealing is expected to be on:
>
> Yeah agreed. With the cleanup it matters even more I think because when
> sealing is set in one place the most likely regression is probably one that
> unseals everything at once.
>
> > 2. Regressions in the new `no_mseal_sys_mappings` boot parameter itself:
>
> In v2 I can check /proc/cmdline for no_mseal_sys_mappings to do that.
>
> Lorenzo, I think that also may inform your question about whether checking
> for the disabled case is redundant, right?
>
> >   When booted with `no_mseal_sys_mappings` (or when unsealed), running
> >   the assertions in Patch 3 (verifying system mappings have no `sl` flag
> >   and that `munmap()` / `mremap()` -- and ideally `mprotect(PROT_READ |
> >   PROT_WRITE)` -- on [vdso] succeed) directly verifies that the boot
> >   parameter works and doesn't regress.
>
> Sounds good.
>
> >  or keep strict failure as an option (e.g. `./sysmap_is_sealed` fails if
> >  unsealed without the boot param, while `run_vmtests.sh` passes a flag
> >  like `--allow-disabled` when `CONFIG_MSEAL_SYSTEM_MAPPINGS` may not be
> >  enabled), so CI environments that expect sealing still catch a broken
> >  seal.
>
> I like this and I think we can do it without adding some of the complexity
> that Lorenzo was not so happy about:
>
> - Have check_sealed skip as usual when [vdso] isn't sealed and param is not set
> - A new test, say expect_sealed, fails in the same case

I'm confused about this one - we want to skip altogether if the feature isn't
enabled, right?

> - run_vmtests runs with -T expect_sealed when CONFIG_MSEAL_SYSTEM_MAPPINGS=y

run_vmtests I will have to best-guess it, e.g. if /proc/config.gz is present
check it, I suppose?

>
> That should be pretty minimal. Lorenzo, Jeff, how does that sound?

Sounds reasonable!

I am a bit leery though of requiring a CI to enable the option when it is known
to break things, however, as CI's might rely on some of the software this
impacts.

--
Cheers, Lorenzo

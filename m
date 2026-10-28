Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793166742;
	b=K2ZaYmkxJQUX0evIjpWrmpkF5ci/Ye4Yl8RFBEP4zAc7q7VnIFQ/+LaLDd/xFEoi1MsO
	 EwkHwwiIKOLkR+vHMGXCGdplBsykEK5uybV9KGx8l9lWJ2avABy4rCDUeFyXR4pOgRVFJ
	 kfBS78SFINCbQ4RigvXRpKd1kceP/r+4q7t9wa3l7AK8fU8uy71ChL2qTMdpFsjD3sosj
	 WEZJ91ezefAERj0o2Hoiks/ddyIRby4Y7A7BweXyWZMeek0im0joqOSre6G1A/FBvdvlr
	 rK7AD5fv3YPnmiqhdOKJImY945/sqk/KE2tAL6/4EA703Kmh7sjS4Xu7QQfbCe9XP6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793166742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=o0+YQ8IhrloxYZmXJNyf64tQivuQ6Pn/Dp36CBxwNv4=;
	b=g4wlfX4l9EnIPPKjlTPCn/OdeEujeR3jcojr/qw0vJpgzhKHLyAnlAlzdwYuitPDcFUw
	 a4LT0H89koImzUj9NNjvwaTUSYrO7Ue8kXnkk1z92zOHqzINDu1hQDKAj6jpDuvhoI7QE
	 6GwO03tA6O9Z9sL253oJETTkYL3Ya/UVmnp6FDd/766UYxhe8KOPVYZ2e7ol4L2L6Q5qk
	 G44vYaDgJhc5v3TZ17ZPgteLW2qAvjmp9TSwNkflqT2AR8wt8SDHYnOBIvG6XnRmVCZ7W
	 JbtcsV2aPtvIcQcgwvoXv7HjBqOtnDgIXmnF3yHtAk2eWQR6nhlsNJqAMwW5xNsO4nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=u1CUAc5U;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C915606A31A
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 05:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C915606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=u1CUAc5U
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-89f639ba307so239701b3a.3
        for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 22:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793166742; x=1793771542; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=o0+YQ8IhrloxYZmXJNyf64tQivuQ6Pn/Dp36CBxwNv4=;
        b=u1CUAc5UGEIg8w651QAnSj1ilJ1Hp07nRBlYJYLip7lca9dtV+G4XIVLxIkkYk+9He
         Gi0KpLWies9ZXilvLmEHfJEIcvI8kzJ1Wyu473aUFgZ+EPn9NADS0gpTZFOInL5tm9Nq
         7qBSbt2D7PxHKFRNJ0ExDlyKLPKzHEsOpZICg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793166742; x=1793771542;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o0+YQ8IhrloxYZmXJNyf64tQivuQ6Pn/Dp36CBxwNv4=;
        b=bTIjrJbaUqD7rBkjk+bU/kKenOcOgFnVG0DJtAHLCdDwZDQkYQa/qi9v9mkEgDp8A7
         TrvQ568eleqxl/IBjJRSLmuM2dIOzaqJMkOk8QymtsFb+JIl5bQHiRm9VGWnOAwTKSto
         grqvQ2jKQcfbCVy+E3XKrhXwnp7JXdJjSTVnhaDe+O+U32+SfILdA2ffhGkwvGn2QP+4
         /wIekGn/IE/Q2ST8+O2S/BB4VkvSFYqBly39upqsmW/u4MQVh8ibdVPe2uBjgDju6UI/
         hdaEv7a6KqSiOq5zST/VopYrQfKQNtTdazqoBQ3dmZwDYh/wADAv4+4rkUnoHZRrbDgA
         QimQ==
X-Forwarded-Encrypted: i=1; AKwUvByQzq1yKcThIExUyVfE6Z3qSFAsYcywJ43/cFdwjHfyyRiW9EfkVNBjh0iN9MrqR3C5EHGXarMgGVSvMViFJpjKH7Hbly4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3DLEiw1tX2n7th5khio+i0yfjLbysciLjt+2UOfYiqooAA7Be
	RWCwbgC1UY7C9ipdgaWu9vja/N/4QznGAomJeTZ+mUu5RUaA6/2W2YQwHIzr7sZombY=
X-Gm-Gg: AYBFou3UgQhPqhfoN/TNVUlqkJMct4QfcCujnpY/H9RC0+JJKLceRXDvJQ02cvNbAub
	W7JTQCf7HMKAPZKOsMIESqvLAx+/Cevbuq9kK1m/c/5c8FYpYdYw62gJkbqzzt9zCvOBm4OdRmh
	Ef2uHaztnBIU/EgDjmC+8hjrDbmsAtUWxSQfkpMxIfUbWgjK1yj7VZAQhT1HmkULGuZs6mbTopQ
	dVM9i0WN2RJ073UhrEiyklDxepeNJ5sNX3Eiz78On7Is824wqxWHHXqT6WAbB8n/Ih7L7JM+cEf
	WCgcDzRPmaUSKFhG3LdshH2COKqVkoRfl8eEMpMlKtKMiP7m9KSuiAuTKiEjVQiRmrLuShcfljx
	GnJ4WdQJV+rAHDVe+b1Zf6tjXHBnTdPXAKkz7ba+2amAmj7c6PsMYA4nbTdlgvJ0d4pmCugWVM/
	MICg4G/Pre1ab8QKauEIBQeXZjK6X6dCM9gmLa+8oaCZxMt2PuUAOPVgSOuNyjqYY7NMC7l+FiS
	g5oSz89EcfmqMKPfWw7Hbnf9YvY0G6RPPoEkEQvLBxF75oENpGJLc+owAaUFouvgmGloCHwC4NP
	TaCwYwIn1D4rpYuAO9GmtAMhjomr7Rg4Z6QTW5wltE+/SOeppgpndcjJLAHxirX5eHgW7Oh8IWh
	3R0qqMPRXHF1Uo7NRlIljXuZEDsNLMNbHvNAKPbhVky/hogmp5XZvxXQMWY4JasWr/7O9e63q
X-Received: by 2002:a05:6a00:4b4f:b0:88d:20ff:15c9 with SMTP id d2e1a72fcca58-8a6e7acb277mr1168038b3a.17.1793166741947;
        Tue, 27 Oct 2026 22:52:21 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a6cfc785sm695363b3a.38.2026.10.27.22.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 22:52:21 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:52:18 +0800
From: Chris Down <chris@chrisdown.name>
To: Jeff Xu <jeffxu@google.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>, Andrey Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/3] mseal sysmap: Add mseal_system_mappings= boot
 parameter
Message-ID: <auGNkhSHpBRd2U_5@chrisdown.name>
References: <cover.1793094611.git.chris@chrisdown.name>
 <5bd3c89d733ad22224f296dfa8900769de937de0.1793094611.git.chris@chrisdown.name>
 <auCxjbvY3qPv1sV6@gremlin>
 <auDTMb6WMFUpxeZy@chrisdown.name>
 <auDTptDQsB4xBcz7@gremlin>
 <18e2972cb8520c2e.3137322e32382e342e3434.279dd1.0000sendgmr@google.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <18e2972cb8520c2e.3137322e32382e342e3434.279dd1.0000sendgmr@google.com>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

Hi Jeff,

Thanks for the review!

Jeff Xu writes:
>Could we please keep the test coverage for the unsealed [vdso] case and
>avoid unconditionally skipping whenever [vdso] is unsealed?
>
>There are two regressions I'd love for us to still be able to catch:
>
>1. Kernel or config regressions when sealing is expected to be on:

Yeah agreed. With the cleanup it matters even more I think because when sealing 
is set in one place the most likely regression is probably one that unseals 
everything at once.

>2. Regressions in the new `no_mseal_sys_mappings` boot parameter itself:

In v2 I can check /proc/cmdline for no_mseal_sys_mappings to do that.

Lorenzo, I think that also may inform your question about whether checking for 
the disabled case is redundant, right?

>   When booted with `no_mseal_sys_mappings` (or when unsealed), running
>   the assertions in Patch 3 (verifying system mappings have no `sl` flag
>   and that `munmap()` / `mremap()` -- and ideally `mprotect(PROT_READ |
>   PROT_WRITE)` -- on [vdso] succeed) directly verifies that the boot
>   parameter works and doesn't regress.

Sounds good.

>  or keep strict failure as an option (e.g. `./sysmap_is_sealed` fails if
>  unsealed without the boot param, while `run_vmtests.sh` passes a flag
>  like `--allow-disabled` when `CONFIG_MSEAL_SYSTEM_MAPPINGS` may not be
>  enabled), so CI environments that expect sealing still catch a broken
>  seal.

I like this and I think we can do it without adding some of the complexity that 
Lorenzo was not so happy about:

- Have check_sealed skip as usual when [vdso] isn't sealed and param is not set
- A new test, say expect_sealed, fails in the same case
- run_vmtests runs with -T expect_sealed when CONFIG_MSEAL_SYSTEM_MAPPINGS=y

That should be pretty minimal. Lorenzo, Jeff, how does that sound?

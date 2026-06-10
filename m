Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C633A0B01;
	Wed, 10 Jun 2026 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781124327; cv=none; b=TnZnrXzpiuRtKWxoxdhJZ+X3fYgvuyl6l/CZt29PSIHSFkyQNk8UIJzNNbLVjA50GmWVGH0hoQcormNpx3RyJClgGMMJK916etDsYcNrBePbDtWU2CGNGI6sqN/MF/j1kqjiAekTBecHfF4EIuGoBLsgE4LzoEbc1yB5SBQWH8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781124327; c=relaxed/simple;
	bh=XI0mVsMJlDKfHnKC7Kseu2fNyd92u7SK3+Ihu+UwTpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBAecY7s68M0FXofCbNIVsPCOYXgbXaLG5ip62gBn0Gusdg3fsFLJp0IiwMgSBnnpNgZfEg/dQ9feVgYPL6MZey98hNQlJYoK5yP6v5GDAsRhy9sHeItLstvC4Q2100Ix0X7H5Bl8PZlA7h1AH8AcR5hNZokw79832p5NY9VcHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZaX8ahK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZaX8ahK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FC11F00893;
	Wed, 10 Jun 2026 20:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781124326;
	bh=2YyXJzKW2hvdCax/4QtTd6JS/Jl3K2pIRKQL3aqJrRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MZaX8ahKXHs+MqzWI6RYCOtpMjITEv2sNw9s33TkctmsYNjJgNUVP3K6DV0bVBxhk
	 QerQyeBPZ3GCumaGE3PmTB5ILdPL1y4OB28n3NBkuNU3lBmP72Hc52XUAdnk9SXiZE
	 h8ggB3XY2VwZew7nmOrj/pZp/gz/ZIa5l+sqNou/kJp2kU+92EBEheAbbAo2h9ca+l
	 xvyAPNLAt6cWolnMMYvHu0N3C4AT3NbvbMzkk1dh1tmYj7j7C1YOriNZIBItdLwkEJ
	 Z7Pwl5/rPlYtIprg0AqaIrsD3HouM68UlnWrTi5XLx1sXYWLhh+cRcoxsyMvjHc0cG
	 RI4e66dBwvWhw==
Date: Wed, 10 Jun 2026 13:45:25 -0700
From: Kees Cook <kees@kernel.org>
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-security-module@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cred: prevent slab cache merging for cred_jar
Message-ID: <202606101345.D1BDA8BBE2@keescook>
References: <20260606142558.13809-1-med08elkadiri@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606142558.13809-1-med08elkadiri@gmail.com>

On Sat, Jun 06, 2026 at 03:25:58PM +0100, Mohammed EL Kadiri wrote:
> The cred_jar slab cache holds struct cred objects, which contain
> process credentials: uid, gid, euid, egid, and capability sets.
> Overwriting any of these fields is sufficient for privilege escalation.
> 
> On a default Ubuntu 6.17.0-23-generic system, cred_jar (named "cred"
> in sysfs) has 2 aliases, meaning 2 unrelated object types share its
> slab pages (object_size=184, objs_per_slab=42).
> 
> Cross-cache heap exploitation relies on slab cache merging to achieve
> type confusion between unrelated kernel objects. CVE-2022-29582
> demonstrates this technique: an io_uring use-after-free is leveraged
> across cache boundaries through page-level reallocation, ultimately
> achieving root. struct cred is a primary target in this class of
> attacks due to the direct privilege escalation that results from
> corrupting any of its identity or capability fields.
> 
> Add SLAB_NO_MERGE to ensure cred_jar receives dedicated slab pages,
> so that freed credential slots can only be reallocated as struct cred
> objects. The memory overhead is minimal: one struct cred exists per
> task, and with 42 objects per slab page, the cost of dedicated pages
> is negligible. There is zero performance impact on the allocation
> hot path.
> 
> This follows the precedent set by skbuff_head_cache (net/core/skbuff.c)
> and key_jar (security/keys/key.c) which use SLAB_NO_MERGE for similar
> isolation requirements.
> 
> Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>

Yes please. :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

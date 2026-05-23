Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740FB18D658;
	Sat, 23 May 2026 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779558277; cv=none; b=YQAezt+o5HDxHQ03cgyroirNVDmrH9pnRj5v9Ar30I1W31ZkpkWmIgCTre+YKPVdnGnhVASKJKcbUCOVOCkO5cEi0+DBXJd88HxBjb+RB+yAq/bfo6P3LdADNhEX/zOsCI8dwtxBWaMYvGN9FfYSjCFgAzbl6Mfoa1OxsfcJsIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779558277; c=relaxed/simple;
	bh=Hk42tTuQ3LyXBHoQG0KXN78hd8MNpJF7HJvgxzKSypo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ghxLXPsJ+zK85+p7+FBQvOEQ1DbhglgTTTsG0K1IXGw+suEeSTOHCb0CQYTekmKtZqw3BW9K6S3kHMEjCf/XQ5DnH+l9mlL3KM4FW/Rj+0PG5WrZ1TKcENJz+tdV3fTuwpRv6nmfnLhezXb4Ju7KJ5rNrrDMR0M9XivPbOhLH+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUmG21A6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUmG21A6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078121F000E9;
	Sat, 23 May 2026 17:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779558276;
	bh=xKjch3qYnVRgH+0jhxi8SdDnFsirC1fAu4QQuLNRpVU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FUmG21A6+vkGw9LBQDhKcCZ8RTq1Cw0la8rLfZoDVXhK4E2zWrKKNHnxQnJOw0181
	 nGuj6LpZlzWasA/gVfBAEaCFc5jSchke4DoA3znDYoQm2busAgLc0aReAx4Hj7Z/mh
	 LVQ+YOX097FxhrTO4z0sXbMndmAHQtpnHu1OcMrzlXP1EzSesNTK3glgkVZAIDa9Em
	 I6jBi/3QTy2hZRDyaW5FjmiJmySHTxWFk1uJz21D6xKpE02subrk0SDCNn0lufx3X+
	 omFAmysh+xY/bqbaN+M5IsQq9wFkcNokr24ekkBnbHLKqRHCjKe/B1TPeHUa6S1hvv
	 uwn9xMxEXwysA==
Content-Type: multipart/mixed; boundary="===============7484647205220404866=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1df480d313e417e1a6526486d873b9f23580295983b0fdea37be34c1fe1ccf35@mail.kernel.org>
In-Reply-To: <20260523160025.16363-2-paul@paul-moore.com>
References: <20260523160025.16363-2-paul@paul-moore.com>
Subject: Re: [PATCH] lsm,bpf: fix security_bpf_prog_load() error handling
From: bot+bpf-ci@kernel.org
To: paul@paul-moore.com,bpf@vger.kernel.org,linux-security-module@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 23 May 2026 17:44:36 +0000 (UTC)

--===============7484647205220404866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit a03af62bb4a3613aadacc8cb75f0007d761e785a
> Author: Paul Moore <paul@paul-moore.com>
> Date:   Sat May 23 12:00:26 2026 -0400
>
>     lsm,bpf: fix security_bpf_prog_load() error handling
>
>     If security_bpf_prog_load() fails there is no need to call into
>     security_bpf_prog_free() as the LSM will handle the cleanup of any partial
>     LSM state before returning to the caller with an error.  Thankfully this
>     isn't an issue with any of the existing code as the LSMs which currently
>     provide BPF hook callback implementations don't allocate any internal
>     state, but this is something we want to fix for potential future users.
>
>     Cc: bpf@vger.kernel.org
>     Cc: linux-security-module@vger.kernel.org
>     Signed-off-by: Paul Moore <paul@paul-moore.com>

This looks like a bug fix for the error handling logic introduced in
commit b3beebbe6154 which imported the kernel/bpf/syscall.c file with
incorrect error handling for security_bpf_prog_load() failure. Should
this include:

  Fixes: b3beebbe6154 ("adding ci files")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26337503379
--===============7484647205220404866==--

Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CF83B994F
	for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2026 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573081; cv=none; b=Op1KVLdVVNHhzRDMMOLR9rPnyuSU9//qxSS9lSpD2g5odzM8sReFxumKYyP3KimxK36fz51a6IVtl7RALLr/ykeihsvO/AkauQN8h0Dk5bRWS7PIWc+X9Vt11K7vglVAzdd2pEdvIHD+0jpxKP3LQd0Lm9M+U3+C9lihkHIHKbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573081; c=relaxed/simple;
	bh=5v/s/7Iuul7C56PuYL9oxgVQSwxVWgtd57ybWn92daw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=do1pfNV2jASbsCaCLUvDCdRei64qvYngsDT+h+bO0buiE/QaTWeNb3j533tMgDc0Uu4WIDv7Q9RTb78yHbxYlvsO5ghGNDKNyFzbAS1YG2LwWGuxusn6h9x4R1RLpAEAY50UGFaQXXnj8eJP5SI2Ml1owguVaDUFB5qGkT3CrsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ESae3DYl; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ESae3DYl"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4834977ae75so586320f8f.3
        for <linux-security-module@vger.kernel.org>; Wed, 16 Sep 2026 08:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789573071; x=1790177871; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u78CS4uMDZfbASZgzU72LbLYuroH821SkavMLSLlG4o=;
        b=ESae3DYl0ElhtPOfui/CPLv6anRyze1qYVeThoLfUDCe0Sh1oPblhbfKsajLJ2zvjj
         E4NqGzIXCwOq7fvg8lQfCGOPI6JimF+pT87HWuoM+2cIeDeYcuDRLEjUPAVwVkNWhODJ
         0sN6SLxWPsl6kbPgYlr4RjmzstJTpSocKrcXqqkDOrzaZA6ArbX+mPL+d+e9aDrQAfXq
         6TBmq6XvGKd6OSxkkcVPtAnRqk58zX94EkP2d69WD9d/ORbD7BZnbF94LIkVjEQWyz9/
         qoMGlSFf3GQj2N0Vf8Op+AKKBlB60F+utpatGeOYhSqb3om63UFlU9nQfrS5vU1Avnsz
         BE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789573071; x=1790177871;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u78CS4uMDZfbASZgzU72LbLYuroH821SkavMLSLlG4o=;
        b=iElblsRKcGJT24i6wEyo5jpZDejYbIHIvheeud/i+vzWIX+C5cPongwgZt5BZvP0PF
         /AjH+Pj/MSaUg+ib8o0iWyqkf1H7APSz/4A49IRwySWQy+my34R3RjXxfOsIvrL9kfV9
         YmVgWYfYv6YwERZJCy53IYiWcV8akMI5uX2M+0dYwzveE9hf9LowArTYVe2zGP2A+DAC
         GPstp6mBlUDg2DCSZDJ+F7TKjKPxd/wvGI8gl0RInw66QXiSfCHMmQP/kC5MRsmEq3B3
         c2rys3/rF/hZB+SIUMWrXCChg+T8IWIRwoow6b04hHx51LYqyTLbcUgDves5Cw0FRw+K
         5cfw==
X-Forwarded-Encrypted: i=1; AKwUvBycdd2sxIWn4J4hNe7DFfKglvZYc3Xs3+Y4hJYd7GAOUZHbAmOVIWrsp5HsNI4x5EUw+tgGiXBkw+dmBPOD25+PY0F1v/0=@vger.kernel.org
X-Gm-Message-State: AFuF++lnhbZspEBJEfQ9jDCFmbKDCDsfZfe99yeTvGTR5IwDvjH85Hd1
	ABH+oGZjjxN2V8B0FRkZ7aLKywA1WXUQOEvAsPRd25DQh+3XcMOymHPOpRrN5KeWuA==
X-Gm-Gg: AYBFou04kqE6xFpwPBqnF+29IYiQvZtVoONk+DEUr5MHtgmTgP9Z1LlNksCMCjmEYrS
	vLhg0Vmne9Of/Z4da9Jxz3xNX/bkvhCVra6BYut3QH4ef3tEwJHqtqziHMuJk87G3JhwPVRxwvq
	Qd/95J3kR1D3PGDQ01kE89r1Ic2+p2lA3Cecxir7lkx47rQ1ZJmYfbGCQrc0ulRixyAz7aB9gac
	+ESQGfxKbC5K1YVYOhCeCct4ptP6IDaeedcF8jXhgbFzAnCB/7wm4dk1iLWMrvQcih7LfUrbmNk
	qBnVhhovFQXxl0QYmmuOGEm2LFvat7cpbP4rXdmNuLULBdQ5HgxyVqERWbvGhvBkiDasjxv0V3w
	uu8StpDAvMt+MvNmChgRv5nIlluExqnoVbTPrs97l2KzXfCUiZ61nJDhJ7xhrUwPQ2qnn8SB7yi
	NOAGs2utIdFADCNgGNSstMn5pCwz/iQtMpyhxdLfM5YdrG2n/njYCWoSKl6MxvWiQ7puMR0d+QK
	rqdfIgp9wG3R0p4w04rz9JdK324
X-Received: by 2002:a05:6000:2408:b0:486:f301:11df with SMTP id ffacd0b85a97d-4870cee0b72mr8867562f8f.6.1789573070432;
        Wed, 16 Sep 2026 08:37:50 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:a430:d4f:f001:4a5d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf438fbsm8022313f8f.36.2026.09.16.08.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:37:50 -0700 (PDT)
Date: Wed, 16 Sep 2026 17:37:45 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Christopher Lusk <clusk@northecho.dev>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: landlock: clarify TTY signal scoping
Message-ID: <aqq3yY8SKIBGUZ8v@google.com>
References: <20260916152336.1589383-1-clusk@northecho.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260916152336.1589383-1-clusk@northecho.dev>

On Wed, Sep 16, 2026 at 11:23:36AM -0400, Christopher Lusk wrote:
> The LANDLOCK_SCOPE_SIGNAL documentation does not describe how TTY-driven
> signals interact with signal scoping.  Holding a PTY master file descriptor
> is a separate capability: its holder can cause the TTY layer to signal
> processes running under that terminal, even across a Landlock domain
> boundary.
> 
> Add a concise clarification to the userspace API guide and the UAPI header.
> This records the capability boundary identified during review of the
> TIOCSIG discussion without enumerating individual TTY signal paths.
> 
> The documentation text and changelog were drafted with assistance from
> Codex (gpt-5.6-sol).
> 
> The userspace API documentation builds successfully with the kernel-pinned
> Sphinx dependencies.  The patch introduces no new warnings; the existing
> missing-graphviz and undefined-label warnings are unchanged.

Minor nit: Last two paragraphs of the commit message would have been
fine to drop for conciseness (the Assisted-by line already lists Codex
and the other paragraph talks about things that didn't change).

But really just very minor, and probably not worth changing unless we
unexpectedly need a V3.

> 
> Link: https://lore.kernel.org/r/aqqJAZfG9FC7PgMW@google.com
> Suggested-by: Günther Noack <gnoack@google.com>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Christopher Lusk <clusk@northecho.dev>
> ---
>  Documentation/userspace-api/landlock.rst | 3 +++
>  include/uapi/linux/landlock.h            | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 84cb7bf6b3ed..33a514ebc615 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -430,6 +430,9 @@ The operations which can be scoped are:
>      This limits the sending of signals to target processes which run within the
>      same or a nested Landlock domain.
>  
> +    Holding a PTY master FD still grants the capability to issue signals through
> +    that PTY to the processes running under that terminal.
> +
>  ``LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET``
>      This limits the set of abstract :manpage:`unix(7)` sockets to which we can
>      :manpage:`connect(2)` to socket addresses which were created by a process in
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index cceda3b3b961..6485af37dd25 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -501,6 +501,8 @@ struct landlock_net_port_attr {
>   *   related Landlock domain (e.g., a parent domain or a non-sandboxed process).
>   * - %LANDLOCK_SCOPE_SIGNAL: Restrict a sandboxed process from sending a signal
>   *   to another process outside the domain.
> + *   Holding a PTY master FD still grants the capability to issue signals
> + *   through that PTY to the processes running under that terminal.
>   */
>  /* clang-format off */
>  #define LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
> -- 
> 2.55.0
> 

Reviewed-by: Günther Noack <gnoack@google.com>

Thank you very much for your contribution! :)

It ended up as a much smaller patch than we started out with, but the
real advancement lies in the understanding of the semantics and in the
double checking of these boundary conditions.  The LLM output was in
some cases a bit wordy ;-) but overall this was a good discovery and
useful discussion.

Thanks,
—Günther

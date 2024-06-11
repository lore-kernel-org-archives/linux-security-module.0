Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA29CB673
	for <linux-security-module@vger.kernel.org>; Tue, 11 Jun 2024 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718067951; cv=none; b=TouzVZ3DmhgWQlrqS6mKHNfYkNJqgZOOcdSYYV/41EFnuTNoR/dMt29rMEWUzJisxdKiyAsI1agAm+5OL1gmJ8PNxSevBWCoj/sdkc6KAwet2QqooquQaYAyP4zu6s7jVrHRofTx7av0Kq4od3SJnDYkgg46tr/w74Xv7bp4Oug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718067951; c=relaxed/simple;
	bh=1ZwDkZMh5wK7KEbCm2y7rfR5RAxqwyRhu58ZhZipeVQ=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=TGYXVnnJdNjMsfQ1PcmFk5FOkLaqohsm0o2rnGgh75v7ABVYHF30R7SitRMWL9bK1OHoXYfNBtw6PAPBhYAsO5JbcaD8OJHEaS6c5JdP2c+L+5FxAlvC4H74fGmbyeHtSoyt6pasCQ+nxOz/uCNLRKlJpwENSjOHcs/qjPwqYeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AAXMqafQ; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AAXMqafQ"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d215a594b9so1819439b6e.3
        for <linux-security-module@vger.kernel.org>; Mon, 10 Jun 2024 18:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718067949; x=1718672749; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yZ4JDG+dJaoWCaYO977Z1LKOPgYLIz36cfcgnvADTfA=;
        b=AAXMqafQhrW6XWQnz8wS9LV3Z90TqFB3oNX7o4sAEeQO+zuQEzuNnLe+kf6R8pvoLm
         DWZ1WPvBaa8wjkyQmElmXJEIG0Ftjd6In5heppa/XlV7p6piiNiwQdaG1Kmx23wi0TxJ
         1MFTyVsG3oZJ3ugq4ihZ+WgtLinL2ruEpulDzPdyllWeUXL1yGqLnnF95r8bHun9OYwk
         brg08Dr5n3vzwjWoNAk/R2Dgj79HcY+UyVDr384d9r5DX/YcA3Sl5fjIQu2jDZkgjtNK
         O5BxyKFuT4CxfBf+4rDhrqKbpTQAVWA5Nxt6i3MKWxwVPly3ZnBbur+k0HaVHWf+oIuE
         E/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718067949; x=1718672749;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yZ4JDG+dJaoWCaYO977Z1LKOPgYLIz36cfcgnvADTfA=;
        b=lW1cYMj20KouRtV+KiVFO9fnKtT8lREQF2ECmtK628Wa/ek0WE9XFW70MKE0dMfUAo
         MF41WU8iZeXQXig1N0TjVe4iwHiw7HjMGE9hHffPM22reDfQP/gGkFv9JgiXGI2thaqi
         7av1BIxrkwq068HE8p+I7Sskh5o9FVqX1pGD9/pJS4T6noeST5kLZVV5Yfbha8wBAR3p
         u9n7OWkt2jA6woN5fIglWQd8sDDaLcKm3R8zlnjNupWtmz12smmJ3JbMOBUbBQKDDaDo
         SXymaHs+Q7cXyeIONg4Pv0EsiAblDRT9h0ltRQ1qPuq8QEgiedH7oxeNg2uw5uSG50zV
         C5rg==
X-Forwarded-Encrypted: i=1; AJvYcCWIfQ1cAmtN2fGFs5QN4/tIc1PMwrFrsKZPd0adZGvV+geo5Le9nRKvagYF/ZhgrZN9J/VAelb6PGrkDUBgtp1NmbhSOU9SsCeCy6cEgGEfw2DdhUX1
X-Gm-Message-State: AOJu0YzXRP+3+EaYmHfVAcvzlCK9JocaL9OZ5xFYFhCdFwj5+mw8X8up
	REWvRcYbcqEE0JJHGaoDDRW/nQYwOn9+Wyb3vn11Z6ZVswvyARrC/IoEBR65+A==
X-Google-Smtp-Source: AGHT+IHbEqXBLO2Hne6cvXvXI7Jk/mxqNCvkIh6oXm2zZK2/y+ysC+4BLi5/GWzLIe/6agFFO8Me6g==
X-Received: by 2002:a05:6808:bd2:b0:3d2:15a5:99ff with SMTP id 5614622812f47-3d215a59ab5mr12107086b6e.32.1718067948753;
        Mon, 10 Jun 2024 18:05:48 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79785665e38sm106079785a.64.2024.06.10.18.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 18:05:48 -0700 (PDT)
Date: Mon, 10 Jun 2024 21:05:47 -0400
Message-ID: <03c6f35485d622d8121fa0d7a7e3d0b2@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, daniel@iogearbox.net, renauld@google.com, revest@chromium.org, song@kernel.org, KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH v12 5/5] bpf: Only enable BPF LSM hooks when an LSM program  is attached
References: <20240516003524.143243-6-kpsingh@kernel.org>
In-Reply-To: <20240516003524.143243-6-kpsingh@kernel.org>

On May 15, 2024 KP Singh <kpsingh@kernel.org> wrote:
> 
> BPF LSM hooks have side-effects (even when a default value's returned)
> as some hooks end up behaving differently due to the very presence of
> the hook.
> 
> The static keys guarding the BPF LSM hooks are disabled by default and
> enabled only when a BPF program is attached implementing the hook
> logic. This avoids the issue of the side-effects and also the minor
> overhead associated with the empty callback.
> 
> security_file_ioctl:
>    0xff...0e30 <+0>:	endbr64
>    0xff...0e34 <+4>:	nopl   0x0(%rax,%rax,1)
>    0xff...0e39 <+9>:	push   %rbp
>    0xff...0e3a <+10>:	push   %r14
>    0xff...0e3c <+12>:	push   %rbx
>    0xff...0e3d <+13>:	mov    %rdx,%rbx
>    0xff...0e40 <+16>:	mov    %esi,%ebp
>    0xff...0e42 <+18>:	mov    %rdi,%r14
>    0xff...0e45 <+21>:	jmp    0xff...0e57 <security_file_ioctl+39>
>    				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>    Static key enabled for SELinux
> 
>    0xff...0e47 <+23>:	xchg   %ax,%ax
>    			^^^^^^^^^^^^^^
> 
>    Static key disabled for BPF. This gets patched when a BPF LSM
>    program is attached
> 
>    0xff...0e49 <+25>:	xor    %eax,%eax
>    0xff...0e4b <+27>:	xchg   %ax,%ax
>    0xff...0e4d <+29>:	pop    %rbx
>    0xff...0e4e <+30>:	pop    %r14
>    0xff...0e50 <+32>:	pop    %rbp
>    0xff...0e51 <+33>:	cs jmp 0xff...0000 <__x86_return_thunk>
>    0xff...0e57 <+39>:	endbr64
>    0xff...0e5b <+43>:	mov    %r14,%rdi
>    0xff...0e5e <+46>:	mov    %ebp,%esi
>    0xff...0e60 <+48>:	mov    %rbx,%rdx
>    0xff...0e63 <+51>:	call   0xff...33c0 <selinux_file_ioctl>
>    0xff...0e68 <+56>:	test   %eax,%eax
>    0xff...0e6a <+58>:	jne    0xff...0e4d <security_file_ioctl+29>
>    0xff...0e6c <+60>:	jmp    0xff...0e47 <security_file_ioctl+23>
>    0xff...0e6e <+62>:	endbr64
>    0xff...0e72 <+66>:	mov    %r14,%rdi
>    0xff...0e75 <+69>:	mov    %ebp,%esi
>    0xff...0e77 <+71>:	mov    %rbx,%rdx
>    0xff...0e7a <+74>:	call   0xff...e3b0 <bpf_lsm_file_ioctl>
>    0xff...0e7f <+79>:	test   %eax,%eax
>    0xff...0e81 <+81>:	jne    0xff...0e4d <security_file_ioctl+29>
>    0xff...0e83 <+83>:	jmp    0xff...0e49 <security_file_ioctl+25>
>    0xff...0e85 <+85>:	endbr64
>    0xff...0e89 <+89>:	mov    %r14,%rdi
>    0xff...0e8c <+92>:	mov    %ebp,%esi
>    0xff...0e8e <+94>:	mov    %rbx,%rdx
>    0xff...0e91 <+97>:	pop    %rbx
>    0xff...0e92 <+98>:	pop    %r14
>    0xff...0e94 <+100>:	pop    %rbp
>    0xff...0e95 <+101>:	ret
> 
> This patch enables this by providing a LSM_HOOK_INIT_RUNTIME variant
> that allows the LSMs to opt-in to hooks which can be toggled at runtime
> which with security_toogle_hook.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/lsm_hooks.h | 30 ++++++++++++++++++++++++++++-
>  kernel/bpf/trampoline.c   | 40 +++++++++++++++++++++++++++++++++++----
>  security/bpf/hooks.c      |  2 +-
>  security/security.c       | 35 +++++++++++++++++++++++++++++++++-
>  4 files changed, 100 insertions(+), 7 deletions(-)

...

> diff --git a/security/security.c b/security/security.c
> index 9654ca074aed..2f8bcacf1fb4 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -885,6 +887,37 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
>  	return rc;
>  }
>  
> +/**
> + * security_toggle_hook - Toggle the state of the LSM hook.
> + * @hook_addr: The address of the hook to be toggled.
> + * @state: Whether to enable for disable the hook.
> + *
> + * Returns 0 on success, -EINVAL if the address is not found.
> + */
> +int security_toggle_hook(void *hook_addr, bool state)
> +{
> +	struct lsm_static_call *scalls = ((void *)&static_calls_table);

GCC (v14.1.1 if that matters) is complaining about casting randomized
structs.  Looking quickly at the two structs, lsm_static_call and
lsm_static_calls_table, I suspect the cast is harmless even if the
randstruct case, but I would like to see some sort of fix for this so
I don't get spammed by GCC every time I do a build.  On the other hand,
if this cast really is a problem in the randstruct case we obviously
need to fix that.

Either way, resolve this and make sure you test with GCC/randstruct
enabled.

> +	unsigned long num_entries =
> +		(sizeof(static_calls_table) / sizeof(struct lsm_static_call));
> +	int i;
> +
> +	for (i = 0; i < num_entries; i++) {
> +
> +		if (!scalls[i].hl || !scalls[i].hl->runtime)
> +			continue;
> +
> +		if (scalls[i].hl->hook.lsm_func_addr != hook_addr)
> +			continue;
> +
> +		if (state)
> +			static_branch_enable(scalls[i].active);
> +		else
> +			static_branch_disable(scalls[i].active);
> +		return 0;
> +	}
> +	return -EINVAL;
> +}
> +
>  /*
>   * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
>   * can be accessed with:
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog

--
paul-moore.com

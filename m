Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35975480954
	for <linux-security-module@vger.kernel.org>; Wed,  2 Sep 2026 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351866; cv=none; b=rIN+z3S3nPEorfJmbHhCW+rMXJF9It722Nu8X24FtFVxl4LN3XmzvBSQwbcwgMeqLBQwd1Cn0Du3DWlHtwHrnLS9SuQGlKtL8Z2Y8Uj+D83HT9gr/CuRiJsSA+zjtABWHVWcGv0yJ0whs/Z9P+T0PMpXbv4Aithyd0lsjcVF+rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351866; c=relaxed/simple;
	bh=oTS+YDDaFxN0Q1LeraRZY2cqh7z1qPcDOqRuWiPId8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhmGo67nYOEODKqS3J6ixTYZ+E0L9/SWdDW8gOLwuwZjBmiPhLVh39hiZnOH0HhN1UhShRHZAEB51IYrwTzCECQm0gNl2ExdpxWqBu4lvnDMj0b3RSjlNpIp8tG8MPp9gIuNowKZvnkqk1OP7HehyCERpO4JKT7dzqYruDabTyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1npwNWd; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1npwNWd"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66bd7857841so1455821d50.3
        for <linux-security-module@vger.kernel.org>; Wed, 02 Sep 2026 05:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788351864; x=1788956664; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RArsbmdfySTb2QuEZZ7/chE2iY/l9of1tF9d4mgeG4M=;
        b=i1npwNWdvZF4/I5c+zZI5K67z+RM+Lp3cgwEwKCj3BgMGBas0ycNS3CJBb4aKO4a+T
         GrGiYCT8yNkaWnOqRaHPpGn0ksP6kwQXthNLrY/Xmwd0uBNDV8rRR4qnxkaXY/ra0jkd
         kgFDAkOyaOWTQMiy1Re+kKDknchky683AhHs97ZjUrxcWttoGGFsp9moja/6HF0GQmnR
         fWsvbjSzcGMACARrBmIlt2jLQ7hKruCxznTNk1U+waQGjWIn2DDxCnIovrX5cUIxKduM
         M6e+iIEQ0Uh2hT7aVb/x7CDdd7cvUzyvD/GLUTzS+rWQBveOzYTVsOSTsaeQe5004Hw1
         SZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788351864; x=1788956664;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RArsbmdfySTb2QuEZZ7/chE2iY/l9of1tF9d4mgeG4M=;
        b=Qi8Bofcx1u/K5GDjXpt0UHXegqw/Pv8SeAed9kQselDDQQ+QS0uEpsUkndpXRcQx2E
         YmJwrOgvTazGh7WsQNGucDtVphZrjj72yNFNuQAoP5q2pNVWRPzxKddQ8RbUdIejCj0k
         5VxVkmd37azIKOto4+7lB4D3fKc0T9fOQ1TrC2S3fFax//cU6ORs0Qk0eNFtELEuaJKD
         QIWbsjD9V1OfWK49qcoR7WB/eT8nV1vBh6V5Sehf2KqxGsggR6hC1jEr95pXCASSUXhY
         +zD5gvTvFG+aeKcz7lKfZTDQxlNKbO06r7VSgfZe/lM7btBswNSaPehXZZgmHWxI1KD8
         13uA==
X-Forwarded-Encrypted: i=1; AKwUvBw71RsP6eAVkTF9kB6xmqBDv5pJaV66t4naLoNydl3vAL+iXbqZ5o0/tl5LX5iEM5ZEwXK2XeOyNI/FL3cgSuGMUyIQY8g=@vger.kernel.org
X-Gm-Message-State: AFuF++mov2jW+oSZaDyPu/N9Pn5SnXeKU3c9cCYcodVnKx82rhDL4jn1
	XFEJ0UFm6sBkTajVkONtDaSlWHL/1GJ+ru/xEveJrUQbTnCvwmxdQraQ
X-Gm-Gg: AYBFou0vJfkcNAIsaRVKnxE1epYvBnwoRQOSHeAC19WmuxFhbizXggwTyO3n47O32MG
	xAejOU3H2cbLxs+tUwFNxsXNBZNH7cjAGW+348GWe4PaV3fh3PkXkw+Q3QdfskPod9iJrMDBPxQ
	hfhUMSlTsGxpj3Hj767ALkJH6VzhCk5rvHcMlcsKKP04k96cHfg+AINq3L4IPaIN6J5QTapT48/
	a/hQQSLouFJcz+G0giT6RuDLxrf6ZgpwkarAYGkffRnqRASEXlQM7S4insHVSJXnsG5Kc1BsUGe
	NlZNz3OTEhBM0uGdwciGFmSxjXjBH9CmBtMFGwOW0vokxCg9Kqgburn4kO3Cz3qf56F7an+9wj4
	TYOIi3z2FWC/DnyyAR8f/alTSo+K0+DTegUODdY2YLwhVxicvajZxIJCBIEBBSiOK9eMXvX+bQ4
	n+LAg2RGemdHEjfWgDYGl1KDLeKSpcoHYY/FiROBVK1oZk3JunhoZQNq/D1DfIpPR11+BSmaqmo
	ZHF2tsPzmXwrrtGiwHepQ==
X-Received: by 2002:a05:690e:b83:b0:668:180c:bf6a with SMTP id 956f58d0204a3-66f9bc3fc3dmr1314531d50.37.1788351863969;
        Wed, 02 Sep 2026 05:24:23 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f78:4c8c:a6cc:a58e])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66f98697fbasm1721817d50.18.2026.09.02.05.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 05:24:23 -0700 (PDT)
Date: Wed, 2 Sep 2026 08:24:23 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/15] selftests/bpf: Test the LSM policy object
 kfuncs with Landlock
Message-ID: <apgTQKnhwMyFdQcr@zenbox>
References: <20260831145858.3869191-1-utilityemal77@gmail.com>
 <20260831145858.3869191-15-utilityemal77@gmail.com>
 <20260831195327.1282C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831195327.1282C1F000E9@smtp.kernel.org>

On Mon, Aug 31, 2026 at 07:53:26PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] File descriptors leak on the error path in test_restrict_binprm_discard().
> --
> 
> commit 7fa3010dd885254cc82b6aa2f6f254ee83a13717
> Author: Justin Suess <utilityemal77@gmail.com>
> 
> selftests/bpf: Test the LSM policy object kfuncs with Landlock
> 
> This commit adds tests for LSM policy object kfuncs interacting with Landlock.
> It tests execution confinement, audit log flags, and concurrent application
> using a syscall program and BPF RCU lock management.
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_policy_landlock.c b/tools/testing/selftests/bpf/prog_tests/lsm_policy_landlock.c
> > new file mode 100644
> > index 0000000000000..9270b39f5e3a7
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/lsm_policy_landlock.c
> [ ... ]
> > +static void test_restrict_binprm_discard(void)
> > +{
> > +	struct policy_test_env env;
> > +	char garbage_path[] = "/tmp/lsm_policy_garbage_XXXXXX";
> > +	int garbage_fd, pipe_fds[2];
> > +	char buf = 0;
> > +	pid_t pid;
> > +
> > +	if (setup_env(&env))
> > +		goto out;
> [ ... ]
> > +	if (!ASSERT_OK(pipe(pipe_fds), "pipe"))
> > +		goto out_unlink;
> > +
> > +	/*
> > +	 * Cannot use spawn_exec_child(): the same process must test its
> > +	 * write access after the failed exec.
> > +	 */
> > +	pid = fork();
> > +	if (!ASSERT_GE(pid, 0, "fork"))
> > +		goto out_unlink;
> 
> [Severity: Low]
> Does this code leak the file descriptors created by pipe() if fork() fails? 
> 
> If fork() fails here, the code jumps directly to the out_unlink label, and it 
> appears neither pipe_fds[0] nor pipe_fds[1] are closed before exiting the
> function. 
> 
> The spawn_exec_child() helper function introduced in this same commit properly 
> closes both descriptors on fork failure. Should similar cleanup be added here?
>
Will fix.

I think that's sashiko's only nit for this patchset.

https://sashiko.dev/#/patchset/20260831145858.3869191-1-utilityemal77@gmail.com

The BPF CI AI review bot didn't run on this since the patchset can't
based on a bpf tree until it catches up to the recent Landlock changes.

Justin
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260831145858.3869191-1-utilityemal77@gmail.com?part=14

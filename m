Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EC1442134
	for <linux-security-module@vger.kernel.org>; Mon, 10 Aug 2026 19:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390920; cv=none; b=Jj+g3srINNfkhjoc0FMcY//OvHChBED51OBdj5IF3dDIJIKwry+HeGC++IsecmA46xThLvxSmmskHPO5cuEE4BjV1ra1sgBxRFoKYf73NMwtjbx8FbhMbFHRTURWeBllmdrzLGpEdsezwBNxliBBB0VhqRcI4u5kbQplH3tajN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390920; c=relaxed/simple;
	bh=LOri3CcuBtdSvAEYFeKTd1PeW4G632pF4oItWhfE/Pw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=blqRAlLXnlBeqknwUxj8vlsIXuqGWnu3slA6jEQT7Fhjm8FLm1pXCd3t3Z85MJ4kgh1MOHGotI4cygkuIYSpRyFq96iklrAnZBKdJwzB76hOGbTv29Rr/At59NAmdrL8GfDysCpz4bl9qrVHMlNTtTqo/DP+QvO+hrrYzFIFE7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dgxzB4zK; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dgxzB4zK"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c0cea8883so2713331cf.1
        for <linux-security-module@vger.kernel.org>; Mon, 10 Aug 2026 12:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1786390916; x=1786995716; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vsd1x7Iz/VQJIsN2hgBouGDdRtwtfDh2Zexev25G1Ak=;
        b=dgxzB4zKI8coAO1aT0pFwxfat56Zm5zt1gevfiFT3TU/hSJDhqFvnzP2B9KbkXTomS
         cU1Y3PIXTk1EgUa11NJMZcNki/kAQEFPu2l+MugzfiYMkFVbwUvaNcGKdCJ6A9fgg9oi
         6KVyJ90ygYkML+wsvi5jkO5PyGATs3PuCSPpoiJtbs6s0AXa4mvMqSJVKpGj5PMpNwMb
         16KiBTwxk27BL9H585nqYDt9vEuVMtbdrRKF8wTdi4SGFlYlKkk9u7blK0sRJHVOxnnu
         WJdOT2JWiuVyIdl81mw/GIqdJdsV0l4K/SaaWrIhndTJG703QAkFU6ZlW6M05RsbGK15
         LRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390916; x=1786995716;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vsd1x7Iz/VQJIsN2hgBouGDdRtwtfDh2Zexev25G1Ak=;
        b=AKPEwF9KXZl8pXmWNfd/866xfQh6imS0h7o1PlcRaVaRqWsHeo81ufFUd00y/ZMSg4
         uKRZ8hsIN1T35f2wq8Nk4fpN1YIRjo67YR8Gp6k8s2WfqCosgZR/D1UmYI2VdywjNvAA
         5dglz+26PN7PnyK8MisZ3J705Vlc9K1a10X0R72SqchoNWBKBMwG++EPtUKmikBnjLVV
         aZHsaYvSKAqcoqZ9IafakIdnk42F3YAEDZR9VIqtjcClrIQQYV3enoFgRW5nSzF26Dvz
         GWw5D5yw/IXXCD2w386j6sl83ntadvvdT2yuXHedpfvqclGcQ5WH9PIjwacaKGbhaUR5
         wGhg==
X-Forwarded-Encrypted: i=1; AHgh+Rps7gUUAKZj0ZBsC05zTA1raFMYcJ2E+v7diBXNf7ue4HflFQuGwpzLTUYF5lDct3d3H1RDdvOMhigeYZQVXzW/wtZ61hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxExeZ36qTGxApkZIBQ/iOpPiELzAl8Ydw1oYRKZz3/gYZSR2eX
	bbCULhAghwhXQtlJcfi6JNTfN1J1lMzPwXOmteYyKxOUMR/QwvYgrUUfw5tX0SiRYkBXKFdm9AF
	zGMwq/w==
X-Gm-Gg: AR+sD11XiOZCTecUihPT4TGw/m2ar5l7eP3KYhMsewG26iOVHsy7eu8vPCVkTERFdy8
	bTlFOVJwzXX5/nsu8ObbBI5XNxAQcXBoaH48lNcImQ+VTNNRBVrXhnx0lMyHYxD8at3ySYXSsJT
	3kSxCGqdTZnUizPYJyF16gH/P5zOvJKqx3syfRzueOy1lxpkAB9GbdULY0/e94/RTqskFWA+ZCy
	BGjvA0wapRapW4h5874qfDGGhUEDS2lDrDijS+lx/K1fph1dl4eQRg22W9Nt+9kiAbQtOnjrO5A
	rlJCFIhxP3z7AzLYFd4KwoRT6ZHmLqKI4z6mSfokpzelTwtbZjzJKfgnYeNcUBNSpB5hAFzt0ue
	IQ3mMZc4bqC/Wc6E29aU5Ob0uNIFov+qnCih3zgddncshX3R+o/zPPc89yLhWz/NVkX/gNhknSc
	WT7FSKZJxjx4nHV4GCYFpD+ZA1x+UjYc/nBqYg6DKJIyMvk8JUvI+ye+aUaDtI8c+N4Szi4xY0/
	Mo9ZkDxMOL9jbTk5LXvGDURKMsj1P+o2Q==
X-Received: by 2002:ac8:584c:0:b0:516:35fe:5524 with SMTP id d75a77b69052e-52d5139f5a9mr11184741cf.5.1786390915980;
        Mon, 10 Aug 2026 12:41:55 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908a91e2cdfsm79012536d6.22.2026.08.10.12.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:41:55 -0700 (PDT)
Date: Mon, 10 Aug 2026 15:41:54 -0400
Message-ID: <2bdf79f45c5eb2ea66d59904418081c5@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260810_1522/pstg-lib:20260809_1908/pstg-pwork:20260810_1522
From: Paul Moore <paul@paul-moore.com>
To: Jann Horn <jannh@google.com>, Serge Hallyn <sergeh@kernel.org>
Cc: Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, audit@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] cred: clarify that task_struct::cred is only for the  current task
References: <20260806-cred-nonrcu-annotation-fix-v1-1-5fd149b2ab54@google.com>
In-Reply-To: <20260806-cred-nonrcu-annotation-fix-v1-1-5fd149b2ab54@google.com>

On Aug  6, 2026 Jann Horn <jannh@google.com> wrote:
> 
> The `cred` field in task_struct is currently marked as __rcu, but that's
> not true: It can point to credentials from access_override_creds(), which
> do not get freed with RCU delay.
> 
> What actually protects task_struct::cred is that accessing it is only
> permitted for the current task (except for setting up a child during fork()
> or tearing down a dead process).
> (There is currently code in Smack that violates this rule, but that's a bug
> and causes UAF, I have sent a separate fix for that.)
> 
> Clarify this, remove the __rcu marker, and remove RCU helpers from all
> accesses to this field.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> For context:
> There have been at least two UAFs of struct cred that I'm aware of, both
> caused by wrong use of task_struct::cred:
> 
>  - https://git.kernel.org/linus/a3727a8bac0a9e77c70820655fd8715523ba3db7
>  - https://lore.kernel.org/all/20260806-smack-uaf-fix-v1-1-26426d389a26@google.com/
> ---
>  include/linux/cred.h  | 17 +++++++++++------
>  include/linux/sched.h |  8 ++++++--
>  kernel/auditsc.c      |  5 +++--
>  kernel/cred.c         |  2 +-
>  security/lsm_init.c   |  2 +-
>  5 files changed, 22 insertions(+), 12 deletions(-)

This looks good to me, with one small nit below, but as we are at -rc7
I think this is best kept until after the upcoming merge window so it
has more than a few days in linux-next.  I'm going to merge this into
lsm/dev-staging with the expectation of merging it into lsm/dev after
the upcoming merge window closes.  If anyone wishes to object to this
patch or add their own review/ACK/test tag before then, please do.

Thanks Jann.

> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 7c0fd17f1601..1328a2ceef4b 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -476,7 +476,7 @@ int __init security_init(void)
>  						    blob_sizes.lbs_inode, 0,
>  						    SLAB_PANIC, NULL);
>  
> -	if (lsm_cred_alloc((struct cred *)unrcu_pointer(current->cred),
> +	if (lsm_cred_alloc((struct cred *)current->cred,
>  			   GFP_KERNEL))

Just a FYI, but I pulled the GFP_KERNEL up on the line above while
merging since it now fits.

--
paul-moore.com

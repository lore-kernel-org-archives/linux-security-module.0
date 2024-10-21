Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D071FF058
	for <linux-security-module@vger.kernel.org>; Mon, 21 Oct 2024 23:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729553993; cv=none; b=RLsQhkmvWTjuSpJhBlnkHD+seqXtK9oZKPUzCYWi+bRsLmhoRcUEBNWPJM1Yd00R2JtNSkwxYeRJO7b5bO+GQHvuAIWehd8K1mbdwfHGOsOoOuACuCOSIaXEJaNfbs8TEwPhEL9xyZ9Y/Np3n7lEVBol9B7/6C8368iCMQWyIv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729553993; c=relaxed/simple;
	bh=9Mjk+knGxo9nQGglniMu8WtjiPcCZiTfSPn+6KQqmgY=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=sfTZ1f+MQnKXTIzFIWs+vC/Sy+eDiqjApR51YX2BGQgxfs9/0hO7ilLplJcZ/V89lbGFzn7tguGADbxNKSgXrUn96/9OPD4DRS1IuMwsh4G9HrCa0ZLWOHEixeC1gVeCZCZ2PqyjWhXBCC/0rgNPzgJ3j5rLza0oX5ZFVuJ3/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=B4FRDqRK; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="B4FRDqRK"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b158542592so293069785a.2
        for <linux-security-module@vger.kernel.org>; Mon, 21 Oct 2024 16:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729553989; x=1730158789; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5e2lRCBhF/0lrzI1nrw+s1eH3A9IyPYDFt7tmHKeZEQ=;
        b=B4FRDqRKcaXEsQ//LBESnkawFmz/cI2L8teK23drofWiu86po54i+Jmpgw0/dFNdze
         YQCu1kUfCGmgBgvwV0yAepGWwGWwfxf3x/ebdrE/kRYvCytocfehOmw+dpLludhxI2DQ
         D/BKYp5q5VHz9Vo6sw2ITl5PvT2Dm3Xc0kn92xekAY2E+uMIO6eTKI60FcFQO4eGUT31
         OUZwJkyBDdfmV8HOqqyg8UXmc/5vzIFEESga7lB0uJWyQCydBW3U3KVwd3+e2E4LQgQ7
         ITjgpVIgQ/2d+WElpNBfZK/TN54B6wNxU59bYyX3G6N2H5WSfuZHVcD/30USnOEkkyY7
         15rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729553989; x=1730158789;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5e2lRCBhF/0lrzI1nrw+s1eH3A9IyPYDFt7tmHKeZEQ=;
        b=FW8hVpDQdYIjLZZwEMOmkjfDNlrCYsCyuzC6K6PQbWSCDNK9XxXgTQ4IXiYibJaRGt
         LG0ROYNwtq5+WfG/M9PLJ5d+zRWwFn8uPREQXiPphO24z2WHrOkgZyyjNjFXkRGAxd6o
         Yl2zIaiqGP0OUNQGT4FPU0Zyi8Ec/3eMq5azOlNIwvj2nvEidag7swnqndwl9lP2dLQb
         eDlOdfKHg4335APthGExtadH24CtUeVAE0el3UOhJ1D3JR/ygkJdh4fJc+OY81T0K+41
         V2TnxLT9EgeUcUHcitOlcgfp2baAo0huTbMJCpn6OTUOtsdnEGbyKf6RKFrrbIwrLrGf
         CBUw==
X-Forwarded-Encrypted: i=1; AJvYcCXnw654dayEkSWzllPrk39BIHad4wYXOgkhq/Gv+cVImDkcwIAQmO4yuYpt0Lom1Ktiy/7EyJ6bD+1J7ofSZIkLv2pynzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFDIWpwUIBrZXEZjgdIIcMdAdFc04nE9AQ8BWoTNta+61F2CEo
	DNuHnabeCO07uUDq6HU6GMyxOlY1A9Hg2EoBGWhRkY2pN3L1/PYn91htFReoog==
X-Google-Smtp-Source: AGHT+IGc+EQuKBMmGMWGtVywnHwWIVFIhDEjXA67LbbrFi385rmMBG2jWd5aax6vHPWRTUq/OlgvAA==
X-Received: by 2002:a05:6214:44a1:b0:6cb:9b65:5c75 with SMTP id 6a1803df08f44-6cde15d2f09mr209558626d6.32.1729553989320;
        Mon, 21 Oct 2024 16:39:49 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008fe843sm23160626d6.45.2024.10.21.16.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 16:39:48 -0700 (PDT)
Date: Mon, 21 Oct 2024 19:39:48 -0400
Message-ID: <dad74779768e7c00d2a3c9bf8c60045d@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241021_1626/pstg-lib:20241021_1624/pstg-pwork:20241021_1626
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, linux-integrity@vger.kernel.org, netdev@vger.kernel.org, audit@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-nfs@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v2 1/6] LSM: Ensure the correct LSM context releaser
References: <20241014151450.73674-2-casey@schaufler-ca.com>
In-Reply-To: <20241014151450.73674-2-casey@schaufler-ca.com>

On Oct 14, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add a new lsm_context data structure to hold all the information about a
> "security context", including the string, its size and which LSM allocated
> the string. The allocation information is necessary because LSMs have
> different policies regarding the lifecycle of these strings. SELinux
> allocates and destroys them on each use, whereas Smack provides a pointer
> to an entry in a list that never goes away.
> 
> Update security_release_secctx() to use the lsm_context instead of a
> (char *, len) pair. Change its callers to do likewise.  The LSMs
> supporting this hook have had comments added to remind the developer
> that there is more work to be done.
> 
> The BPF security module provides all LSM hooks. While there has yet to
> be a known instance of a BPF configuration that uses security contexts,
> the possibility is real. In the existing implementation there is
> potential for multiple frees in that case.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: audit@vger.kernel.org
> Cc: netfilter-devel@vger.kernel.org
> To: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: linux-nfs@vger.kernel.org
> Cc: Todd Kjos <tkjos@google.com>
> Reviewed-by: Serge Hallyn <sergeh@kernel.org>
> ---
>  drivers/android/binder.c                | 24 ++++++-------
>  fs/ceph/xattr.c                         |  6 +++-
>  fs/nfs/nfs4proc.c                       |  8 +++--
>  fs/nfsd/nfs4xdr.c                       |  8 +++--
>  include/linux/lsm_hook_defs.h           |  2 +-
>  include/linux/security.h                | 35 +++++++++++++++++--
>  include/net/scm.h                       | 11 +++---
>  kernel/audit.c                          | 30 ++++++++---------
>  kernel/auditsc.c                        | 23 +++++++------
>  net/ipv4/ip_sockglue.c                  | 10 +++---
>  net/netfilter/nf_conntrack_netlink.c    | 10 +++---
>  net/netfilter/nf_conntrack_standalone.c |  9 +++--
>  net/netfilter/nfnetlink_queue.c         | 13 ++++---
>  net/netlabel/netlabel_unlabeled.c       | 45 +++++++++++--------------
>  net/netlabel/netlabel_user.c            | 11 +++---
>  security/apparmor/include/secid.h       |  2 +-
>  security/apparmor/secid.c               | 11 ++++--
>  security/security.c                     |  8 ++---
>  security/selinux/hooks.c                | 11 ++++--
>  19 files changed, 167 insertions(+), 110 deletions(-)

...

> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index 1bc2d0890a9f..8303bbcfc543 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -1127,14 +1122,14 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>  		secid = addr6->secid;
>  	}
>  
> -	ret_val = security_secid_to_secctx(secid, &secctx, &secctx_len);
> +	ret_val = security_secid_to_secctx(secid, &ctx.context, &ctx.len);
>  	if (ret_val != 0)
>  		goto list_cb_failure;
>  	ret_val = nla_put(cb_arg->skb,
>  			  NLBL_UNLABEL_A_SECCTX,
> -			  secctx_len,
> -			  secctx);
> -	security_release_secctx(secctx, secctx_len);
> +			  ctx.len,
> +			  ctx.context);

Nitpicky alignment issue; please keep the arguments aligned as they
are currently.

> +	security_release_secctx(&ctx);
>  	if (ret_val != 0)
>  		goto list_cb_failure;
>  

--
paul-moore.com

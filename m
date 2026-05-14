Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D06C3C0A19
	for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778791454; cv=none; b=dkmpeJALiODYsqQC9I1n21SQ6YbDbYUDKz1VQ3QyH+5cGbl4WailAbq/WOzPs0xb1aWGca8PTB7LPmODYm+s831ScmVVwv5fPvktAVvbBcbog/wcE9nOm+YIkXaufxKOzIH0Gkk7iNUNcgYFrbm90H5oPV1BpI7ZF2PSWGz3zcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778791454; c=relaxed/simple;
	bh=bhsOuUIaNixFGUNouO+flDtH1Ol7OJbIIYt+9nRn+ow=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=BjV8UNIrIa4ip3/sriFL+wdkGU1wm93CbV5R5/e5AORbNaZxeveGgfpFyPOxelAHkveOvGrRsN5a5+cgsX/n2yF5maH1UCWQa08FtiMYeV+VsZS9b4No0PL2oWDQPasiBTyqVnQZ6vjKnQwOEpCrfd7J8g6rWsIrDj4H1nhYuHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OSc1CYb0; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OSc1CYb0"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8c921396e37so14076546d6.2
        for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 13:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778791451; x=1779396251; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iIn517qMFa/72Ee/XGTDeeK9Cq6VJiGDpV2GCDJOS7E=;
        b=OSc1CYb0LA2hDiDhS0KeITKEVBykeYFWm5mB0F2ke+6PQDCnTZXwjSXfPcFZ2NjxZh
         Ud8DZ2Pn80kJgStc5aPzDIhYLMhcN1gBuV634XDMewUMWFm1C4TCCf85M8NSRiX1eLv7
         zr2glp2nDXnD4JkJPtYxTMuKBslrojKLiTEHAcm3EH6FwxYhOdc0MwS1z8EnASGXUNdh
         qhqkOHGuzzpUceCeCbvLtRLmYW42xUzlK1M6PLl6EmmgsVevWHKple3NmFdra+FfED0d
         w7cz8MNWx7gA9pA1tPMPQc/OFjkj/Fy1Lz2cu5g15GIezPqAP5ftUK5m0p3AWAzVxQZa
         4dLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778791451; x=1779396251;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIn517qMFa/72Ee/XGTDeeK9Cq6VJiGDpV2GCDJOS7E=;
        b=ImWuAdDP2ZDV17s928XQI7P0Oytoo+qTbdnWyjYU47g80k8TZjahLuTz2dO6jmUkSy
         kDPimZWYArv8PCUia4Z/NidOCROVmYiKEZ6ByULAxTOZa2EJxZR8YmTPxAQWs1Ii5D+K
         cCslb2TBSnuIAFLS6ifL3rmLx/YyZjo7gvgEi8k82it1HLhAa8Tg9a3cpsL2IZIEmJhF
         qBZZRQ1iDOcXZygAbsfee43oUmIFoI++7UV3calls71y+8HUqupzmARrci++4Mya2MTa
         HfF8e+1I5jH7XLWHewDTIMiyWAj76vzmkD0BRGO10uYMni6GzZzu3o22ynOeWKtRL+jD
         ovxA==
X-Forwarded-Encrypted: i=1; AFNElJ+l3Rb92AU3otQXQWbPLGZSL+zsnGK7e/Ba+wTRQCJWqTm4aD3gtWzPSSPGWmikhQZvPKD64Q89of3kYAewyv74txLuKBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWdhy9wH6LvEck5Mxs4/1wjx0pIDVNGbDNHZXRwsOjbT1QBYPw
	JGFP4W6l4Ff1jxGX/0CDwfV/b9YYvkBtTEb8GRsRAnq9GCruakwjLBuLB/Nec4WQPQ==
X-Gm-Gg: Acq92OFWsV+HsW6mXc8EGOzU45A8EEmdMtN2v/A0kfYB6KbcpVRq5Ryg+b13Vb35pVW
	kc5sLOIz+6+bL5r10tyxFbWyDuGQWwX4HFZZLi0EQ4BysmpMTZIujo3fb/cMPeZESshKNvU0sI2
	4H5vuTXHFiQuVPVK1GYAgLYS95UkGHw45TAXX3yJfpaJEW5YFoOVLaWQI62J2Ze8TvSHoUwQzaM
	62FDlY0LIcawGgJVYkO7OeyL1eGsP/qLHupy9khAzVCJ97pdtStCfZ7+AejxQGmep8gB43K+PYx
	RQS0gigjqCWPCZX5ZeHYqhhGbRi16CGo87jKF2YpA9/FD5C726Le5uHSWKx7yt3Sl+aW3LGEyu6
	9q/Q2GnFJ6VwdhzSZ8TMLL6mLMgf1uRgjkszej4beVmAumP4/JAAL1Yu22xKoXnuRDcDapD2DwG
	tTFJQNOCzEO/ncqsTES7+CrF+r6dSmANgTURZk6INAjwnOK/ryNANONhN0rqGsjOt8uelPhpgrK
	duRGos=
X-Received: by 2002:ad4:5e88:0:b0:8ac:b70c:8a9b with SMTP id 6a1803df08f44-8ca0f70f697mr20146116d6.44.1778791451056;
        Thu, 14 May 2026 13:44:11 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c358539sm32474826d6.41.2026.05.14.13.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 13:44:10 -0700 (PDT)
Date: Thu, 14 May 2026 16:44:09 -0400
Message-ID: <16093a0278a6d7d1a0a8bc055c228bed@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260514_1634/pstg-lib:20260514_1359/pstg-pwork:20260514_1634
From: Paul Moore <paul@paul-moore.com>
To: Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Sumit Semwal <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, Christian Brauner <brauner@kernel.org>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Albert Esteve <aesteve@redhat.com>, mripard@kernel.org, echanude@redhat.com
Subject: Re: [PATCH RFC 4/5] selinux: Restrict cross-cgroup dma-heap charging
References: <20260512-v2_20230123_tjmercier_google_com-v1-4-6326701c3691@redhat.com>
In-Reply-To: <20260512-v2_20230123_tjmercier_google_com-v1-4-6326701c3691@redhat.com>

On May 12, 2026 Albert Esteve <aesteve@redhat.com> wrote:
> 
> The security_dma_heap_alloc() hook allows security modules
> to control which processes may charge dma-buf allocations
> to another process's cgroup via the charge_pid_fd field of
> DMA_HEAP_IOCTL_ALLOC. Without a policy implementation, the
> hook is a no-op and the restriction is not enforced.
> 
> On SELinux-managed systems any domain with access to a
> dma-heap device node can therefore exhaust another cgroup's
> memory budget without restriction.
> 
> Implement selinux_dma_heap_alloc() using avc_has_perm() with
> a new dma_heap object class and a charge_to permission. Policy
> authors can then grant cross-cgroup charging selectively,
> for example:
> 
>   allow allocator_app_t client_app_t:dma_heap charge_to;
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  security/selinux/hooks.c            | 7 +++++++
>  security/selinux/include/classmap.h | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0f704380a8c81..ea1f410b9f619 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2189,6 +2189,12 @@ static int selinux_capable(const struct cred *cred, struct user_namespace *ns,
>  	return cred_has_capability(cred, cap, opts, ns == &init_user_ns);
>  }
>  
> +static int selinux_dma_heap_alloc(const struct cred *from, const struct cred *to)
> +{
> +	return avc_has_perm(cred_sid(from), cred_sid(to),
> +			    SECCLASS_DMA_HEAP, DMA_HEAP__CHARGE_TO, NULL);
> +}
> +
>  static int selinux_quotactl(int cmds, int type, int id, const struct super_block *sb)
>  {
>  	const struct cred *cred = current_cred();
> @@ -7541,6 +7547,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(capget, selinux_capget),
>  	LSM_HOOK_INIT(capset, selinux_capset),
>  	LSM_HOOK_INIT(capable, selinux_capable),
> +	LSM_HOOK_INIT(dma_heap_alloc, selinux_dma_heap_alloc),
>  	LSM_HOOK_INIT(quotactl, selinux_quotactl),
>  	LSM_HOOK_INIT(quota_on, selinux_quota_on),
>  	LSM_HOOK_INIT(syslog, selinux_syslog),
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 90cb61b164256..d232f7808f6b8 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -181,6 +181,7 @@ const struct security_class_mapping secclass_map[] = {
>  	{ "user_namespace", { "create", NULL } },
>  	{ "memfd_file",
>  	  { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL } },
> +	{ "dma_heap", { "charge_to", NULL } },
>  	/* last one */ { NULL, {} }
>  };

While we have seen some one-off patches to add specific resource/cgroups
controls in the past, much like this one, we've yet to see a patchset
that provides a more comprehensive set of resource/cgroup access controls
for SELinux.

I'm not opposed to a patch like this, but I would like to see it as part
of a larger effort to introduce access controls across all of the
existing cgroup control points where it makes sense.  In other words,
let's see a design for cgroup access controls so that we can ensure we
have something that is meaningful and makes sense from a policy
developer's perspective.

--
paul-moore.com

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793138072;
	b=hlFCC1LS+ktM1wcd4j6G0jf/YqT+NrK2AMcSzHHHa1SHvLNKQFLxBXsSq3v+5UgQnWQJ
	 wbPKdGYWVzIhm0yKzB4Yy+IifH1tOh0DXOJpK+MuD8ehUvad+A8grIO0ljDxPusL9G+Jm
	 re0ntSZhGR25SwmSLad0lvSgDlCrsQoL8jkP4OY8zUibvNtR/HSdvG/TE9heqzKR0DiT1
	 uYE1jIEQFq71ZSfJ7XMmXdzSh69QtDmYnszAqos14NaWVUV6r0h9GpVRwoFeCCgsduL8b
	 m/RIkkRVESS3neX26u3rDsi5ah0ym94AhdTZvw0wT+0BbEPE4eLbyPBOHlTzDbEAYgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793138072;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=bCCkBw+sgGKMHO3jZN/+vOo9DzF5rZyDIUC1lptCGuY=;
	b=i223YysbeH0NIiepLqOvjGMpbH+VaLnwWMNyIGSvjFLmAiXty+TmFUBE/fWTL/Wn9KqA
	 wJY8imKJRzidMFxdiyCTV2/eGiKn71Bqcd8SIOrpNbMDu5mOqcaUUotbVEtYzCrDFh0Vp
	 2NwEs2mwA7YwTn62T0f9pk4zb/wbJrZNO0kEEL6FoK33J7N+M6VDqmQpac4QHSSIEXSx8
	 nXn5o3tRHD5GVoECs3tUf8eYnguckB/enrPQjSZ+F6+ZuDCsOXMYtjQkSFA/hO3PZFe3e
	 aqS6n+vDoH05aiKZt/5nQEmb82Q8sYCihhBt2DeyDAM4IexKz/dqhoHPBmtrvs5pxYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=OzRtD8Nh;
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A80606A31D
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 21:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8A80606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=OzRtD8Nh
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 729643FE5B
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 21:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1793138070;
	bh=bCCkBw+sgGKMHO3jZN/+vOo9DzF5rZyDIUC1lptCGuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=OzRtD8Nhv+0dcM/Hora+CjAxGpFapOJWISlw5KbRVHKLf4ALrHVCAKdiWjGW9v8F+
	 tSwf8q1jACfKZE8uDLtSxbEWIxsIN1F6L318ZX6YWgirv2GGfNFdNTfUsmBBCBemz+
	 UZ85TWS/a8Lr+Oky5PYe7arEb8vdCoLb79jN9Q36z9Fuu7vOJwBnjHqx2HweWn+Kao
	 eV9hLCs/rgrqEg6vvnlj5NmPa+WckrBpq/ILKpJemc4q2xUIHpVWJTu3VPKVkETJAu
	 Xe6R9/+2X862opY+41RTQjM8/5T1tUdIM4y014ZVW6pY0iGs3d1ZIAFPPmuYscQeSY
	 5Ih8k3mu+F1IPqVU63YB6xbkl6G/lYSBO17a73DMYlS8Kq+qMTrrtr6CPnyzckncJ/
	 7ZoM7eZegIfdr6PFdZVTFVAwlhk7UGVD2DsojyvibWXLGpDOZjc0Xtn6YpRfv6stEZ
	 5rzQNnij+ItAs5InAqwJbXAJN84zHPJrFZwC9F4PIyMnWvd6QZstl979/iYz6Xk7Jf
	 CzmzNd+aYOeesSEsrbScdzBxifoYfutNKLjLF0fOBLsRDI40TJUhpgGEreBTEK9d8S
	 +CqIQlc2CVfii4hCO66rd1jAowl9NCJlbRruaZDv/NsIiidlingXPAMHSLay/WNiTN
	 ViWBA/hVUXtqswEglnwrp9ks=
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-6790b1d3bc9so674636d50.0
        for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 14:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793138069; x=1793742869;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bCCkBw+sgGKMHO3jZN/+vOo9DzF5rZyDIUC1lptCGuY=;
        b=xwnd32PPoh6Lxo1DIXbMFqdMSGWiqK7f/0IAOJsilLT3VAr1M3GKFsONgDL/HfVS58
         XLgWIyZDA6Jh5C96qOjNvGGjPP+WtJpAZ/BW1Nx7ojXJ7z5dJtAMYPahNGyNJhhwf87F
         3FKhPA2n/nkqvBOeDrOjUrs83+tECi4ds81c8Lppt2SB6t/Uc5g0VehwdAQm2Gjd2ziu
         ttO579OPib2RdXx7CHI6VAIuzGoMS/OTu2Jq87sWWsNChsU3uv+diY6DC120oRYcp91I
         rqb4/R+JI1DIk6IVVtfycx3/Vj1XNwd8ayW36qXwselSA3TUjAIo0VavQ6xFnGx6iAiD
         znQQ==
X-Forwarded-Encrypted: i=1; AKwUvBw2P50JAcKTz2zHCbGLNsbwHzjSozYb7a6wyqEOKl1XpUds2sCW2oRn/fbw/EWm1ikcgZIp7GDNVtMSWoV9xhMbuJ+Wy6I=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5wvKekR65jHz9yHdsk2vG6xfEUp0dewb4XQxh7MlCgH2pTPm9
	iAwcwftyREVkikePHuzd1Yfck4ScuQFImORYE+VaDGo8hjcha+jwxbo2WDu+6W2ewsfNIoQhX/t
	CV0nE1N2X2QNiuTOj0u6MmP/9aymPyaPTMP1o3S5/O569Q+aH0DGVz89T1cN3IGHtBkZqyeQpgc
	38Od2PFzHQlfsvf9+6Kg==
X-Gm-Gg: AYBFou2ltVexIYofzMToeJJJuWszeRh3s6ckM8g3DqSgci4BLsQCJwTVklXkRaz5sMm
	dIMPfTUEZc9h1vfPwQLFYzW5ZeFeXRMk20ay9JxNtquGYi+YTDgUHQr9dBOxxOWqVHF6S78Nccl
	4fB5Gp7eHmQkZeHrXTwy2UrgnjAtYwUDaXMZi44/ejBtswMfHshh0CQvcYxJLASpOQ3+YAL+4Lj
	rAL+pbzjmr+6K3PDXDuLHiHOe4hRxA41NjeUMVtAO+IsMP7j+/+uEQAvXfowqwo1pm2t6xriY/w
	5aecbifV71rKhrSY8KzOio9m04RZkId8SzfvmwaF9btbXfxpt7kd7DwZIUU4xKDbsWBRp+0Du6G
	oZPsuaEeAUQeCQXtwfihbCS/pT8vSPE+pnZCPptxa0Kx/6Y1htn3/ruFD
X-Received: by 2002:a53:c712:0:b0:675:47ba:21a4 with SMTP id 956f58d0204a3-67a7bd3e821mr594842d50.47.1793138068758;
        Tue, 27 Oct 2026 14:54:28 -0700 (PDT)
X-Received: by 2002:a53:c712:0:b0:675:47ba:21a4 with SMTP id 956f58d0204a3-67a7bd3e821mr594831d50.47.1793138068457;
        Tue, 27 Oct 2026 14:54:28 -0700 (PDT)
Received: from [172.21.9.52] (host-209-35-187-178.broadbandcancun.mx. [209.35.187.178])
        by smtp.googlemail.com with ESMTPSA id 956f58d0204a3-67a7a0c31f1sm766291d50.11.2026.10.27.14.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 14:54:27 -0700 (PDT)
Message-ID: <1fd1c075-96f7-402f-abb1-0444c8df08fb@canonical.com>
Date: Tue, 27 Oct 2026 14:54:26 -0700
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH security v1] apparmor: fix a use-after-free in
 aa_lookupn_ns()
To: Binbin Deng <18983559317@163.com>, georgia.garcia@canonical.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: ryan.lee@canonical.com, cengiz.can@canonical.com,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260923054623.247634-1-18983559317@163.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260923054623.247634-1-18983559317@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/26 22:46, Binbin Deng wrote:
> aa_lookupn_ns() takes a reference on the namespace it finds with
> aa_get_ns(),which is kref_get() on the reference count that the
> namespace is released through, without checking whether the namespace
> is still in use.  A concurrent removal of a ":"-prefixed namespace
> looks the same namespace up and only then takes the parent lock to
> remove it, so the last reference can be dropped between the lookup and
> the aa_get_ns() call: the reference count then reports the increment on
> a zero count and the kernel classifies the following use of the object
> as a use-after-free.  A user with CAP_MAC_ADMIN can trigger this by
> writing a ":<name>" removal and a ":<name>/<profile>" removal to
> /sys/kernel/security/apparmor/.remove concurrently.
> 
> refcount_t: addition on 0; use-after-free.
> WARNING: lib/refcount.c:25 at refcount_warn_saturate+0xc0/0xe0, CPU#6
> Call Trace:
>   <TASK>
>   aa_lookupn_ns+0xa9/0xc0
>   aa_remove_profiles+0x4fb/0x730
>   ? __kvmalloc_node_noprof+0x219/0x5c0
>   ? __pfx_aa_remove_profiles+0x10/0x10
>   ? aa_loaddata_alloc+0x65/0x1f0
>   ? _copy_from_user+0x2d/0x80
>   ? aa_loaddata_alloc+0x111/0x1f0
>   profile_remove+0x2ee/0x4a0
>   vfs_write+0x21e/0xcf0
>   ? rcu_core+0x29c/0x1740
>   ? timerqueue_linked_add+0x1f4/0x3d0
>   ? __pfx_vfs_write+0x10/0x10
>   ? mutex_lock+0x81/0xe0
>   ? __pfx_mutex_lock+0x10/0x10
>   ? __pfx_rcu_core+0x10/0x10
>   ? __pfx_hrtimer_update_next_event+0x10/0x10
>   ? mutex_unlock+0x7b/0xd0
>   ? fdget_pos+0x24d/0x4b0
>   ksys_write+0xf7/0x1c0
>   ? __pfx_ksys_write+0x10/0x10
>   ? restore_fpregs_from_fpstate+0x37/0xc0
>   do_syscall_64+0xf9/0x540
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   </TASK>
> 
> Fix by rejecting a namespace whose reference count.
> 
> Fixes: 3664268f19ea0 ("apparmor: add namespace lookup fns()")
> Signed-off-by: Binbin Deng <18983559317@163.com>

I have pulled this into the apparmor tree

> ---
>   security/apparmor/include/policy_ns.h | 16 ++++++++++++++++
>   security/apparmor/policy_ns.c         |  2 +-
>   2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/include/policy_ns.h b/security/apparmor/include/policy_ns.h
> index cc6e84151812..4f8359875476 100644
> --- a/security/apparmor/include/policy_ns.h
> +++ b/security/apparmor/include/policy_ns.h
> @@ -117,6 +117,22 @@ static inline struct aa_ns *aa_get_ns(struct aa_ns *ns)
>   	return ns;
>   }
>   
> +/**
> + * aa_get_ns_not0 - increment references count on @ns found via lookup
> + * @ns: namespace to increment reference count of (MAYBE NULL)
> + *
> + * Returns: pointer to @ns, if @ns is NULL returns NULL,
> + *          NULL if @ns is being freed
> + * Requires: @ns must be held with valid refcount when called
> + */
> +static inline struct aa_ns *aa_get_ns_not0(struct aa_ns *ns)
> +{
> +	if (ns && aa_get_profile_not0(ns->unconfined))
> +		return ns;
> +
> +	return NULL;
> +}
> +
>   /**
>    * aa_put_ns - decrement refcount on @ns
>    * @ns: namespace to put reference of
> diff --git a/security/apparmor/policy_ns.c b/security/apparmor/policy_ns.c
> index 5a907a875d8f..ae9168c1a85e 100644
> --- a/security/apparmor/policy_ns.c
> +++ b/security/apparmor/policy_ns.c
> @@ -207,7 +207,7 @@ struct aa_ns *aa_lookupn_ns(struct aa_ns *view, const char *name, size_t n)
>   	struct aa_ns *ns = NULL;
>   
>   	rcu_read_lock();
> -	ns = aa_get_ns(__aa_lookupn_ns(view, name, n));
> +	ns = aa_get_ns_not0(__aa_lookupn_ns(view, name, n));
>   	rcu_read_unlock();
>   
>   	return ns;


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793138040;
	b=wLMpmP8ZcCo4h2zzv7lpr8O5R1M69PuyBcwKad4ewQR4Rxkdf0UGLJN5UgRvvFtFjbmM
	 oiD8eV8XSYkbOBmqpE0akRCjwvQUo0AhX+xGSmohp/aZvjSAmVqquqC1OLmX6Ssynytwn
	 Mrt8cemuP+XSdDvkWva5xL+Et3gPGmtP7ZDltts7bkuQqEpdXc+zwkIajfjMeGZrrBD/a
	 GPjEeXbSyM0CqRC4wmtWK+de0WFe3SGbo+Y5RwMITOx3TynGowgQtd8r1cYMg4+Vqxsrr
	 Ky7PfUOjJPlvm+ctydRuT/i6AMeiITeB3UBw7JsFIr29NHzZUVbMiwQggYCTu3aUFoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793138040;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=AD/k9cYbXEiOGzD9V0TQmHHppOTOq2qhcSCOEe0VlIw=;
	b=l6klc0eBuSRR6SNa4hQzh2sG4x9RpV/NP7SyAby+NGGbTp6MMWOajzFF5mMvTWi3cu5w
	 98dEXfnwymOMh1+0evLLlq02aUJQIe1cTCqdfcT0zUUUF70nXUReUGVaDYYODXb1pG082
	 xgFTbDmZ7ths64QHRYtqjoizTVDW0m6NCnGsP8r/2cydoQte6nv6+GV4+Evj6VkpYhomA
	 QTbOUln8A35vM5rP/AuZPYDDkcEZojTzK1s5jd5nGiW6rpRbB0UhRtakfl9vMZjTZXnFD
	 ycsSC/iTmPtaVZmFuxESWPFviyw/4pWfqlp+jXSKA8Ija7+ygnyQluPxo8oGuBmVZcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=Hi8Tpv4+;
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEC1606A31D
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 21:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAEC1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=Hi8Tpv4+
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5021C3F98D
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 21:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1793138038;
	bh=AD/k9cYbXEiOGzD9V0TQmHHppOTOq2qhcSCOEe0VlIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Hi8Tpv4+mEIZR+uibZ/eJlatjt/pbWJ1EjZ+Mti/qnYLY3cqKIlAstOaLllf2Z0Az
	 7iRZPfm34UL23uGSAiTyQH29uEdBCe1l7+fRIYxuUt9/RuMh1+Wm8BOgnLtTUdxfaQ
	 MeUbVhg1OvPVP5yJ9znFZyD1p0MY/4uIkCWhnjpicqD0hN3TuwW9GEL2E+I/dQPS1T
	 mP4rCuWF5UYvgZBrxeMmmlW8G2GkRuRxBH+uI9jODOLPHTQ7XTGgWZyHSQrn0InDP4
	 MMwSqlesAThVyBKQhzR3Ec/T5yHxWGsYRpODy29DVx04qDwZc8J7OohL5rh7MBEa3b
	 53XYZhw5t9xiA+QZ0HjzcLS9i0lpYXOXbxR4RVx26nl+vH1AnSZBUlbcm3fE+jcp6H
	 1oSC9pvz+Jp8wGpDXA9KSCg9TzKNOFm5wWLiKlQagiDHkOje7O9kzcsibgTJnhwOFl
	 LJfJA/KcBh42Wo343ibWVUWlJ0TD+fO9z0xgGECteN6ytKrqGyQogdI08Y23oyXsuD
	 ym0KTqVgVZFiohprmfnbAH77+yYJUwpJN+aES8eLezy4euRc1EJQiTYp0HLjH7OY10
	 xT1YX+t/BE+5G8DVxvgbOrinCDi9uxVS90s22B/t4H+/KSwn8Bx59Og5wuq6acUipL
	 dOgBxiKEqXJEdn1BidpRFSjk=
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b0e878f574so7169687b3.1
        for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 14:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793138037; x=1793742837;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AD/k9cYbXEiOGzD9V0TQmHHppOTOq2qhcSCOEe0VlIw=;
        b=oWiZj8y+rbPttDkuNG8hZIzOawLA5NJosJSVO6umDK0XidcR2bxiWlJRfDrXdW4XrL
         XVb5UcDj0lcekGz3Jff0PPTdOBKkskCxEJTgBxDaUNoPNjA4+UxWm14B0yLtxEyONH8m
         1kdbn+h64S8y4nJJXrpck+77vrvBrC4BWLxRN5Hp311v5UAKREZG9zbobUeLy2M+447Q
         RA8Ka8Uv6JomsyFqd8Ba5+jXvKTGqTgKuE+1UEw5tdBZdo8Ljk/FIpGBXcO5/XX7SOy1
         Yan1UW+FSex5ffXFeHQJfo1xo2uHUzQfoS7KGKh9sZPiXUY4ob/bnb0lY8hZzJgD5drW
         eLVQ==
X-Forwarded-Encrypted: i=1; AKwUvBxT6Xvvr/wkHix4hSXN9dTIj1rwoP5e5IkuhkepgVeYqkwqvJUNopi3pPrY3ygz5RfPGVy0yBmjWahJqXe9t2mPhtirPUY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjMd2ES8DwhB362zhYhoGeHMSnSaMWnln+vOfFI6vjc1twXfI2
	ycWnqzGFC6Iz/EZq/lZdpf4zReHfCRJVxZMSLPeH/tuaesAsxyzR1WIe97bBlCWYKxV+M8Gtr4F
	OoIgGVj/rUUJ660/xTJoRFGw7yw3pFbLnRYjsPHA+x5I9eS35/LANgQPdBUikr7dIjPZmb9KbZQ
	EhFwbYh+4E8eRmWM9usg==
X-Gm-Gg: AYBFou2L58d1IQYPTvx7OegRNZp4Krm/xvl3AJT0vbV/B6Wn/YO7EjgpsOFgx/Bu2aq
	6B8+jV++qUHEqvSidC00Kqp0CmHIVi4Iit862na8Vr2uYyOemYoMXWO9GZdJtpr71C0HRCslYa2
	RHtbzzRHkdkbvQyooB4ABdoPxZW/W7BttlI9Up5arpwCW/AYZTyxqMVE+vatquR5cF99TDC8+2n
	vcD1YO/DnLp7fARN5BtM3KMSK9E4NdYGu/6/grUx2iCIKUkQ7WoTCATxaC6vdNXeqTnmYQ9ZKqj
	4y37zQ4KPlQnzIRslkTRqOg3mDWH/FTim4UOROFYxqCEiw/j0irJNCQYshGAklTA8ECsC/oul/R
	PUVf6TWmfReswIKXiPAx5+fIXRmiSvgVASq6imqGcycMEwdaGBkPramQ=
X-Received: by 2002:a05:690c:698b:b0:8a9:a1e9:2665 with SMTP id 00721157ae682-8b19c9c4d40mr29476527b3.6.1793138037122;
        Tue, 27 Oct 2026 14:53:57 -0700 (PDT)
X-Received: by 2002:a05:690c:698b:b0:8a9:a1e9:2665 with SMTP id 00721157ae682-8b19c9c4d40mr29476347b3.6.1793138036785;
        Tue, 27 Oct 2026 14:53:56 -0700 (PDT)
Received: from [172.21.9.52] (host-209-35-187-178.broadbandcancun.mx. [209.35.187.178])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-8b19e53e20csm19210517b3.13.2026.10.27.14.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 14:53:55 -0700 (PDT)
Message-ID: <4b75bd04-d82b-44f6-87ad-c18225146a73@canonical.com>
Date: Tue, 27 Oct 2026 14:53:54 -0700
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

Acked-by: John Johansen <john.johansen@canonical.com>

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


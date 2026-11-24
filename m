Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795528213;
	b=gG8w7nrTSI5huywVouefAoW7YCPMPT/ew5cIrhaTkq6MtBL3vU7ETfmn19K6D6k5mtnS
	 0TpqJ+rMF8g27z/ubPMOIvNJBTg8dtzcUvJpvlsodE1kDkgd2e8YOR9krW6kkBCVbfcsC
	 fSdIT7KVwk26g+zp4v02QbKLtvHlHMBhhHm1GANl8VuKBR0rL1q83bhfkVX2eOiTI0g/7
	 x71jo2A89Us5M3x2Y1DZhA9B2zxta4/9K8TJo+tgfI6Y4nwT3TpNI/I/j4qvEBZxmTywu
	 rca9JylM24Lkmrhyi81ldHVz8zQSEadCYBzNx7NDcsY/6Wws9SIw+EO6VG50ntVbm/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=XTPCHg4unEN6vtUDvCIgxfYMZVabwQIC4dv3+3CL15w=;
	b=PKj9OT294QXmcEaegGrmLUEwHN5ClfhMvHE8PaeAgs3cDBgxvMT33O5HTBmlwZXIxwIH
	 JhnUvzLLtQmdRHLIFtFAAKabbyI/h0uELdnWU51c+P7IWPf2ciPldPMXFlOmUuJESw95+
	 MxjF3YokVr73fTCUp7sQEy18zI+y9hWZsrMXV84Rv+fv87EWC+2WhVNrftHKAHPPrGHjR
	 qvew+PhgiPYtaq62Lc+Gc5dLpjaqT7do71A2+tNNFmWp40nxLh3fxg4oTAli9OflXtpm8
	 Y9Gcm8iyjMAxXxxMlY+QkIYM0z2WhbruT8mMngNgo5WlH9t9lvPGdHt1Fo0qg6nDO9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=A8I4Yhd3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7F8606A327
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 13:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F7F8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=A8I4Yhd3
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so38147425e9.1
        for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 05:50:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795528211; cv=none;
        d=google.com; s=arc-20260327;
        b=Zsk+1AvJRdru2ZdquX9lVPMx48xOTSAkTvLt2TWtjmq3eVyuBk80XWVXEiGicK9kDA
         IpQh6Zcgeu5OExEqafxLhjy5FtgKLl3MdUawo2zHS0bPXhQJTY962JHyCes9wK85Dy/+
         kWKzzrU/QQc76wjgJMRTGzsnO7Z5LdCm78K6zHK5dY3GLvj6M/Q8MkrvOocq2bjF4/Le
         LY6yC7MzqATm2jUJ2rTyGxroDLYoJYyqm/Abu3GmlEZO+5YVeWiZIsyuztQowtV96KyP
         a+TLDuKHBSGqtKmY9BSpGYnWqE6eCDgbtQSsHcVg0XIJI+VANIahFfTu7SnN4NK+CKcM
         x8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XTPCHg4unEN6vtUDvCIgxfYMZVabwQIC4dv3+3CL15w=;
        fh=qL/9oKx8osqkjP8U1qQrhxi0pRO8QfrgrDsAtvH+q3A=;
        b=NHd/cekrlXKD/0GQZMHTbC9l8C4RusvcBXqLtIfRrw6o8jJRQ3ThRGx0/rgFj1dtyC
         7/tpEDA1BML/9jiLb/zDjysVaC5kpP1hflQ1Tw365wNnfkt96xIWpNKjuDBC1hY/Ky6T
         iGveSxZfV6V4YUgRiekYyR8TWMGqzB1ebOjcOgQSD5queVSSkRyMLhYKVS+EzvyFpK0X
         X4ahyqJcSJX7KeindHeni2+R4iR57zcFJQ57rZadhXIAHtFSU58QKE8Y5SbZppjmXwfF
         JoJZIR4hdmASUXcZ2PVY3yEqCM9lURW7ztNhy3qJNXaBXFZq18LXKBvCqDzNkOm8w7wn
         Nusw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795528211; x=1796133011; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XTPCHg4unEN6vtUDvCIgxfYMZVabwQIC4dv3+3CL15w=;
        b=A8I4Yhd3hz3WrVqqp6QMzsDrRJ3HJpUPxahpoSPUafEcj3SFymXcsAZEIf+a8ALG0Y
         V6s6xA+Ay4lWI9NhS7nxfL6F29mbmiE0uOfCYQxnOZUS20qgiOGqYoApJy9HRpK68tu/
         HSDE3IpIQJQ4GKB5Z7mVIff3PBnaum/E2gzkgJ+jFNG6YlWz7P5hX0VEOjoFbkoF1lDn
         8Ndrqr7MabRwOciYR7MGfzUJA7NWdJsl6TU8hPnym7YlbmO7JaMnO34+0kr0IDyXTgzd
         2RYMtv2kGAXDO2iT8hQ8hVHgIcSefON4ja9k6LVugyoh7mCZfqIgxnZvX+r5RFBAMb5n
         NOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795528211; x=1796133011;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XTPCHg4unEN6vtUDvCIgxfYMZVabwQIC4dv3+3CL15w=;
        b=zHXo7pdTPQY8nUc69M91EqyotG01lTzFzd2vj1TKuB72PGCmvfVsCF585FlZRCWppj
         3GvHy7DEuXk2hDWKkhb9hKM2MImYoSgv1XNyrfAvvVMLC0Fxx/XoW37wgvpGOWdS0fgZ
         Vlz9a0jdro6C0edz2Hp1/y0Ox+XGPkVP6hU1mPLynKMAX9HzK1nHK0DwqYo/XPdjyJ+m
         84W4ls0z92azs0kgDWN//8ACiBtlS3oo3RNxw9yy5PGYmr07aoStHobCrB6s3bMPY3nE
         Sn/SwQcQ+w0QDtxKuyu8a+hcherEJc+aF515TL806fB0hUAmQ0rOOEFd5tvQOTxbtJLb
         AI1w==
X-Forwarded-Encrypted: i=1; AL+hErFvYOR6e8yJjF5Jn2Gw0RQPxYoUHhm3aufc2Ou24YuS4n6+JWwSs91W8INSYYJYhq7orjluhtxUeDnVGpNJo+eQ017cqLk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hH4jx83yROjqgDMD+hNZQAM3kkZY2Teoyzq2wXFyW5ZBDWEdj
	MrRPyFfpFQXCfyyywoHqtULpWgqhMtxdf2sj82sf7n0lWka5thSg/1fGcxI1K5SvdtUz6Wzsm0y
	ShCjjAUGe9dcv5dmJdUgHjFZSbl+LlcU=
X-Gm-Gg: AZFdTZf9TI9LeyQAKfBmOlJbisuts9V90c7OL09wyr01pXAnI0TbZ9+sMiAO67EKIXF
	HqxkZGSoVYMuE+/6v8dKsLhLs46KYZYmn4H8Z20d4lBi+QLx6U3StD7RoPp8EIKaaliYgx+i8y8
	9Yd6+pMOd2n4kNsNsG9ViwOShV6b7QlW/7dpOq7KxjnSLCxbkabfZ60JneT5RjOBVTp6v9yk00V
	w2s0HPdyqqLPdEC8Mn8nhu9a7iBHooeruZrpROZJlS6qce4B3PDLi2R9hh29ZFbeMt1202jNO1U
	+9D0gmUfw/TtiyYT/eJFFW+//1dBtqOOaYdboGlz6nnp+qAjT7hGfd6TMeM4t3Vik4lnXOREKzo
	1jTmriMKL07Rn2B+DFYsJ7afRzkN/Lggw7OYbHD2jUqyYXwRBqXQP
X-Received: by 2002:a05:600c:800e:b0:4bb:7757:fe58 with SMTP id
 5b1f17b1804b1-4bb8881b9d7mr305306125e9.19.1795528210579; Tue, 24 Nov 2026
 05:50:10 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124-v2_20230123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com>
 <20261124-v2_20230123_tjmercier_google_com-v6-6-dce12fa03ad6@redhat.com>
In-Reply-To: <20261124-v2_20230123_tjmercier_google_com-v6-6-dce12fa03ad6@redhat.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Tue, 24 Nov 2026 14:49:55 +0100
X-Gm-Features: Aa3M54qkPJ8C4GRzLQzCC_QtBShd4rpGnT89RPbtOkkrzzkAiMVQPjTTZfQmmls
Message-ID: <CAJ2a_DeDF+9pbLKS9pcX4Tot4xZZ-K7HydKnDjW6TWC5bvREzQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] selinux: Restrict cross-cgroup memcg charging
To: Albert Esteve <aesteve@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, 
	Philipp Stanner <phasta@kernel.org>, airlied@gmail.com, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	echanude@redhat.com, mripard@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Nov 2026 at 14:05, Albert Esteve <aesteve@redhat.com> wrote:
>
> The security_current_memcg_charge_task() and
> security_current_memcg_charge_cgroup() hooks allow security modules to
> control which processes may charge or transfer memcg memory to another
> process's cgroup, named by a pidfd, or to an arbitrary cgroup named by
> a cgroupfd, both passed in charge_fd. Without a policy implementation,
> either hook is a no-op and the restriction is not enforced.
>
> On SELinux-managed systems the only limit is CAP_SYS_RESOURCE. A
> domain that holds both dma-heap access (today's only exporter that
> opts-in) and that capability, can charge memory to any cgroup outside
> its own subtree. Since the capability is all-or-nothing, SELinux
> policy cannot express which targets such a domain may charge to.
>
> Implement both selinux_memcg_charge_task() and
> selinux_memcg_charge_cgroup() using avc_has_perm() with a new cgroup
> object class and a new charge_to permission. Both charge_fd flavours
> ultimately charge a cgroup, so one permission covers them and the
> target type keeps the distinction: for the pidfd path the target is
> the referred task's SID, as there is no cgroup object to take a label
> from; for the cgroupfd path it is the cgroup directory's inode SID,
> which comes from the genfscon entry for cgroupfs unless the directory
> is relabeled.
>
> The checks run when the charge target is resolved, before the
> CAP_SYS_RESOURCE baseline is evaluated, and apply to every explicit
> charge_fd target, including the caller's own subtree, so policy needs
> a rule even for self-charging. Policy authors can then grant
> cross-cgroup charging selectively, for example:
>
>   allow allocator_app_t client_app_t:cgroup charge_to;
>   allow allocator_app_t cgroup_t:cgroup charge_to;
>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  security/selinux/hooks.c            | 19 +++++++++++++++++++
>  security/selinux/include/classmap.h |  1 +
>  2 files changed, 20 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6c4c64d6e904..76a714107ae4 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2204,6 +2204,23 @@ static int selinux_capable(const struct cred *cred, struct user_namespace *ns,
>         return cred_has_capability(cred, cap, opts, ns == &init_user_ns);
>  }
>
> +static int selinux_memcg_charge_task(const struct cred *to)
> +{
> +       const struct cred *cred = current_cred();
> +
> +       return avc_has_perm(cred_sid(cred), cred_sid(to),

Small nit:
`cred_sid(current_cred())` could be simplified using `current_sid()`

> +                           SECCLASS_CGROUP, CGROUP__CHARGE_TO, NULL);
> +}
> +
> +static int selinux_memcg_charge_cgroup(const struct file *file)
> +{
> +       const struct cred *cred = current_cred();
> +       struct inode_security_struct *isec = inode_security(file_inode(file));
> +
> +       return avc_has_perm(cred_sid(cred), isec->sid, SECCLASS_CGROUP,
> +                           CGROUP__CHARGE_TO, NULL);
> +}
> +
>  static int selinux_quotactl(int cmds, int type, int id, const struct super_block *sb)
>  {
>         const struct cred *cred = current_cred();
> @@ -7683,6 +7700,8 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>         LSM_HOOK_INIT(capget, selinux_capget),
>         LSM_HOOK_INIT(capset, selinux_capset),
>         LSM_HOOK_INIT(capable, selinux_capable),
> +       LSM_HOOK_INIT(memcg_charge_task, selinux_memcg_charge_task),
> +       LSM_HOOK_INIT(memcg_charge_cgroup, selinux_memcg_charge_cgroup),
>         LSM_HOOK_INIT(quotactl, selinux_quotactl),
>         LSM_HOOK_INIT(quota_on, selinux_quota_on),
>         LSM_HOOK_INIT(syslog, selinux_syslog),
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 90cb61b16425..1f1f2fc4d35d 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -181,6 +181,7 @@ const struct security_class_mapping secclass_map[] = {
>         { "user_namespace", { "create", NULL } },
>         { "memfd_file",
>           { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL } },
> +       { "cgroup", { "charge_to", NULL } },
>         /* last one */ { NULL, {} }
>  };
>
>
> --
> 2.55.0
>
>

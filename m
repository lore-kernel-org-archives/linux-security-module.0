Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED25747DD64
	for <linux-security-module@vger.kernel.org>; Wed,  2 Sep 2026 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354308; cv=none; b=h3fBiEQs0pYWpTqXAzS+NH+4dTS4jXZR7thZvTocZFQxkSmw2TjznYiBl9+JzEA/EkU90eeCBRVHImmGqdN6GRierOVVkN4GWrCWr9N1KjKEfrerLUzbaUtJLe8VhanNU6FZQv4/aV0lqVWN4Sz7sVqA/vtvqFhfpAj6VeovEAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354308; c=relaxed/simple;
	bh=tXPS8UNC1v9DuiaMuucFPopWOOVVCFMSW8Cp05LqM9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lG+1WggA3wKFXXzyxidMxc3gsDQv6XJjtSIAINzRxLrbJ5hs11oR01fAJ2VWvD0drbT7nYEIjzDT4MnLPoFDzVhWRi2RSLqa7STpVNCb5TF0LyEbS9KfI3rSWy2eXMwM7BHoQWu19+YTRO5/fGm5db+OYO7em1lS8OaUZx5ty9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOagKBvH; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOagKBvH"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-90e9ad1a373so14681016d6.0
        for <linux-security-module@vger.kernel.org>; Wed, 02 Sep 2026 06:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788354306; x=1788959106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5mfL9J76Lwd5/7wRAvKdCeJfAtdDB4Im8NEaXbTZIxw=;
        b=eOagKBvHy0cclBYONDE3LGTtd+vdB8AwKE3s9NxdR+/EQMuK0x6NrTu3wszdVu1Bol
         zbe5JEnZy5AgBBD5Hb8rCiaaDPPgiAVLL5SNwtQmGXn1xwyMsnG2tNUHR2C6oeI6cUW9
         XcyPb6nnrDKWenRtmyQw7WK+YNbeiYJHRhIGCnrViDQ6GrbT2eylP5CyhofwKTl1xsjS
         P2VTWtf+vJIzVi0sYa2hsePyb/4T4Ko/e7OLbi0spr0GFw5I/52uJoY0owhwvcKNZwHD
         /oSSoa/Ch2B90fkHjPQ/OVYkk+QEJAplJEF3dQFuAMf6FjFgwXWs+fiFQpzo1Ri6Y/Gu
         9AIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788354306; x=1788959106;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5mfL9J76Lwd5/7wRAvKdCeJfAtdDB4Im8NEaXbTZIxw=;
        b=Vv25WSUpNBn5YLh2RqUDr+wdMXYPnEDaylXmtfc4IisGC+opUDAt0MhK8DF2tuahiJ
         tIXKc5QEHvn4seKvr2aenniGQNlS4MpK9R5iiX5f4zeLE5jCMByacKjvNr71kG9UOuk1
         YE2+wEY0toxEnSglvDQFGywvX/IMlT5MB80McY4ReUQGnlZIvlsJb6tC15+QGli2V8Vu
         lkf2ADjruhj2zb6uP6q8aZ79SI10jWPjWmpGxT1rf1hxw5Q8aLPmWyGj4Fo5s2FrTcUl
         9rjNsVdE3U9ckVHdKCOKGyePVq7Brf4SdBQE2KxOFFjIrLDp2nBq9RLhtb2xRFBLWpTZ
         FkFQ==
X-Forwarded-Encrypted: i=1; AKwUvBwn2wDUXD5yfVZom7A679Fb5hm2bw4u4MaOKKP44QFtPvKK4LMXB4yjByn2jzVMv+M9WhnMlI5SqEDH/6PK/BmU7wQCghQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lsjP5VypupkouSsrd9gpbGEh/vbEElctnQNbgycoUFYB3T3x/K
	kZhlMAhMTYk2qS1P8t4NVMtBwZczHlpvKqh5d7LQSQsxMtPpMvVUqg8M
X-Gm-Gg: AYBFou2vHEV+cfAOUEGqp59cDuQzjOG8GZCG7TIll2V9iMpyaBGUoXPW6C8QzHqqQLN
	JCQztnyTmZ4XyvR6T2D8gtMB/xC0ivW4KbUdw6ytHq7r1Te1l7tviqn+TAgoP4noMw2VhTijabg
	06wNI1a82YetVTm6IL4PQrTyXbw1iaNwTaSPZ2BW9Cw1F8awZ/JiGSrkZUwgGq8atGMKedX32L2
	JsEBc7XdcIUbCujVZisa8K9M564DTgHPrAXLL06RiTszLrFWF3J2Y/HBD9pQ5FbN7UdKbcnPHoW
	ZlAjJOlgVQcA6N5oIxm/QPCoOxvN6vBidvWVHq9Lgk0kZT5hswQZE1kabiix+vuUD+SKu2DFJOD
	9M+Oqal+QBTskwytFkJ1hJbM6/AgdyT44wRIfk891vt4FZlPbglJFx/eywh5Qg0nb/ezpqTd5tv
	FjGuinku2lSDt62zW8t6QphZH5Hf1IZlYgMyEBQdEfthvrzowUKK0p18YtiRvLC6Nf3WwXMCLe9
	j9e3PUfIzHZZwNKY2F3iQ==
X-Received: by 2002:ad4:5962:0:b0:8fe:57d4:69cd with SMTP id 6a1803df08f44-9102eabaebamr26390076d6.14.1788354305529;
        Wed, 02 Sep 2026 06:05:05 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:f78:4c8c:a6cc:a58e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee3bc37sm18005506d6.20.2026.09.02.06.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:05:05 -0700 (PDT)
Date: Wed, 2 Sep 2026 09:05:03 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, paul@paul-moore.com, mic@digikod.net, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, kees@kernel.org
Cc: gnoack@google.com, jack@suse.cz, song@kernel.org, 
	yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v2 01/15] lsm: Add the LSM policy object lifetime hooks
Message-ID: <apgX1HKQ7b973YV-@zenbox>
References: <20260831145858.3869191-1-utilityemal77@gmail.com>
 <20260831145858.3869191-2-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831145858.3869191-2-utilityemal77@gmail.com>

On Mon, Aug 31, 2026 at 10:58:43AM -0400, Justin Suess wrote:
> Add struct lsm_policy_object, the identity an LSM embeds in a policy
> object it shares with BPF programs, and the three hooks managing such
> an object's lifetime:
> 
>   policy_object_from_fd(fd, &object)
>   policy_object_get(object)
>   policy_object_put(object)
> 
> The object records the owning LSM's LSM_ID_* value.  The BPF kfuncs
> built on these hooks dispatch each call on an object to the one LSM
> matching its lsmid, which resolves the containing object with
> container_of(); the framework never interprets an object beyond its
> lsmid.  The type field discriminates between the owning LSM's own
> policy object kinds and is private to it, with 0 reserved as "unset"
> so a zeroed, untagged object fails every type check.
> 
> from_fd has no object to route by: the fd refers to a file set up
> through the owning LSM's own userspace interface, so the fd itself
> identifies its LSM.  The framework offers the fd to every
> implementation in turn; an LSM declines a fd that is not one of its
> policy objects with -EOPNOTSUPP, and any other error is a definitive
> translation failure.
> 
> The hooks back referenced BPF kptrs, which imposes the same lifetime
> contract on every implementation: from_fd returns a reference on a
> live object, get acquires with inc-not-zero semantics and fails with
> -ENOENT once the count dropped to zero, put may be called from
> contexts that cannot sleep (BPF drives it from map destructors), and
> the containing object is freed only after an RCU grace period, as
> programs load policy object kptrs from maps under RCU and may examine
> an object concurrently with its last put.
> 
> The hooks are excluded from the "bpf" LSM's attachment points.  The
> object-routed hooks are unreachable there, as LSM_ID_BPF policy
> objects cannot exist; for from_fd, whose walk visits every
> implementation, a BPF program cannot fill the object out parameter,
> so an attachment returning 0 would hand the caller an uninitialized
> pointer.
> 
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h |  4 ++++
>  include/linux/security.h      | 11 +++++++++++
>  kernel/bpf/bpf_lsm.c          |  3 +++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 65c9609ec207..d7684407737a 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -452,6 +452,10 @@ LSM_HOOK(int, 0, bpf_token_create, struct bpf_token *token, union bpf_attr *attr
>  LSM_HOOK(void, LSM_RET_VOID, bpf_token_free, struct bpf_token *token)
>  LSM_HOOK(int, 0, bpf_token_cmd, const struct bpf_token *token, enum bpf_cmd cmd)
>  LSM_HOOK(int, 0, bpf_token_capable, const struct bpf_token *token, int cap)
> +LSM_HOOK(int, -EOPNOTSUPP, policy_object_from_fd, int fd,
> +	 struct lsm_policy_object **object)
> +LSM_HOOK(int, -EOPNOTSUPP, policy_object_get, struct lsm_policy_object *object)
> +LSM_HOOK(void, LSM_RET_VOID, policy_object_put, struct lsm_policy_object *object)
>  #endif /* CONFIG_BPF_SYSCALL */
>  
>  LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 153e9043058f..5e423bea080e 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -168,6 +168,17 @@ struct lsm_prop {
>  	struct lsm_prop_bpf bpf;
>  };
>  
> +/*
> + * Identity of a policy object an LSM shares with BPF programs,
> + * embedded in the LSM's own object.  @lsmid identifies the owning
> + * LSM; @type discriminates that LSM's policy object types, with 0
> + * reserved as "unset".
> + */
> +struct lsm_policy_object {
> +	u64 lsmid;
> +	u32 type;
> +};
For some clarity:

lsm_policy_object is just a handle to a refcounted lsm-private struct.

It can't be forged / created manually because it's a trusted kernel
pointer, so the only way to get it is through policy_object_from_fd.
And you cannot mutate any part of it from BPF.

But it's what enables the generic model. Calling it a "policy object"
may be short sighted though, that term is heavily overloaded in the LSM
space. I don't want to prescribe any restrictions on what an LSM can use
it for, after all some LSM have no notion of "policy" at all or have a
different meaning for it.

For SELinux, this "lsm_policy_object" could be an sid, for AppArmor an aa_label,
for Smack a label, etc. The intention was to allow writing programs that
don't care about any details of a particular LSM.

Justin
> +
>  extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
>  
>  /* These functions are in security/commoncap.c */
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 1433809bb166..d06744d72e04 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -56,6 +56,9 @@ BTF_ID(func, bpf_lsm_xfrm_decode_session)
>  #endif
>  BTF_ID(func, bpf_lsm_ismaclabel)
>  BTF_ID(func, bpf_lsm_file_alloc_security)
> +BTF_ID(func, bpf_lsm_policy_object_from_fd)
> +BTF_ID(func, bpf_lsm_policy_object_get)
> +BTF_ID(func, bpf_lsm_policy_object_put)
>  BTF_SET_END(bpf_lsm_disabled_hooks)
>  
>  /* List of LSM hooks that should operate on 'current' cgroup regardless
> -- 
> 2.55.0
> 

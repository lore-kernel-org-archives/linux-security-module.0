Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96932375F69
	for <linux-security-module@vger.kernel.org>; Wed,  2 Sep 2026 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373730; cv=none; b=KyKxRY/MEFE3+ib/pVPPX9sxJWqcAD3x8qElYwqpaTbArLgFwzBI73FuuU8w/KOKGtPVUJk3+z6hP1oCPEgLuVjkrb30Ez9JVUU/sB6GE+S4h5uI9j7MF090scDWiVIxU7d3UWdFI5e+qfocKkJa2KbeIIT7V4+YolsXoNfRsdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373730; c=relaxed/simple;
	bh=tfC/RB9kz8s1oonO8uu6fd2cb2zJHjZWJyAYedq2t0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+BmTrLEFzfUT8DhRx9jpGA2NfFNbFnKdRo7Ma22xBztzkIHxBG1uCXh/K11s3Z+/meQMwCll9X0nOIFUPv5CchGnih9vDmOuXaKkAdcD1cmcpoEc9DuA4iT0m1LhZzM0C+1XxPwaIekgEB3SdPy6ME7+Lvd+2gAFfdB/QmG3vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/DP2eKM; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/DP2eKM"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-861a2ae9c51so18826517b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 02 Sep 2026 11:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788373727; x=1788978527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oDxoWYox+1+oZjWxNuh3RL0Qsto297A849qEA0ZTYLI=;
        b=R/DP2eKMBLU8mcc/+JkMEGtC7h9LyFbsWswegXuBlO1hHt7torUECy2UWqJab5FKoX
         pQh9jd5XnE7sFU28MPOqrYJDkYx0edL5U+0gCnd0EoQ5+6sQLbloXHHRM8U96ZDRwHLm
         Ena3Dj91ii25dKKMFc7oxy3+FIy/7h8KBVcP7nCt+MK3BEAoRVjeJlLHMGRpgkovE8nT
         lX/5JrZEMDW8Z5DFkb0CSrzT27hOL01ywDtV8CSNUtAuUhzCu7jRzRDbPRvfCTxhexOA
         sqcfjVjeWvkUexVCFVgmXJ4+zp97UGQvW7mYA5l7FB3YKrQheP7O8O3hKVd5ChgaaeNj
         vfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373727; x=1788978527;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oDxoWYox+1+oZjWxNuh3RL0Qsto297A849qEA0ZTYLI=;
        b=d3G0iBby6H7ksPLJUiwI+WfS1sIzN2aoKdnckYoZrR4oSJygz4qCztzI16k4Cnx7D1
         MiaMpyzSmuGamWxEs64SPXbxqDH5OM58oQ7ac7vmjMiYPnWf+vYPMCJcPku2TJw3OZv4
         YQ1BIzEWMZouM0mKgJ3t1nD3j85CSL27jaB3jG3wiTL5Giy1WIvFl8sDhA9Kt6GnZkRz
         jMdBY7RQpRT7X5Q2vLOdXhWuIaY2TH84R+XTACFLRm1JQaq5a8+dF7TL+Ou2pulF8YL2
         uUNeUTFo4vS0OLujcZZLI1etS4HDP2nnfhW3fPtmWiQ92Q11JrM79zSqlL9xr1A9XTka
         p45A==
X-Forwarded-Encrypted: i=1; AKwUvBwUkJZCo1fT3ojElciSj8CQ5YdRsvKcF6vO2HtrXkW36/uhn+ZqGlTV7tBd5A5iu/9BThm3I0ceGTgvetG07NkEailgRog=@vger.kernel.org
X-Gm-Message-State: AFuF++kgqiOPoYee1RYd4zc8z8+T648Y6sE5MQrYv++U9Bhfm7CxzOlL
	Nw0vPr9lzvqgwnaGIcOyWMOqNBDnL5g3D5V8LAYA+ihHFT+yVDOsYkNU
X-Gm-Gg: AYBFou1szjB8ZoypLht+4iN54P+H493/Xymb+qSyobu8JW08lRlvzminGQVnLMac5jU
	rEqQMnBd76FlIgB1THptPGBQ+X3mUALd2l+ZrBK14GAQVl2FMG72xqp0Wh/CuJvwfCCJNj9JOvN
	SUkuJ1YNpCdRxv+9yFN8jExzf4XQzvkwIhrIJPrtba5wlVQI/V2L79orU1BfvVo8YLNmGInjqKX
	eBrugN3b72tQRpK8IjoQmVb0sgD3QlCMhhJtM3VpLgxlCu6WU5I/eFXDfVsTtIqGCFTUkBinK3S
	L3Wbm6PPL7L00wYA56Ehhs81+0dWzEYCyfLOuvJovZ/OBwraW9bg0iWWL0rY3mNvUbriym3QE0E
	MYGXTDDt8ZGOFZSt0pRxTRC9vuxigWzr62z55fNU6YDq0ej/jD09LVJzZsqDdW3Ls6aFXwbkC+w
	FR3t83U1nCiexXMezxjp34FDBjNOaTAbUUqArKGwewuI5nKTTN1LViH6u6W8iAP2RCPAWI9qcKm
	9Q6j1lsZhyywhkoAMsIUm6wXFqq
X-Received: by 2002:a05:690c:a5d6:b0:833:f9bd:b289 with SMTP id 00721157ae682-86c552e5e02mr31455827b3.31.1788373726869;
        Wed, 02 Sep 2026 11:28:46 -0700 (PDT)
Received: from suesslenovo ([2600:1700:18fb:6011:51fa:ff89:a955:fb9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-86c184e4b52sm23405307b3.34.2026.09.02.11.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:28:46 -0700 (PDT)
Date: Wed, 2 Sep 2026 14:28:45 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, paul@paul-moore.com, mic@digikod.net, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, kees@kernel.org, gnoack@google.com, jack@suse.cz, 
	song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] lsm: Add the LSM policy object lifetime hooks
Message-ID: <aphlyRhOALyp4tSK@suesslenovo>
References: <20260831145858.3869191-1-utilityemal77@gmail.com>
 <20260831145858.3869191-2-utilityemal77@gmail.com>
 <apgX1HKQ7b973YV-@zenbox>
 <298197df-1f92-40b8-8baf-8f52a3dcec20@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <298197df-1f92-40b8-8baf-8f52a3dcec20@schaufler-ca.com>

On Wed, Sep 02, 2026 at 10:51:37AM -0700, Casey Schaufler wrote:
> On 9/2/2026 6:05 AM, Justin Suess wrote:
> > On Mon, Aug 31, 2026 at 10:58:43AM -0400, Justin Suess wrote:
> >> Add struct lsm_policy_object, the identity an LSM embeds in a policy
> >> object it shares with BPF programs, and the three hooks managing such
> >> an object's lifetime:
> >>
> >>   policy_object_from_fd(fd, &object)
> >>   policy_object_get(object)
> >>   policy_object_put(object)
> >>
> >> The object records the owning LSM's LSM_ID_* value.  The BPF kfuncs
> >> built on these hooks dispatch each call on an object to the one LSM
> >> matching its lsmid, which resolves the containing object with
> >> container_of(); the framework never interprets an object beyond its
> >> lsmid.  The type field discriminates between the owning LSM's own
> >> policy object kinds and is private to it, with 0 reserved as "unset"
> >> so a zeroed, untagged object fails every type check.
> >>
> >> from_fd has no object to route by: the fd refers to a file set up
> >> through the owning LSM's own userspace interface, so the fd itself
> >> identifies its LSM.  The framework offers the fd to every
> >> implementation in turn; an LSM declines a fd that is not one of its
> >> policy objects with -EOPNOTSUPP, and any other error is a definitive
> >> translation failure.
> >>
> >> The hooks back referenced BPF kptrs, which imposes the same lifetime
> >> contract on every implementation: from_fd returns a reference on a
> >> live object, get acquires with inc-not-zero semantics and fails with
> >> -ENOENT once the count dropped to zero, put may be called from
> >> contexts that cannot sleep (BPF drives it from map destructors), and
> >> the containing object is freed only after an RCU grace period, as
> >> programs load policy object kptrs from maps under RCU and may examine
> >> an object concurrently with its last put.
> >>
> >> The hooks are excluded from the "bpf" LSM's attachment points.  The
> >> object-routed hooks are unreachable there, as LSM_ID_BPF policy
> >> objects cannot exist; for from_fd, whose walk visits every
> >> implementation, a BPF program cannot fill the object out parameter,
> >> so an attachment returning 0 would hand the caller an uninitialized
> >> pointer.
> >>
> >> Cc: Paul Moore <paul@paul-moore.com>
> >> Cc: Casey Schaufler <casey@schaufler-ca.com>
> >> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> >> ---
> >>  include/linux/lsm_hook_defs.h |  4 ++++
> >>  include/linux/security.h      | 11 +++++++++++
> >>  kernel/bpf/bpf_lsm.c          |  3 +++
> >>  3 files changed, 18 insertions(+)
> >>
> >> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> >> index 65c9609ec207..d7684407737a 100644
> >> --- a/include/linux/lsm_hook_defs.h
> >> +++ b/include/linux/lsm_hook_defs.h
> >> @@ -452,6 +452,10 @@ LSM_HOOK(int, 0, bpf_token_create, struct bpf_token *token, union bpf_attr *attr
> >>  LSM_HOOK(void, LSM_RET_VOID, bpf_token_free, struct bpf_token *token)
> >>  LSM_HOOK(int, 0, bpf_token_cmd, const struct bpf_token *token, enum bpf_cmd cmd)
> >>  LSM_HOOK(int, 0, bpf_token_capable, const struct bpf_token *token, int cap)
> >> +LSM_HOOK(int, -EOPNOTSUPP, policy_object_from_fd, int fd,
> >> +	 struct lsm_policy_object **object)
> >> +LSM_HOOK(int, -EOPNOTSUPP, policy_object_get, struct lsm_policy_object *object)
> >> +LSM_HOOK(void, LSM_RET_VOID, policy_object_put, struct lsm_policy_object *object)
> >>  #endif /* CONFIG_BPF_SYSCALL */
> >>  
> >>  LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
> >> diff --git a/include/linux/security.h b/include/linux/security.h
> >> index 153e9043058f..5e423bea080e 100644
> >> --- a/include/linux/security.h
> >> +++ b/include/linux/security.h
> >> @@ -168,6 +168,17 @@ struct lsm_prop {
> >>  	struct lsm_prop_bpf bpf;
> >>  };
> >>  
> >> +/*
> >> + * Identity of a policy object an LSM shares with BPF programs,
> >> + * embedded in the LSM's own object.  @lsmid identifies the owning
> >> + * LSM; @type discriminates that LSM's policy object types, with 0
> >> + * reserved as "unset".
> >> + */
> >> +struct lsm_policy_object {
> >> +	u64 lsmid;
> >> +	u32 type;
> >> +};
> > For some clarity:
> >
> > lsm_policy_object is just a handle to a refcounted lsm-private struct.
> >
> > It can't be forged / created manually because it's a trusted kernel
> > pointer, so the only way to get it is through policy_object_from_fd.
> > And you cannot mutate any part of it from BPF.
> >
> > But it's what enables the generic model. Calling it a "policy object"
> > may be short sighted though, that term is heavily overloaded in the LSM
> > space. I don't want to prescribe any restrictions on what an LSM can use
> > it for, after all some LSM have no notion of "policy" at all or have a
> > different meaning for it.
> >
> > For SELinux, this "lsm_policy_object" could be an sid, for AppArmor an aa_label,
> > for Smack a label, etc. The intention was to allow writing programs that
> > don't care about any details of a particular LSM.
> 
> Why aren't you using an lsm_prop pointer? What if the operation you're
So lsm_prop from my understanding allows multiple LSMs to store their
data for one *shared* kernel object in a structured way.
(i.e one object; multiple lsms using it)

lsm_policy_object is sort of the opposite case:

In this case, the object is *owned* by a particular LSM. Think a
Landlock ruleset, smack label, or aa_label etc, that could never
foreeably have a semantic meaning to other LSM. 

> planning to perform is relevant to multiple active LSMs? Today you can't
> use SELinux and AppArmor together on an upstream Linus kernel, but that
> should be changing sometime this decade.
>
The object is not relevant to other LSMs by construction. The
lsm_policy_object is an lsm internal object, specific to the LSM.

You'd never make an lsm_policy_object for an inode, dentry, socket, etc.

So if you wanted to use LSM A and LSM B with this API, you'd need to
acquire each of their policy objects in turn. But you apply them both
with the same API, without having to care about LSM details.

Justin

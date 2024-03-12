Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A384D13B28E
	for <linux-security-module@vger.kernel.org>; Tue, 12 Mar 2024 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263205; cv=none; b=moSkCIbUtfRir6Lo0zuYTs5aHTCuf7gFaWbKFVXv1wQcialS6bqNxRHcP2szi4KTkyfv+9pc0eTtKwvaiE5QueMba7QhsNkOYSr+Yk9Mg18DMleLU/WuifxGARdSORtRy91UnmmlrS0Rnub2ysqg7LjBwv2Gu94Zl9COJBsMuN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263205; c=relaxed/simple;
	bh=ODBwrrI/trcFkdEjJ9gJJB5JMu44UNEg7dQLx1OB5rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DopaOPZqfU7EAvzXloLVpojmqh5wRuEwxpzhRotEuWXgEnDf7VxAB3aKUhZ6hPGe41IS3APlrcDVanRhIythTtYH1MRcN8CKVXcOSheYGNoGjlsf873h7YmXMh0bCNDdnVMvq/9Iow6Qkdsc4tfB0SmWHDSxErXw4FkGDJ5gTN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eisIbU3m; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eisIbU3m"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso5285201276.0
        for <linux-security-module@vger.kernel.org>; Tue, 12 Mar 2024 10:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710263202; x=1710868002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rm7l+RMSZUqlJJ7DTu0GuXUMEcKHLbKcsHpJaXGfU7Q=;
        b=eisIbU3mBKRJicxPXBF3Q+rP7hzmR6PNkBd7REayXUtW/xwkGdc0bvLVxCVXpqLLz0
         RRGm2vsiLEEPhJc4gSiyPUhywCpeBiHSqsqzbUJ72TOOLUqiYQfaAamB8tfdOn8eGzSW
         yl6zSZERuVtTCr5LO21L1bOTZouaGroQZqYZdoU34CB9aRQDeUc+iCJGPmZOP7bOWPbl
         g9k0eN2hwJw4uaEilYrbUBYu/Ox84dIqVDerBsdueM9Aw58jdW40LbB02hAyCM9k9BpQ
         TUU0L9a9wbcDjlhCqjNTDup2jn1Z+kjsYjEA7Hk+++jRxlPv2Uw8SLKw4eKT/MYDTxwo
         iuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710263202; x=1710868002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rm7l+RMSZUqlJJ7DTu0GuXUMEcKHLbKcsHpJaXGfU7Q=;
        b=OTu8A38DbTzjDef8xMxNQyf7op6yufPN4xXwRvqFSAI2J1cH2t2hVgI4xVDgXOh+4S
         v3DJWt8nuT+v6lZ7XuX0nGSRWKS7eEeHCPxbGt0I+So6bHnouTyIA5fvnjauqBdH6rXF
         1mpnEke8U2rF4ugo0hJd8TcwMv1KHxMrYLqeV2KPHCCqeGDr6cDixv/sASdfvC2ClK1P
         7u1F1Pp6wUY3ijB/+JPhKaMipZapUJbEsjlHlmkU3cNl55x17HbnXXVRx1N4Z5vAxxJ1
         ApUH31mb9FmRL++NNYgAsdKZSFh0X0OtRmWJyvoOhUAaUbQOMrvss3OlnZS4YjyuaiZy
         +tEw==
X-Forwarded-Encrypted: i=1; AJvYcCUD8a97ef0BMVYehPAGbZNINggEMUfmBg5PoqvhyQuhKtvGff5TxMT0iSjL6B/0lc2/e3xQit/zZeyum9HwBFtiqQlNeamN+0I22iyWTytb50veJ5Fm
X-Gm-Message-State: AOJu0YxyUZ/3MCUq4TZckViG4gqrD4BHuAabP9MwhMEAW0kqcz3R9q7S
	sMEnjT/UrwzjHChqib04Kp1H5BDe0MpS0lI97DgheAZ5xJW/+kjCCQrjab/Ws8NKvV3yOj472EK
	kCzOHt/FWjxSdIvNHUzgaN/4xHY+D6Xq9qaj/
X-Google-Smtp-Source: AGHT+IGE+VfMAqbVYN41jVn1YyoH5kAy0AKB+zcQZl0WABPOYxYN+EL+RCMyJWkqXwdFHtxZGLeP8pt7ClkhUNY5aic=
X-Received: by 2002:a25:b227:0:b0:dc7:45d3:ffd0 with SMTP id
 i39-20020a25b227000000b00dc745d3ffd0mr80052ybj.1.1710263202618; Tue, 12 Mar
 2024 10:06:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912205658.3432-1-casey@schaufler-ca.com> <20230912205658.3432-6-casey@schaufler-ca.com>
 <20240312101630.GA903@altlinux.org> <CAHC9VhRgjNT2YnVgCqMJnyr227qUjmfrWZ+LBnu_DGxnJZgeKw@mail.gmail.com>
 <f122b3a9-1208-4c0b-9289-73eb070a8337@schaufler-ca.com>
In-Reply-To: <f122b3a9-1208-4c0b-9289-73eb070a8337@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 Mar 2024 13:06:36 -0400
Message-ID: <CAHC9VhRfwjsGiHXBRcWA6S9+H_kj0vMdQC0gyHr3ZnX-u7KzRQ@mail.gmail.com>
Subject: Re: [PATCH v15 05/11] LSM: Create lsm_list_modules system call
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "Dmitry V. Levin" <ldv@strace.io>, linux-security-module@vger.kernel.org, jmorris@namei.org, 
	serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 11:27=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 3/12/2024 6:25 AM, Paul Moore wrote:
> > On Tue, Mar 12, 2024 at 6:16=E2=80=AFAM Dmitry V. Levin <ldv@strace.io>=
 wrote:
> >> On Tue, Sep 12, 2023 at 01:56:50PM -0700, Casey Schaufler wrote:
> >> [...]
> >>> --- a/security/lsm_syscalls.c
> >>> +++ b/security/lsm_syscalls.c
> >>> @@ -55,3 +55,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, a=
ttr, struct lsm_ctx __user *,
> >>>  {
> >>>       return security_getselfattr(attr, ctx, size, flags);
> >>>  }
> >>> +
> >>> +/**
> >>> + * sys_lsm_list_modules - Return a list of the active security modul=
es
> >>> + * @ids: the LSM module ids
> >>> + * @size: pointer to size of @ids, updated on return
> >>> + * @flags: reserved for future use, must be zero
> >>> + *
> >>> + * Returns a list of the active LSM ids. On success this function
> >>> + * returns the number of @ids array elements. This value may be zero
> >>> + * if there are no LSMs active. If @size is insufficient to contain
> >>> + * the return data -E2BIG is returned and @size is set to the minimu=
m
> >>> + * required size. In all other cases a negative value indicating the
> >>> + * error is returned.
> >>> + */
> >>> +SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *=
, size,
> >>> +             u32, flags)
> >> I'm sorry but the size of userspace size_t is different from the kerne=
l one
> >> on 32-bit compat architectures.
> > D'oh, yes, thanks for pointing that out.  It would have been nice to
> > have caught that before v6.8 was released, but I guess it's better
> > than later.
> >
> >> Looks like there has to be a COMPAT_SYSCALL_DEFINE3(lsm_list_modules, =
...)
> >> now.  Other two added lsm syscalls also have this issue.
> > Considering that Linux v6.8, and by extension these syscalls, are only
> > a few days old, I think I'd rather see us just modify the syscalls and
> > avoid the compat baggage.  I'm going to be shocked if anyone has
> > shifted to using the new syscalls yet, and even if they have (!!),
> > moving from a "size_t" type to a "u64" should be mostly transparent
> > for the majority of native 64-bit systems.  Those running the absolute
> > latest kernels on 32-bit systems with custom or bleeding edge
> > userspace *may* see a slight hiccup, but I think that user count is in
> > the single digits, if not zero.
> >
> > Let's fix this quickly with /size_t/u64/ in v6.8.1 and avoid the
> > compat shim if we can.
> >
> > Casey, do you have time to put together a patch for this (you should
> > fix the call chains below the syscalls too)?  If not, please let me
> > know and I'll get a patch out ASAP.
>
> Grumble. Yes, I'll get right on it.

Great, thanks Casey.

--=20
paul-moore.com

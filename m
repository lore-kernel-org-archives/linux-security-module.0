Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEA152F88
	for <linux-security-module@vger.kernel.org>; Wed, 31 Dec 2025 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767192473; cv=none; b=UZef6lVL44TEH77VxsKrx2TB6XruaanvyBFVwO+pQF/2el3ssqrlbC4GvRJ8E9vYqQwB0y7yOaB0Mvzf0IPfoN2HOMT4EYcdJj4jM6wL7GS2aq9pSn45JUPC0pcu5d0cUDeUue76MdNrGKB4WER7g7Pggs/WoYIV44GMBNaJ9IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767192473; c=relaxed/simple;
	bh=EAnDkKLV2e6zCNgmm4wtvlU0zbGRVV/UmLKOX+hrDFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwmxvswCoP4jLC7/r5t2F65e4iLchtf8GTUmvyJ8wbXW49RGJVn3mUSlkyicYU+Bw+eQ+vOwteD8ETM3OMM23XGQuJ/AeRfYciJy0IghHQMJu69/ObuG9u1fWAPu9nDy9YO9kv7JUilAhM4JKjT48hv7Dd9okNxHm9xhgaC0XWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gPk11g4D; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gPk11g4D"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so9299365b3a.3
        for <linux-security-module@vger.kernel.org>; Wed, 31 Dec 2025 06:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1767192471; x=1767797271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqv61uqhUYi1ziPYTk4Tusgq/Jmczuzwr/hbBD4XE+s=;
        b=gPk11g4DsvJIgokmx/MJSdVcrnR+P60ZB+fIn03CegCaG5I/sfn2SBw58q63liAuuV
         ajtEFAcm/myFzD4M4UaV9fG10Rmzw749xlcVIa8nRR3YrTHKLsJ/KZKF6ctTgmx5JFrw
         o0pQIxmZ7StH8LKQc8sybGICcJtzj6fFmPuYBUIkCRHmzJhihRUtzHUaXq8N6UuFfYoo
         DrKWNaG1FC5NXRu8Pqe4BGVoT5lm/6oIRYnBkyt92+sOarjd4BCahibQjhDXkOmAhrND
         OaAjgi1B+wVebcBw6YTOfeLv3N9LQkO1PDddOwiov9IRTxxeqUlTN5E0UsAIkTfQSv3M
         ZPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767192471; x=1767797271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oqv61uqhUYi1ziPYTk4Tusgq/Jmczuzwr/hbBD4XE+s=;
        b=pnZyo6iiT9cfDSCbAZc7PqVwSTzAi/c7n/cuUs9kWksioceV3YLXfCPvZIFrbTi5d7
         +z2HtzKCfhYxkrUGfeAScLaN/JuXij+fAwZWIISeQWVcAugCquUMsnY+viSgacrWrLdy
         rHRuS4F+rgLSUsYI1NmMUFs9VRRm0klPzv0WUgqaoSINgTqmFc5J1kOKEWlnOsjt85Gf
         cj26pdQ9DCjbiymi4dPCOecw8IbviwG+suCJBOsX1NT1n+5bAgHabP2Rr2Ex0T/3XpDh
         bxdJgXWvsO4JCqY7xqpvVMqwEwEBu5QJNwFV/aty65nf+014u+rwBKEkIJdc3HVmmjYb
         RiMg==
X-Forwarded-Encrypted: i=1; AJvYcCUMqauVIvcmGtbcRxl7qK7lMiyORArXPTqlcZRUuAzsmSNuhl1bFRSWqn9XKgwMBPHcqtAX0VVsXcObWm1ojMwMC+vEfF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8/LDnWsQEWCv4IfRiynVFtmZfM3bh1W9NT8VyolX/ejhmkTZO
	jL6Qfajp1K7f9LkwwcWty50NRwgGyMKC4SHgna9mYmzqvely6OtImu76mIQ1m07yx7v2uLNFhIn
	zjmHd3V5lkYzsIAPlmwXRHrs+iu7ooq6QdbO72fmg
X-Gm-Gg: AY/fxX5f88ebGAFspVEvpnpkfWBdnhbIDsDWKub+7Z1vYgOYC0KP0du2mxaTlKJCHxz
	cG/exYdNgCU3qQKGuBufUulZzk9pnPab6FkFMhfXbdJ1ELa21IXRzVW2dZY5KBl4z2r3rlfSROx
	Jw689L5+3VnHSepCOxt+0iWw1rUm14i/5K5ufQbpalx3tGnEe5gW30WYKd7jwSA/EPHEbTpRWUZ
	a1xd0AaPVWVnAXvuBZHv7NvlBv2KOXzZkQtZwWn1PlfH4ZiP8FgpdPhBxDKcIKbAxPtPAo=
X-Google-Smtp-Source: AGHT+IERI8H613gOtpKPggQsilkaSV9ybN6DgMDggq5LNKPjUEoDd5XMlj+kpIfXkFoEbYhQ3Atd7d9cbQ3qEyKeAzc=
X-Received: by 2002:a05:6a21:99aa:b0:35d:cc9a:8bde with SMTP id
 adf61e73a8af0-376a81dcc0fmr33689552637.36.1767192471191; Wed, 31 Dec 2025
 06:47:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACVn-YmCOUQVQd1FYZhcMSQAK5gsvzA7+k5oiocN23nKRMKBMA@mail.gmail.com>
 <20251231031117.37793-1-wq513132@alibaba-inc.com>
In-Reply-To: <20251231031117.37793-1-wq513132@alibaba-inc.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 31 Dec 2025 09:47:39 -0500
X-Gm-Features: AQt7F2qvZPEHgarH-RrWkvdTDzprxpoAjKaRj_E3zZkJtXcI8Umsy7OhVXnX-PU
Message-ID: <CAHC9VhQYf79Ni3M1r_F2L=vKtDyqOU3Rim+q480OB7Rzam+6xg@mail.gmail.com>
Subject: Re: [BUG REPORT] memory leak in prepare creds triggered by
 Netlink/fremovexattr (v6.12.62 , found C repro for Invalid bugs)
To: wangqing <wangqing7171@gmail.com>
Cc: yangyuhang0619@gmail.com, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 10:11=E2=80=AFPM wangqing <wangqing7171@gmail.com> =
wrote:
> On Thu, 25 Dec 2025 at 19:12, yuhang hang <yangyuhang0619@gmail.com> wrot=
e:
> > BUG: memory leak
> > unreferenced object 0xffff888023928000 (size 184):
> >   comm "syz-executor", pid 10631, jiffies 4294970296
> >   hex dump (first 32 bytes):
> >     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace (crc 1adddbfd):
> >     kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
> >     slab_post_alloc_hook mm/slub.c:4152 [inline]
> >     slab_alloc_node mm/slub.c:4197 [inline]
> >     kmem_cache_alloc_noprof+0x29a/0x320 mm/slub.c:4204
> >     prepare_creds+0x2e/0x760 kernel/cred.c:212
> >     copy_creds+0xa7/0xa50 kernel/cred.c:312
> >     copy_process+0xf7d/0x8b20 kernel/fork.c:2262
> >     kernel_clone+0xeb/0x900 kernel/fork.c:2810
> >     __do_sys_clone+0xcf/0x120 kernel/fork.c:2953
> >     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >     do_syscall_64+0xcb/0x220 arch/x86/entry/common.c:83
> >     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > BUG: memory leak
> > unreferenced object 0xffff88802067d920 (size 16):
> >   comm "syz-executor", pid 10631, jiffies 4294970296
> >   hex dump (first 16 bytes):
> >     00 00 00 00 00 00 00 00 00 3d 08 1b 80 88 ff ff  .........=3D......
> >   backtrace (crc 8e8e0e90):
> >     kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
> >     slab_post_alloc_hook mm/slub.c:4152 [inline]
> >     slab_alloc_node mm/slub.c:4197 [inline]
> >     __do_kmalloc_node mm/slub.c:4331 [inline]
> >     __kmalloc_noprof+0x331/0x460 mm/slub.c:4344
> >     kmalloc_noprof include/linux/slab.h:882 [inline]
> >     kzalloc_noprof include/linux/slab.h:1014 [inline]
> >     lsm_blob_alloc security/security.c:685 [inline]
> >     lsm_blob_alloc security/security.c:678 [inline]
> >     lsm_cred_alloc security/security.c:702 [inline]
> >     security_prepare_creds+0x294/0x320 security/security.c:3240
> >     prepare_creds+0x54e/0x760 kernel/cred.c:242
> >     copy_creds+0xa7/0xa50 kernel/cred.c:312
> >     copy_process+0xf7d/0x8b20 kernel/fork.c:2262
> >     kernel_clone+0xeb/0x900 kernel/fork.c:2810
> >     __do_sys_clone+0xcf/0x120 kernel/fork.c:2953
> >     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >     do_syscall_64+0xcb/0x220 arch/x86/entry/common.c:83
> >     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Hi,
>
> I've analyzed the kmemleak output and the copy_process() code path.
> The allocation happens in prepare_creds(), but all error paths after
> copy_creds() correctly call exit_creds() to release the credential.
>
> This is likely a false positive caused by RCU delayed freeing of
> struct cred. The object is queued via call_rcu() and not immediately
> freed, so kmemleak may report it as "unreferenced" before the grace
> period completes.
>
> To verify, please:
> 1. Run `echo scan > /sys/kernel/debug/kmemleak`
> 2. Wait 2-3 seconds
> 3. Run `echo scan > /sys/kernel/debug/kmemleak` again
> 4. Check if the report disappears.
>
> If it persists across multiple scans, then it might be a real leak.

Thanks for looking into this, if you are able to confirm that this is
a real leak, please let us know.

--=20
paul-moore.com

Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACC42E3716
	for <linux-security-module@vger.kernel.org>; Wed,  3 Sep 2025 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931202; cv=none; b=sRnbwdtjzoJmj79NgWc+SIqQ8Bx9qLfD9X8Zw2AKyozUXNUIf2rJYQ0M05w8f/nskmtfE8/HVNdNRGFpS/6BFP3MAlO+PwdaX701QR/24+Rn2pbObSmvcDqxzFGugCc2ve+n3u0KVvETcaovIuK6OzReL63sj1u7BRk5F4SpE+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931202; c=relaxed/simple;
	bh=0MaG39Q10+lRsjDKYez8QkznlAN7+rEuOEcO8KHI5a0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k43Ap14J47LL1Y/zM7K44tGz/7t/wMfhC2q16qNhJ378rEAbHBKmB0tpXPszhzpWvzCkz7za/oi3xTCjdUZowSkOC4jKY0sJAdtI0jNOM+kk+0dhW2hvLIhr8Witshk0CCWLXPuajtcZVkbIHYUXdPhNd0tdu/xVJRrFixiiEOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZkE6CsCz; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZkE6CsCz"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32b6108f2d5so164329a91.3
        for <linux-security-module@vger.kernel.org>; Wed, 03 Sep 2025 13:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756931199; x=1757535999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXOKUhuO1qAsEEf2zdDA37wCLb2DEnMcoGNBMXWm0MY=;
        b=ZkE6CsCziq8zVGP9z73lM6U9o7/BXD4HzR9kNQfyCbvZOBSeAnbO4UohlU7z0woW6T
         srUizqZ6kBhlN553jVhSoQODEOUTYOb/dHnRCQ4lQnMd5TBphl9UvAFZTMZSPSIJUllM
         MBnl/mCRq6HdGpYI3B8+BCp8QVKqTM22vBgzTIFoKA7WgEyLf8perBKVUUg6bLbhinJi
         uM5lcV5XiZqKrv+YKj3Qzh3pJnXvbWWxzYr+Z/ibEEVt0ZMSYYl3cjM+HH3CJIe+a/Er
         f+x5KL607eya2h2G0sPICeCuVrNYv9JoJsqVqZ6ohrkzu6D5qEMBPFJT/N/6kgufysfb
         be7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756931199; x=1757535999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXOKUhuO1qAsEEf2zdDA37wCLb2DEnMcoGNBMXWm0MY=;
        b=vbH3tX+9vpFi2Mvc2o+0WKKIJskARewd+dFE0o9XFXku/CHE1XNPtLEyZOcVQYWstj
         PlFq2HAEQ/RIUwymbiFjnmmmIfpGnVTv1w05xaztckZhgKR/9pZNiOi8oWQucokmF7b2
         cAAwD0d7gsdWsycU+KFFAm1W3gTfjd1JEM3GT4v8tCjHePkvM24u8wVfqDEd4PFTfr0O
         l8NNPlRjEs4g3OU5XAQxCGqllCFM4YgniBkryrwW8O2yt0INsqNDBmzudT1fDD97ZbxH
         8jRcqu8hJysBjJUHXQ4dYeeWgRap32o9nJd4lEe/bMnQxX2PKrrejLiJziZKnJqLdk2i
         MSUQ==
X-Gm-Message-State: AOJu0YyEhwXu43vVjwzQrFQZpIHqRnIK8aAsvgNQywD/Kj1/xGChVzG7
	vW4+d3hmS041VYXduAZrgjF11ZK501VCvuxwnWNOLveANPtDBvvGQIYoxWzh+wXotQNNrKEjgcv
	esidm2+tFP9rKRGA+WrMc/D0ytOQPL6soBUv61mfq
X-Gm-Gg: ASbGnctDtLExGdilPFrdFniIkd+VmJqMAs+df+3bP1mshCwSKb6el/M7pwhCVZEsiHe
	asn3ow3IK4W9njWHRTCbOOPwPjVbqydglKbOr5JzU1WBeHfKbQKvLai9ud8NtCOEh51DUjDru2T
	oliGQAo9+f38RQAWOqiL//bhldXOsgoaYtq2cbjoWxdesMDZwJL5cIE1fUCHG5K+9EMn5PpvOyv
	WDyP8Y=
X-Google-Smtp-Source: AGHT+IGlvup2xpjVL7Dhtel9vzzWcSj+zF8XRGa4iEdhrLRU5CzfIiVjQSX5z0wuO723g1nSxHsZHaxDuStGWwe0zYc=
X-Received: by 2002:a17:90b:2550:b0:32b:92ac:cfb6 with SMTP id
 98e67ed59e1d1-32b92acd0a2mr453692a91.12.1756931199212; Wed, 03 Sep 2025
 13:26:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-47-paul@paul-moore.com>
 <06a68323-b297-4be7-92eb-c2091207b9f0@canonical.com>
In-Reply-To: <06a68323-b297-4be7-92eb-c2091207b9f0@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Sep 2025 16:26:26 -0400
X-Gm-Features: Ac12FXx8har4tdX6rI0dDPC0HOg1CPyZ1wT-CCBQj6hwAZvlOnWX7etUk1-2YCQ
Message-ID: <CAHC9VhQnFJLXrhcbQ2b7rWDNYjRRKoevqiKYchE_39ShcjgLEw@mail.gmail.com>
Subject: Re: [PATCH v3 11/34] lsm: get rid of the lsm_names list and do some cleanup
To: John Johansen <john.johansen@canonical.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 1:20=E2=80=AFPM John Johansen
<john.johansen@canonical.com> wrote:
> On 8/14/25 15:50, Paul Moore wrote:
> > The LSM currently has a lot of code to maintain a list of the currently
> > active LSMs in a human readable string, with the only user being the
> > "/sys/kernel/security/lsm" code.  Let's drop all of that code and
> > generate the string on first use and then cache it for subsequent use.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >   include/linux/lsm_hooks.h |  1 -
> >   security/inode.c          | 59 +++++++++++++++++++++++++++++++++++++-=
-
> >   security/lsm_init.c       | 49 --------------------------------
> >   3 files changed, 57 insertions(+), 52 deletions(-)
> >
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index 7343dd60b1d5..65a8227bece7 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -172,7 +172,6 @@ struct lsm_info {
> >
> >
> >   /* DO NOT tamper with these variables outside of the LSM framework */
> > -extern char *lsm_names;
> >   extern struct lsm_static_calls_table static_calls_table __ro_after_in=
it;
> >
> >   /**
> > diff --git a/security/inode.c b/security/inode.c
> > index 43382ef8896e..a5e7a073e672 100644
> > --- a/security/inode.c
> > +++ b/security/inode.c
> > @@ -22,6 +22,8 @@
> >   #include <linux/lsm_hooks.h>
> >   #include <linux/magic.h>
> >
> > +#include "lsm.h"
> > +
> >   static struct vfsmount *mount;
> >   static int mount_count;
> >
> > @@ -315,12 +317,65 @@ void securityfs_remove(struct dentry *dentry)
> >   EXPORT_SYMBOL_GPL(securityfs_remove);
> >
> >   #ifdef CONFIG_SECURITY
> > +#include <linux/spinlock.h>
> > +
> >   static struct dentry *lsm_dentry;
> > +
> > +/* NOTE: we never free the string below once it is set. */
> > +static DEFINE_SPINLOCK(lsm_read_lock);
>
> nit, this is only used on the write side, so not the best name

Fair point, I'll rename it to lsm_read_str_lock, it still has "read"
in the name, but it should be a bit more clear that it references the
lsm_read_str variable.

> > +static char *lsm_read_str =3D NULL;
> > +static ssize_t lsm_read_len =3D 0;

Similarly, I'm renaming lsm_read_len to lsm_read_str_len.

> >   static ssize_t lsm_read(struct file *filp, char __user *buf, size_t c=
ount,
> >                       loff_t *ppos)
> >   {
> > -     return simple_read_from_buffer(buf, count, ppos, lsm_names,
> > -             strlen(lsm_names));
> > +     int i;
> > +     char *str;
> > +     ssize_t len;
> > +
> > +restart:
> > +
> > +     rcu_read_lock();
> > +     if (!lsm_read_str) {
>
> should probably be
> if (!rcu_access_pointer(lsm_read_str)) {

The description for rcu_access_pointer() contains the following sentence:

  "Within an RCU read-side critical section, there is little reason to
   use rcu_access_pointer()."
  https://elixir.bootlin.com/linux/v6.17-rc4/source/include/linux/rcupdate.=
h#L628

Perhaps I'm reading it wrong, but it looks like the RCU folks would
prefer we not use rcu_access_pointer() here?

--=20
paul-moore.com

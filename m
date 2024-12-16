Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE0A143723
	for <linux-security-module@vger.kernel.org>; Mon, 16 Dec 2024 22:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734389994; cv=none; b=cT3aGSIpULW3ekEMG0CU/BhZEi6Tcw4RT9+NtVsidgGdzNLWbtNhH8XmN9hO0j9V7dyRYF7kNiyqWLUB/+HLAB7UyFSncYBFlvmxnvd15Jcrp9ewuhaKFxp7lIuHx7B5c+XMUc/OqxeAszQkzxXlYbIPBRcwlPPFD5olBbn8qnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734389994; c=relaxed/simple;
	bh=6CzZjhZCFL0Ybneq0eBqdaZBEzuWpGJse2bKpcrxqa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMWXjnJnV+gZsNb0HyLY4qTG7enzMEmxv+M8YhU3o2LLZyFuA5p2AvxQ3oeBlaiPkJFYIjFYT/+zsD5mj4kChqgBIxWLIveLZ6G31ysyc0i1JIl0/GlwyntYFkdefZLiymiwEqYysTkR+PAW0Ri9eKg6Ky8PcgukmC+eZq7AhQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KQsV/XqD; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KQsV/XqD"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e46c6547266so2129805276.3
        for <linux-security-module@vger.kernel.org>; Mon, 16 Dec 2024 14:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734389992; x=1734994792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Lfh5UPu/j3h78rAA5gO/RJboYcPhcbanZwSgKE8DBw=;
        b=KQsV/XqDdIcSoWC0jtN8CqEdBKzOJlxalmyuyT1KpFpXxNcHFKXV7JyukNCzBmBnjO
         MuN++EEGRrffkyaxHHidZrVfZIItV2DcQZQIeklcHU9caK3X1IxT4vJKzr2SRX40bRgS
         0e9f9mQnQ6QGm3aL6E16p6+jEvqvYr6e1tLDOsQ+PEFawqkDN+ETMCh2EhtBtKaeamMk
         8zbpV/sQmpNHZu1bZgiYAggXduDhRmlgQytvzSQf8bs9bpaV4kcrtqBMcVdDPL8iItBA
         c0e3g0kT5R0wV89d1wNkaUUNUDPfh5NF42M8vYzPEcoo77RtT8xTF4SJfwfe8K9qgA4t
         Vqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734389992; x=1734994792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Lfh5UPu/j3h78rAA5gO/RJboYcPhcbanZwSgKE8DBw=;
        b=WBkwYmwkaQArOakOvRc+S7s7WcsiCyZnQBGJlUp6cLV+yuf8m3bCXGNcV3MS+h7/Eg
         gtujucJeZ3TXT/uYcMwM/QokyK5y9Tz9LbOPIeHVDmIgtr4xoWLZuI8tXGLHYW4+2MQw
         X8ZKPBjxLrXiC9OY1KL18ETpxVZucfycbq7/1Sgmlacvt3c/e13gttEmUDFsJiOa61X7
         BYUXjfhIq6lB8gPsrKHq0OZpk7Klmsdvg+XkafVWQwqApUqzgrG9KofAg8Xw9C4NdHxS
         rRMcxvNuA/qnz4xa2Lr1x7Lx6nQ5rCwGgSOHQg3YFS3Vq7L8YAKzSdNSmldYXS6/obDK
         cE7g==
X-Forwarded-Encrypted: i=1; AJvYcCV4zhLr6YfDgSpXBGl6rht9UkS4uO1BGGYEFyAbZlJKgF3DSGKv0hwJM3dJCnBPvDpV/ETcTR9Fq+dC6CB0d3qdVsOYBp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCYbUQXddJ6ycyJEcbCZtZlORku3lPhuLeAWJBt3k7f3KyEP7m
	6xIjkvT+s1/7XNb5Z98qgus5y1J4bRJMfZDeUOJhe0ALU4oHKjZJia4bFd7OG6ZyuL075qZNDJq
	27XJknkxUXJpAfreRkq6fJLMtXmUIVMUXhwSn
X-Gm-Gg: ASbGncuCNVM2diSfV+xuHpNhKhpr9vtCTFWIDS8WNeBcnsnAWWbnCDas52YcCvzSx36
	2a/NqNg1u0yeczFEkFGdaGLqOTdH5+NZEb3tN
X-Google-Smtp-Source: AGHT+IH7eibkUq2e5Dc3R+veB818DrzM9GHb597Rjdip4BACdsyaPWU/84UKp8Q4zq5Sq5eeEXCS+lMeszEgozCdizo=
X-Received: by 2002:a05:6902:2487:b0:e4d:89e9:6a97 with SMTP id
 3f1490d57ef6-e52f963078dmr1437392276.3.1734389991958; Mon, 16 Dec 2024
 14:59:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <675f513a.050a0220.37aaf.0106.GAE@google.com> <20241216030213.246804-2-leocstone@gmail.com>
 <86023b72-1a45-4115-b800-93297a3e2405@I-love.SAKURA.ne.jp>
In-Reply-To: <86023b72-1a45-4115-b800-93297a3e2405@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Dec 2024 17:59:40 -0500
Message-ID: <CAHC9VhRDrmNBF7ta_AHNbztDZ90zCJ81+m+4inGu_Jv2m2dChA@mail.gmail.com>
Subject: Re: [PATCH] lsm: check size of writes
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Leo Stone <leocstone@gmail.com>, 
	syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com, jmorris@namei.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	mortonm@chromium.org, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 4:59=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/12/16 12:02, Leo Stone wrote:
> > syzbot attempts to write a buffer with a large size to a sysfs entry
> > with writes handled by safesetid_gid_file_write(), triggering a warning
> > in kmalloc.
> >
> > Check the size specified for write buffers before allocating.
> >
> > Reported-by: syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D4eb7a741b3216020043a
> > Signed-off-by: Leo Stone <leocstone@gmail.com>
>
> Since handle_policy_update() has two callers, you should check
> inside handle_policy_update().
>
> By the way, since syzbot found this pattern in multiple LSM modules,
> do we want to ask Andrew Morton to send all patches in one pull request
> (instead of sending trivial patch from multiple LSM modules) ?

I think you mean Micah Morton (mortonm) and not Andrew Morton (akpm),
yes?  Micah is the SafeSetID maintainer while Andrew maintains the
memory subsystem, and likely a few others.

In order to help prevent merge conflicts across the different LSM
trees I think it would be best for each LSM maintainer to merge their
respective patches.  If one of the maintainers is not responding after
a period of time, I can pick up the patch via the LSM tree.  We have
had some issues with SafeSetID in the past, but I'm hopeful we
resolved that with Micah and we just need to give him some time to
review and pickup this patch.

> > ---
> >  security/safesetid/securityfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/safesetid/securityfs.c b/security/safesetid/secur=
ityfs.c
> > index 25310468bcdd..5eba4c7f8d9e 100644
> > --- a/security/safesetid/securityfs.c
> > +++ b/security/safesetid/securityfs.c
> > @@ -254,7 +254,7 @@ static ssize_t safesetid_gid_file_write(struct file=
 *file,
> >       if (!file_ns_capable(file, &init_user_ns, CAP_MAC_ADMIN))
> >               return -EPERM;
> >
> > -     if (*ppos !=3D 0)
> > +     if (*ppos !=3D 0 || len >=3D KMALLOC_MAX_SIZE)
> >               return -EINVAL;
> >
> >       return handle_policy_update(file, buf, len, GID);

--=20
paul-moore.com

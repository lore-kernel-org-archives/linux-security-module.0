Received: from mail-vs1-f67.google.com (mail-vs1-f67.google.com [209.85.217.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CCC3542E1
	for <linux-security-module@vger.kernel.org>; Wed, 11 Feb 2026 19:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770839015; cv=pass; b=ld0DZyXRhb7z4U7SQbGbYHgjlnBE6WaC6sytonWeiSPLP7muAyFZtBitzBjXEPexBPTdVzv/cJK1rinAlBXRlQbSL/vbPYGudK7SQzpJWelO2B8hS3ruGw//SGBh+A4W3jgociQshNlKoVOHRjk80dasDr/WIH0Xjrq+vGnliiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770839015; c=relaxed/simple;
	bh=oXQ1XB8B3wClH1fLqpgOnCS78LK40SPPGujDt6bxq94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQ6roegRJ36SLFQaRDFkCaM/XCfqRL/NL+A8N/xgtgmHm5JVdQh2O3SFi9LErMRcObHl+eG4kOZ+FTIJ7ltGEdRhqbRjCPiZ6/BiFrBoY2hhQyFKVQqtkeUR0NX+tlOaDmUYTPc+akWefhQJxQQ8GYnNV4JdQsGXM+nHQL9/NOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PowYvJbT; arc=pass smtp.client-ip=209.85.217.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PowYvJbT"
Received: by mail-vs1-f67.google.com with SMTP id ada2fe7eead31-5fdf3735e14so430395137.2
        for <linux-security-module@vger.kernel.org>; Wed, 11 Feb 2026 11:43:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770839013; cv=none;
        d=google.com; s=arc-20240605;
        b=RyFEL0c+zFOso4XeWuwAXNCAEViyxM+da0XN6NUUdIbR0BxLBjDkxBujfzuzK++By6
         6RcgCZVrzIfMoA2U9hRUn6DVh1l5dlu1Xske8dlR0aAw7IFBvU2hKHzBY3ojAy8y4quD
         n5T1DOWxUgr+q66kGBOnjdpgSa1DbhM+9GbAzxWOq7Lf615Kmc5c6eEhqKieTdSyKQFx
         XTG5yYHo2a+b4q1SWXOmtrTaihVWzQu/rT9q7c/n9TwupF+3rb+VN0aAmoG6qlwwDbjl
         O7eLOH5HosGQqq40Qb+l5vwmcrBiBOwgb2WybTY5brXWXSGUxnH/Lh5/t6kx5l2a0xFs
         jffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gHntEFiFJWWh+7XoaBNqKXQpADrwgSFaOdTDNIvp++o=;
        fh=mh97L2PU8wqQsTh0bzlxlCuK8YlaL2oTf8jDEHMFtaw=;
        b=FPivtwVt08pzQX6gAPwljfb5LbtMebfox0SFyG0pBNje9IEKsIY2ZP2Kfc0++HNZWY
         aMXqnhNfZfGoWoF3WdJpKWvMNTWI6IN7H+at4uhI6vxvc+WZxcNfwX/FlnmcDT4WL/KR
         1yfnITCPlQ9VrAGrVHMk6f+2bI924Rg5YjReJ4brQACndABFlrt7J1B6Bjju/7u7K4aD
         iMgR+ItoktE47Ll9nTRLy8FiLSvEXGYzMbHZJMdkDKLSAb42oVQjU3EByEZRDso8ssNU
         lAWLtPgtnOGcCMunlisdLKwomAdKc8pzbftOeIZ0dk5aoKSDF/veb63SeNir0RkdTc+p
         Ve3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770839013; x=1771443813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHntEFiFJWWh+7XoaBNqKXQpADrwgSFaOdTDNIvp++o=;
        b=PowYvJbTJPD5aOP9KtNXgpElGAHlayOJtccZi17gLCiV7NklgomQwPWvFL+tS/F06+
         a4IHJWMKWcQOCMuG0V5Y1S7C3NMpWRRazWJSMGJ/+lW0n8XplZ7g7PHPZvoIPWr7ddC6
         kBURI9c6WeteHacV61ibMk9mDDzli28UvAOwlslzqHBLPbUBqJzca/m0c5JolC7p1VcV
         qs5+NNIx3MrvmcDaY/OsicJhdP7sZwy9m5emE/013J9SvcxjRvFzxDsyfLjLcjyYInMY
         HBHhumq6HhVkgF0CZKb1GWABndE+59YlInwq0nEKWZ3tZaa6o+GwTjhAB8RDB0zcOK4h
         ee1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770839013; x=1771443813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gHntEFiFJWWh+7XoaBNqKXQpADrwgSFaOdTDNIvp++o=;
        b=PgjeQsRsy5YSzShjqwMeyK8FA4SfnSyh6EQDGLKVpX4gG9oTRQcNad34xVezCMFYJP
         4+TW3UjFQPizaffejr70+tAk7M9cJWQCI95qE5jAm8AwGI9MNZmIFovaO8cOUNlyJnf7
         KHLN4HaqaUpgFST5lY0ChLlKAfTzkIEVGRyJQYS5l8aln7TBIMvzlDY6p+0a+Fkf6Ew5
         85aiHxpFPet90bBC1VKiD2dl12BYMs6kKy23jBzS3ZCG1xSRax7ZgA1o/7ighRneT4Z8
         jbf8FoXMgrGWCjnazoq97gPXlcei7VC6EdMeWnXUUOMRSC8JvdWuujauEqhxAYzUAJcJ
         5vbg==
X-Forwarded-Encrypted: i=1; AJvYcCWtzqHMZPmBtk+n3gZdRpvBoqH4HRQQ7LGpk9YLS0J6ULD9CL91XMiDaz/RGFveb2t9xZHXKrQzoyDv8E2Ln7pMAyExbtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEFmz+UPpKBO3MDb35YTKe4jlVo3Rt16aFRmhrfbVRY1eKmq/V
	wJbL2+O58/3j4mj620aRJQEmT9d8Uzyy7QMZahXVXLJUSLvSUd3YgInpd9I3pfjS1wPBHKvrCJt
	q2vHfomhpS8YL4+CYbJ5ZRmDv0lWOKxw=
X-Gm-Gg: AZuq6aKEahVOD4uF0wasFMveakUx04G4T7TQlPkKki6MF4MEJupFn8BDwwkB9qe1V7Z
	8f9juSeIuoRMqUQs0DzOie0OCmb3InLPUHu6OqWYThR9sOALsq5wqts5C6sBZ+ZdLcAQ3CqZCOj
	lPU8egWwVXwO4AOauYN0D1IdbWnUgQnzk+kBxmmNiQcy4Ovy8RSjUyNnL6Q4XIxIe7FB8RjLyE9
	yGWBsf7j+NtP8V8jZz0xJkAAP2ZW0iRVDBqxxyPdfQSZcJaJZd5j6fLZvJISnV70mk7hbtFgn39
	N5oykRo=
X-Received: by 2002:a05:6102:b03:b0:5fd:faf5:bc7a with SMTP id
 ada2fe7eead31-5fdfbe41f38mr144483137.41.1770839012601; Wed, 11 Feb 2026
 11:43:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206180248.12418-1-danieldurning.work@gmail.com> <20260209-spanplatten-zerrt-73851db30f18@brauner>
In-Reply-To: <20260209-spanplatten-zerrt-73851db30f18@brauner>
From: Daniel Durning <danieldurning.work@gmail.com>
Date: Wed, 11 Feb 2026 14:43:21 -0500
X-Gm-Features: AZwV_Qhs3SxVp8P05lu1S3k0H4-gjDRINJd9WaPk3va07O3EBGHdjmRA3KZwHck
Message-ID: <CAKrb_fEXR0uQnX5iK-ACH=amKMQ8qBSPGXmJb=1PgvEq8qsDEQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fs/pidfs: Add permission check to pidfd_info()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	paul@paul-moore.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 9:01=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, Feb 06, 2026 at 06:02:48PM +0000, danieldurning.work@gmail.com wr=
ote:
> > From: Daniel Durning <danieldurning.work@gmail.com>
> >
> > Added a permission check to pidfd_info(). Originally, process info
> > could be retrieved with a pidfd even if proc was mounted with hidepid
> > enabled, allowing pidfds to be used to bypass those protections. We
> > now call ptrace_may_access() to perform some DAC checking as well
> > as call the appropriate LSM hook.
> >
> > The downside to this approach is that there are now more restrictions
> > on accessing this info from a pidfd than when just using proc (without
> > hidepid). I am open to suggestions if anyone can think of a better way
> > to handle this.
>
> This isn't really workable since this would regress userspace quite a
> bit. I think we need a different approach. I've given it some thought
> and everything's kinda ugly but this might work.
>
> In struct pid_namespace record whether anyone ever mounted a procfs
> with hidepid turned on for this pidns. In pidfd_info() we check whether
> hidepid was ever turned on. If it wasn't we're done and can just return
> the info. This will be the common case. If hidepid was ever turned on
> use kern_path("/proc") to lookup procfs. If not found check
> ptrace_may_access() to decide whether to return the info or not. If
> /proc is found check it's hidepid settings and make a decision based on
> that.
>
> You can probably reorder this to call ptrace_may_access() first and then
> do the procfs lookup dance. Thoughts?

Thanks for the feedback. I think your solution makes sense.

Unfortunately, it seems like systemd mounts procfs with hidepid enabled on
boot for services with the ProtectProc option enabled. This means that
procfs will always have been mounted with hidepid in the init pid namespace=
.
Do you think it would be viable to record whether or not procfs was mounted
with hidepid enabled in the mount namespace instead?

> > I have also noticed that it is possible to use pidfds to poll on any
> > process regardless of whether the process is a child of the caller,
> > has a different UID, or has a different security context. Is this
> > also worth addressing? If so, what exactly should the DAC checks be?
>
> Oleg and I had discusses this and decided that such polling isn't
> sensitive information so by default this should just work and it's
> relied upon in Android and in a bunch of other workloads. An LSM can of
> course restrict access via security_file_ioctl().
>
> Fwiw, pidfds now support persistent trusted extended attributes so if
> the LSM folks wanted we can add security.* extended attribute support
> and they can mark pidfds with persistent security labels - persistent as
> in for the lifetime of the task.
>
> > Signed-off-by: Daniel Durning <danieldurning.work@gmail.com>
> > ---
> >  fs/pidfs.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > index dba703d4ce4a..058a7d798bca 100644
> > --- a/fs/pidfs.c
> > +++ b/fs/pidfs.c
> > @@ -365,6 +365,13 @@ static long pidfd_info(struct file *file, unsigned=
 int cmd, unsigned long arg)
> >               goto copy_out;
> >       }
> >
> > +     /*
> > +      * Do a filesystem cred ptrace check to verify access
> > +      * to the task's info.
> > +      */
> > +     if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
> > +             return -EACCES;
> > +
> >       c =3D get_task_cred(task);
> >       if (!c)
> >               return -ESRCH;
> > --
> > 2.52.0
> >

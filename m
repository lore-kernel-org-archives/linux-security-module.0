Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1226A13DDB9;
	Wed, 25 Sep 2024 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727257745; cv=none; b=oZ0g2kbfmWWeTVNZzAsv6I3Vfn8iIP5T4hafXD2IdD6DVIPbfEFawGAIPKKIoVYG+bQ2XQuEsCUAo5csaPv02VKlyZlGTbQAiB3RrWnr8gy08H0xyAnvJY31+hetKZE6CoFh8HV1nN9+6cP6h2P5MI8ieFB2x9yj1dxx2RsV2H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727257745; c=relaxed/simple;
	bh=iAAeFJ8JZnzjZMFhbPFm5j1KiUQgwapUpx0At078Wqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8BnwPG4O+pWd0TTKQWs1ayXMsSeCez46juugwHNJSmBilnlgODVlABfvK1TKxxqUGGGSsmyQ0XE9NpX9Hw8YIDnQE+jJScWx6lOVWy10GWkhFIS0H2Ft7imGwBT/0en4EYHj3VNs/Y/E7DAj8adWhs5ffeGEn4gj70jYJnumZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIWq2mUh; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIWq2mUh"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53568ffc525so7682735e87.0;
        Wed, 25 Sep 2024 02:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727257741; x=1727862541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8XLjvV0Uhz8/lsidK2GZAkhOD7DZjaxTggs1N63dxw=;
        b=DIWq2mUh/953oLSmTMGtsDeSl/6SL7kXYgr+iIRKQXDgtFXff6F1u1Sv/waQGmhnql
         LtyYFyCnhFbiGtrGOd6vrB0Haef3nQlDngurj3dlg1J94RHb+VTXVBtn8IqvDZCxGhwp
         zs8oNNmij9td0z15wtcDy8tKmiko7zj+VIGvmOvWsbtYn19ASplmwrqJoY0iUbfCs61x
         Ry79s7FM1b/ipZFCmNC0/qEJ9p0iwGtXcimlWtqWtmnxiTVaWgog0wVZDa5C5sTA3MX2
         IwI+CHdeewYhTPvGB5d2Ohumxd/83xZ9mZ87eA/1FHVWFzFLYaeqI96ZyN0jslPgK+nE
         2Ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727257741; x=1727862541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8XLjvV0Uhz8/lsidK2GZAkhOD7DZjaxTggs1N63dxw=;
        b=aM1sOdBT0/o4vake+2bQjoRWv/JIhu04bMWiXGCtGWJgPhfsOw0Vcf7M/aJV7I5LVO
         SoNqW2ia0CeeZsC0RdXHDempEf5hBWzneLWS+hQ/jBFkaVRnCUr1k25MtizG0VUL1oHX
         EzNRdubPQ9EG5FrmOxOEwg9Dq2wrdafqZlqqv9xcCezJiwfvnTXn7BqlrL6Po39khT7+
         TbpXMMokF5eoqO8Myqf144ZWmmLPtf6d6NzJlGUrJptT3iGf/zodA4d3JeefO/SVC3Xk
         UA+mBrYAn9vVeT6e/hsCW4Z8MYddMa9g6Ri4z3g/50NdXtOMcGE8PR9b7/AmBRM0YpDQ
         L+2w==
X-Forwarded-Encrypted: i=1; AJvYcCU3T5ZTBIHwjfyok7KJ0Rk7oWnmgtdKWSEQR9A9RUMmPiEOy7eEuuKFoJxUpbm/PWqdmM8hO5S6Fx7O3ci1sbHeO2IxXYCY@vger.kernel.org, AJvYcCWmcV50EVKlc7/jCpwBV6s8dN/Ly6v3844S3Kc9jD8qAE2o6Jal91e6vl/c5uWxb6mdOVpvCZ82iPSwHSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhGcFl8WduqSrrMaolp3+pIT5z9q0rUrZiwNYddYZdMkuL34MU
	LPfldE/ElIMd4OdTsU5ko8GeXF2LERKKKqd4BGP+/gnmQIU0mnP74zlZ6aCKOhBu3pe5wJMMATs
	d97g12ubqKwskrdO/rIWQ6vmrNp0=
X-Google-Smtp-Source: AGHT+IH9tGGmzuoLdC+9FXy5dnBsaQ1Nkmre0QQV5rsQ+OMz1rCD3hlJDYfZvk0zaO5dBMltrkcDTbCLFOGk+jhleJY=
X-Received: by 2002:a05:6512:e93:b0:535:6cef:ffb8 with SMTP id
 2adb3069b0e04-5387756780cmr1158043e87.54.1727257740572; Wed, 25 Sep 2024
 02:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925081628.408-1-ebpqwerty472123@gmail.com> <64882dd5-5efd-4912-ab3d-0e6ee76380cf@lucifer.local>
In-Reply-To: <64882dd5-5efd-4912-ab3d-0e6ee76380cf@lucifer.local>
From: Shu Han <ebpqwerty472123@gmail.com>
Date: Wed, 25 Sep 2024 17:48:45 +0800
Message-ID: <CAHQche-B9P00QEbBN7-6s64EEm6+VXOgDDPZtaf12LLSV_nnqA@mail.gmail.com>
Subject: Re: [PATCH] mm: move security_file_mmap() back into do_mmap()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, Liam.Howlett@oracle.com, vbabka@suse.cz, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

TL;DR: Thanks for the sugguestions in format. But for actual content, it ma=
y
be more appropriate to read it in its entirety first.

> TL;DR: NACK because you sent two conflicting non-RFC patches as
> 'alternatives', which is not how development on-list works. Please resend
> maybe one of these as an RFC...
>
> +Al into this as he is the author of commit 8b3ec6814c83.

> You can't send multiple conflicting non-RFC patches at once... that's
> completely ridiculous.
>
> NACK, and re-send one of these as an RFC perhaps referencing the other as
> an alternative?

I am very sorry that I sent the wrong subject which should add "RFC",
due to lack of experience.

> On Wed, Sep 25, 2024 at 04:16:28PM GMT, Shu Han wrote:
> > This patch moves the security_file_mmap() back into do_mmap(), which
> > revert the commit 8b3ec6814c83d76b85bd13badc48552836c24839
> > ("take security_mmap_file() outside of ->mmap_sem"). Below is the reaso=
n.
>
> Nit - we typically use the short version of the commit hash when
> referencing a commit, so this would be commit 8b3ec6814c83.

Thanks for the correct of format.

> Also if this is a revert this should be reflected in the subject... and
> presumably given the original patch is from 2012 it's not a revert at all=
?

It is conceptually a revert of the commit(revert the feature change in the
commit), but not in the git sense(revert the lines of code).

> 'Some logic'? Which?

The next paragraph provides corresponding examples.

> There's no security_file_mmap() function in the kernel? You mean
> security_mmap_file()? You're attempting to do something pretty major here=
,
> so while this is obviously a typo it's pretty important you get these
> details right :)

Thanks for the correct. In fact, this is copied from others reply.

> But we might want to do things internal to the kernel that don't require
> this check? Drivers can map too - the only place we need to be doing the
> security check is in the user-facing mmap syscall.
>
> If something is added that calls do_mmap() without proper security checks=
 -
> that's a bug in _that_ interface.
>
> So I disagree with this patch as a whole.
>
> Keep in mind we _do_ perform a security-hooked free memory check in the
> mmap logic security_vm_enough_memory_mm(), so it isn't as if everything i=
s
> bypassed, only this security_mmap_file() function.
>
> Which is surely only applicable in instances of user-facing API so is... =
in
> the right place now?
>
> Yeah I am not convinced on any level.

Bypass security_mmap_file() is enough for an attack for SELinux.

As with the position of security_vm_enough_memory_mm(), the LSM hook must
be placed in a __internal__ position to avoid bypassing as mentioned in
the two examples, which can lead to serious security issues.

SELinx and many other mandatory access controls(MAC) rely on LSM hooks.
MAC is not a shallow interception of user-facing like seccomp, it is
__not__ a DAC. In fact, SELinux also restricts some internal behaviors
of the kernel (the SELinux label for the kernel is usually `u:r:kernel:s0`
). Yes, in the sense of DAC, the kernel certainly has full permission.
But MAC must prevent user space code implicitly triggering the internal
behavior of the kernel, which can be expolit by attackers.

Do such a change is also suggested by LSM maintainer in the fix of [1].

> > It is noteworthy that moving the security check in do_mmap() will let i=
t
> > in the mmap_write_lock, which slows down the performance and even have
> > deadlocks if someone depends on it(Since security_file_mprotect() is
> > already in the lock, this possibility is tiny).
>
> Err what? We can't accept a patch that might deadlock even if you claim t=
he
> possibility is 'tiny'... that's a NACK in itself. You _have_ to demonstra=
te
> that you aren't deadlocking, this isn't optional.

Yes, this patch should be marked as a RFC, not request for merge immediatel=
y.

> > Link: https://project-zero.issues.chromium.org/issues/42452389 [1]
> > Link: https://lore.kernel.org/all/20240919080905.4506-2-paul@paul-moore=
.com/ [2]
> > Signed-off-by: Shu Han <ebpqwerty472123@gmail.com>
>
> You need to have a fixes tag here for Al's patch presumably.

This is not a fix for these two links, but a further measure taken to avoid=
 the
recurrence of such fixed issues.

> Err.... why are we removing all of this??

This is mentioned in patch.

> > Moving security_file_mmap() back into do_mmap() can avoid
> > forgetting, and avoid __repeated__ logic for whether READ_IMPLIES_EXEC =
should
> > add PROT_EXEC for the mapping or not(In current, the !MMU case won't
> > imply exec if the file's mmap_capabilities is not exist, but the
> > security check logic is different).

Link: https://lore.kernel.org/all/20240919080905.4506-2-paul@paul-moore.com=
/ [1]

Lorenzo Stoakes <lorenzo.stoakes@oracle.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=
=8825=E6=97=A5=E5=91=A8=E4=B8=89 16:44=E5=86=99=E9=81=93=EF=BC=9A
>
> TL;DR: NACK because you sent two conflicting non-RFC patches as
> 'alternatives', which is not how development on-list works. Please resend
> maybe one of these as an RFC...
>
> +Al into this as he is the author of commit 8b3ec6814c83.
>
>
> On Wed, Sep 25, 2024 at 04:16:28PM GMT, Shu Han wrote:
> > This patch moves the security_file_mmap() back into do_mmap(), which
> > revert the commit 8b3ec6814c83d76b85bd13badc48552836c24839
> > ("take security_mmap_file() outside of ->mmap_sem"). Below is the reaso=
n.
>
> Nit - we typically use the short version of the commit hash when
> referencing a commit, so this would be commit 8b3ec6814c83.
>
> Also if this is a revert this should be reflected in the subject... and
> presumably given the original patch is from 2012 it's not a revert at all=
?
>
> >
> > Some logic may call do_mmap() without calling security_file_mmap(),
> > without being aware of the harm this poses to LSM.
>
> 'Some logic'? Which?
>
> There's no security_file_mmap() function in the kernel? You mean
> security_mmap_file()? You're attempting to do something pretty major here=
,
> so while this is obviously a typo it's pretty important you get these
> details right :)
>
> >
> > For example, CVE-2016-10044[1] has reported many years ago, but the
> > remap_file_pages() can still bypass the W^X policy enforced by SELinux[=
2]
> > for a long time.
> >
> > Add a check is easy, but there may have more calls to do_mmap() in the
> > future. Moving security_file_mmap() back into do_mmap() can avoid
> > forgetting, and avoid repeated logic for whether READ_IMPLIES_EXEC shou=
ld
> > add PROT_EXEC for the mapping or not(In current, the !MMU case won't
> > imply exec if the file's mmap_capabilities is not exist, but the
> > security check logic is different).
>
> But we might want to do things internal to the kernel that don't require
> this check? Drivers can map too - the only place we need to be doing the
> security check is in the user-facing mmap syscall.
>
> If something is added that calls do_mmap() without proper security checks=
 -
> that's a bug in _that_ interface.
>
> So I disagree with this patch as a whole.
>
> Keep in mind we _do_ perform a security-hooked free memory check in the
> mmap logic security_vm_enough_memory_mm(), so it isn't as if everything i=
s
> bypassed, only this security_mmap_file() function.
>
> Which is surely only applicable in instances of user-facing API so is... =
in
> the right place now?
>
> Yeah I am not convinced on any level.
>
> >
> > It is noteworthy that moving the security check in do_mmap() will let i=
t
> > in the mmap_write_lock, which slows down the performance and even have
> > deadlocks if someone depends on it(Since security_file_mprotect() is
> > already in the lock, this possibility is tiny).
>
> Err what? We can't accept a patch that might deadlock even if you claim t=
he
> possibility is 'tiny'... that's a NACK in itself. You _have_ to demonstra=
te
> that you aren't deadlocking, this isn't optional.
>
> >
> > Link: https://project-zero.issues.chromium.org/issues/42452389 [1]
> > Link: https://lore.kernel.org/all/20240919080905.4506-2-paul@paul-moore=
.com/ [2]
> > Signed-off-by: Shu Han <ebpqwerty472123@gmail.com>
>
> You need to have a fixes tag here for Al's patch presumably.
>
> > ---
> > An alternative method is moving the check of READ_IMPLIES_EXEC out of
> > do_mmap() and calling the LSM hooks at the same time, which has better
> > performance and compatibility but may introduce some complexity. It has
> > been proposed in [3], which cannot be applied at the same time with
> > this patch.
> > Link: https://lore.kernel.org/all/20240925063034.169-1-ebpqwerty472123@=
gmail.com/ [3]
>
> You can't send multiple conflicting non-RFC patches at once... that's
> completely ridiculous.
>
> NACK, and re-send one of these as an RFC perhaps referencing the other as
> an alternative?
>
> > ---
> >  include/linux/security.h |  8 ++++----
> >  ipc/shm.c                |  4 ----
> >  mm/mmap.c                |  9 +++++----
> >  mm/nommu.c               |  5 ++++-
> >  mm/util.c                | 19 ++++++++-----------
> >  security/security.c      | 41 ++++------------------------------------
> >  6 files changed, 25 insertions(+), 61 deletions(-)
> >
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index c37c32ebbdcd..e061bc9a0331 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -423,8 +423,8 @@ void security_file_free(struct file *file);
> >  int security_file_ioctl(struct file *file, unsigned int cmd, unsigned =
long arg);
> >  int security_file_ioctl_compat(struct file *file, unsigned int cmd,
> >                              unsigned long arg);
> > -int security_mmap_file(struct file *file, unsigned long prot,
> > -                     unsigned long flags);
> > +int security_mmap_file(struct file *file, unsigned long reqprot,
> > +                    unsigned long prot, unsigned long flags);
> >  int security_mmap_addr(unsigned long addr);
> >  int security_file_mprotect(struct vm_area_struct *vma, unsigned long r=
eqprot,
> >                          unsigned long prot);
> > @@ -1077,8 +1077,8 @@ static inline int security_file_ioctl_compat(stru=
ct file *file,
> >       return 0;
> >  }
> >
> > -static inline int security_mmap_file(struct file *file, unsigned long =
prot,
> > -                                  unsigned long flags)
> > +static inline int security_mmap_file(struct file *file, unsigned long =
reqprot,
> > +                                  unsigned long prot, unsigned long fl=
ags)
> >  {
> >       return 0;
> >  }
> > diff --git a/ipc/shm.c b/ipc/shm.c
> > index 3e3071252dac..ce02560b856f 100644
> > --- a/ipc/shm.c
> > +++ b/ipc/shm.c
> > @@ -1636,10 +1636,6 @@ long do_shmat(int shmid, char __user *shmaddr, i=
nt shmflg,
> >       sfd->vm_ops =3D NULL;
> >       file->private_data =3D sfd;
> >
> > -     err =3D security_mmap_file(file, prot, flags);
> > -     if (err)
> > -             goto out_fput;
> > -
> >       if (mmap_write_lock_killable(current->mm)) {
> >               err =3D -EINTR;
> >               goto out_fput;
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 18fddcce03b8..56f9520f85ab 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1260,6 +1260,7 @@ unsigned long do_mmap(struct file *file, unsigned=
 long addr,
> >  {
> >       struct mm_struct *mm =3D current->mm;
> >       int pkey =3D 0;
> > +     unsigned long reqprot =3D prot, err;
> >
> >       *populate =3D 0;
> >
> > @@ -1276,6 +1277,10 @@ unsigned long do_mmap(struct file *file, unsigne=
d long addr,
> >               if (!(file && path_noexec(&file->f_path)))
> >                       prot |=3D PROT_EXEC;
> >
> > +     err =3D security_mmap_file(file, reqprot, prot, flags);
> > +     if (err)
> > +             return err;
> > +
> >       /* force arch specific MAP_FIXED handling in get_unmapped_area */
> >       if (flags & MAP_FIXED_NOREPLACE)
> >               flags |=3D MAP_FIXED;
> > @@ -3198,12 +3203,8 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long,=
 start, unsigned long, size,
> >               flags |=3D MAP_LOCKED;
> >
> >       file =3D get_file(vma->vm_file);
> > -     ret =3D security_mmap_file(vma->vm_file, prot, flags);
> > -     if (ret)
> > -             goto out_fput;
> >       ret =3D do_mmap(vma->vm_file, start, size,
> >                       prot, flags, 0, pgoff, &populate, NULL);
> > -out_fput:
> >       fput(file);
> >  out:
> >       mmap_write_unlock(mm);
> > diff --git a/mm/nommu.c b/mm/nommu.c
> > index 7296e775e04e..e632f3105a5a 100644
> > --- a/mm/nommu.c
> > +++ b/mm/nommu.c
> > @@ -681,7 +681,7 @@ static int validate_mmap_request(struct file *file,
> >                                unsigned long pgoff,
> >                                unsigned long *_capabilities)
> >  {
> > -     unsigned long capabilities, rlen;
> > +     unsigned long capabilities, rlen, reqprot =3D prot;
> >       int ret;
> >
> >       /* do the simple checks first */
> > @@ -818,6 +818,9 @@ static int validate_mmap_request(struct file *file,
> >       }
> >
> >       /* allow the security API to have its say */
> > +     ret =3D security_mmap_file(file, reqprot, prot, flags);
> > +     if (ret < 0)
> > +             return ret;
> >       ret =3D security_mmap_addr(addr);
> >       if (ret < 0)
> >               return ret;
> > diff --git a/mm/util.c b/mm/util.c
> > index bd283e2132e0..47345e927a8f 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -581,17 +581,14 @@ unsigned long vm_mmap_pgoff(struct file *file, un=
signed long addr,
> >       unsigned long populate;
> >       LIST_HEAD(uf);
> >
> > -     ret =3D security_mmap_file(file, prot, flag);
> > -     if (!ret) {
> > -             if (mmap_write_lock_killable(mm))
> > -                     return -EINTR;
> > -             ret =3D do_mmap(file, addr, len, prot, flag, 0, pgoff, &p=
opulate,
> > -                           &uf);
> > -             mmap_write_unlock(mm);
> > -             userfaultfd_unmap_complete(mm, &uf);
> > -             if (populate)
> > -                     mm_populate(ret, populate);
> > -     }
> > +     if (mmap_write_lock_killable(mm))
> > +             return -EINTR;
> > +     ret =3D do_mmap(file, addr, len, prot, flag, 0, pgoff, &populate,
> > +                   &uf);
> > +     mmap_write_unlock(mm);
> > +     userfaultfd_unmap_complete(mm, &uf);
> > +     if (populate)
> > +             mm_populate(ret, populate);
> >       return ret;
> >  }
> >
> > diff --git a/security/security.c b/security/security.c
> > index 4564a0a1e4ef..25556629f588 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -2927,42 +2927,10 @@ int security_file_ioctl_compat(struct file *fil=
e, unsigned int cmd,
> >  }
> >  EXPORT_SYMBOL_GPL(security_file_ioctl_compat);
> >
> > -static inline unsigned long mmap_prot(struct file *file, unsigned long=
 prot)
> > -{
> > -     /*
> > -      * Does we have PROT_READ and does the application expect
> > -      * it to imply PROT_EXEC?  If not, nothing to talk about...
> > -      */
> > -     if ((prot & (PROT_READ | PROT_EXEC)) !=3D PROT_READ)
> > -             return prot;
> > -     if (!(current->personality & READ_IMPLIES_EXEC))
> > -             return prot;
> > -     /*
> > -      * if that's an anonymous mapping, let it.
> > -      */
> > -     if (!file)
> > -             return prot | PROT_EXEC;
> > -     /*
> > -      * ditto if it's not on noexec mount, except that on !MMU we need
> > -      * NOMMU_MAP_EXEC (=3D=3D VM_MAYEXEC) in this case
> > -      */
> > -     if (!path_noexec(&file->f_path)) {
> > -#ifndef CONFIG_MMU
> > -             if (file->f_op->mmap_capabilities) {
> > -                     unsigned caps =3D file->f_op->mmap_capabilities(f=
ile);
> > -                     if (!(caps & NOMMU_MAP_EXEC))
> > -                             return prot;
> > -             }
> > -#endif
> > -             return prot | PROT_EXEC;
> > -     }
> > -     /* anything on noexec mount won't get PROT_EXEC */
> > -     return prot;
> > -}
> > -
>
> Err.... why are we removing all of this??
>
> >  /**
> >   * security_mmap_file() - Check if mmap'ing a file is allowed
> >   * @file: file
> > + * @reqprot: protection requested by user
> >   * @prot: protection applied by the kernel
> >   * @flags: flags
> >   *
> > @@ -2971,11 +2939,10 @@ static inline unsigned long mmap_prot(struct fi=
le *file, unsigned long prot)
> >   *
> >   * Return: Returns 0 if permission is granted.
> >   */
> > -int security_mmap_file(struct file *file, unsigned long prot,
> > -                    unsigned long flags)
> > +int security_mmap_file(struct file *file, unsigned long reqprot,
> > +                    unsigned long prot, unsigned long flags)
> >  {
> > -     return call_int_hook(mmap_file, file, prot, mmap_prot(file, prot)=
,
> > -                          flags);
> > +     return call_int_hook(mmap_file, file, reqprot, prot, flags);
> >  }
> >
> >  /**
> >
> > base-commit: f89722faa31466ff41aed21bdeb9cf34c2312858
> > --
> > 2.34.1
> >

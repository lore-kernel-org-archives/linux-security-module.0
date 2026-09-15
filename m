Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE144A8FEC
	for <linux-security-module@vger.kernel.org>; Tue, 15 Sep 2026 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493082; cv=pass; b=JoOH+/pBjfjL0plVnJKlZa2/M8xsu3TBQJWYHVtQbvs4Gi1pvpHumhxB/LA47YfQggWiGMoiC14dfdIRPd8ms6RT9/Oq2KZfTcdmWGNuaMxN/IgtRpwcWmiOZgOfG//vUfgke1rEEGq3Si4jWUNtZxIlCq/MPuXKqt0KtmZr9EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493082; c=relaxed/simple;
	bh=YK5Wharn3MvhXziVkzSATMwWQgMc1QJoA1IBgFlVnow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOh7iapsbaNd8aZYHEFeNylHzE0VuGgJ+131JTc/DkJUVR2m9PY18VVnPf6/JmFxYGWHh5wWKyWHtDiifWvi1Cvpg29bvmnLuOfMAhUlGlk6GEU1gNJspPYw0BgFxblmcwgj0Iw0DE4LNaq4q73W1U2+TT7jepURMkRdj0g+89w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BBMAX2bw; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BBMAX2bw"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed1368so315075ad.1
        for <linux-security-module@vger.kernel.org>; Tue, 15 Sep 2026 10:24:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789493080; cv=none;
        d=google.com; s=arc-20260327;
        b=EcM2lztm1Yw21OQ7gYBvX3NVMLkVEpoQc5MLbOfSxNGTY6sAM2zuGNvNu4+qyFBC8m
         kB87mvu7/3VnaVbJJIiedoiGN5P9/X3UKAo+yDwiVZQX3plG2b1v91d8bOBG9FYKPGOu
         SaZR6frha+C9cqXPrhQGzOCXemBjz4PCQ5Hedc5cGFsPS2z9h3p3YQZCzMun/XiLVHh3
         vDEQgM05EDBwl4cGvOeZG9TkhqJv0UNnhZNHulNZflOujnFzN4osU1DByHDcXcBarayn
         puQ7ApUKxwHgXT/MS6yJ2+XOKZ3U0IZgzBTVUphpAIQqKpZOgRT54jmPzHKr2qCKUQyM
         OAtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o7oag7tiLT9gQ7HZpXwTqWFezAuLM/E3QUVZxySQWaQ=;
        fh=GUDm3y6q7uwZvbs812iYiTmo7RuQNmGNA7VdK8lAV7Y=;
        b=izZoWX16Jxeq7fD6cd8fG8daHHC9H2+/wMzMRM32uxsiCqOzcrK8WEYEWks9rmicPr
         9x9l9+1ZB2mzmDWwNX/1CdeLky4SRH3xEnalkhUldB1P/CbCjBUQJOeWof1F67QCwnwZ
         8ooyCXfrXaN7HTRCQaVI8000F8QBkEzaegmTS+1PxpMp7woQpra1nAKUz6V7hHjLXzNS
         IAJ4XoShHMBhj5HAK4YQjXDUEyN4tDg4Rhe7BXdotuwBAIza/9TYhurJW8ghQN8Ky75o
         GhzBkrg2Pd+YLTLwlX5hp9RtIjRoTUebHVKu/FzT4VvmEaMY6zpR34WRT8bPUC1cwWB6
         p60A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789493080; x=1790097880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o7oag7tiLT9gQ7HZpXwTqWFezAuLM/E3QUVZxySQWaQ=;
        b=BBMAX2bw5EeGurrd/QnGsKlGFtaRiTPpaxZKh+yLe47ZwOYOprejq/jhzZSgYGhMuj
         1Ng6/qZd82evfIFQR1isM0C2li89khhnvDdPgC9a6CzBa9zDLQxvYNnyOTkzzYIfDCWt
         YtKhqCqcWfIZMWr/xQjwtVaLSydxOsurYv7DFTPN2wQ58zTC/5iUYlfEuDFQ4KsglHC+
         +77XxEAGDtKWu54YWvZamSpIqK+jpIIuut8NDMBVtplQMWQzAp+RtzKD/KXm0Epivsoh
         ozsTGTcCAC55j50oK3bV+F3h1ivhrwYl8WFdALqQY/PB8rrp7EfLLTxDeQTvd6pugT0S
         xqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789493080; x=1790097880;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o7oag7tiLT9gQ7HZpXwTqWFezAuLM/E3QUVZxySQWaQ=;
        b=cYLBUIsNEV0zhBbCFPVWdxPaWvKXn6A4LkszHCitQX6DsnRnu2sH2PIwwwxKHgJhd7
         2QPhl+uaU9C0kXynxXbM5v8nfadJDHalvovEWOV67DMqCSL6WK7SqBdvB29GGqrcOgnv
         5xEWxqmADxbbfanlCelr3jr2hsRNZtbVT+d2Q21HnnF3DTejfyuN8xoaovREHulQRorx
         LcUHzfeLn9KFdo8MfDIxm8/n8IvDFdDACz0w9Tkh2vajuORZ3sqPPu/I231MYKMdfd+W
         y9apxtUJ6Xo2eoczXIrETvfGNGkU9TON6NLxehsCX/M5d3oWFtStfYz7JagUlJYCZnn0
         UhIw==
X-Forwarded-Encrypted: i=1; AKwUvBzaN7Am9BgA9ZwCRsudyKhjbxuVbduLH9IaLR7BK1knmgiyVCmrdC81VmnZPY8nypgrE1UI1u9QzOCgvZJXwNEqAm+2F3E=@vger.kernel.org
X-Gm-Message-State: AFuF++nKlykUvqxgF2dy6Bwg0035FOI3r1PABnGop0R65B6k0LcaHcbk
	VNmDtLBTuWPtWVI9dHNW8/IJ9dxYMixTUaYjCqR1fGGZhgxmKU50ZlKUPnY9hSxHO5ujYGxW7rt
	1+0oOKJgaoksesD++RII+9bSs9/FjyMOabniIDVVo
X-Gm-Gg: AYBFou1gci/dJp9Oj2OnQ6OCK6qNrt3H+R1OqaGe19L5+FNn6jyrwBy+y6DEciu7a9p
	KhCj+kU0uwYRRt1LZc+O9DBXWMyvABEyh8U7onLtuXO2+zgd/Q3HM8hr8x6LTjUp7KNiJ+MRxbj
	GkVmzgs+oOxOBM5yEhGqoDBlkYJDaeYkw9i6wFS4JtKQ18tTEiZrlTc6lf+hD+agife/zLFjXsw
	oYnIkBKaCgHNLTMIGgWEhVPF1/Vu0rXxHIbChWZUIGFNBrr6cywv+WozMOKJQtclBUea0kqQ2s4
	T2JeralWHpTR8M8nv0sZf1Io/2syQzAmQDz2VMx9/yPS8GRHAdTRiwbexCZXUkV19QiWSsyK32A
	Xj+I2zx4ZmQ/SmunkQzSMXA==
X-Received: by 2002:a17:903:17c3:b0:2d8:d4d0:7930 with SMTP id
 d9443c01a7336-2dd6c774465mr154307025ad.20.1789493080252; Tue, 15 Sep 2026
 10:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
 <20260907-selinux-pokemem-v3-2-0bafbaeafe50@google.com> <aql6gyQJoxEjx0xY@shallyn-amd>
In-Reply-To: <aql6gyQJoxEjx0xY@shallyn-amd>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 15 Sep 2026 13:24:27 -0400
X-Gm-Features: AcwNN1WSVv7LZW6UVyRb9JR3csRFIsKvXqH5B9SYVb6JqyH17r20MARaxjq7-ak
Message-ID: <CAHC9VhTjo+znkxBmvseCH1K3aJN18ZO7+6QGE-a+Sy6XN=uaMQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: "Serge Hallyn (AMD)" <sergeh@kernel.org>
Cc: Jann Horn <jannh@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 1:04=E2=80=AFPM Serge Hallyn (AMD) <sergeh@kernel.o=
rg> wrote:
> On Mon, Sep 07, 2026 at 11:00:17PM +0200, Jann Horn wrote:
> > If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently hav=
e no
> > good opportunity to block a process from overwriting read-only code in =
its
> > own address space through FOLL_FORCE writes via /proc/self/mem.
> > The security_ptrace_access_check() LSM hook is bypassed when a process
> > opens /proc/self/mem because this is considered "introspection".
> >
> > This causes a hole in SELinux EXECMEM enforcement, which tries to ensur=
e
> > that a process cannot create executable anonymous pages.
> >
> > PROC_MEM_FORCE_PTRACE prevents that and ensures that such FOLL_FORCE
> > accesses are only possible when the LSM allows ptrace() attachment; but=
 it
> > is unclear how quickly PROC_MEM_FORCE_PTRACE can be deployed in
> > environments running lots of third-party code, such as Android.
> >
> > So, introduce a new LSM hook that can forbid FOLL_FORCE specifically fo=
r
> > such "introspective" accesses.
> >
> > Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  fs/proc/base.c                | 14 ++++++++++++--
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  7 +++++++
> >  security/security.c           | 25 +++++++++++++++++++++++++
> >  4 files changed, 45 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index bec6197329dc..295b21203c7f 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -851,6 +851,11 @@ static int __mem_open(struct inode *inode, struct =
file *file, unsigned int mode)
> >  /* private_data for proc_mem_operations */
> >  struct mem_private {
> >       struct mm_struct *mm;
> > +     /*
> > +      * Was the ptrace access check on open bypassed because the opene=
r used
> > +      * the same MM (introspection)?
> > +      */
> > +     bool opened_by_owner;
> >  };
> >
> >  static int mem_open(struct inode *inode, struct file *file)
> > @@ -864,12 +869,14 @@ static int mem_open(struct inode *inode, struct f=
ile *file)
> >       priv->mm =3D proc_mem_open(inode, PTRACE_MODE_ATTACH);
> >       if (IS_ERR_OR_NULL(priv->mm))
> >               return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> > +     priv->opened_by_owner =3D priv->mm =3D=3D current->mm;
> >       file->private_data =3D no_free_ptr(priv);
> >       return 0;
> >  }
> >
> >  static bool proc_mem_foll_force(struct file *file, struct mm_struct *m=
m)
> >  {
> > +     struct mem_private *priv =3D file->private_data;
> >       struct task_struct *task;
> >       bool ptrace_active =3D false;
> >
> > @@ -884,10 +891,13 @@ static bool proc_mem_foll_force(struct file *file=
, struct mm_struct *mm)
> >                                       READ_ONCE(task->parent) =3D=3D cu=
rrent;
> >                       put_task_struct(task);
> >               }
> > -             return ptrace_active;
> > +             if (!ptrace_active)
> > +                     return false;
> > +             break;
> >       default:
> > -             return true;
> > +             break;
> >       }
> > +     return security_mem_foll_force(file->f_cred, priv->opened_by_owne=
r) =3D=3D 0;
> >  }
> >
> >  static ssize_t mem_rw(struct file *file, char __user *buf,
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_def=
s.h
> > index 65c9609ec207..12f84a1e6fab 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -36,6 +36,7 @@ LSM_HOOK(int, 0, binder_transfer_file, const struct c=
red *from,
> >  LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
> >        unsigned int mode)
> >  LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
> > +LSM_HOOK(int, 0, mem_foll_force, const struct cred *subject, bool open=
ed_by_owner)
> >  LSM_HOOK(int, 0, capget, const struct task_struct *target, kernel_cap_=
t *effective,
> >        kernel_cap_t *inheritable, kernel_cap_t *permitted)
> >  LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 153e9043058f..e8bc2e644241 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -338,6 +338,7 @@ int security_binder_transfer_file(const struct cred=
 *from,
> >                                 const struct cred *to, const struct fil=
e *file);
> >  int security_ptrace_access_check(struct task_struct *child, unsigned i=
nt mode);
> >  int security_ptrace_traceme(struct task_struct *parent);
> > +int security_mem_foll_force(const struct cred *subject, bool opened_by=
_owner);
> >  int security_capget(const struct task_struct *target,
> >                   kernel_cap_t *effective,
> >                   kernel_cap_t *inheritable,
> > @@ -676,6 +677,12 @@ static inline int security_ptrace_traceme(struct t=
ask_struct *parent)
> >       return cap_ptrace_traceme(parent);
> >  }
> >
> > +static inline int security_mem_foll_force(const struct cred *subject,
> > +                                       bool opened_by_owner)
> > +{
> > +     return 0;
> > +}
> > +
> >  static inline int security_capget(const struct task_struct *target,
> >                                  kernel_cap_t *effective,
> >                                  kernel_cap_t *inheritable,
> > diff --git a/security/security.c b/security/security.c
> > index 71aea8fdf014..2cde1efdb7a6 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -595,6 +595,31 @@ int security_ptrace_traceme(struct task_struct *pa=
rent)
> >       return call_int_hook(ptrace_traceme, parent);
> >  }
> >
> > +/**
> > + * security_mem_foll_force() - Check if FOLL_FORCE is allowed
> > + * @subject: credentials using which /proc/$pid/mem was opened
> > + * @opened_by_owner: whether checks on open() were bypassed because th=
e opener
> > + *                   has the same MM as the target
> > + *
> > + * Check if FOLL_FORCE is allowed for accessing process memory through
> > + * /proc/$pid/mem. opened_by_owner signals whether the opener's MM was=
 the same
> > + * as the target MM, meaning the security_ptrace_access_check() hook w=
as
> > + * bypassed on open().
> > + * (Current current->mm does not matter for this; for example, if writ=
e() is
> > + * called on an FD that was received from another process which obtain=
ed it with
> > + * open("/proc/self/mem"), @opened_by_owner is still true.)
> > + *
> > + * Note that this hook is only designed to be useful in the opened_by_=
owner
> > + * case, where the subject credentials effectively also describe the o=
bject.
>
> Given this, would it make more sense to call the hook something
> like `security_mem_foll_force_self()` and only call it in the
> opened_by_owner=3D=3Dtrue case?

Sometimes we can't avoid it, but in general I'd like to see us avoid
calling LSM hooks conditionally, I'd much prefer the hook
implementation (either at the LSM framework level or the individual
LSM) do the conditional check.  See my comments on the previous
revision.

> I only suggest it because it seems to lower the cognitive load
> when looking at this code, so it might make it easier to maintain.

--=20
paul-moore.com

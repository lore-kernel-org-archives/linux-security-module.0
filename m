Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468C94503E5
	for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787922249; cv=pass; b=Lt5d/ELnw0pilZGt0icHoqvl8RtWehWWjm9GU6rDHttUxnT712UFPOwVSg7kHHlP9dbp/KGwUWlMjA7XiuUNbgVcK20nbRfwyhjgD+MWqHsRl8eVb/prx4HNUx9rTsT9xIknAOtlfwvcPQsb0PFNkfrpCS8+DUrb/xEnoCNJYmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787922249; c=relaxed/simple;
	bh=1Or7Yk4K+PY44II/C+RDLMa76t8c/i3h+x9+k7dnu84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uplP8/3dJmdpNw/9KYKDWUkJHBkU7El8RfZoIT3bOCOC52Gw7eDYXT+AihEPEtrUVvIM8KkSeKtJFdxig/pElJe1I7YRHdMmyodwxep78LjHbDxe4Et7MblvCckL8KDXK9S70PCR33dtQzB6fJCFBXO0Gau6tIu9Wzh2uDUhWkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u665zmZF; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u665zmZF"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ccdf36f63dso113925ad.0
        for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 06:04:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787922245; cv=none;
        d=google.com; s=arc-20260327;
        b=gCZ/BcJInnNC7nuF7qO6LZiva9STAGDCrrXWzgR2JI5hAJd5Z58DLGroumUI4W61Nf
         agEZ0EQfQKEcRwlRjZnW+mWXhu7UO9SMEjOvYlTa3YiRKAjsYaWSarPI+2ga8Md+xXvl
         1xjj96YiEjOfmulnLLqeMNRXHysElr/NGwa/JuE+hsZQt4UGdHVjcVnOP2YCct5AJRxu
         IWNVmFQmGO+NYGof3NL0T1NheGkr8A5Msdr0Nuj0VpOyTtwscqPvdEyM9Gf2uyrxdMV9
         S5ZVeonJXr6NeWea9u4OuRCcbbwYizP0WQttZQlz2VDAUpAZF7zdj+3iCHFGOwJLJAEW
         4+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AGNsWwS32agEvYOtAgbeI1ZzpY28DdOxNCH4H2BS0Ww=;
        fh=8EOePdL9vUu5jAYdHxK9TcWFNp25keywWs0Bx/hGWBI=;
        b=XQsNunWO1JY38Zr40gNbofZG556uVQc99270ZLl9qG5NnHfNF+onJBc/CzdQoyVYPw
         nQ+9YMXX+aYnlNfFEdng7zrpWAZvRZnKZRn8NjUbMhkAtpHZRNqkLdpsj7dRqQlwKsaF
         4H3jWiNeCH8KqiEgI8ig3IT7y3Uy+J+F6d5GLCFScsqf0fhgd4BEwBRetHeCJ1u4a8pK
         VtcjIsxaoInaK18eH4Rs1UIMjhXLHkLh+jHJK2LSmhKstxYCWro57U2EXMBOpULgXAnR
         NDwuRvssGYwAbKhAtuQHeCII5+6AHn8BPEt45Nl4vaSl7Sq7OwUO67KHGxLC4zNgsyFy
         9MbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787922245; x=1788527045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AGNsWwS32agEvYOtAgbeI1ZzpY28DdOxNCH4H2BS0Ww=;
        b=u665zmZF/0xyEKSpEUeig5u1rrZu0obH5B1WsKOsz1Izg/YPeqnkSncVDlgPPPIzgX
         CjEjcJzJoX5Yb9sTDNJvIy9qLHX+LlAY289I2zh9U393V7fe+hJKaxEviL+yW3LnQyDC
         8byiEmjYFyu1v4dOgMjJf0zWwYtwnLtiWbEd86mWCcJQqSyN8IyRpijZ+t2D702KyrpG
         GBfLWb4+j8TAXGY3wJr02VHt3VOwzmDogBhQkuSCI3/zuowFNJ4tPOWmTchoaouMuwKB
         PUTzdXrJPd0ZVAiAoykHqz/I3qhMzKvLUEm6rwDZPf9abuQZ7Xfm/0Yx6uXJ+jMOvD9d
         /EJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787922245; x=1788527045;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AGNsWwS32agEvYOtAgbeI1ZzpY28DdOxNCH4H2BS0Ww=;
        b=eEzIgcQleaOjmaQJLXe5G+ADZbWdjqVYLcU2CI2x87R2BtTEChGQTxc9DBaSxz3v43
         NYhxdrQ75Jm/Cj4bPFRKVCWIIRKa4VuPeoRfvFwMpnHVSfLHW+rO5e2Dbar7o5p1mx2d
         XGhyU+LHSgp9bVqymB+yzyEvXd1b9KdDlE/wI63DYJPYuD3gULkKNakjC3HtK1+c9hyU
         sY1FcBwG6YxtsrVy5Gz636WHTsA+DMmBRkeC0Iu9UQKg2Tiletjkyfa4BiVTIwMuPXGH
         prurgrLp0Vo3Un7dKkFk7SAkzWYpcNCKoxquZtSi1Qe7mAfgmZDSAaHte7DGyT9FInw5
         Rxxg==
X-Forwarded-Encrypted: i=1; AHgh+RoPMhaOExnAsSIPlrfixMmQ1yawMfTzaQnaFP5Ruc/BU3YEQE5oW3cEsi9KAQA4jwbAyOpcys1Vcq42aRrHKn/Fo1dQgG4=@vger.kernel.org
X-Gm-Message-State: AFuF++nn3pj6z6KLTSXfxJUr2Vs55dOPFgZ+JwdyGTIu0sSisn6wNTsD
	G+rwN3hNv3o+iPeLS4aGlpYnRU27j06JIRUqN5oJPXuba+NSzqQm1hcrhESfXCJ0M3p3fAyTGYV
	ihg8iedfg9dXN9JbJtaKG2orw9IMOMwzrF9e8jpBr
X-Gm-Gg: AR+sD12RXL5WuJ9FHSEHkgNRKqwXW8owdBwzQoPH/xvlpjDUpU+ktZWWeOBRbrZdgP5
	QR3YQkViH6HXozkaFqNRbgOq9fVgsdv3xFYnH+Hvo9HJUR/HKn4y3LpouYfNTgS1AEjWklFOw5+
	aOjUdkwHg7W6ytjkaytpCJ9Xp4GmRQi9u2eSFgYUVyIP3V9XVjKUMhhhDlep4pIgFdHhsz8Gc+G
	Ttcu3eOYc2CcIyXA4CGU2qYfW42nhGBctnUjIZSjMh31Bo2juf+aZBEJivNHn3cOU7IQiRDo/fY
	uvBX8kYZkZhJBxKciRxHmpE4YXOWq+X/2wpWsa7MUQdkclHqybg0Gd1/NvezUJi0EVvli4L/aGs
	nHPtCR0H9DVfsvjWfGAxlxaZYuZnpuUjfFNdwOVbV
X-Received: by 2002:a17:902:d2c7:b0:2d3:153d:acae with SMTP id
 d9443c01a7336-2d74f1898edmr6942445ad.0.1787922244063; Fri, 28 Aug 2026
 06:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-selinux-pokemem-v2-2-b46bc64916d8@google.com> <82929c994076d95f99560ecc67f6cfce@paul-moore.com>
In-Reply-To: <82929c994076d95f99560ecc67f6cfce@paul-moore.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 28 Aug 2026 15:03:26 +0200
X-Gm-Features: AcwNN1XrNltc_VuHQhdOWGeareZ_mPOwkDqM-dog-6Ggxhiy2PpwWw0NSSm2Yn8
Message-ID: <CAG48ez1rd3cFhmGn7mWkaVvGqYg+cDiGUhuhH6r51dUm-QBXUA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 3:10=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Aug 25, 2026 Jann Horn <jannh@google.com> wrote:
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
> > Signed-off-by: Jann Horn <jannh@google.com>
> > Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> > Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  fs/proc/base.c                |  9 +++++++++
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  6 ++++++
> >  security/security.c           | 20 ++++++++++++++++++++
> >  4 files changed, 36 insertions(+)
> >
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index bec6197329dc..dc6fdcb47b79 100644
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
> > @@ -886,6 +893,8 @@ static bool proc_mem_foll_force(struct file *file, =
struct mm_struct *mm)
> >               }
> >               return ptrace_active;
> >       default:
> > +             if (priv->opened_by_owner)
> > +                     return security_mem_foll_force_opened_by_owner(fi=
le->f_cred) =3D=3D 0;
> >               return true;
> >       }
> >  }
>
> First things first, we've got to shorten that hook name :)  What do you
> think of security_proc_mem_foll_force()?

If we move the "opened_by_owner" part into a flag then I guess that
works... will do.

> Beyond that, we really try to avoid making LSM hook calls conditional.  I=
t
> can limit what an LSM can enforce, it tends to be a bit more fragile, and
> it adds some unnecessary work in the case where CONFIG_SECURITY is
> disabled.  I would suggest passing 'opened_by_owner' flag as a second
> parameter to the LSM hook and calling the hook unconditionally in the
> default switch case as a replacement for the 'return true;' statement.  I
> understand it may seem a bit odd, but we try to make the LSM interface as
> generic as possible with respect to different models and this is one way

I guess I can do that, but then the question becomes, what other modes
of using the LSM hook that don't currently exist in the kernel should
I be supporting with this? I can make this a parameter, but any LSM
policy that actually uses the parameter in a different way would
probably be buggy/inconsistent, unless other new LSM hooks are added.

If your intent is to make the hook work for any /proc/$pid/mem access,
including when the caller is ptrace-attached, then I guess I have to
move around the security hook call in proc_mem_foll_force() a little
bit. I guess I'll do that in v3, though I really don't like trying to
come up with a reasonable in-kernel API contract for a scenario that
currently has zero users.

> we do that.  It also ensures we don't have to process the 'opened_by_owne=
r'
> check in that case where the LSM is disabled.

(I don't think that's an improvement - we have to do the comparison
either way, but in the current version, we then use it to
conditionally branch to a security hook, while the v3 patch will
instead unconditionally call into the security hook.)

> >  LSM_HOOK(int, 0, capget, const struct task_struct *target, kernel_cap_=
t *effective,
> >        kernel_cap_t *inheritable, kernel_cap_t *permitted)
> >  LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 153e9043058f..74eb876054b0 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -338,6 +338,7 @@ int security_binder_transfer_file(const struct cred=
 *from,
> >                                 const struct cred *to, const struct fil=
e *file);
> >  int security_ptrace_access_check(struct task_struct *child, unsigned i=
nt mode);
> >  int security_ptrace_traceme(struct task_struct *parent);
> > +int security_mem_foll_force_opened_by_owner(const struct cred *subject=
);
> >  int security_capget(const struct task_struct *target,
> >                   kernel_cap_t *effective,
> >                   kernel_cap_t *inheritable,
> > @@ -676,6 +677,11 @@ static inline int security_ptrace_traceme(struct t=
ask_struct *parent)
> >       return cap_ptrace_traceme(parent);
> >  }
> >
> > +static inline int security_mem_foll_force_opened_by_owner(const struct=
 cred *subject)
> > +{
> > +     return 0;
> > +}
>
> With proc_mem_foll_force() currently returning true/1 in this case,
> shouldn't the LSM hook return true/1 when disabled?

No, I have proc_mem_foll_force() doing:
"return security_mem_foll_force_opened_by_owner(file->f_cred) =3D=3D 0;"

So returning 0 means "allowed", returning an error code means "denied".

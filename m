Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2774749C1
	for <linux-security-module@vger.kernel.org>; Tue, 25 Aug 2026 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666482; cv=pass; b=Q4lnbvbG0szneWGjIlKHTZT6kOaJ9tN0giTItoSaLGXhxGsIbRzMukVbIg9Y4/9lBSE+6KMy/iD1lcmy6uh3emi5alhAgmCYMOdVHzzjAF/WE1DlQ5ov81szRtZKab9dYdwlq1U6HeXCj9Kpe/13Dm6Wxp7VQF9McaSQJ3RbTFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666482; c=relaxed/simple;
	bh=pL5MtX5pBfqar5x9PgpB5R/pSJ/FKbRaufhUQePnTTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVg/53ghVTL6/C31659ivxzVF5GQtHkl0aWqwsWNUENC795ATgrprrnk4iJ8anSPduAtJ2MU6t4VXaQj0s7E5LDH6eauyaj4PBeA7TQZZD50U+OAnCDhsHIFIop1nV/QwBJrvzs+iqRSxjy4WnzLfJbr8ewSBQVfnvmlYW2E+6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qlCFwgmT; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qlCFwgmT"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cede6375caso124885ad.0
        for <linux-security-module@vger.kernel.org>; Tue, 25 Aug 2026 07:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787666480; cv=none;
        d=google.com; s=arc-20260327;
        b=fgvvDyGhAFXi2iDfQ0SKOF5DHLJWGHzbZbQ7WYE0eUsscJwvFo8kxHy6axPN1S44aQ
         H6g51+Wsqff8IvA/tLHXozll4fj06kle83iJZXyvLCGUQIrXEhMKw9OE0i0wjeE8oSur
         47+tSTE71b9V5WU7sgjfX+i6Alhci/lmF23v3/gan05x9GdiFODvhdMO7+tWmF3XoZw2
         xbK/5G3zd1bnMapmi3h8FNmI7G5WvWG98D79t7AF4bw1r11Tbq96mYN5fdEoEv4VTjA1
         vIQvp8zN+TixxFJnw1UsWqkXx8VoUU24FlO5nW4e6HyOJiI/RACR4Fb3xl0NOThIgEYP
         Zfhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XkjZxCxJdfT2LMn1D0Amm2coBqwtgPaPywf77Df6Gqc=;
        fh=pSeprSHSZB4HwiIzNaOBxxafHIhRSkY4iZCuQB2AeIw=;
        b=n5IsfbjeSdZIqn3M6Y7yFCoecTrrl0Qcv8cSfdURuzf0JgkjjZn++KNtozWxNqt++f
         XHIR+UeOVNFPVSDyt4QZQcU/K2sbQw91sOofdSztH1klm0frpQwpIthTXCGIhLejmHiX
         P9HsmF9FI+2ub8/vz+D0LKkUN9XtQfnwXVhvqk8ld1uD52CqqPyKXCt1ssn1Gxu92Fqw
         He9CpPplXM4GgFFl9sUQ9siaVPDmGuTU3ctIQQEKboLB5C+4uqVwnlofP0ys9hEiTCar
         z+Ox1KRbx2IlVE/uG5Z72jNdcrMmADc5eeRLHsOCmVXOiDYkNHXAmC9X04eQiaP1Yd0I
         66qA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787666480; x=1788271280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XkjZxCxJdfT2LMn1D0Amm2coBqwtgPaPywf77Df6Gqc=;
        b=qlCFwgmTd/AGLejg7DbPMG1scCcQhjLgx+t6nHQQ6ydMQZ4YkKX4rwutV0o4BghWtD
         9k4bOOZzzQatc+o0cd8eQH6dU/HTw/hv8hnEfgWJ9FDBnSPq6rCnE1uzXWkszpA+X5cL
         Zy/MplCq+UjtcSZMCJMY9ezFC34DsY54uaAPRRCu8pprFcRJyDetHwL8K17Wcd3EtNnO
         zLOwUbkZ1VpPMtWpOGys3IpBtR+29ut+pi0MNb6M4KF8Eow/nt+iSLBXDIM3AwoqgJTt
         2m4xj9bsTxrbkup5GRPEBrX7icbW+JIwiH/lh4S1IelEa82muMiYFasilMnvF7IVnHEe
         Y/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787666480; x=1788271280;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XkjZxCxJdfT2LMn1D0Amm2coBqwtgPaPywf77Df6Gqc=;
        b=itlrWFIIkBepsuXQzbX/MmcRYy/c3Eakm/bupujZl541D5/VXmSFcz3fyd3FcHxavV
         BOFi3l66jplo9XTnw2Y6LsR2KyLgoVIe1/wWpWObOku984GIl56YlkzqUbb/U/w1o268
         EhgoBEh3pY7yBjTr+8LJv0bgKPX096f+4fAZGoZjbs4GZnT6zjnoah9Iz59rk/Tusw7p
         jAjdKiAhsCKd7nwrYjpA2XzEeNX66pvcuzY3N1pxP1qzOlxvL6ZDhzokAKR8zZ/e9CBY
         TG9vM0VYeWO7bVfxAz+LG70+AElT56Htnt4b19S35mPY3dxr7FZRL2gCfztSa3Hdpv1r
         3UMA==
X-Forwarded-Encrypted: i=1; AHgh+Rq0L5YPh+kqc602HFe3ZI4mkoDJhKS8qRjR5Tmp6S8gK41KlQffx0TFkQ7e+IwAs2ciEVELMsl4rInLsq/j61r1Gwv4lGA=@vger.kernel.org
X-Gm-Message-State: AFuF++mApXXp03k+O3K+ts1Yev8sTrdvDcL54IgcJamGV2evz70kH/nx
	5s5wvuQwVG9VLlXQ0pd0PDWnWuORB7j85gWKsKkByGFyg3tDWwlp9BHO5E8k7S2LCzLSbNK14V0
	R5D+ugH2vLGfVPgbsTbDfEx7NAJ+37Nla6fZZRzag
X-Gm-Gg: AR+sD10PVz/K/iwnsj3lmUFvrQRIRoPEqxc8gBx4T6Tf32e3CX7gT36ieYqB7/qdUmJ
	Yvil/J2fE/lnOZ/OuGOe1m920WLooaV2LftIGf88MH5mRdTBM2/OYKIfKYqBwVykybrQx73MgHH
	DcTGTID6IQTN/86lyEg4C/8KUWvIVtMzyvAZgnxgmWLEAsqdHYFNwTy1wqfaQnN60iPE5jzh3q7
	FTRBaMOjAefZG3mGthxqfMtHCazGVgJ6S6VhN+vYwoKDYawtnwc52DxITL3INroqW3R7ObGk88E
	543SYwbfVxY7A2y/ANKpsZxxNn/8JA/VYMhngAfLYp6KrloWUWEP+EspTLjeDoDWi8kRxPmH38E
	s5YMsje60lyPY5a3Uz85gaLgx1BgAAA==
X-Received: by 2002:a17:903:98b:b0:2ce:b436:272a with SMTP id
 d9443c01a7336-2d6e07f16dfmr936545ad.3.1787666479395; Tue, 25 Aug 2026
 07:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <20260825-unweigerlich-biotechnologie-abnormal-accff844337f@brauner>
In-Reply-To: <20260825-unweigerlich-biotechnologie-abnormal-accff844337f@brauner>
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Aug 2026 16:00:40 +0200
X-Gm-Features: AcwNN1Vfg8wgAQZTxYtddPbSXEdmTL4JLXmxKeMr_IG98S_z91XZ1jHBOrg8fJk
Message-ID: <CAG48ez14F42BgHm5dKeP4g8D_6CNhnAfF7BXdcBwa4NdtFiaiw@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:19=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Tue, Aug 18, 2026 at 09:51:06PM +0200, Jann Horn wrote:
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
> > ---
> >  fs/proc/base.c                |  6 ++++++
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  6 ++++++
> >  security/security.c           | 15 +++++++++++++++
> >  4 files changed, 28 insertions(+)
> >
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index bec6197329dc..3dfaef49bb70 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -851,6 +851,8 @@ static int __mem_open(struct inode *inode, struct f=
ile *file, unsigned int mode)
> >  /* private_data for proc_mem_operations */
> >  struct mem_private {
> >       struct mm_struct *mm;
> > +     /* Was the ptrace access check bypassed due to introspection? */
> > +     bool introspection;
> >  };
> >
> >  static int mem_open(struct inode *inode, struct file *file)
> > @@ -864,12 +866,14 @@ static int mem_open(struct inode *inode, struct f=
ile *file)
> >       priv->mm =3D proc_mem_open(inode, PTRACE_MODE_ATTACH);
> >       if (IS_ERR_OR_NULL(priv->mm))
> >               return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> > +     priv->introspection =3D priv->mm =3D=3D current->mm;
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
> > @@ -886,6 +890,8 @@ static bool proc_mem_foll_force(struct file *file, =
struct mm_struct *mm)
> >               }
> >               return ptrace_active;
> >       default:
> > +             if (priv->introspection)
> > +                     return security_introspect_mem_foll_force(file->f=
_cred) =3D=3D 0;
>
> Hm. Why not pass the reason to security_introspect_mem_foll_force() and
> call it unconditionally? Similarly it could also be called for the
> active ptracer case. Then you'd just need to pass a flag to the security
> hook and the LSM can decide based on that.

A process which is attached as a ptracer can modify memory with (for
example) PTRACE_POKETEXT and registers with (for example)
PTRACE_SETREGS. LSMs that want to prevent such debugging operations
are supposed to prevent ptrace attachment with the ptrace_access_check
hook.

I am just trying to plug the enforcement hole where ptrace-style
modification of process state is possible without going through
ptrace_access_check - which means just looking at these
"introspection" cases.

If I wanted to provide LSMs with a more granular ability to do some
PTRACE_MODE_ATTACH operations (like attaching via ptrace) while
blocking other operations (like PTRACE_POKETEXT or changing register
values), that would require more plumbing, so I'm not trying to do
that here.

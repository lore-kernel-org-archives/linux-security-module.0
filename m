Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EF4253351
	for <linux-security-module@vger.kernel.org>; Tue,  9 Sep 2025 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452223; cv=none; b=F8wVcAFLk7do42vCYrbqJiCKQbR+GC54CdUUHexN0n8vrMwxRFP+JQ6ZzHek6t/E1HS0C0L7CEqS9IJL0r9V2G63NKkOSdTJtf4bHb2F82OrQzOz5CPmSndjcU149l+Ebl0uSVqQdvv9niNFr30ee7yIhsLIgHyEo1oOFd1N1+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452223; c=relaxed/simple;
	bh=Dt42INzN9U0WvxS+jUlTdxOxsoOoT8a2dyEqiGv005U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVdMrrH53K40xgBWYMLTcw9aWkskzZ5HOEWHR5CISgUdO3CwacxcmNYbNISf+jivIKUQhDQkYNXPdiCaYm6vfZleXweqOjNKFx7buyw3hL2aOnMs+XI9HXhq7z6MGMZ3PL/bj14rlt9vyrZR19FKZ5tiz0ZSfjvY3qh/SWstDmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LbEfWq1/; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LbEfWq1/"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4f7053cc38so3819554a12.2
        for <linux-security-module@vger.kernel.org>; Tue, 09 Sep 2025 14:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757452220; x=1758057020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2cG/mK5wqDybUQGFQEkWBC5lBJfTdv6AvrW8OgR6q8=;
        b=LbEfWq1/BY7Eg5u3jpBUaGbdIH8Ox6CoivkaIA//44MtzSAtN9tQEsiqIk0Dos3qk0
         3BQC4LeqBenlSMaktB9PIiEGuxUc6yM+vRDuQbEVVPelXbNZDgAjXliyR5I99dD3NBcM
         iq5TEjskZGTiGUZFN2IdMNtUVx2GTuqAth59V+pZ7RC6LTBwoMlOjeR9u0zsBpgOrZbW
         DSGMvdoiG7JXgFXQWxEiUnno4z7bJtuk5daouK2pby15IHfZ+/CTAtUqfeuPxHX7Jzwm
         6W6V+k0B9GZaz3Awl8sskNfbPF1rEQwLWk7SfMI4SMR2xmSp5rl+z2EygWo6g6VXFECK
         u21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757452220; x=1758057020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2cG/mK5wqDybUQGFQEkWBC5lBJfTdv6AvrW8OgR6q8=;
        b=srDIbxEq/yLJqZ6wd7dDUTIgdVzKJsIt4xi1sjYVOiKxalRvllO6ccfK6ChNapxHT0
         8h7hvDmTcE7xOUImOQ2mybFQNSqkA+0fYL630KU+HdFmg7wrX1Sv8ijT+9PW9jfffCB/
         QR/L6TSD8DLUeCtoKxXdM9MZpUtceRAagBfPjbA5TRvDUJSmZdo/02oK55AL/YwjNRfr
         jF9XJFkRCAWLsJ01sh7CvhEEHZS2SZn2LEWOaRVpbRz6lPHBS760wX+NrZ4LLtZh2yC9
         43rPmUcNNUcvu5IQcllN6W6z84orZMxLTY1hProaUDl1FTrkx3ZVvSmulcc6m29Zdvp+
         cPjg==
X-Forwarded-Encrypted: i=1; AJvYcCW4TzAKxT5CX+vSXCAxzBDbvUXH7HObnhDwELW2mzzoV70pJPIFOJ4/g8eao0dO64CQzoA7rZ/Tb9dHPcteVLAf1d9wDvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5NT0Cc3K+V6WxCUT+uV73qpwIycVCYVX4cM9v49cA0LrYWOld
	T+jRD4fvHwnPY2lSV2j/edxdqS5Wkr9vOT8HVMyoon2foskoknOy4CJzMXT7TFQP9MclYMoumq5
	0D6szXQaH03U6DOXasRq9vAAxtlPjyMMBj3tQkPSy
X-Gm-Gg: ASbGncuwmHBAr+Skl23OKqYESVmE4Y6mzvlYR5aI2j9tQ6Z8mKixDmmPDo9j7BknoNV
	wR35bYCAFZ4RaazsZrQfTiRGQHGjUkHly97Io2LOIyYhFsjvkQwYqOR6Tkv/CifhNtXxsa5Tfzj
	pUyVCOe1+BXxgOcQMStL8+QcHaMKZa9sIFSwu0gitQQwB5GNg0yDQNHakC/RLAm6XQ5nd+p6i8J
	HranO0=
X-Google-Smtp-Source: AGHT+IFG7w3FOCnO7S8iIokZgAsSINZsrpiz3Ys96zLr6kCQRn865YPB71KK71zIy8iQMBZAebWvkkV/MJhLqntWdHY=
X-Received: by 2002:a17:90b:3c0f:b0:329:f408:1070 with SMTP id
 98e67ed59e1d1-32d43fcfd9emr20011740a91.33.1757452220060; Tue, 09 Sep 2025
 14:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908013419.4186627-1-tweek@google.com> <CAEjxPJ5q0eriGjo1tdfN+pzBBN5OeyfMaYp_sNQcOg-rDaXVCA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5q0eriGjo1tdfN+pzBBN5OeyfMaYp_sNQcOg-rDaXVCA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 Sep 2025 17:10:08 -0400
X-Gm-Features: Ac12FXwWb3SOwQ7VnHVntpJWLHK5Nv99C1sNZTrun4dRgTex4G1DZb8W4i4WZ_Q
Message-ID: <CAHC9VhR1pEFYzSFaqqWsU8C6vDaH_E8uZZ5g=KyK6TJvA7a8MQ@mail.gmail.com>
Subject: Re: [PATCH v2] memfd,selinux: call security_inode_init_security_anon
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	James Morris <jmorris@namei.org>, Hugh Dickins <hughd@google.com>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Isaac Manjarres <isaacmanjarres@google.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 12:32=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Sun, Sep 7, 2025 at 9:34=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@goog=
le.com> wrote:
> >
> > Prior to this change, no security hooks were called at the creation of =
a
> > memfd file. It means that, for SELinux as an example, it will receive
> > the default type of the filesystem that backs the in-memory inode. In
> > most cases, that would be tmpfs, but if MFD_HUGETLB is passed, it will
> > be hugetlbfs. Both can be considered implementation details of memfd.
> >
> > It also means that it is not possible to differentiate between a file
> > coming from memfd_create and a file coming from a standard tmpfs mount
> > point.
> >
> > Additionally, no permission is validated at creation, which differs fro=
m
> > the similar memfd_secret syscall.
> >
> > Call security_inode_init_security_anon during creation. This ensures
> > that the file is setup similarly to other anonymous inodes. On SELinux,
> > it means that the file will receive the security context of its task.
> >
> > The ability to limit fexecve on memfd has been of interest to avoid
> > potential pitfalls where /proc/self/exe or similar would be executed
> > [1][2]. Reuse the "execute_no_trans" and "entrypoint" access vectors,
> > similarly to the file class. These access vectors may not make sense fo=
r
> > the existing "anon_inode" class. Therefore, define and assign a new
> > class "memfd_file" to support such access vectors.
> >
> > Guard these changes behind a new policy capability named "memfd_class".
> >
> > [1] https://crbug.com/1305267
> > [2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@google.c=
om/
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> > Changes since v1:
> > - Move test of class earlier in selinux_bprm_creds_for_exec
> > - Remove duplicate call to security_transition_sid
> >
> > Changes since RFC:
> > - Remove enum argument, simply compare the anon inode name
> > - Introduce a policy capability for compatility
> > - Add validation of class in selinux_bprm_creds_for_exec
> >
> >  include/linux/memfd.h                      |  2 ++
> >  mm/memfd.c                                 | 14 ++++++++++--
> >  security/selinux/hooks.c                   | 26 +++++++++++++++++-----
> >  security/selinux/include/classmap.h        |  2 ++
> >  security/selinux/include/policycap.h       |  1 +
> >  security/selinux/include/policycap_names.h |  1 +
> >  security/selinux/include/security.h        |  5 +++++
> >  7 files changed, 44 insertions(+), 7 deletions(-)
> >
>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index c95a5874bf7d..6adf2f393ed9 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2315,6 +2316,9 @@ static int selinux_bprm_creds_for_exec(struct lin=
ux_binprm *bprm)
> >         new_tsec =3D selinux_cred(bprm->cred);
> >         isec =3D inode_security(inode);
> >
> > +       if (isec->sclass !=3D SECCLASS_FILE && isec->sclass !=3D SECCLA=
SS_MEMFD_FILE)
> > +               return -EPERM;
> > +
>
> Sorry, I should have mentioned this earlier, but usually we try to
> avoid triggering silent denials from SELinux since it provides no hint
> to the user as to what went wrong or how to resolve.

Ooof, yeah, I should have noticed that too.

> Arguably reaching this code would be suggestive of a kernel bug but I
> know that BUG_ON() is frowned upon these days.
> Maybe we should WARN_ON_ONCE() here or similar?

BUG_ON() is definitely a no-no, but WARN_ON_ONCE()/WARN_ON() is still
considered okay last I checked (no forced panic).  Of the two I think
WARN_ON() would be a better choice here.

> We also rarely return
> -EPERM from SELinux outside of capability checks since usually EPERM
> means a failed capability check
> (vs -EACCES). Defer to Paul on how/if he wants to handle this and
> whether it requires re-spinning this patch or just a follow-on one.

Another fair point.

Considering that we are at -rc5 right now, we only have a few more
days left in the current dev cycle, I'm going to merge this now (with
a subject line tweak and some unnecessary vertical whitespace
removed), and I'll put together a quick little patch to do the
WARN_ON()/EACCES conversion which you'll see on list shortly ...

--=20
paul-moore.com

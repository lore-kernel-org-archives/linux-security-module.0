Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01D839449C
	for <linux-security-module@vger.kernel.org>; Thu, 20 Aug 2026 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251491; cv=pass; b=ZaAAxtBEDL+fMXWAHfI54SR/O1kqHG9a8i7hwYRFxYiBqsdFRP2RBKe84dfdv0OSBNfiD0VcHV8a79QFTQs6Szvz4POQD8G2y2gk4qif9/UkjabFzJBsduq2et9P5yce2UTm5O1f37gm2YOrBn7VqLbsv57cZFOp2nGvzACq1iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251491; c=relaxed/simple;
	bh=1BUl/L18VjoyHto2cVeOh6hrwiaVF2vC8ns+kaLeyMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+pmOm11bEfioDG19a2fWJo2ZzUyG7JRoHk1oDViq3Ry5q/m2RXKjowCMTpwuaab1Ymmf91V+2KdkYuQEPFehZ0Tr77m6yRcX09TBoBH85WirFGsGSt7gufglZrNcX4bgwP/nM5FdnF9RmANWMem6OV2laXZw4EhDOZkSXFFGKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcEQf1Jf; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcEQf1Jf"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d3b440b97aso13405ad.1
        for <linux-security-module@vger.kernel.org>; Thu, 20 Aug 2026 11:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787251489; cv=none;
        d=google.com; s=arc-20260327;
        b=gAQfu4SaQflG2+PB6eHvzaTpCiVzuq0us/1zaIEVRz7ocP/eVX8usXRWTgR6jb2qWa
         JevTZni1mSEGo0kFGPK85okGM8X1Ozq6jphKyStH7Bj0kkpSjj/ZQOsjuVR80BRB580Z
         7JojvXPMVdK7kPpjIIIikKl2vOpOs4g8lYcvcqBweWvVLxNshcs67XSM6lmhhPmNmvCE
         erysXF36WBHs5JCIfelewwIdRh9g9YqNeFblYJ2ibSolW+lHhXea3Gq+4APj6npHUpul
         YJzLWpcTl7Y+e1hiaZq6X9m5i/Npu/TXnPMQeVICfX/uSVie1w6+UWdlIpNg837mZ7ou
         RbcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ra+u2k+WGBbYHMuPstN144hB8VFxEn7aIl8UwdTV5yc=;
        fh=scvYLsp/Q7KIql24twzmfncFQmlt5nai5Sb3+qpPIls=;
        b=jwV2G8CXjNADvqcpTKC65UKzlFtJDqXhdDUfr+0j7ZDjuz3Vv1cdR28e3GEKSLn4yL
         yL5ONZepEXEsTlP6njMnh/o/uWjosln8Gp/27B1xgmnf+nBlyHBnBU1fdboWjofugsXK
         HEUFZ5pJq9rAFGglHtIu3MqmmcxojAJDL1CTMuCiRfn37nJ7RNQjd7zlc5TjNBN3VyUY
         mkTX0xU6faY4aI4C+8SULoV3eDVGudyREYAatp8rlLELMkiMWqV3rUocMtHsvkMSLx6m
         5ppIdafsPhB8KUKO7eTuA0U/g1vPeI7LbfvRQNgVuejhvluUThcqSK4xNZDRWEQbpHFi
         9EwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787251489; x=1787856289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ra+u2k+WGBbYHMuPstN144hB8VFxEn7aIl8UwdTV5yc=;
        b=dcEQf1JfkWtQKZBW2y7hJGbPS0z3rtQhMHHnMumkdEDuG5xKqTTfSFlfpDKJWAvsNo
         GeGUDOCIcKgYORGaZxwEVxUFxnQbEOo1Uk3H3R/2SecKGnktgMIFpXipPoWfiaMOTsZZ
         JOxtqIbtd+PulOvFb+6S13QPQXLZ3miLwBf62Hy6yV5Z/PC9n3C42kdhMrGEZvgLzkxn
         dqi15ns7h9w6ogFAyccb4BSKtizbWBFxP8GbkT7GgFEVFg+CgVSi9rVX8B1PfSmaK71S
         YBeAKX8dHnbmZAC5yO6RjDUH2pXT1eUwiNdkYV3XscblaanNUG2SQp6+uZOV6cgiOEtP
         /E1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787251489; x=1787856289;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ra+u2k+WGBbYHMuPstN144hB8VFxEn7aIl8UwdTV5yc=;
        b=UjAkejTiCbe0uZLG3QDOxsu2ws3h4ro4A0rTn3G2qz6fwJox1tQG3X/j4XQXKaADGN
         VZ/LVzh0B3tCIgxs7NNghuwDvD30PmkrUAfPzdv+CZ6tDMK2nPr2XVBReQb5C6vrcEsm
         UzEqW45LeJujaq3BXiDiY1O5TU8v6Iiiov7kwTZui+2qPuqbj9DQhAdn43hCdb15pia9
         a2LtdKR0oyQAZzwfmM/fIgbx0PEygYKlp3LQ2J4npTuszArou2cHzkfwXfx3rLvBEcdc
         MT1hDwyYNpKL6RiqjjNXHCiA31vIzZKrFzFRKg+jJnBxI9qc+FxybBy2xStvWYMYgSlN
         X3cQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro2ELhDC7zGF/4mdnH2Sq54qE9OVGiDzTqjTnJ0FcR6smzrYqzOYM7u6DD8PttkDnq65QTriQ3dnss73iFEFLFnJ8QqFdE=@vger.kernel.org
X-Gm-Message-State: AFuF++kAfjY/a4TyQnT4Q0hpQbAcvN38eb0zKoxpGlj76BlrrOUCCBJu
	x0k/ld1++3LPuxgH51Nasqb8FcGryUkj570Yo0bclOUGhOVF0UUMCHJ9XdOltKjXD7B17LrQ8rN
	lx7bdsSsy1Te8h/0d9hfjmWzTcxI6fg8I311zniSJ
X-Gm-Gg: AR+sD13ZtfJYGWaKHQ8h+DRfUv16zpZynIymgAbajsy8/ZYLhxw+CpTC9/LgxdK45ms
	YTdeYPBPxW5UFrse/jWUhMT2+OL+JY9qh5BtXitG+g+i/qzGP/WMS+Bk1R9cjn7T86yL4k8YvVT
	hB2sdS6R1KFaXmqgSQMI9ptzwUKQONM5NNSP5Jt9zKVquJNex8nTSIRsThBndvJMVZEN9v+iq5L
	6tlIMNxf9PkCLvUbXQbegK5sxa4J3pwao0pC6fWMoVv7yEjpZ5RDLLECdbEXUGvXELlCFoN4o8A
	ovXHb0O3veeZ5H8dMk8bc5YZruyUYLmxwodm0ivAk1Th4Zvs2+8QsTeUi5hVMeP0TFd0VvaAVzs
	sBo2qlHW+TpQUQbwDh0D4nNpIo9Hstw==
X-Received: by 2002:a17:903:22c7:b0:2ca:cbe5:c3af with SMTP id
 d9443c01a7336-2d64b50af9cmr824745ad.7.1787251488719; Thu, 20 Aug 2026
 11:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
In-Reply-To: <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 20 Aug 2026 20:44:12 +0200
X-Gm-Features: AcwNN1WPc46lB25I9dlQYQePR9UcO75mKPz3cBjmzriG3esMrA3mvmTFFADdtWE
Message-ID: <CAG48ez2Ngo3=VtyykXY6ynVzGwA8px-p4zV3V6U=YfgV-Hy4BA@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 7:22=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
> On 8/18/26 21:51, Jann Horn wrote:
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
>
> Is the feat that the fd could be passed to someone else that would then n=
ot be
> detected as introspection?

Yes, exactly, that's the primary reason why I did it this way.

Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F85429CEC
	for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2026 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323753; cv=pass; b=jZ4C3LORW+lBXJqvfSBw3X/XSu2JTr1GuSfdkPPI9l9Qc3C0uGwml+DW7UnpRuB6NGuZJylX3Lz3O9z0oLRVt/iy+lol6nw40y+nzYjv7jhUTAZloh0EdtAnLlO7L42z4dctlxIEY7u2nmOdecQCpbSM+pShhCdogegJVvcOpt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323753; c=relaxed/simple;
	bh=e7lZBlf4BQjKWZ7FXBRUvZEHvETpn0y3fvgbNkdPxwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4bqTBTvPLl1Is8MJ/xQeuTGChNjQow/yIU714zDnQklfqtSqegGrom/ckwIsIWC02Q470g/0ln3VF0/CnY/R13PQvzjWVXuSjlwFBEJYYKGXKMHiuiW3P7KSFnF6cJ0w6/a86sN6NymBYRlsfgwLFy+dE4vG/SwuwRs8C42D8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nfjl0MYN; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nfjl0MYN"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cede6375caso101105ad.0
        for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2026 07:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787323751; cv=none;
        d=google.com; s=arc-20260327;
        b=eeMftbCZNRjkgnypeuwZYnLTcsSCOsMsK3DoRNGNv36csS4FaozBG7WaKVcw7DNAdW
         gscfcoFWBT1MtBwb70BOWGWmAj8t0N4s4LQKTGA3BibMOJV6VYClqdst5iz1DdKGsqdU
         Z+z4JaFAtGR9JSKVydGLa/1yZXjdGEF2IfetyFC2yiZLItknzJns7D1drdm5aW42K1QO
         mSpHCl3hu29klHWBcyL8PXrDy+LttJpNXd4ez28RQ29YzB1uX1t8k/LNbAI2H2Az/lMt
         cykqCF32B5GbIcYF7pv5GhEbdmZAMQDz6ato4mlm6DnH4SF3STK9tUZcKA3cZWdbRcPQ
         SmUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vlc/iU0BEBi/KNin4z6a2IXssoOeWKNQCCK9ZmekGRI=;
        fh=Q1KUtT08EffVAKxFDDnIDQKI579eg9vStaoj9RweApI=;
        b=AZuGgPnxSsuJm/JeXT/j9snSnmk7SirHKJHcuCmltJ0CNH/LgjjX8LxZP/DGsKhWGL
         xps+YvyJ/wfYsudfqQyearEs0LhNZi/ikHSEw677QBRFMaJxqX2f1Sv9zHcEzQ4lqUp6
         tal/+eZrGuK913UY6e4qfo9g7JjGycjVrHE4NItudQ9JHralenNqcou2rHPrYHB5e5Ij
         QfXGhDcX9XbMc1llgThEGoDOtllonSgLYbaAIXveziwxWVPJYm24kS3mqGJrjZy84Wx8
         ZcgSr/mXNoQRGzxHXRFVCtbVeczXBoq/1uUOoYgHosaJ23viBC83ez/b74jKOnVwe80c
         FTVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787323751; x=1787928551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vlc/iU0BEBi/KNin4z6a2IXssoOeWKNQCCK9ZmekGRI=;
        b=nfjl0MYNhwStfkYy8/CHTnFDsoMZ4CVqW2rtTKJlAbbemwhyF5xS6dd7yTgR2Q39q3
         TTHgoVR6lZwYqmPkQNkUAKHsnwrgCrIjquDbQFjoSzQi2HLOU25WJWNe8bWtZEXr0++Q
         n8ovWBvKdDvsuXSu3wT+AZqxDQ08QXVnnByhhvSbRd1uh1Hkawc+b2OmMOALI2ihZbsC
         k8dDAXRNmB4+oOtmA4H9ul2iUAp9Wn5SI5pepMHPoYRoWIf9hMujbM0MuZoFCpqaPGSB
         wVD3zj1ABw9iufj1HY6F2kmJXZFqR9/fMLme2LHClPCNKFv4K+pwEr1pOloFXf0MGCnr
         1SuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787323751; x=1787928551;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vlc/iU0BEBi/KNin4z6a2IXssoOeWKNQCCK9ZmekGRI=;
        b=SZj6SCxfBg45Njq0NKkZihp+RL5SIiBkbQZB1J2BDk5wnuiTHV4/n88USA4bymvaje
         Kor/H3DFtIy25yUT5P+EB6LKRPR/0GaN/fqkrvKP+gn9dbEVgkyS2ZDv0CjLJerDLK9M
         c3OHVB/b5fxL08PEafp5lfBMk2RzXYQ97EcyWWi360nduFzryTVuXylXy6+dMNrJORPR
         7QEOnirVixQR0EN9oGCkPfneQmiCp40bmn5COtHU4HwVJ7TeEWuTf2O2DOA5mD2Rl8m7
         P2j7FrxEsEKPIMghfqnlvYQS4+4uc9RuMz3o1sfKyO9e7Tq4ebFccmOebK20aF0YisZr
         qS+w==
X-Forwarded-Encrypted: i=1; AHgh+RqwJb4YM3CxxCIVNo6t81oY1ZmoFO5L/7dhX7GYEJH3SMdR6zUSPlKo+5nnQnfxFR68GkwQoNWpGvYNQRZs7eQsrv0fcL8=@vger.kernel.org
X-Gm-Message-State: AFuF++nMu8YeEv7uaA2zhJjbhTkr6lhuS+5RuQ7jcYlxGNi+PYB0lw+w
	MLPf1aSvhs2eT2yLTnYRo08GM7IzOUmcletB3TcHm4855UQCPd3ccYe7MrBCdlcS1+TkArko/Ic
	T50CaCVxsCIVen/3xrMWwBUgPZylnXPZY2Iez7pu6
X-Gm-Gg: AR+sD10puMBEbi2dJ9IJjgTLSOI329FVOQwZi1BJucu0fRa+DS0M9evVutANHlCq9MS
	uFlRhrtIUbMyFBFws4xNshWwXz0rKJWhdrrsTrRjcFCS5gV/gIr8oSmsHQ5eVIgX6SzLmWH/Eq0
	3nGDoFLguXTf8adOZEMGQXkkPTBVSREKZpAq4aRi2T0G8X6PLfhxU7IFv/vpMmEdHHlR4o5M4Ul
	59ZROnu/7CM/vJhvDecnKoonaLO6wyRm0i8LWvFGHS4b/yOQwd87z4VhDTRCIDrW+rtdXc4T1eZ
	9yQh150AmxB1Q/Nlz6jywQUiU1Ov/IxT6XDiwoIm2RN+TMlWu+8EFyn4CUJW5WVVjoSDS52xc1E
	+cWDTmZZo3hEy0t3VbH2UPPok8lfxxLJCE5Z0x5U=
X-Received: by 2002:a17:902:d98d:b0:2bd:3bfd:74f1 with SMTP id
 d9443c01a7336-2d64b0242damr7580045ad.2.1787323750012; Fri, 21 Aug 2026
 07:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
 <CAG48ez2Ngo3=VtyykXY6ynVzGwA8px-p4zV3V6U=YfgV-Hy4BA@mail.gmail.com> <dd8c34a9-0e09-453b-88e1-0a5511816627@kernel.org>
In-Reply-To: <dd8c34a9-0e09-453b-88e1-0a5511816627@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 21 Aug 2026 16:48:32 +0200
X-Gm-Features: AcwNN1XIz1KzlKUYbPV7VaC7KEh2VkyaYQONO-MSpK_iCwFkMVBjZQBPINMVB_Y
Message-ID: <CAG48ez2bZEV+3ww2x9XV_5vRPZ_3jU_zg6+h=BDKQ94Xrd3Tqg@mail.gmail.com>
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

On Fri, Aug 21, 2026 at 4:19=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
> On 8/20/26 20:44, Jann Horn wrote:
> > On Thu, Aug 20, 2026 at 7:22=E2=80=AFPM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> >> On 8/18/26 21:51, Jann Horn wrote:
> >>> If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently h=
ave no
> >>> good opportunity to block a process from overwriting read-only code i=
n its
> >>> own address space through FOLL_FORCE writes via /proc/self/mem.
> >>> The security_ptrace_access_check() LSM hook is bypassed when a proces=
s
> >>> opens /proc/self/mem because this is considered "introspection".
> >>>
> >>> This causes a hole in SELinux EXECMEM enforcement, which tries to ens=
ure
> >>> that a process cannot create executable anonymous pages.
> >>>
> >>> PROC_MEM_FORCE_PTRACE prevents that and ensures that such FOLL_FORCE
> >>> accesses are only possible when the LSM allows ptrace() attachment; b=
ut it
> >>> is unclear how quickly PROC_MEM_FORCE_PTRACE can be deployed in
> >>> environments running lots of third-party code, such as Android.
> >>>
> >>> So, introduce a new LSM hook that can forbid FOLL_FORCE specifically =
for
> >>> such "introspective" accesses.
> >>>
> >>> Signed-off-by: Jann Horn <jannh@google.com>
> >>> ---
> >>>  fs/proc/base.c                |  6 ++++++
> >>>  include/linux/lsm_hook_defs.h |  1 +
> >>>  include/linux/security.h      |  6 ++++++
> >>>  security/security.c           | 15 +++++++++++++++
> >>>  4 files changed, 28 insertions(+)
> >>>
> >>> diff --git a/fs/proc/base.c b/fs/proc/base.c
> >>> index bec6197329dc..3dfaef49bb70 100644
> >>> --- a/fs/proc/base.c
> >>> +++ b/fs/proc/base.c
> >>> @@ -851,6 +851,8 @@ static int __mem_open(struct inode *inode, struct=
 file *file, unsigned int mode)
> >>>  /* private_data for proc_mem_operations */
> >>>  struct mem_private {
> >>>       struct mm_struct *mm;
> >>> +     /* Was the ptrace access check bypassed due to introspection? *=
/
> >>> +     bool introspection;
> >>>  };
> >>>
> >>>  static int mem_open(struct inode *inode, struct file *file)
> >>> @@ -864,12 +866,14 @@ static int mem_open(struct inode *inode, struct=
 file *file)
> >>>       priv->mm =3D proc_mem_open(inode, PTRACE_MODE_ATTACH);
> >>>       if (IS_ERR_OR_NULL(priv->mm))
> >>>               return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> >>> +     priv->introspection =3D priv->mm =3D=3D current->mm;
> >>
> >> Is the feat that the fd could be passed to someone else that would the=
n not be
> >> detected as introspection?
> >
> > Yes, exactly, that's the primary reason why I did it this way.
>
> Okay, would "opened_by_owner" or something like that be clearer? At least
> "introspection" is less intuitive for me.

Ack, I'll rename it to something like that for the next version.

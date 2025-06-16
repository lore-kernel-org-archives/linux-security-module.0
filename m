Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063EA28A707
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750104977; cv=none; b=sQYGFmP/8jT4N2BuG/YLjSV/uISRXD4JbNjHw9zjJ28WtfYnq15G/WTIY5WytE7WyShUHgEi8VRUq+qDQtMVtrz2BqRu0LhIPwrbUmnKB7KARbiuufj/cMUba1P3Ks2sDuYTeogK9AtqLXu+Mm2U6z9WVeCHaegExgcDmU3+XiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750104977; c=relaxed/simple;
	bh=WVC9QyPy9+Tk0E1Q3CNbjmQ1KuPv9THZD++LtPRsAco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvPa4V2v8YnqIuFEXgEboL6ofR8FbTbr3wNP7prcJIxdlMq9jeUmOhMMc2UfR8NpZ0bBrKUxvAY5+PFR1+vydxOW1usg8imEEH58u30hsgu51dnEWz+Q3Fwtj0B9JgvXfrZ1js//I3uHr/aNStSK5ruLtP1xUBS+aCbl8jdtO/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WncF+7Xo; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WncF+7Xo"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70e3980757bso40700107b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 13:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750104974; x=1750709774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dScWmAMZFK0fm2mL6aq7jQir8PNp5loDd5z8uWsAF9c=;
        b=WncF+7XodGOHa1WgFkb6f9HdnudXhjXB6iH/jOvXcvDy+bLt50wSTtb/WkxuiWX8ON
         j1mInxeI9prnfJg+yfBVfoeEYlmJM/LX6uw9k+/TFR+HIoVHapamfThjba/Evo66lodx
         rORDOXrInudPDfgtIoPbH54PVLcqj5ftdfHgCX7Ciu88heG1Oo2USgbgNjyXMyb9ApRd
         Bn1jv6YHYw4AbRxEOODkuuvxLj6l1qSxD/Cyd4HjCWnb0ZzJ/n26a0eCmHMEQrsE7pPh
         IC2+pw+LR5ifoQDdV96OK2PIkue0MeFvHd7Q0itxkJpYPr1e9zLvswn0DBxWs/6Fbbj/
         hkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750104974; x=1750709774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dScWmAMZFK0fm2mL6aq7jQir8PNp5loDd5z8uWsAF9c=;
        b=p6sNbto6AtXxbz+XJQuIytIsbTVV0UtyaTyxVrFYKwcreclHcMycGxGcpHSHGmtZI7
         1ekboYQGdZd+ykwn4n/vkzbrTfBMbC2bnyb1lWfHXt/Ztg4QKuSxUzQV4znn60sOXrW5
         cEus73Uh8YjkMIc39xAtrh0ao5eclu6CoU7DvGs9tN0rZea2kw0Q9ev6IlaXy7I+p4nG
         UeTXgcs0+BVhCbIFqmmOkNUam06rtKE2MUiy9YY5kt3W4LtYiKHSA2xjq73JitVcvT48
         vt1PeDwccX8ydkfYImQZrOi9tFbeh83xVBFh5JqrKW8KVBiJKlgCxq5wcKdR+B6Eia2w
         I5Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVBVRb4qZFJTPYniqdmITWknx/CNjHZRCpXzdFsC+G+SHbPzE/QX0oI4F027M5hX8cr4YRnOf3Q5dC3zIzfwidNyBW9Sbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrnQ1yY0+wvnL5WIe1trlmXjysPFIVKFX080sjzdupgDR2oFbx
	9h2dutb4gGy7PFLNROL66nHrNU+RUMkSAIsyu/OC9Y2J+6oo2Vx19IELRGy8h7HAHT9lMqZZ2d5
	4U6+Tjd7/NBsGrPPukPsHul/cRI+3MenyGH/t4PDb
X-Gm-Gg: ASbGncseMNRb7HhNiSVCbVFBtTArucDo83UyMMYfN9kxsPRDyn+d8w4fdijcsC9pw5e
	MjsQsaZNOFkvzlS5hsKs2G+xnqehKVy9o3qFVf1cJSvjMsRCKG+nhPslTLaeNf/+1061hy1PtMy
	AHu1yqLLQufbTrW2fzV2XFacEoBuJvNqMSxaIeRwDAkgE=
X-Google-Smtp-Source: AGHT+IHDfGsVQ/9BF7Q1YHgvqHBtlRCp8+hY4gdBjE1LujIr4TKoMRg+lL5ep1EWCQnM0/Yh2lo5IZJUlATSo0lrvYg=
X-Received: by 2002:a05:690c:a0a4:10b0:70e:6c9c:e123 with SMTP id
 00721157ae682-7117211bb80mr117143457b3.0.1750104973910; Mon, 16 Jun 2025
 13:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202505151451.638C22B@keescook> <87ecwopofp.fsf@email.froward.int.ebiederm.org>
 <CAG48ez1VpuTR9_cvLrJEMmjOxTCYpYFswXVPmN6fE3NcSmPPVA@mail.gmail.com>
 <87wmagnnhq.fsf@email.froward.int.ebiederm.org> <202505201319.D57FDCB2A@keescook>
 <87frgznd74.fsf_-_@email.froward.int.ebiederm.org> <CAG48ez0N_1CEKyMHdjnvwsxUkCenmzsLe7dkUL=a6OmU4tPa6Q@mail.gmail.com>
 <87zff6gf17.fsf@email.froward.int.ebiederm.org> <CAG48ez1z97sCsx53W0O_dCCJL6tnf2pWuv=qaeszcYBfz_01sA@mail.gmail.com>
 <CAHC9VhRPUXwqLvo4rbxL0++5zqHXfD8_tr-sirTJXdF_Aba_UQ@mail.gmail.com>
 <20250612212626.GA166079@mail.hallyn.com> <40CCFDE0-A0DC-4F4E-8621-206F53D9225B@kernel.org>
 <CAHC9VhSMmNafbxLqP3j=nOra7OjHiECg6gUsWUuETWcZ01GrmA@mail.gmail.com> <407E9767-BDB7-48B2-BCEF-BBDD8EEF3DEA@kernel.org>
In-Reply-To: <407E9767-BDB7-48B2-BCEF-BBDD8EEF3DEA@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Jun 2025 16:16:02 -0400
X-Gm-Features: AX0GCFu4v2ls9mzOE7-52fnZfZ-J6tsORNiqdM6QZKKUh6H3_dRaN5AJeoVNfcM
Message-ID: <CAHC9VhRyVBGjTfqAC6yZWpp+4y4NcRupeybMLYro7yuM4Zg=hw@mail.gmail.com>
Subject: Re: [PATCH v2] exec: Correct the permission check for unsafe exec
To: Kees Cook <kees@kernel.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Richard Guy Briggs <rgb@redhat.com>, 
	Max Kellermann <max.kellermann@ionos.com>, jmorris@namei.org, 
	Andy Lutomirski <luto@kernel.org>, morgan@kernel.org, 
	Christian Brauner <christian@brauner.io>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 3:57=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On June 13, 2025 8:28:46 AM PDT, Paul Moore <paul@paul-moore.com> wrote:
> >On Thu, Jun 12, 2025 at 9:48=E2=80=AFPM Kees Cook <kees@kernel.org> wrot=
e:
> >> On June 12, 2025 2:26:26 PM PDT, "Serge E. Hallyn" <serge@hallyn.com> =
wrote:
> >> >On Tue, Jun 10, 2025 at 08:18:56PM -0400, Paul Moore wrote:
> >> >> On Wed, May 21, 2025 at 11:36=E2=80=AFAM Jann Horn <jannh@google.co=
m> wrote:
> >> >> > On Wed, May 21, 2025 at 5:27=E2=80=AFPM Eric W. Biederman <ebiede=
rm@xmission.com> wrote:
> >> >> > > Jann Horn <jannh@google.com> writes:
> >> >> > >
> >> >> > > > On Wed, May 21, 2025 at 12:13=E2=80=AFAM Eric W. Biederman
> >> >> > > > <ebiederm@xmission.com> wrote:
> >> >> > >
> >> >> > > > Looks good to me overall, thanks for figuring out the history=
 of this
> >> >> > > > not-particularly-easy-to-understand code and figuring out the=
 right
> >> >> > > > fix.
> >> >> > > >
> >> >> > > > Reviewed-by: Jann Horn <jannh@google.com>
> >> >> > > >
> >> >> > > >> @@ -917,7 +911,7 @@ int cap_bprm_creds_from_file(struct linu=
x_binprm *bprm, const struct file *file)
> >> >> > > >>         /* Process setpcap binaries and capabilities for uid=
 0 */
> >> >> > > >>         const struct cred *old =3D current_cred();
> >> >> > > >>         struct cred *new =3D bprm->cred;
> >> >> > > >> -       bool effective =3D false, has_fcap =3D false, is_set=
id;
> >> >> > > >> +       bool effective =3D false, has_fcap =3D false, id_cha=
nged;
> >> >> > > >>         int ret;
> >> >> > > >>         kuid_t root_uid;
> >> >> > > >>
> >> >> > > >> @@ -941,9 +935,9 @@ int cap_bprm_creds_from_file(struct linu=
x_binprm *bprm, const struct file *file)
> >> >> > > >>          *
> >> >> > > >>          * In addition, if NO_NEW_PRIVS, then ensure we get =
no new privs.
> >> >> > > >>          */
> >> >> > > >> -       is_setid =3D __is_setuid(new, old) || __is_setgid(ne=
w, old);
> >> >> > > >> +       id_changed =3D !uid_eq(new->euid, old->euid) || !in_=
group_p(new->egid);
> >> >> > > >
> >> >> > > > Hm, so when we change from one EGID to another EGID which was=
 already
> >> >> > > > in our groups list, we don't treat it as a privileged exec? W=
hich is
> >> >> > > > okay because, while an unprivileged user would not just be al=
lowed to
> >> >> > > > change their EGID to a GID from their groups list themselves =
through
> >> >> > > > __sys_setregid(), they would be allowed to create a new setgi=
d binary
> >> >> > > > owned by a group from their groups list and then execute that=
?
> >> >> > > >
> >> >> > > > That's fine with me, though it seems a little weird to me. se=
tgid exec
> >> >> > > > is changing our creds and yet we're not treating it as a "rea=
l" setgid
> >> >> > > > execution because the execution is only granting privileges t=
hat
> >> >> > > > userspace could have gotten anyway.
> >> >> > >
> >> >> > > More than could have gotten.  From permission checking point of=
 view
> >> >> > > permission that the application already had.  In general group =
based
> >> >> > > permission checks just check in_group_p, which looks at cred->f=
sgid and
> >> >> > > the group.
> >> >> > >
> >> >> > > The logic is since the effective permissions of the running exe=
cutable
> >> >> > > have not changed, there is nothing to special case.
> >> >> > >
> >> >> > > Arguably a setgid exec can drop what was egid, and if people ha=
ve
> >> >> > > configured their permissions to deny people access based upon a=
 group
> >> >> > > they are in that could change the result of the permission chec=
ks.  If
> >> >> > > changing egid winds up dropping a group from the list of the pr=
ocess's
> >> >> > > groups, the process could also have dropped that group with set=
resgid.
> >> >> > > So I don't think we need to be concerned about the combination =
of
> >> >> > > dropping egid and brpm->unsafe.
> >> >> > >
> >> >> > > If anyone sees a hole in that logic I am happy to change the ch=
eck
> >> >> > > to !gid_eq(new->egid, old->egid), but I just can't see a way ch=
anging
> >> >> > > egid/fsgid to a group the process already has is a problem.
> >> >> >
> >> >> > I'm fine with leaving your patch as-is.
> >> >>
> >> >> Aside from a tested-by verification from Max, it looks like everyon=
e
> >> >> is satisfied with the v2 patch, yes?
> >> >>
> >> >> Serge, I see you've reviewed this patch, can I assume that now you
> >> >> have a capabilities tree up and running you'll take this patch?
> >> >
> >> >I can take another look and consider taking it on Monday, but until
> >> >then I'm effectively afk.
> >>
> >> I'd rather this go via the execve/binfmt tree. I was waiting for -rc2 =
before putting it into -next. I can do Sunday night after it's out. :)
> >
> >I'm not going to argue either way on this, that's between you and
> >Serge, but as the entire patch is located within commoncap.c and that
> >is part of the capabilities code which Serge maintains, can you
> >explain why this should go via the execve/binfmt tree and not the
> >capabilities tree?
>
>
> Well, it's code exercised exclusively by the execve syscall (even the sub=
ject prefix says "exec"), but really I just want to be aware of changes in =
this area. How about we do what we're doing in vma, which is to list specif=
ic files in both entries in the MAINTAINERS file?

Double listing commoncap.c seems a bit heavyweight here and will
likely catch a lot of things unrelated to exec, but maybe some
additional K/regex fields in the exec section would make sense?

> Anyway, sure, Serge, go ahead and take it. :)
>
> Acked-by: Kees Cook <kees@kernel.org>

--=20
paul-moore.com

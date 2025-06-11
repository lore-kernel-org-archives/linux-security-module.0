Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCBF4A32
	for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 00:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749601149; cv=none; b=EoaRUbbdZoqlnpCu4yJscH5PJ2J/MKjnHBkzuox07XHyNbGbjuRanxUxw9G7yYn8u7gTlId2INSJmfpj3ekqcdc9aEDiAhOVAj6HcBRErUr1m4WS1Co57+qkZxSnwlO79FY9m7rsAdbyCXSwyjF6v6VLg3ZtTFyliz8FKjc4NYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749601149; c=relaxed/simple;
	bh=IORY47wQy4LdI/kDBVKUbdiso0NR611iMYIP8OEfsyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPws5L20Kz1MxdHPqmaXaxMJ0OsFKDy32Oh7Fs2Q0CRXjaGrpzXfWYtidanMpZilhjp6Og8ggzsxmyBBgtU7KMtSQVv+peR/CshGDKwPQogWIihOUTWOcg1gY0DOLDbUjxXInmq/fzNooGLQ3Di9Xqq59ww9FJ3mDDJP2ZGusMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JTh8w6YA; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JTh8w6YA"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70e3e0415a7so4360587b3.0
        for <linux-security-module@vger.kernel.org>; Tue, 10 Jun 2025 17:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749601147; x=1750205947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVdd3dLz7ZIcTr4ufDvopuLf4wfm5imcfIZtINlNmT8=;
        b=JTh8w6YA00XKao01rmwKXhwmpa/t4X9EF472nSVPbopTKbrpmpDwm14wDQJ6Z/8Wv4
         tHtbeBFBGLTqyl4RLoqhUk2ixOJCcSlq0ACfbnFycyyDNUKGFc6b2jSU0EN6cQWFUxxd
         xeGYNTjlqnkxhcxImxvg9GVuozJrE8A3bZrL+1PWgE8MF1ngTtpwdVz78PtYsBmtK+nI
         cSvBdiZ3bQYZAorKwhh9W98I8yuGwehYbVOzsEd8jBF0egXMjuByAAg1+RhtQyy1UxjT
         bA1OhtYHVtG+AVYu7YS2bQlS3k6k4ntCvMc7thOxk5sF9Nkl/dbONmcTDfDW1qzn8IGb
         VeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749601147; x=1750205947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVdd3dLz7ZIcTr4ufDvopuLf4wfm5imcfIZtINlNmT8=;
        b=AMsdwiH75eQIvoESLrcIeWnYnKjyeBBCb3tMGdnmlQDAIMzqQE7D83g5Mj61AHFtp0
         SZa5MZfGq6ECjSUdxQfcKSnGcLTW2Rn0m2FY8lYpuklZpTqb08jsL0GFG6QeQHuWCyro
         1hvCZNaIw2RQOLJOH1pYOaCcwVPiMrz2exlPcpS1dTV5pDNaVNRqYlYy78KN5SayJPWR
         zQ4mrKGv2AFk1b/OJQAyLZdLk+rvsKucjlVvDBu6WkHMWJ2Xuvtq7Ug0Pi7jiPMyElWJ
         NNmCRlCwIgYLerhhk3VWaJuKisy1mQt0v0aLVaHxuxhhW/vlWix4O2k5YF0eCqX2/73J
         ZkAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4cyLFE61wx4ynl4fQt+u7Xc2iftOVnWGi/oVyDdQLVsa9dkhld9sRjv6iKYDNVEoUiRNOhvHNT9jCKDX9WP+ReSbJ0SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHgWH/P9g0psouX9+KT/TtSSHV2gARgm2ZI5ExILoQuh85CXqG
	hqySk4+HDWsa1/qEZpJFrs6vPAdkopl0ZcjboupqwUEogZailhwjeYrdUHXPjX8Ar8n6lWw/EdK
	t3NQhW6We/i5+04mDNzToFv10qZkrH9wqDTVHS87D
X-Gm-Gg: ASbGncviFPP6zKzeekVnj/COPPbSogy2KhY2bfK6PhbwNqPIWd1hXCXRB2elb3+7uwf
	nS15J3n9WWlsyWHwHyexR5FbbamUtEjhwavNK38lplgnUDMiO9pIsm6kWz+eekPbzIEBuGfmapk
	Ss8TKC7nL3VtuDVVHhVwslFo6+ysGULPOdvC8RPr3g4OA=
X-Google-Smtp-Source: AGHT+IFhaywKvZhSqGMYCEnZVjdvyyEH3lPyXmudVciSPFI3Riyi/kqwflYAzvkhk/3jL5m6fRCinhNMSX8xauJ1HpU=
X-Received: by 2002:a05:690c:dc3:b0:70e:25b2:8f42 with SMTP id
 00721157ae682-71140b0ba00mr21319537b3.18.1749601146869; Tue, 10 Jun 2025
 17:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306082615.174777-1-max.kellermann@ionos.com>
 <878qmxsuy8.fsf@email.froward.int.ebiederm.org> <202505151451.638C22B@keescook>
 <87ecwopofp.fsf@email.froward.int.ebiederm.org> <CAG48ez1VpuTR9_cvLrJEMmjOxTCYpYFswXVPmN6fE3NcSmPPVA@mail.gmail.com>
 <87wmagnnhq.fsf@email.froward.int.ebiederm.org> <202505201319.D57FDCB2A@keescook>
 <87frgznd74.fsf_-_@email.froward.int.ebiederm.org> <CAG48ez0N_1CEKyMHdjnvwsxUkCenmzsLe7dkUL=a6OmU4tPa6Q@mail.gmail.com>
 <87zff6gf17.fsf@email.froward.int.ebiederm.org> <CAG48ez1z97sCsx53W0O_dCCJL6tnf2pWuv=qaeszcYBfz_01sA@mail.gmail.com>
In-Reply-To: <CAG48ez1z97sCsx53W0O_dCCJL6tnf2pWuv=qaeszcYBfz_01sA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Jun 2025 20:18:56 -0400
X-Gm-Features: AX0GCFteIk2y01CS-cNcS4mA_PTKbDwTd2hyrP2HwjpuZ2_UI5DzEEK5JAgjzOw
Message-ID: <CAHC9VhRPUXwqLvo4rbxL0++5zqHXfD8_tr-sirTJXdF_Aba_UQ@mail.gmail.com>
Subject: Re: [PATCH v2] exec: Correct the permission check for unsafe exec
To: Jann Horn <jannh@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Richard Guy Briggs <rgb@redhat.com>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Kees Cook <kees@kernel.org>, 
	Max Kellermann <max.kellermann@ionos.com>, jmorris@namei.org, 
	Andy Lutomirski <luto@kernel.org>, morgan@kernel.org, 
	Christian Brauner <christian@brauner.io>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 11:36=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
> On Wed, May 21, 2025 at 5:27=E2=80=AFPM Eric W. Biederman <ebiederm@xmiss=
ion.com> wrote:
> > Jann Horn <jannh@google.com> writes:
> >
> > > On Wed, May 21, 2025 at 12:13=E2=80=AFAM Eric W. Biederman
> > > <ebiederm@xmission.com> wrote:
> >
> > > Looks good to me overall, thanks for figuring out the history of this
> > > not-particularly-easy-to-understand code and figuring out the right
> > > fix.
> > >
> > > Reviewed-by: Jann Horn <jannh@google.com>
> > >
> > >> @@ -917,7 +911,7 @@ int cap_bprm_creds_from_file(struct linux_binprm=
 *bprm, const struct file *file)
> > >>         /* Process setpcap binaries and capabilities for uid 0 */
> > >>         const struct cred *old =3D current_cred();
> > >>         struct cred *new =3D bprm->cred;
> > >> -       bool effective =3D false, has_fcap =3D false, is_setid;
> > >> +       bool effective =3D false, has_fcap =3D false, id_changed;
> > >>         int ret;
> > >>         kuid_t root_uid;
> > >>
> > >> @@ -941,9 +935,9 @@ int cap_bprm_creds_from_file(struct linux_binprm=
 *bprm, const struct file *file)
> > >>          *
> > >>          * In addition, if NO_NEW_PRIVS, then ensure we get no new p=
rivs.
> > >>          */
> > >> -       is_setid =3D __is_setuid(new, old) || __is_setgid(new, old);
> > >> +       id_changed =3D !uid_eq(new->euid, old->euid) || !in_group_p(=
new->egid);
> > >
> > > Hm, so when we change from one EGID to another EGID which was already
> > > in our groups list, we don't treat it as a privileged exec? Which is
> > > okay because, while an unprivileged user would not just be allowed to
> > > change their EGID to a GID from their groups list themselves through
> > > __sys_setregid(), they would be allowed to create a new setgid binary
> > > owned by a group from their groups list and then execute that?
> > >
> > > That's fine with me, though it seems a little weird to me. setgid exe=
c
> > > is changing our creds and yet we're not treating it as a "real" setgi=
d
> > > execution because the execution is only granting privileges that
> > > userspace could have gotten anyway.
> >
> > More than could have gotten.  From permission checking point of view
> > permission that the application already had.  In general group based
> > permission checks just check in_group_p, which looks at cred->fsgid and
> > the group.
> >
> > The logic is since the effective permissions of the running executable
> > have not changed, there is nothing to special case.
> >
> > Arguably a setgid exec can drop what was egid, and if people have
> > configured their permissions to deny people access based upon a group
> > they are in that could change the result of the permission checks.  If
> > changing egid winds up dropping a group from the list of the process's
> > groups, the process could also have dropped that group with setresgid.
> > So I don't think we need to be concerned about the combination of
> > dropping egid and brpm->unsafe.
> >
> > If anyone sees a hole in that logic I am happy to change the check
> > to !gid_eq(new->egid, old->egid), but I just can't see a way changing
> > egid/fsgid to a group the process already has is a problem.
>
> I'm fine with leaving your patch as-is.

Aside from a tested-by verification from Max, it looks like everyone
is satisfied with the v2 patch, yes?

Serge, I see you've reviewed this patch, can I assume that now you
have a capabilities tree up and running you'll take this patch?

--=20
paul-moore.com

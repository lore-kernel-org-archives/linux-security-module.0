Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9CB21D59B
	for <linux-security-module@vger.kernel.org>; Wed, 21 May 2025 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841819; cv=none; b=Ah6TTNWBX/Y4xhMk802sItYgOT4zIdRB4AVsohnOMEzq/k3aJvjpj2PdMiePKetcaD8S1HToNxWgJiSY33wEbbOS2gPm9NyeMCQqktt4BFG3wRd3xvfAnS5RSPUQmqv/nIZV0l04Y1k9shvrWOobFNsGr+nOhV+AJWA50liuDYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841819; c=relaxed/simple;
	bh=SM7KrvI7eLMIkyAD0UVXhjfdPdQtn+P+cabacZ6LcTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzuNcdkXIQqEyTNVwhn+Mrr1I3rmsiJ2hztzbBzZk8Tr3/XOgD8CqSAkLLdWmZmN7jNRqx6M8KWiXUXVBk/dq/OUtPGkv9SlH60I94Fr+Zeh3T40MpD7Wd4F3V3ksbkrzMB+wQG4k3uxwR6qp3MEKajYni1yj+ffbhpU0HLvRs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NvyqMsT+; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NvyqMsT+"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6000791e832so38332a12.1
        for <linux-security-module@vger.kernel.org>; Wed, 21 May 2025 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747841816; x=1748446616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfZmxGM2+EUbxWogJjiQEh6M304h/CsnIOCgDa2Sp+E=;
        b=NvyqMsT+Kr7clFVllOptZ80AyebxS1wxDV4PBIxibj4f9gTkkXVRjwfmII68bTd56+
         j003zIgZtlVHeJ96AwM4hXSPeTxu6atwuYyGLlalEC1arcAGMbT+XcPEzK7kfICvgcnP
         eHKe/EJDhwg1iZ0aMgvXQVqdo0EguEvgFTXve0EVsAE81AChDrPlHwqQFk96JAiC9rhH
         sz1n3OrATV21/9/8/talDuLAciozam75U98xafSiDRzwI8/z999/Lod/E76fkn3uFHVY
         WHNRlsRtcruaDjZLpl3dacTwjf4b3pr3maUItyXnbvfNI3dvULxVK9QzLchBmaErdbIV
         /xTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747841816; x=1748446616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfZmxGM2+EUbxWogJjiQEh6M304h/CsnIOCgDa2Sp+E=;
        b=P6J1eyAk25PnHbAAVZ8mnFR9HbrlQcrMgTwrPfRaBFt711DIoXsseoQuYNZM3mEyi2
         f0aRhsZflRXPubwjTzagWukr0tPVUMq8p7YJfs2DQoD+H/G08nDL5nPEXENV+At27Esw
         M8QCwKzrRQDrOyw3xANz4AoZG+npHcZJhKY72GLzWhTdKXod2LlkdOEB7332ArykEIBX
         WhL7wRrjnsK54bEWN5M3OnI/wWbHDz2xkNF6PN3bpLpjYQphj5al2jIKt2mgF8MBU3ab
         kbCbKh5KMFaqYXP0F4kHUU0O6XMKSSQvB868NxWuh03HL+trGIY0aBWcozMv8S4fcfQ+
         JF/A==
X-Forwarded-Encrypted: i=1; AJvYcCXH0TpkQi9sjAmjEMweuNHM/crcaeutnawoLr03F82f830LEth6YuOihIMZisVYFWoaMs7ZlSxuoukhP6+dCNnD2NNVNU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLaNitRIN7eeiInQ87wJHdhrvkrI5E0/jBEL7e3C62Scq/I2FM
	E+YHQZ2IcwEXWiGErIeUszD7AK85FGvGjbaVfVYUmZlQecHWv5JMfWKSrQqi4rz5OMdPxm8Lmt7
	KchQHmITEN9qDBhrH708Z6Y/MrQHzbwn0DsTVno4F
X-Gm-Gg: ASbGnctT20hGYCMIHBH5+IbKB0ZT5OAXse8jeZvVK4mj21LiSz8ieFWvfTd77ZW8nnd
	2p862KSia1cLUIA2KbpfStBRZqVDcJby2N5b7p4iNz9QJ1uBEt+Jvgate20ccVmqO2BXdvq5hli
	eWGiFuxv69xyNs3CjQYu0FgRAFcuoOHGI40yFAqnFmeXgk95ZA/9gTJKlZE3mF86rT6/nZnAeZs
	CMR2DeGOz8=
X-Google-Smtp-Source: AGHT+IH0PCZmu9XxCrE1x8a3M5h757rXSLLQQPqZgeIp1ENluSUZFfqmgEsSp7VlY8zsloCLnP6yToP6FboR1V/iGI4=
X-Received: by 2002:a05:6402:f85:b0:5fd:28:c3f6 with SMTP id
 4fb4d7f45d1cf-6019c8884b4mr462918a12.4.1747841815673; Wed, 21 May 2025
 08:36:55 -0700 (PDT)
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
 <87zff6gf17.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87zff6gf17.fsf@email.froward.int.ebiederm.org>
From: Jann Horn <jannh@google.com>
Date: Wed, 21 May 2025 17:36:18 +0200
X-Gm-Features: AX0GCFuH7zkVGqrB7QBSXnPK059YsKAZdSIDiUFJ2RJe1PMCQ4EwP8ivhAY7NrM
Message-ID: <CAG48ez1z97sCsx53W0O_dCCJL6tnf2pWuv=qaeszcYBfz_01sA@mail.gmail.com>
Subject: Re: [PATCH v2] exec: Correct the permission check for unsafe exec
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Richard Guy Briggs <rgb@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, Kees Cook <kees@kernel.org>, 
	Max Kellermann <max.kellermann@ionos.com>, paul@paul-moore.com, jmorris@namei.org, 
	Andy Lutomirski <luto@kernel.org>, morgan@kernel.org, 
	Christian Brauner <christian@brauner.io>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 5:27=E2=80=AFPM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
> Jann Horn <jannh@google.com> writes:
>
> > On Wed, May 21, 2025 at 12:13=E2=80=AFAM Eric W. Biederman
> > <ebiederm@xmission.com> wrote:
>
> > Looks good to me overall, thanks for figuring out the history of this
> > not-particularly-easy-to-understand code and figuring out the right
> > fix.
> >
> > Reviewed-by: Jann Horn <jannh@google.com>
> >
> >> @@ -917,7 +911,7 @@ int cap_bprm_creds_from_file(struct linux_binprm *=
bprm, const struct file *file)
> >>         /* Process setpcap binaries and capabilities for uid 0 */
> >>         const struct cred *old =3D current_cred();
> >>         struct cred *new =3D bprm->cred;
> >> -       bool effective =3D false, has_fcap =3D false, is_setid;
> >> +       bool effective =3D false, has_fcap =3D false, id_changed;
> >>         int ret;
> >>         kuid_t root_uid;
> >>
> >> @@ -941,9 +935,9 @@ int cap_bprm_creds_from_file(struct linux_binprm *=
bprm, const struct file *file)
> >>          *
> >>          * In addition, if NO_NEW_PRIVS, then ensure we get no new pri=
vs.
> >>          */
> >> -       is_setid =3D __is_setuid(new, old) || __is_setgid(new, old);
> >> +       id_changed =3D !uid_eq(new->euid, old->euid) || !in_group_p(ne=
w->egid);
> >
> > Hm, so when we change from one EGID to another EGID which was already
> > in our groups list, we don't treat it as a privileged exec? Which is
> > okay because, while an unprivileged user would not just be allowed to
> > change their EGID to a GID from their groups list themselves through
> > __sys_setregid(), they would be allowed to create a new setgid binary
> > owned by a group from their groups list and then execute that?
> >
> > That's fine with me, though it seems a little weird to me. setgid exec
> > is changing our creds and yet we're not treating it as a "real" setgid
> > execution because the execution is only granting privileges that
> > userspace could have gotten anyway.
>
> More than could have gotten.  From permission checking point of view
> permission that the application already had.  In general group based
> permission checks just check in_group_p, which looks at cred->fsgid and
> the group.
>
> The logic is since the effective permissions of the running executable
> have not changed, there is nothing to special case.
>
> Arguably a setgid exec can drop what was egid, and if people have
> configured their permissions to deny people access based upon a group
> they are in that could change the result of the permission checks.  If
> changing egid winds up dropping a group from the list of the process's
> groups, the process could also have dropped that group with setresgid.
> So I don't think we need to be concerned about the combination of
> dropping egid and brpm->unsafe.
>
> If anyone sees a hole in that logic I am happy to change the check
> to !gid_eq(new->egid, old->egid), but I just can't see a way changing
> egid/fsgid to a group the process already has is a problem.

I'm fine with leaving your patch as-is.

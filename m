Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECA572636;
	Fri, 13 Jun 2025 01:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749779295; cv=none; b=dIdjgRQ4EynVK4acKaKJff+P+8d6Z8IPuuR7lNZTkpLA/Y9zvuV1+pryH0kVz1blkyaNA1QKUVEvU5j9scSLLwrQAADZsDYC6SjhJOpNu2bJ/NMatxBnFjHMQkJzDKgucVyllN9I08z7a70uj9JSj47fft/bSMdWx74Fe8ID+14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749779295; c=relaxed/simple;
	bh=q464iU8oHlOhLED7rRVpQcVddt2ATVpp07Hs0FJvkhs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=o8uxog51Y+3ePSlK60JzBD1sGjPb+Vv2qEkvHC9v/qeQ5flDxsI0B4UqIXr9F0x8BrQT2FMGLin+eMuLnbSL+VVJDhBFycAAOW3V9wr/WHwDfGjt5UGgeTkmw+FtAZDvFHF19acori8uH7udCkrjE6zdA1HlyXmsA9Kkm59XfB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1xX1Hgd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1xX1Hgd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C2CC4CEEA;
	Fri, 13 Jun 2025 01:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749779295;
	bh=q464iU8oHlOhLED7rRVpQcVddt2ATVpp07Hs0FJvkhs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=o1xX1HgdwejrnX+GXCdC9S2Fjocpu2bzjEEehryJnyXXEYAkmBK9+/h7SS+7VSwbo
	 8U9hHjdoBxZ3eYmFRL2I2wuW5ybBhtozGPcRQGbD1p8poOk0CcjS14QtV210xu5CkD
	 FLMf2VBCKjhdt0UDnCBbv4aFRXeXqd10mKJrX2ItmO2ggSGRTKJFKW2ZbPjdMW2hJE
	 S1eoBKRhv2fPB4aJDeyhZhI7kroOVvAQMfoukme0U5x2l315GPE0CEXwG5Mcni/l1q
	 gKumC53vfUQHU5dgoiXY3RMGKABIGRi/+d4wZFQsqzpMlmArJlY9m1KnXNlAxG4dob
	 BVSOSifEpkk/A==
Date: Thu, 12 Jun 2025 18:48:13 -0700
From: Kees Cook <kees@kernel.org>
To: "Serge E. Hallyn" <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>
CC: Jann Horn <jannh@google.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
 Richard Guy Briggs <rgb@redhat.com>,
 Max Kellermann <max.kellermann@ionos.com>, jmorris@namei.org,
 Andy Lutomirski <luto@kernel.org>, morgan@kernel.org,
 Christian Brauner <christian@brauner.io>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] exec: Correct the permission check for unsafe exec
User-Agent: K-9 Mail for Android
In-Reply-To: <20250612212626.GA166079@mail.hallyn.com>
References: <202505151451.638C22B@keescook> <87ecwopofp.fsf@email.froward.int.ebiederm.org> <CAG48ez1VpuTR9_cvLrJEMmjOxTCYpYFswXVPmN6fE3NcSmPPVA@mail.gmail.com> <87wmagnnhq.fsf@email.froward.int.ebiederm.org> <202505201319.D57FDCB2A@keescook> <87frgznd74.fsf_-_@email.froward.int.ebiederm.org> <CAG48ez0N_1CEKyMHdjnvwsxUkCenmzsLe7dkUL=a6OmU4tPa6Q@mail.gmail.com> <87zff6gf17.fsf@email.froward.int.ebiederm.org> <CAG48ez1z97sCsx53W0O_dCCJL6tnf2pWuv=qaeszcYBfz_01sA@mail.gmail.com> <CAHC9VhRPUXwqLvo4rbxL0++5zqHXfD8_tr-sirTJXdF_Aba_UQ@mail.gmail.com> <20250612212626.GA166079@mail.hallyn.com>
Message-ID: <40CCFDE0-A0DC-4F4E-8621-206F53D9225B@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On June 12, 2025 2:26:26 PM PDT, "Serge E=2E Hallyn" <serge@hallyn=2Ecom> =
wrote:
>On Tue, Jun 10, 2025 at 08:18:56PM -0400, Paul Moore wrote:
>> On Wed, May 21, 2025 at 11:36=E2=80=AFAM Jann Horn <jannh@google=2Ecom>=
 wrote:
>> > On Wed, May 21, 2025 at 5:27=E2=80=AFPM Eric W=2E Biederman <ebiederm=
@xmission=2Ecom> wrote:
>> > > Jann Horn <jannh@google=2Ecom> writes:
>> > >
>> > > > On Wed, May 21, 2025 at 12:13=E2=80=AFAM Eric W=2E Biederman
>> > > > <ebiederm@xmission=2Ecom> wrote:
>> > >
>> > > > Looks good to me overall, thanks for figuring out the history of =
this
>> > > > not-particularly-easy-to-understand code and figuring out the rig=
ht
>> > > > fix=2E
>> > > >
>> > > > Reviewed-by: Jann Horn <jannh@google=2Ecom>
>> > > >
>> > > >> @@ -917,7 +911,7 @@ int cap_bprm_creds_from_file(struct linux_bi=
nprm *bprm, const struct file *file)
>> > > >>         /* Process setpcap binaries and capabilities for uid 0 *=
/
>> > > >>         const struct cred *old =3D current_cred();
>> > > >>         struct cred *new =3D bprm->cred;
>> > > >> -       bool effective =3D false, has_fcap =3D false, is_setid;
>> > > >> +       bool effective =3D false, has_fcap =3D false, id_changed=
;
>> > > >>         int ret;
>> > > >>         kuid_t root_uid;
>> > > >>
>> > > >> @@ -941,9 +935,9 @@ int cap_bprm_creds_from_file(struct linux_bi=
nprm *bprm, const struct file *file)
>> > > >>          *
>> > > >>          * In addition, if NO_NEW_PRIVS, then ensure we get no n=
ew privs=2E
>> > > >>          */
>> > > >> -       is_setid =3D __is_setuid(new, old) || __is_setgid(new, o=
ld);
>> > > >> +       id_changed =3D !uid_eq(new->euid, old->euid) || !in_grou=
p_p(new->egid);
>> > > >
>> > > > Hm, so when we change from one EGID to another EGID which was alr=
eady
>> > > > in our groups list, we don't treat it as a privileged exec? Which=
 is
>> > > > okay because, while an unprivileged user would not just be allowe=
d to
>> > > > change their EGID to a GID from their groups list themselves thro=
ugh
>> > > > __sys_setregid(), they would be allowed to create a new setgid bi=
nary
>> > > > owned by a group from their groups list and then execute that?
>> > > >
>> > > > That's fine with me, though it seems a little weird to me=2E setg=
id exec
>> > > > is changing our creds and yet we're not treating it as a "real" s=
etgid
>> > > > execution because the execution is only granting privileges that
>> > > > userspace could have gotten anyway=2E
>> > >
>> > > More than could have gotten=2E  From permission checking point of v=
iew
>> > > permission that the application already had=2E  In general group ba=
sed
>> > > permission checks just check in_group_p, which looks at cred->fsgid=
 and
>> > > the group=2E
>> > >
>> > > The logic is since the effective permissions of the running executa=
ble
>> > > have not changed, there is nothing to special case=2E
>> > >
>> > > Arguably a setgid exec can drop what was egid, and if people have
>> > > configured their permissions to deny people access based upon a gro=
up
>> > > they are in that could change the result of the permission checks=
=2E  If
>> > > changing egid winds up dropping a group from the list of the proces=
s's
>> > > groups, the process could also have dropped that group with setresg=
id=2E
>> > > So I don't think we need to be concerned about the combination of
>> > > dropping egid and brpm->unsafe=2E
>> > >
>> > > If anyone sees a hole in that logic I am happy to change the check
>> > > to !gid_eq(new->egid, old->egid), but I just can't see a way changi=
ng
>> > > egid/fsgid to a group the process already has is a problem=2E
>> >
>> > I'm fine with leaving your patch as-is=2E
>>=20
>> Aside from a tested-by verification from Max, it looks like everyone
>> is satisfied with the v2 patch, yes?
>>=20
>> Serge, I see you've reviewed this patch, can I assume that now you
>> have a capabilities tree up and running you'll take this patch?
>
>I can take another look and consider taking it on Monday, but until
>then I'm effectively afk=2E

I'd rather this go via the execve/binfmt tree=2E I was waiting for -rc2 be=
fore putting it into -next=2E I can do Sunday night after it's out=2E :)

--=20
Kees Cook

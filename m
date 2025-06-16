Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75646B5;
	Mon, 16 Jun 2025 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750103849; cv=none; b=nlRsX9m3ELJvjHU/UO8f2apwI/tttHxxuC/bqSc+jVjgNIBHETVhJR+CxL6w1WUcZLS41WG7Z9jYaC+njDpbjcNy9aWNspGYlLOJDF0KdhP7kaXx05dJxjmXm08GOdxcusx2bsUvMEmBAFUDbhzXHR3lHbnhctQJ1+bROdg3Z80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750103849; c=relaxed/simple;
	bh=XcqvK4bZ0wXtZ7s1nOwnjUbTJTOByR/dsLvbXQsSzGg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=YKh9sOaRzmn7CluEdaUcGNpVDdsNZyChjugzPHYmUNOLkGVWsWW+CzbxPmsqY8zClRoxPBP9xBvhSY48czon9MEPE0pl1UglCwFq/p5FpgLVWwty1Fj0iW8ulUF4AZlzhaTyG8IBxV+S+u7gBlelfJ85RVu0uHVNmACRhQGveWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyjZ/RrV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyjZ/RrV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADD7C4CEEA;
	Mon, 16 Jun 2025 19:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750103849;
	bh=XcqvK4bZ0wXtZ7s1nOwnjUbTJTOByR/dsLvbXQsSzGg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=iyjZ/RrV9g2Yn5RoVYLVlX+2xXKkFt6PW99nBvb3B10UsSDlAnH1XsUDhPo24NZyS
	 4lxueao6jcM52smcTFgKOPuRVkTGQkqzxHiLDZ7C+8c92baTMlLiz1EfvQ3X2kfb/x
	 8u2CDVLRIM0s1Bf7WEfYFSl3Ph4lMiuLGvgJlu5lyqgU6k4zEZ0p4IQl/+VyIctxws
	 KHvUbJO41SuytoBS3VfSiLrYhil11jo553DMFkUZujuxRsJegynYSrruUFEoQRuCNX
	 /FbrbbzVGNNmqML4XQvEpCKQ56JV+OzxWQ2PwdQk76g9/+jvJxvRREYvjMSmXa3bSG
	 NIS1O2BkZen6A==
Date: Mon, 16 Jun 2025 12:57:26 -0700
From: Kees Cook <kees@kernel.org>
To: Paul Moore <paul@paul-moore.com>
CC: "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Richard Guy Briggs <rgb@redhat.com>,
 Max Kellermann <max.kellermann@ionos.com>, jmorris@namei.org,
 Andy Lutomirski <luto@kernel.org>, morgan@kernel.org,
 Christian Brauner <christian@brauner.io>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] exec: Correct the permission check for unsafe exec
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHC9VhSMmNafbxLqP3j=nOra7OjHiECg6gUsWUuETWcZ01GrmA@mail.gmail.com>
References: <202505151451.638C22B@keescook> <87ecwopofp.fsf@email.froward.int.ebiederm.org> <CAG48ez1VpuTR9_cvLrJEMmjOxTCYpYFswXVPmN6fE3NcSmPPVA@mail.gmail.com> <87wmagnnhq.fsf@email.froward.int.ebiederm.org> <202505201319.D57FDCB2A@keescook> <87frgznd74.fsf_-_@email.froward.int.ebiederm.org> <CAG48ez0N_1CEKyMHdjnvwsxUkCenmzsLe7dkUL=a6OmU4tPa6Q@mail.gmail.com> <87zff6gf17.fsf@email.froward.int.ebiederm.org> <CAG48ez1z97sCsx53W0O_dCCJL6tnf2pWuv=qaeszcYBfz_01sA@mail.gmail.com> <CAHC9VhRPUXwqLvo4rbxL0++5zqHXfD8_tr-sirTJXdF_Aba_UQ@mail.gmail.com> <20250612212626.GA166079@mail.hallyn.com> <40CCFDE0-A0DC-4F4E-8621-206F53D9225B@kernel.org> <CAHC9VhSMmNafbxLqP3j=nOra7OjHiECg6gUsWUuETWcZ01GrmA@mail.gmail.com>
Message-ID: <407E9767-BDB7-48B2-BCEF-BBDD8EEF3DEA@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On June 13, 2025 8:28:46 AM PDT, Paul Moore <paul@paul-moore=2Ecom> wrote:
>On Thu, Jun 12, 2025 at 9:48=E2=80=AFPM Kees Cook <kees@kernel=2Eorg> wro=
te:
>> On June 12, 2025 2:26:26 PM PDT, "Serge E=2E Hallyn" <serge@hallyn=2Eco=
m> wrote:
>> >On Tue, Jun 10, 2025 at 08:18:56PM -0400, Paul Moore wrote:
>> >> On Wed, May 21, 2025 at 11:36=E2=80=AFAM Jann Horn <jannh@google=2Ec=
om> wrote:
>> >> > On Wed, May 21, 2025 at 5:27=E2=80=AFPM Eric W=2E Biederman <ebied=
erm@xmission=2Ecom> wrote:
>> >> > > Jann Horn <jannh@google=2Ecom> writes:
>> >> > >
>> >> > > > On Wed, May 21, 2025 at 12:13=E2=80=AFAM Eric W=2E Biederman
>> >> > > > <ebiederm@xmission=2Ecom> wrote:
>> >> > >
>> >> > > > Looks good to me overall, thanks for figuring out the history =
of this
>> >> > > > not-particularly-easy-to-understand code and figuring out the =
right
>> >> > > > fix=2E
>> >> > > >
>> >> > > > Reviewed-by: Jann Horn <jannh@google=2Ecom>
>> >> > > >
>> >> > > >> @@ -917,7 +911,7 @@ int cap_bprm_creds_from_file(struct linux=
_binprm *bprm, const struct file *file)
>> >> > > >>         /* Process setpcap binaries and capabilities for uid =
0 */
>> >> > > >>         const struct cred *old =3D current_cred();
>> >> > > >>         struct cred *new =3D bprm->cred;
>> >> > > >> -       bool effective =3D false, has_fcap =3D false, is_seti=
d;
>> >> > > >> +       bool effective =3D false, has_fcap =3D false, id_chan=
ged;
>> >> > > >>         int ret;
>> >> > > >>         kuid_t root_uid;
>> >> > > >>
>> >> > > >> @@ -941,9 +935,9 @@ int cap_bprm_creds_from_file(struct linux=
_binprm *bprm, const struct file *file)
>> >> > > >>          *
>> >> > > >>          * In addition, if NO_NEW_PRIVS, then ensure we get n=
o new privs=2E
>> >> > > >>          */
>> >> > > >> -       is_setid =3D __is_setuid(new, old) || __is_setgid(new=
, old);
>> >> > > >> +       id_changed =3D !uid_eq(new->euid, old->euid) || !in_g=
roup_p(new->egid);
>> >> > > >
>> >> > > > Hm, so when we change from one EGID to another EGID which was =
already
>> >> > > > in our groups list, we don't treat it as a privileged exec? Wh=
ich is
>> >> > > > okay because, while an unprivileged user would not just be all=
owed to
>> >> > > > change their EGID to a GID from their groups list themselves t=
hrough
>> >> > > > __sys_setregid(), they would be allowed to create a new setgid=
 binary
>> >> > > > owned by a group from their groups list and then execute that?
>> >> > > >
>> >> > > > That's fine with me, though it seems a little weird to me=2E s=
etgid exec
>> >> > > > is changing our creds and yet we're not treating it as a "real=
" setgid
>> >> > > > execution because the execution is only granting privileges th=
at
>> >> > > > userspace could have gotten anyway=2E
>> >> > >
>> >> > > More than could have gotten=2E  From permission checking point o=
f view
>> >> > > permission that the application already had=2E  In general group=
 based
>> >> > > permission checks just check in_group_p, which looks at cred->fs=
gid and
>> >> > > the group=2E
>> >> > >
>> >> > > The logic is since the effective permissions of the running exec=
utable
>> >> > > have not changed, there is nothing to special case=2E
>> >> > >
>> >> > > Arguably a setgid exec can drop what was egid, and if people hav=
e
>> >> > > configured their permissions to deny people access based upon a =
group
>> >> > > they are in that could change the result of the permission check=
s=2E  If
>> >> > > changing egid winds up dropping a group from the list of the pro=
cess's
>> >> > > groups, the process could also have dropped that group with setr=
esgid=2E
>> >> > > So I don't think we need to be concerned about the combination o=
f
>> >> > > dropping egid and brpm->unsafe=2E
>> >> > >
>> >> > > If anyone sees a hole in that logic I am happy to change the che=
ck
>> >> > > to !gid_eq(new->egid, old->egid), but I just can't see a way cha=
nging
>> >> > > egid/fsgid to a group the process already has is a problem=2E
>> >> >
>> >> > I'm fine with leaving your patch as-is=2E
>> >>
>> >> Aside from a tested-by verification from Max, it looks like everyone
>> >> is satisfied with the v2 patch, yes?
>> >>
>> >> Serge, I see you've reviewed this patch, can I assume that now you
>> >> have a capabilities tree up and running you'll take this patch?
>> >
>> >I can take another look and consider taking it on Monday, but until
>> >then I'm effectively afk=2E
>>
>> I'd rather this go via the execve/binfmt tree=2E I was waiting for -rc2=
 before putting it into -next=2E I can do Sunday night after it's out=2E :)
>
>I'm not going to argue either way on this, that's between you and
>Serge, but as the entire patch is located within commoncap=2Ec and that
>is part of the capabilities code which Serge maintains, can you
>explain why this should go via the execve/binfmt tree and not the
>capabilities tree?


Well, it's code exercised exclusively by the execve syscall (even the subj=
ect prefix says "exec"), but really I just want to be aware of changes in t=
his area=2E How about we do what we're doing in vma, which is to list speci=
fic files in both entries in the MAINTAINERS file?

Anyway, sure, Serge, go ahead and take it=2E :)

Acked-by: Kees Cook <kees@kernel=2Eorg>


--=20
Kees Cook

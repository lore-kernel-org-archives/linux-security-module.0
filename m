Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E127FD;
	Thu, 12 Jun 2025 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749763966; cv=none; b=k8UlgQXJHZ5zpVXpL+aBmlYvD+cBeXsreP4hzivxsUURAnyNQ/BgndiMT6uqeNxHMdDVRCpexlNahNgiYuF0kRceGdJ2wSwKZbJ3DImolwVt23VhyKyJaADO/+WUT3D1DaJypZ4/Qz0ow68rjI7qvY0z2d91bfnW2VnMSqExMc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749763966; c=relaxed/simple;
	bh=ON3tli/S6K3gaMncVtXAqZDYSF179jqt86fVFR3uljs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSOfWKC6Q+0N6Lx65vrReYR7/v6518xcBlpDbyTYUMtyJtVdJrMkFhl52KgMxh8P4MwgaB7/fvrAKpZ2r25FIVPlndDaQP62+F4QaWgPU8X6iwxMYmPssbTGV5s6niLjf7Yu8oN0QMVcbAVgjWh3Ct+qipMMII+GB4rYTZnkpKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 0BA6F6B4; Thu, 12 Jun 2025 16:26:26 -0500 (CDT)
Date: Thu, 12 Jun 2025 16:26:26 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Jann Horn <jannh@google.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Richard Guy Briggs <rgb@redhat.com>,
	"Serge E. Hallyn" <serge@hallyn.com>, Kees Cook <kees@kernel.org>,
	Max Kellermann <max.kellermann@ionos.com>, jmorris@namei.org,
	Andy Lutomirski <luto@kernel.org>, morgan@kernel.org,
	Christian Brauner <christian@brauner.io>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] exec: Correct the permission check for unsafe exec
Message-ID: <20250612212626.GA166079@mail.hallyn.com>
References: <202505151451.638C22B@keescook>
 <87ecwopofp.fsf@email.froward.int.ebiederm.org>
 <CAG48ez1VpuTR9_cvLrJEMmjOxTCYpYFswXVPmN6fE3NcSmPPVA@mail.gmail.com>
 <87wmagnnhq.fsf@email.froward.int.ebiederm.org>
 <202505201319.D57FDCB2A@keescook>
 <87frgznd74.fsf_-_@email.froward.int.ebiederm.org>
 <CAG48ez0N_1CEKyMHdjnvwsxUkCenmzsLe7dkUL=a6OmU4tPa6Q@mail.gmail.com>
 <87zff6gf17.fsf@email.froward.int.ebiederm.org>
 <CAG48ez1z97sCsx53W0O_dCCJL6tnf2pWuv=qaeszcYBfz_01sA@mail.gmail.com>
 <CAHC9VhRPUXwqLvo4rbxL0++5zqHXfD8_tr-sirTJXdF_Aba_UQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRPUXwqLvo4rbxL0++5zqHXfD8_tr-sirTJXdF_Aba_UQ@mail.gmail.com>

On Tue, Jun 10, 2025 at 08:18:56PM -0400, Paul Moore wrote:
> On Wed, May 21, 2025 at 11:36 AM Jann Horn <jannh@google.com> wrote:
> > On Wed, May 21, 2025 at 5:27 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > > Jann Horn <jannh@google.com> writes:
> > >
> > > > On Wed, May 21, 2025 at 12:13 AM Eric W. Biederman
> > > > <ebiederm@xmission.com> wrote:
> > >
> > > > Looks good to me overall, thanks for figuring out the history of this
> > > > not-particularly-easy-to-understand code and figuring out the right
> > > > fix.
> > > >
> > > > Reviewed-by: Jann Horn <jannh@google.com>
> > > >
> > > >> @@ -917,7 +911,7 @@ int cap_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file)
> > > >>         /* Process setpcap binaries and capabilities for uid 0 */
> > > >>         const struct cred *old = current_cred();
> > > >>         struct cred *new = bprm->cred;
> > > >> -       bool effective = false, has_fcap = false, is_setid;
> > > >> +       bool effective = false, has_fcap = false, id_changed;
> > > >>         int ret;
> > > >>         kuid_t root_uid;
> > > >>
> > > >> @@ -941,9 +935,9 @@ int cap_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file)
> > > >>          *
> > > >>          * In addition, if NO_NEW_PRIVS, then ensure we get no new privs.
> > > >>          */
> > > >> -       is_setid = __is_setuid(new, old) || __is_setgid(new, old);
> > > >> +       id_changed = !uid_eq(new->euid, old->euid) || !in_group_p(new->egid);
> > > >
> > > > Hm, so when we change from one EGID to another EGID which was already
> > > > in our groups list, we don't treat it as a privileged exec? Which is
> > > > okay because, while an unprivileged user would not just be allowed to
> > > > change their EGID to a GID from their groups list themselves through
> > > > __sys_setregid(), they would be allowed to create a new setgid binary
> > > > owned by a group from their groups list and then execute that?
> > > >
> > > > That's fine with me, though it seems a little weird to me. setgid exec
> > > > is changing our creds and yet we're not treating it as a "real" setgid
> > > > execution because the execution is only granting privileges that
> > > > userspace could have gotten anyway.
> > >
> > > More than could have gotten.  From permission checking point of view
> > > permission that the application already had.  In general group based
> > > permission checks just check in_group_p, which looks at cred->fsgid and
> > > the group.
> > >
> > > The logic is since the effective permissions of the running executable
> > > have not changed, there is nothing to special case.
> > >
> > > Arguably a setgid exec can drop what was egid, and if people have
> > > configured their permissions to deny people access based upon a group
> > > they are in that could change the result of the permission checks.  If
> > > changing egid winds up dropping a group from the list of the process's
> > > groups, the process could also have dropped that group with setresgid.
> > > So I don't think we need to be concerned about the combination of
> > > dropping egid and brpm->unsafe.
> > >
> > > If anyone sees a hole in that logic I am happy to change the check
> > > to !gid_eq(new->egid, old->egid), but I just can't see a way changing
> > > egid/fsgid to a group the process already has is a problem.
> >
> > I'm fine with leaving your patch as-is.
> 
> Aside from a tested-by verification from Max, it looks like everyone
> is satisfied with the v2 patch, yes?
> 
> Serge, I see you've reviewed this patch, can I assume that now you
> have a capabilities tree up and running you'll take this patch?

I can take another look and consider taking it on Monday, but until
then I'm effectively afk.

-serge

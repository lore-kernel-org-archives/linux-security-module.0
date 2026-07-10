Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738673939C9
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jul 2026 21:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783720559; cv=pass; b=tGz6jPjy42DFKyUKHhAqfp9qX4GapCojp379cmyfODIiELSRexymIXETn8CGYslRuKVpNV50801/r4AMdI01jYmW4xb4cUDms+mkf4Kwte+2goeM+qIVPDKQLJJ1hdNxKlLnHT2sLMqz5RMQWRaOHfgGKrcsQNwGHJ7QicUaZLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783720559; c=relaxed/simple;
	bh=CpBTlve58c00BbzjM0b8zgecVzKqAVP6/zTAcKxUqpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TnBE6unR/Qc2C2BwBHx/Vemrh46/lfNmgypR8uRqiVNPCXaoKRHBL1pOiBlSWgNAnhVYMPsLVPmwEtXV/5fRXQPXDi9JxQlFPBGbC4rXUGBU5oC5mlMEUkNqmuho3hstEfAoEi01QAOXr/TjHdiTKKi1wg/SpTS4EPvPI8COxNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DapG6S/H; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DapG6S/H"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc6dd436c6so15380135ad.2
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jul 2026 14:55:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783720557; cv=none;
        d=google.com; s=arc-20260327;
        b=OZDvpp03gR9AjNRFwqWlE3avU0CimT0L8NSnVYvT6n8LRYhy3Wqhentq30Q/9rwV0w
         9BFg1kLDvqGWucpPZydO4g1Efyzx9y8zx7CAXoAb5xmxOeHCq5u5rf4sX/uriQVxRxz3
         BQ4Lz2Zv57cq8bImSwpilHKaOhsNsIZn0uT5v55IdIE60yo3SpVpW3WWMX4P7Ke0/YVX
         J4hRDEZEya8+7CMFX/7BxYrkYD2kHUX8le25dvuzgOg0HLO+w1LToEJjXtZ9LHaxWx4D
         L0jDlKs2nZyWc859Zu+xr7W3xjNaUKf5g/0TS5TQOLcro+zGvefiTWLZqT+5qRFppSSx
         73Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6nW9bDyOYHp4zq5N/lxHsUJ94wjBO7jwW7eDg4ejnfg=;
        fh=3pvV2StOWNk3e/tEgOBBpPdOAltezGakklWrN3DbVE8=;
        b=QPCgkADNyGkeRU5W7lpg+on1Rn4lvvs7kuJsonOrvBSpBjOLnC9u8wCFbSLvO5bjui
         /hxhwA5zVKRFRUh4cSpKA2d6HsG6kaMO7lc8ENowkOD3MkEyLtflXgjMqXaHec+elGDe
         NJ/P2C10tbW3tSVxnaShaDaZnse7RDjXXJgvZHzhhgyOCAZT8T0vY7Z+h8jbbd3otybk
         1fvRsLuNo1lJokA5Ni0VusIEhL636YdklifN38bxalTF4O5e9gUwE7R4JUWfNPGkPith
         2Mg2UEKJBB2D2m6064wYfrkYytOwfh3IDsDe8GsMeyoWGnZsi8CgmxbK7QXKSpLGpWR0
         t/IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783720557; x=1784325357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6nW9bDyOYHp4zq5N/lxHsUJ94wjBO7jwW7eDg4ejnfg=;
        b=DapG6S/HsoQjSDy2bdJEbgxhfqOQRGYa6eb+fOMxWXrIOkLm3BoP25qN6D352GxLQM
         k1zA6e6yGAK4QBwmplxJJ6sjFqZ7LiIxjsP+ei2asL4TpLjav7hsp52Dkg4nUhsS3hDr
         4sS1X4TA4uOoyvvirJpNiGOJaGgumPpTXmTof9sTYK+zBZG/LKfzshMOFBrCemRc78Vc
         LUCR3AEqxP8XqL2xwMkn1OuLMZlP0zX+DLXTG0HBSpnXvlFICLA9QDwI3vglrbDFqBIY
         o2PAdWPZ8ZeoxngIqyqkBI5G7DkLEsSpaudjtZL55IaaH23meWwfsfSfkS/+ThGg4LRS
         BNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783720557; x=1784325357;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6nW9bDyOYHp4zq5N/lxHsUJ94wjBO7jwW7eDg4ejnfg=;
        b=PR/GRYEHSVlVl7SIHqdfKMFCe+P2b34hITxyEt+b1wb1PfSZsMppWS4stsacGdN+FV
         rvnXKwKTf2Y6Drlt5sUN8hT7enO6nxKvZbN6mQwjn0FcPfbdHqNsFsexyZ6x2MgOdZcj
         v02WKQBna6dfUs3PxK3IcR/Uzq5Xq4R5ElIOmus8lh9mD6NFpOldg9VOAtWhfo152Sl7
         /uqQy3xUIGdjUAoCrYnHW0rM/IQF0FPeUIQlUikFws1pzTFRzwXWBzjnpXo6bljoXY3m
         RsCQa7DPE/hfw0eaKDeeRx6IoJd8TD8FHbae+6i1v7J9LUBKp0knpFnZb+iSRR1e5Ma0
         Scug==
X-Forwarded-Encrypted: i=1; AHgh+RqW4FL48tppte04ktOGjb6gzedxwwbrUJWYFmtYOq+WNQwevTyQ5WkBZ3AYK+Y9irD/DA5vEswhQFD8JPII+DoetnPQCLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6a7HyZdRDGnN0TqbAs2uvWJhSet48YEEwZYbKmsaNF91jRS/a
	adddKOdjJS9D5Lc1eYmqoUKy3kaPjDQ/sIdsINnhmvaq26OG/n0IsdBJWCZ37m03hhNihTFoRDI
	aM00NXNQcjGDcPKksaQngFOhzJ16M4NdoevIZpj0N
X-Gm-Gg: AfdE7cneurNzY03JOwjeNbyF9900K3bE9rn20gDT/2yp9+YcFc+FOqTCZd87oIxaLWr
	aGI35XD/AhIth/kct71EAZLptObnPq4xZA68BwPRtOLVVlAUtDDvoz1y4ZLv9p/PuWG65p42Sus
	O9U9hJEb/gpQ329XGeQF2yOeh8qTmux80ZRS68thxosvUJYATgXqHoE3opPXQYOf/sg47WItUXx
	gyOR1ca/NiqSR8H3L7MA297kfd/OceneMZOXCs66g3clLMK53PNvgcg+ie/H30iBAI1vBjfUbKb
	cfkxdjM=
X-Received: by 2002:a17:902:c946:b0:2c9:97a8:aff0 with SMTP id
 d9443c01a7336-2ce9f3d32f3mr7347585ad.41.1783720556784; Fri, 10 Jul 2026
 14:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703102759.9626-1-achillesgaikwad@gmail.com>
 <20260707152305.15324-1-achillesgaikwad@gmail.com> <CAHC9VhSWWhMjs282cOTT45gn0pa8bDSxD0H24_is7k4tXmGJxQ@mail.gmail.com>
 <ac4f209c-f465-4938-adae-ecd00ecab175@app.fastmail.com> <CAHC9VhQYjj3--K6KkDJBf6LfXqtj4TPh5LsMBpPYc0-Zz6wTMA@mail.gmail.com>
 <CAEjxPJ7dttPDxQDa_xXFd1H-QT_vkUwjtnH+=3cmG5dhSiaAXw@mail.gmail.com>
 <CAHC9VhSyCuiPBRWz_vUbx7+L5yLiXkjKX+7UyCLr82-_gAj2NQ@mail.gmail.com>
 <CAEjxPJ4+wgUDY3YxajZ=2D3WLzgat_Mqvr05VtJ4KrXW7_kuXA@mail.gmail.com> <CAHC9VhSxpAx+G35fbcMjJ1PfqJxDZYpTEu=qpO+0PQe=nkX5-g@mail.gmail.com>
In-Reply-To: <CAHC9VhSxpAx+G35fbcMjJ1PfqJxDZYpTEu=qpO+0PQe=nkX5-g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Jul 2026 17:55:45 -0400
X-Gm-Features: AVVi8CcRGJaw79Fwkeco2JWCt0FgBIV6FkEdFiwKcVM1JtfPwuXxarWAiXeQC18
Message-ID: <CAHC9VhRq+Vth-4D4OHFAY_6hXqmj=MgTc_2G=3Ehr6bAQzp26Q@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4.2: fix nfs4_listxattr size accounting
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Anna Schumaker <anna@kernel.org>, Achilles Gaikwad <achillesgaikwad@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 5:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Thu, Jul 9, 2026 at 8:33=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Jul 8, 2026 at 4:11=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Wed, Jul 8, 2026 at 2:54=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > On Tue, Jul 7, 2026 at 4:01=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> > > > >
> > > > > On Tue, Jul 7, 2026 at 3:12=E2=80=AFPM Anna Schumaker <anna@kerne=
l.org> wrote:
> > > > > > On Tue, Jul 7, 2026, at 2:48 PM, Paul Moore wrote:
> > > > > > > On Tue, Jul 7, 2026 at 11:24=E2=80=AFAM Achilles Gaikwad
> > > > > > > <achillesgaikwad@gmail.com> wrote:
> > > > > > >>
> > > > > > >> A call to listxattr() with a buffer size of 0 returns the ac=
tual
> > > > > > >> size of the buffer needed for a subsequent call. On an NFSv4=
.2
> > > > > > >> mount this triggers the following oops:
> > > > > > >>
> > > > > > >>   [  399.768687] BUG: kernel NULL pointer dereference, addre=
ss: 0000000000000000
> > > > > > >>   [  399.768705] RIP: 0010:_copy_from_pages+0x44/0xe0
> > > > > > >>   [  399.768722] Call Trace:
> > > > > > >>   [  399.768723]  nfs4_xattr_alloc_entry+0x1bf/0x1e0
> > > > > > >>   [  399.768730]  nfs4_xattr_cache_set_list+0x43/0x1f0
> > > > > > >>   [  399.768731]  nfs4_listxattr+0x21f/0x250
> > > > > > >>   [  399.768733]  vfs_listxattr+0x55/0xa0
> > > > > > >>   [  399.768736]  listxattr+0x23/0x160
> > > > > > >>   [  399.768737]  path_listxattrat+0xba/0x1e0
> > > > > > >>   [  399.768739]  do_syscall_64+0xe2/0x680
> > > > > > >>
> > > > > > >> security_inode_listsecurity() (via the xattr_list_one() help=
er) now
> > > > > > >> decrements the remaining size even when the buffer pointer i=
s NULL, so
> > > > > > >> in the size-query case, 'left' underflows to a huge size_t v=
alue. As a
> > > > > > >> result, nfs4_listxattr_nfs4_user() treats the NULL buffer as=
 a real one,
> > > > > > >> leading to a NULL pointer dereference in _copy_from_pages().
> > > > > > >>
> > > > > > >> security_inode_listsecurity() does not return the number of =
bytes
> > > > > > >> it added to the list, so the code derived it as
> > > > > > >> 'size - error - left'. That is also wrong in the size-query =
case:
> > > > > > >> the generic_listxattr() contribution is only subtracted from=
 'left'
> > > > > > >> when a buffer is present. Thus, the query result comes up sh=
ort by
> > > > > > >> exactly that contribution (e.g., "system.nfs4_acl" on a moun=
t with
> > > > > > >> ACL support), and a caller that allocates the returned size =
gets
> > > > > > >> -ERANGE on the subsequent call.
> > > > > > >>
> > > > > > >> Declare 'left' as ssize_t, use a scratch copy to measure sec=
urity
> > > > > > >> hook consumption, and only decrement 'left' if a buffer is p=
resent.
> > > > > > >>
> > > > > > >> Fixes: f71ece9712b7 ("security,fs,nfs,net: update security_i=
node_listsecurity() interface")
> > > > > > >> Suggested-by: Paul Moore <paul@paul-moore.com>
> > > > > > >> Signed-off-by: Achilles Gaikwad <achillesgaikwad@gmail.com>
> > > > > > >> ---
> > > > > > >> Changes in v2:
> > > > > > >>  - Use a scratch variable to track security label size direc=
tly,
> > > > > > >>    replacing the old formula that undercounted the size-quer=
y case.
> > > > > > >>  - Drop the now-unneeded NULL-buffer special case for
> > > > > > >>    nfs4_listxattr_nfs4_user().
> > > > > > >>  - Retitled from "fix nfs4_listxattr NULL pointer dereferenc=
e"
> > > > > > >>    (the same accounting bug caused both the oops and the und=
ercount).
> > > > > > >> v1: https://lore.kernel.org/linux-nfs/20260703102759.9626-1-=
achillesgaikwad@gmail.com/
> > > > > > >>  fs/nfs/nfs4proc.c | 10 +++++++---
> > > > > > >>  1 file changed, 7 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > [CC'd the LSM and SELinux lists for visibility]
> > > > > > >
> > > > > > > Unfortunately my testing was unsuccessful due to an NFS probl=
em that
> > > > > > > started with the v7.2 merge window that I haven't had the tim=
e to
> > > > > > > bisect yet.  Assuming the NFS folks are okay with this change=
, I
> > > > > > > figure they will want to send it up to Linus via their tree, =
if not
> > > > > > > let me know and I can send this up via the LSM tree.
> > > > > >
> > > > > > Yeah, we'll send it through the NFS tree.
> > > > >
> > > > > Thanks Anna.
> > > > >
> > > > > > I'll be curious to hear
> > > > > > what problem you're hitting, and what patch is the culprit once=
 you
> > > > > > do that bisect!
> > > > >
> > > > > Yes, me too :)
> > > > >
> > > > > I'm still working through a review backlog so it might be a bit b=
efore
> > > > > I have a chance, but in case anyone wants to test it out, it's ea=
sily
> > > > > reproduced using the selinux-testsuite and the NFS tests:
> > > > >
> > > > > https://github.com/SELinuxProject/selinux-testsuite#nfs
> > > >
> > > > They seem to pass for me with and without the patch (they don't
> > > > exercise listxattr AFAIK).
> > > > This was on the current selinux/dev branch, v7.2-rc1 based.
> > >
> > > They work for me on vanilla v7.1 and fail somewhere before vanilla
> > > v7.2-rc1 (still bisecting).
> > >
> > > I wonder if there is an interaction problem with a recent userspace
> > > update.  What distro/userspace are you running for your tests?  I'm
> > > doing my testing on a relatively recent Rawhide.
> >
> > I was on F44, so yes, it could be a difference in e.g. coreutils or
> > other userspace on rawhide that is tickling this particular bug.
>
> I haven't had a chance to look into this yet, but the git bisect just
> produced the commit below as the offending commit:
>
>    commit 01c2305795a3b6b164df48e72b12022a68fd60c1
>    Author: Jeff Layton <jlayton@kernel.org>
>    Date:   Wed Mar 25 10:40:32 2026 -0400

Ooops, nevermind, scratch that - I still have one more kernel to test.

--=20
paul-moore.com

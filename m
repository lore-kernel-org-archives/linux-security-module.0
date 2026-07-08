Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551803E317F
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jul 2026 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541475; cv=pass; b=SORK/dP8xAeXviX2jVtGoElIlvDi/fipMMy1ZNEeDw4GgEnVdDuzc/h42GI7MbPted4dOlzk0hF0UaKxmo6NMZV3BXDv63kPAgaPHCfg6sKkFeLMwKZrjYybvOKXoOdl4sTY5J9I7LWRlKCC1QFOEE8nCgAjOPk5SVh/mkFNFFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541475; c=relaxed/simple;
	bh=Fy6qHwAxMBKgI4ys2Q4APPGANBPucrsGbSz4jBFobcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X32eGSESOjQcBoAE0GD57pc+gK3W6dfb9R9iQnubRJRFKXCpb/d63M68MnXLPQ7iAxybGapR52b0nwLob8/KyeosAQvdrimsrl6DbXSBbYRTLKLH6U3J2BPX6u4opBMvxvdke+gVviCD+t50apUr3InCLFyWhPbLarL/BwZDH2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z4Uw7QTh; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z4Uw7QTh"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cace91f112so11810905ad.0
        for <linux-security-module@vger.kernel.org>; Wed, 08 Jul 2026 13:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783541468; cv=none;
        d=google.com; s=arc-20260327;
        b=d9kFrmKnzMp6w5p9EpoQvwCm0EdVIrrYIi89uVoRbb133rqipoW6ucoVjPw0pl859u
         GtgYE4yoEwnjLnGRbIoDC+3LxybnLYeMykc4HjUWmQV2RAK34bsdNTu8CFvbhHUWrGHh
         IHP004jqV2/PyX8IG8TL5Cny0H6IPu1Ml7o63iXJx++4Dy/64gqGFebf0fwCFF2JhqO1
         TOdh+B72dI7cxIGX4Kfc6fx0lljhYnY82M1sN5+xJLohXko177zRaDUDt3gDcKZFGSxw
         U4QoORccwImSknkFR2DfmDmfPY0B0eke3QP7tJ3mPxyrCQhzanFT8gmBmJ73F1MUDz9h
         VWXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SX6q4fztsZP6iSk58v5T5RdgQrRxRC3vIHoyseYXr/w=;
        fh=U3Ey44dPhUOk9SJpUuwy09WNUS2WkgZvbKcn+QqN7bI=;
        b=ex7gyJjLFAihDbzfUMed9MnVRE9cphCc3kXAdQSu7dgIfmU25/56KhG/w6WivraJAy
         bCnLNY6hQaWE6W6LQcgK5H/1BCvStYWGQgUSTSAIki7dad8dX8qMQtSpYUob2aLNNXpv
         +SE+h/HsZBW/Q1NUJbS/yQFEemmYJYBjH9RqcRKAXE18Tti12B9ikXp9xhDnzBKJ9IGC
         zDF0iGYxacI13PPUlp/xPZzD8RIXF0FFuPDmYmbKXVU7oorXMEqYjM7ANdheXxOGHyCo
         xOk2eNck1kZv2n6JN92TMtZv8WW0fDPtwSKgUMkJpAGIMc8PVdnjCoUBT5FgN5wKFLkx
         6VZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783541468; x=1784146268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SX6q4fztsZP6iSk58v5T5RdgQrRxRC3vIHoyseYXr/w=;
        b=Z4Uw7QThiTeLmGGlWNX9W5FqapTdXmaSETNDj1euK/4eD+uHj0wF+eJ7QiN+Z9Zb2n
         NklKrHPmx95uaXG2dMJzd6/wLBTcE48GXp8e8wEhjurUdaF2di8b8a1sNz636/+2ZZU5
         lXxbUSQRdvpvAqa4MDFpM2ZScMaVOwu7pDCZegINDpA60wtt2sxzY+6r1zW0EDjis3Zv
         7twndEUexWygWWqdo8PDnjz2v81gxchpJ9gE7asxoGmMxvUWwGc/Gs5zKs7+EsJG8b2E
         9rqIxygMv4BhV2W1dDC7hFH8qi1nZv0kEiaJkvHVY7iZrY902kd34zRyvjiyvRWY9nxC
         Ymyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783541468; x=1784146268;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SX6q4fztsZP6iSk58v5T5RdgQrRxRC3vIHoyseYXr/w=;
        b=qgEzSwv9x9cxFj+0qazRv9520Au4SLVemx2akgYb7pmhPU725upaJVX/GNDhOvltCn
         Ze6oT1jnwQkpKGuBHZTfo9xvQkqIXBCypJAzWObCy8AD8XMX4RSWiUhpKRW8cMmXq5sJ
         TiDuQIM4xq61KyPCsnL/l/tqB4nb38qumETibI3DIw3lUjWhrrQiWSDRMurOwR9hfGrA
         M76EdpiFD7G3i3Ze1vE/5tle/hCudomZPCz88mGAlsJZPSG+s3LSTru76YOo0TF9xXYA
         ++AZZTQWjgnDIwKWBRPYZawFQR7zaTu9n5hfcW8nM/Ey7kB+y0b/JIsqcdSk481CIwwz
         vv9g==
X-Forwarded-Encrypted: i=1; AHgh+Rpwn5pmcXWTWN+cX73em0T2F3cqepsm8SWhiNGPkT7JQpSqVhzGL9DtbcPNJGeJQSEDvmPEQtQRBmKrvSvxnuC+GYyzaf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNLiQQM/v4IDdgyDizPQRGObq7qyPRV4ONs75SVNXk78yy8SAx
	45HFacnUCKym8r1fmsv3lRMIkIi0dyLXj1G6RJcm7Wi4yebufectrOZlm5NuWkmoFgwrZPDpIov
	bDCQ4wqTtuDmleYr2aFovfkTZgFXUCh2L+RpuMk15Q/Y3f6/8uAYrhQ==
X-Gm-Gg: AfdE7clwQawarAPQCQx9fdWX16xWLLoQPp3vtn41he3PYeLOPrnut79WHiLGuYFGHfw
	Chzr7x0fkQGl7GLEoEw4TUZ6dRE+mQSsY6INQzIMOfpX9QGqs//VNdytwjhX1fSHWdRFW7zA8hM
	TSmKNT7CRTv6nR3s+cyB3LPEWZaeOcnn4RTZ2jXkXL+zCDd0qPq4n169FpjJy6hUjJK651v5mob
	UdC9bNL3WULITtpGO0AOeU/8O4lC5Kz1rCbxFefVQVf0G4FtrDj1CzTJx3W690CXqq3X6ga
X-Received: by 2002:a17:902:eccb:b0:2ca:d7a0:1318 with SMTP id
 d9443c01a7336-2ccea3ab636mr36736505ad.11.1783541467977; Wed, 08 Jul 2026
 13:11:07 -0700 (PDT)
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
In-Reply-To: <CAEjxPJ7dttPDxQDa_xXFd1H-QT_vkUwjtnH+=3cmG5dhSiaAXw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 8 Jul 2026 16:10:55 -0400
X-Gm-Features: AVVi8Cd4qoj8FowNXz9SQ-0VNk5KpjXCV9um-QDkJOYlORaYRve8VAb1A0UZ88M
Message-ID: <CAHC9VhSyCuiPBRWz_vUbx7+L5yLiXkjKX+7UyCLr82-_gAj2NQ@mail.gmail.com>
Subject: Re: [PATCH v2] NFSv4.2: fix nfs4_listxattr size accounting
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Anna Schumaker <anna@kernel.org>, Achilles Gaikwad <achillesgaikwad@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 2:54=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Jul 7, 2026 at 4:01=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > On Tue, Jul 7, 2026 at 3:12=E2=80=AFPM Anna Schumaker <anna@kernel.org>=
 wrote:
> > > On Tue, Jul 7, 2026, at 2:48 PM, Paul Moore wrote:
> > > > On Tue, Jul 7, 2026 at 11:24=E2=80=AFAM Achilles Gaikwad
> > > > <achillesgaikwad@gmail.com> wrote:
> > > >>
> > > >> A call to listxattr() with a buffer size of 0 returns the actual
> > > >> size of the buffer needed for a subsequent call. On an NFSv4.2
> > > >> mount this triggers the following oops:
> > > >>
> > > >>   [  399.768687] BUG: kernel NULL pointer dereference, address: 00=
00000000000000
> > > >>   [  399.768705] RIP: 0010:_copy_from_pages+0x44/0xe0
> > > >>   [  399.768722] Call Trace:
> > > >>   [  399.768723]  nfs4_xattr_alloc_entry+0x1bf/0x1e0
> > > >>   [  399.768730]  nfs4_xattr_cache_set_list+0x43/0x1f0
> > > >>   [  399.768731]  nfs4_listxattr+0x21f/0x250
> > > >>   [  399.768733]  vfs_listxattr+0x55/0xa0
> > > >>   [  399.768736]  listxattr+0x23/0x160
> > > >>   [  399.768737]  path_listxattrat+0xba/0x1e0
> > > >>   [  399.768739]  do_syscall_64+0xe2/0x680
> > > >>
> > > >> security_inode_listsecurity() (via the xattr_list_one() helper) no=
w
> > > >> decrements the remaining size even when the buffer pointer is NULL=
, so
> > > >> in the size-query case, 'left' underflows to a huge size_t value. =
As a
> > > >> result, nfs4_listxattr_nfs4_user() treats the NULL buffer as a rea=
l one,
> > > >> leading to a NULL pointer dereference in _copy_from_pages().
> > > >>
> > > >> security_inode_listsecurity() does not return the number of bytes
> > > >> it added to the list, so the code derived it as
> > > >> 'size - error - left'. That is also wrong in the size-query case:
> > > >> the generic_listxattr() contribution is only subtracted from 'left=
'
> > > >> when a buffer is present. Thus, the query result comes up short by
> > > >> exactly that contribution (e.g., "system.nfs4_acl" on a mount with
> > > >> ACL support), and a caller that allocates the returned size gets
> > > >> -ERANGE on the subsequent call.
> > > >>
> > > >> Declare 'left' as ssize_t, use a scratch copy to measure security
> > > >> hook consumption, and only decrement 'left' if a buffer is present=
.
> > > >>
> > > >> Fixes: f71ece9712b7 ("security,fs,nfs,net: update security_inode_l=
istsecurity() interface")
> > > >> Suggested-by: Paul Moore <paul@paul-moore.com>
> > > >> Signed-off-by: Achilles Gaikwad <achillesgaikwad@gmail.com>
> > > >> ---
> > > >> Changes in v2:
> > > >>  - Use a scratch variable to track security label size directly,
> > > >>    replacing the old formula that undercounted the size-query case=
.
> > > >>  - Drop the now-unneeded NULL-buffer special case for
> > > >>    nfs4_listxattr_nfs4_user().
> > > >>  - Retitled from "fix nfs4_listxattr NULL pointer dereference"
> > > >>    (the same accounting bug caused both the oops and the undercoun=
t).
> > > >> v1: https://lore.kernel.org/linux-nfs/20260703102759.9626-1-achill=
esgaikwad@gmail.com/
> > > >>  fs/nfs/nfs4proc.c | 10 +++++++---
> > > >>  1 file changed, 7 insertions(+), 3 deletions(-)
> > > >
> > > > [CC'd the LSM and SELinux lists for visibility]
> > > >
> > > > Unfortunately my testing was unsuccessful due to an NFS problem tha=
t
> > > > started with the v7.2 merge window that I haven't had the time to
> > > > bisect yet.  Assuming the NFS folks are okay with this change, I
> > > > figure they will want to send it up to Linus via their tree, if not
> > > > let me know and I can send this up via the LSM tree.
> > >
> > > Yeah, we'll send it through the NFS tree.
> >
> > Thanks Anna.
> >
> > > I'll be curious to hear
> > > what problem you're hitting, and what patch is the culprit once you
> > > do that bisect!
> >
> > Yes, me too :)
> >
> > I'm still working through a review backlog so it might be a bit before
> > I have a chance, but in case anyone wants to test it out, it's easily
> > reproduced using the selinux-testsuite and the NFS tests:
> >
> > https://github.com/SELinuxProject/selinux-testsuite#nfs
>
> They seem to pass for me with and without the patch (they don't
> exercise listxattr AFAIK).
> This was on the current selinux/dev branch, v7.2-rc1 based.

They work for me on vanilla v7.1 and fail somewhere before vanilla
v7.2-rc1 (still bisecting).

I wonder if there is an interaction problem with a recent userspace
update.  What distro/userspace are you running for your tests?  I'm
doing my testing on a relatively recent Rawhide.

--=20
paul-moore.com

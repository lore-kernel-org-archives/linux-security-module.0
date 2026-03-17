Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589A538E5C0
	for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773732375; cv=pass; b=oZexWyq10ezlx1q/nNywkPlsuFMfEaBNpZkFwgj/aN9O+sXbB5H1IzfBdZLsXCs3oLtbAfomIwyKj4W3BMAGue/Eyu5n8rR0Kw2VUtfY6ffX78+QdV0/15J7Lw0uAH5uQCkmHQ6PzI5UvlhTstCpYhNLs4qMBaeAvag+NsMffAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773732375; c=relaxed/simple;
	bh=f8UETNxqUQnzPIAZtG43HfP4bjrDwk0GJJOmlIbeQc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeaSPdVNbqxyezzS+eFTHd1xZxyY//w8vkc+W3tDwbOr2uGbnYjNM3JbVVZl++EL4rXEno4phTaehxRy6rrDqgSfpnMQO+kxCh2d2R8ofz6DyajZCZZwYsAPDsvqmA3DeURs/Tv39oZ/ovGh9nICMBrKEtgHcsxV2805PyNmmIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGjkNiln; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGjkNiln"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b93698bb57aso77314666b.0
        for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 00:26:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773732372; cv=none;
        d=google.com; s=arc-20240605;
        b=Kd/OTrDxwmI3yyhcvGwmJ1ruDRmW/nSk1c3DUHH7XunEc6o4hTySgk6nJWkwLduGvE
         SOgwmf9chjTbWoPq3OkQmWPlpPOB5MLeRbCx5ADrJ9kzRHaY7QFcN9aqs6DezP/lS/+h
         Ro/O24YFp7lE5iIh04Ds1UZ4PLb+QHz24D5FPOf0FlH6+d/uiUEqTBcqmTHoG4uab2jE
         4UDOdgRiUwy2WwlIlgYjl3Kv0+/QRLrK7DRcICfxomf1gxijJ8s8Hs5GidqJEUPMPv87
         BPKgoNct2Kw1KqX0IYoQwqG09/3adz1gSK1o1aTjfAyWrhi37MpYmSkJ2Y3h109qc0wm
         vDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i3xav1WzJK9rzK57tlDdYAfYY5vgZYqApatQD+1lTTc=;
        fh=1FLv0Jz16nFfn8NMF1W/4LOwo1OEaSqkx8dBTTb5sDo=;
        b=ceVy7VXkJPPtO3s9OuuAspUkorvzylR3S757DyoUeZBeRAqkfDQDOe7UAA0MYq6F9u
         eP8oMcVC+cY1V2jD01CybOH+IIBpIc7o15MmMf3GxbhZbKHWmF7ZQijVvMic3bFWkPrj
         dc1ckrg/OTfAEHXrBtp2B1AldRe70t7RmOk/S37N3D7YqUZU/kXNTUG0HgVnC1Q+Ne1Y
         7UzQ1A1E946776mLdOMYK8Knsz/cdeNDzGj8bG0f8goiUhibve/9mwAA0wrKlKFxwYVQ
         jtuKnTgLOAOos0fIGgm6yfBt9ngH81xrbFFiOlieFqiE137STqeKRgtKMFknGbYwPCu5
         lACg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773732372; x=1774337172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3xav1WzJK9rzK57tlDdYAfYY5vgZYqApatQD+1lTTc=;
        b=TGjkNilnWLGvnVVETbbI+TTJD6At4Tcc0N2XhWRm162KPV0KehCLfltBPpboGCf1hF
         SDTakddI2G70h2P4hVJeZK01D3T3VYvWyHqk2fUlvp76PMKf0DNpM6022lpEQ/cTWBYe
         UkR6rhiIEOXqAGK6105CDMUD8J+H+4LspFV0iFVLaDyEV8UTMej0KWYOzvHw+VGp5WDK
         ne3ViYov1uuldf3cOs6mfG/h/gWnbmJwe+f+MgpCbjX/RSzxPFUhIS+aNSnTOmlFbcSB
         du9b2n/b3n8NyZG3TrPWmna6zi2Brh1voYaRbHegojj2qDyV/5fOS59gXorYFiSy8cbJ
         26kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773732372; x=1774337172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i3xav1WzJK9rzK57tlDdYAfYY5vgZYqApatQD+1lTTc=;
        b=BIsWH9fEgb5dML00okhtPBofHunPrntsA3MkJ3CgYu9lrdETXiXOKFgm7coorAfXgW
         FF1z6ujc7S14XXURF0vjDlH7VAtCBlGPfb7qCai/XbZGCa/DKAGZ7OFDQJMDxyG0LwWi
         Nyx+1peLEdIKQ5zeMLhjfF9aKqgisRinRvHMN5a+47WbPoLbxyiVCyiQXp8k1XlVJmtY
         MXUcBXMpz6mLQnt5RdoDiAlmEspcmIR6b8KyVmgxTLTRceg6+GzKiYE3gqhSA6x2AQLJ
         uvX7LHfZcvsHA72QzJw0qfeK4GHFFuzVY4EDxX6hH+5LLuFEAV9XRBlyB7dlz65mxx6T
         +dmA==
X-Gm-Message-State: AOJu0YyTuSEBZRik7AztPJpE80sMvsTKj+VoYrA5+hlAYyOVlb9S0rVp
	rd7EMrxC5A7A6QLxL/lTSv/xKpiNQIQ3gJR9uczcfCyfdAQU2JRWKxh56JFC6ZS2ciPQ7eNPvlO
	RqE2RmN6WW6+g0ududkR25EJnayXJPGk=
X-Gm-Gg: ATEYQzwAt548OVTHMxl/jYiq8zOHRwduJkau69EUbWbUaaSDCbccET1xyTrxm3ywfVB
	01INKQmQfbQIDVgx51Cs8U42+6KF+zHRXZM8PSComQUKEdbdtKwF14fteck7fnS8R2pQ+H9xrcQ
	hk1ANsUjyRwsgf0HvCcSBDFbxCTGcin9tFG4vLN5xZR3uDfn57a2gTsWcb5O75/qKF2tV9/f5An
	4j1jK93psiYkEX0+UMoaCl+l6yzKcl/w0LyAGPw060ORm1Y27zHR+iaPIe0ES3MYt3EjQZIsaqx
	APiMAC9y1/ikasO0YaRRGnpKtVG6h7PCwU9iEl1T
X-Received: by 2002:a17:907:3d03:b0:b94:231f:26ca with SMTP id
 a640c23a62f3a-b97d6d99d0fmr133734066b.20.1773732371166; Tue, 17 Mar 2026
 00:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316213606.374109-5-paul@paul-moore.com> <CAHC9VhTEX-sRjyVi2p9j_jFjyWbzy54b=iteiTKGq-mnBaHkrg@mail.gmail.com>
In-Reply-To: <CAHC9VhTEX-sRjyVi2p9j_jFjyWbzy54b=iteiTKGq-mnBaHkrg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 17 Mar 2026 08:25:58 +0100
X-Gm-Features: AaiRm50sF1v33VMxCQO8F4CAvv3PlKmjLZTCcf_1PYwrrTaEu5VQoATkjlrFBkw
Message-ID: <CAOQ4uxi7+6Qt5K9s6Fq8deN-ep2gnxqJ6-wJy9pXJzszpfn-6A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix incorrect overlayfs mmap() and mprotect() LSM
 access controls
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 10:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Mon, Mar 16, 2026 at 5:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > The existing mmap() and mprotect() LSM access control points for the
> > overlayfs filesystem are incomplete in that they do not cover both the
> > user and backing files.  This patchset corrects this through the additi=
on
> > of a new backing file specific LSM hook, security_mmap_backing_file(),
> > a new user path file associated with a backing file that can be used by
> > LSMs in the security_file_mprotect() code path, and the associated
> > SELinux code changes.
> >
> > The security_mmap_backing_file() hook is intended to allow LSMs to appl=
y
> > access controls on mmap() operations accessing a backing file, similar =
to
> > the security_mmap_file() for user files.  Due to the details around the
> > accesses and the desire to distinguish between the two types of accesse=
s,
> > a new LSM hook was needed.  More information on this new hook can be
> > found in the associated patch.
> >
> > The new user path file replaces the existing user path stored in the
> > backing file.  This change was necessary to support LSM based access
> > controls in the mprotect() code path where only one file is accessible
> > via the vma->vm_file field.  Unfortunately, storing a reference to the
> > user file inside the backing file does not work due to the cyclic
> > ref counting so a stand-in was necessary, the new user O_PATH file.
> > This new O_PATH file is intended to be representative of the original
> > user file and can be used by LSMs to make access control decisions base=
d
> > on both the backing and user files.
> >
> > The SELinux changes in this patchset involve making use of the new
> > security_mmap_backing_file() hook and updating the existing mprotect()
> > access controls to take into account both the backing and user files.
> > These changes preserve the existing SELinux approach of allowing access
> > on overlayfs files if the current task has the necessary rights to the
> > user file and the mounting process has the necessary rights to the
> > underlying backing file.
> >
> > --
> > Amir Goldstein (1):
> >       backing_file: store user_path_file
> >
> > Paul Moore (2):
> >       lsm: add the security_mmap_backing_file() hook
> >       selinux: fix overlayfs mmap() and mprotect() access checks
> >
> >  fs/backing-file.c             |   28 +++++---
> >  fs/erofs/ishare.c             |   12 ++-
> >  fs/file_table.c               |   53 +++++++++++++---
> >  fs/fuse/passthrough.c         |    3
> >  fs/internal.h                 |    5 -
> >  fs/overlayfs/dir.c            |    3
> >  fs/overlayfs/file.c           |    1
> >  include/linux/backing-file.h  |   29 ++++++++-
> >  include/linux/file_ref.h      |   10 ---
> >  include/linux/lsm_audit.h     |    2
> >  include/linux/lsm_hook_defs.h |    2
> >  include/linux/security.h      |   10 +++
> >  security/security.c           |   25 +++++++
> >  security/selinux/hooks.c      |  108 ++++++++++++++++++++++++++++-----=
-
> >  14 files changed, 231 insertions(+), 60 deletions(-)
>
> Due to the nature of the issue, I'm going to merge this into
> lsm/stable-7.0 in a few moments so the changes can get some testing in
> linux-next with the idea of sending this up to Linus' later in the
> week.  If anyone has any concerns over this patchset, please let me
> know as soon as possible.
>

Since previous 4 revisions were not posted to public list,
let me repeat my concern from v4:

On Fri, Mar 6, 2026 at 5:24=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, Mar 6, 2026 at 3:24=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
...
> > My expectation is that the merge of this patch will be collaborated
> > with Christian ...
>
> Of course, that is one reason he is on the To/CC line.  More on this
> in my reply to your 0/4 comments.
>

I am sorry Paul. This must be a misunderstanding.

My expectation for collaborating the merge of my patch with
Christian was that an agreement would be reached regarding
which way it would be routed to Linus.

CC to Christian and sending the patch to Linus without getting any
ACK from Christian was not the way I expected this to go.

> > and that it will NOT be auto selected or rushed into stable.
>
> I haven't marked it with a 'Fixes:' tag or a stable Cc which in my
> experience are the two quickest ways to get pulled into a stable tree.
> I'm not sure what stable policy Al or Christian have for the VFS tree,
> but LSM and SELinux commits are not pulled into the stable trees
> unless explicitly marked with a stable Cc or requested by a dev after
> the fact.
>
> > I don't mind if you want to route the security_mmap_backing_file() hook=
s to
> > stable to use it for some simpler bandaid for stable, but rushing this
> > one to stable is not a good idea IMO.
>
> Once again, see my (upcoming) reply to your 0/4 comments.
>

TBH, I don't understand the logic of placing patches in lsm/stable-7.0
without the intent of backporting them to stable.

I perceive my patch as a risky patch for overlayfs and the vfs
this is why I wanted Christian do be part of the decision if and when
my patch is sent to Linus.

Thanks,
Amir.

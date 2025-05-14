Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEDB22318
	for <linux-security-module@vger.kernel.org>; Wed, 14 May 2025 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747256240; cv=none; b=kEVzQbN2D20ZA4/TUHBZ3z7x5Xz1fg6AZkg/HUkhpsTyLJN9na4GUliOOiPFSi13d7W7Bq1hTbcxAIEybTyAYGIq2Xj6m51PI/9o8dUxLS+sgQQXmYTGdqthOUFPf3SZM0wbiSo1kxXy35P2nzUG+9c4rEV3ZuE8xdEaN5x+YOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747256240; c=relaxed/simple;
	bh=hvvQ2pUYnZJR61LFz/51B8Xyw9gpi8oWmkmoASpxPMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WIKlqiacGGYbOty1yFbei9LcSbXKtvExUKi19RVemPT2cjVpkn5VvEhKQDoXJt47s/auOZ6PIh0zXrtK7yfGGbXexFrJhRCJV2MvQpuVfUGCNx1Jvwr9IlMIpxHAI9drGD/QBX2l4N16IacI5eN+QQkbo68kgNc1LeG0lxRQ39E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XcamvQgF; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XcamvQgF"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e733cd55f9eso276041276.1
        for <linux-security-module@vger.kernel.org>; Wed, 14 May 2025 13:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747256238; x=1747861038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlqmH4WT69hzfobPlD8etu8qibl5LWMx50hF3RsDw34=;
        b=XcamvQgFZuGH/wDntCfuVEzv9FG/Cs8FGp+bq+M/uf3XGE6buiBOtSWFO3NXvyF1jL
         kOKpCmGeiEwftY1jt0pjcNW0cgfM11U+bzm3kHBqpyt03/D7cUG0MFvEXKRiT3TAHRvk
         bxnOxhkgNEMfinBMSNMIuUiRZwbsuxo3c1Tbiwr94sjczvWeWjnGr0ggV1Px/PtV4WAT
         2v0il3Tq+H7CGh0RJLWiQqPHLwEUl4XN4LCPp3QzXp+yUob+ic8x1iubmfTUZzxufrgU
         boRB7/E6zgGqcETPp1oxC9Rwga0uZfuiBboU646r7TRxh/tRjyZnZdq5bJgoO4vVX5Di
         cM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747256238; x=1747861038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlqmH4WT69hzfobPlD8etu8qibl5LWMx50hF3RsDw34=;
        b=Wa+E3KQJC8mmikP+341crfhjWRBWEKcWaUSnhjFN6apVerkhIoT+N9FZ5bg26THhjq
         c/oOBErwq5lhjk+8VYOkvQZiz7W1xQ19HuX7vd6odFZKdHGRyJNzpmSQVnycUTIzX6Fq
         bAvZXb7Txz3ILJ+MBU+kWcM/ov6OLdLKmq14kIbhe1YSQrQ0Ap6gZTBmhLSVGMmniYwZ
         jOOMwBkOxK3kAVDG0+IrV2eESIzRoxl7UGSSOKmNpmjffI40WCIcv5yKtPKWOyYqveo9
         Y6O4eSn3J7yYFHvrvkzIv+8nsvdV1cC0XcKbsqaowWC0tg44ZAv0cc7KEC7pcY28gIFM
         OdEw==
X-Gm-Message-State: AOJu0YzgNL1EEgJ4p7Tt90vdf4q7+/JdFat3APGmu4lNwIaNzF0nqaGC
	g+SxB8MzBZB59kgMmb8nHARNsS9ouQv9cxC/95w2kepGZhK3bwvU0Auq1rXduGAD411hmlAwd83
	iSkwwHoUgBGDXH6zSPb59rCsJvm6opSRXj20RqZv3RerOazM=
X-Gm-Gg: ASbGncvxD4Z7kuOw7yrSROsLXsPYuEiPqumd2sL6EfbiPkI/zxBBLZ54hq8Ca6EwjPt
	hCtEM4/UBNncjynP3SplXH1qNuNXy5YOeu4oczJzsL7CRoD/weivBn3ZY51bdiraQMVCoWDslSg
	mBdts9CAlwNadt53g6XK2dVg6uCOgMvwllxJuqBsW0gp8=
X-Google-Smtp-Source: AGHT+IEl50Xu/vI+QbWzypfULTtnm70M/ccebQQobN7gDukIhD1K+vOzlCjYteIGVbw+npGcz0d50Mf5SbPrco5Va6c=
X-Received: by 2002:a05:6902:2e0f:b0:e79:1281:c4e7 with SMTP id
 3f1490d57ef6-e7b3d613ac2mr5927962276.48.1747256237829; Wed, 14 May 2025
 13:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-60-paul@paul-moore.com>
 <81106a29-90ce-4439-9b4c-60bb2962fe04@schaufler-ca.com> <CAHC9VhRUr+sXhLzDSjiG9bEVbzZd2u632dLMVpcCe6By_d_H4w@mail.gmail.com>
 <3d884912-6225-485b-a7dd-2aa4073265f2@schaufler-ca.com>
In-Reply-To: <3d884912-6225-485b-a7dd-2aa4073265f2@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 14 May 2025 16:57:06 -0400
X-Gm-Features: AX0GCFteL-GzhrL1nK-8Taj6ebOVTPAFysXn6CklaGbrkDpk3gpjTNx_RqmsztA
Message-ID: <CAHC9VhR5OFDvJNJLy9jKMsB4ZVx=phm6k6iebT6VuXD96kNEEA@mail.gmail.com>
Subject: Re: [RFC PATCH 29/29] lsm: add support for counting lsm_prop support
 among LSMs
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 3:30=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 5/13/2025 1:23 PM, Paul Moore wrote:
> > On Tue, May 13, 2025 at 12:39=E2=80=AFPM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> >> On 4/9/2025 11:50 AM, Paul Moore wrote:
> >>> Add two new variables, lsm_count_prop_subj and lsm_count_prop_obj, to
> >>> count the number of lsm_prop entries for subjects and objects across =
all
> >>> of the enabled LSMs.  Future patches will use this to continue the
> >>> conversion towards the lsm_prop struct.
> >>>
> >>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >>> ---
> >>>  include/linux/lsm_hooks.h         | 6 ++++++
> >>>  security/apparmor/lsm.c           | 1 +
> >>>  security/bpf/hooks.c              | 1 +
> >>>  security/commoncap.c              | 1 +
> >>>  security/integrity/evm/evm_main.c | 1 +
> >>>  security/integrity/ima/ima_main.c | 1 +
> >>>  security/ipe/ipe.c                | 1 +
> >>>  security/landlock/setup.c         | 1 +
> >>>  security/loadpin/loadpin.c        | 1 +
> >>>  security/lockdown/lockdown.c      | 1 +
> >>>  security/lsm.h                    | 4 ++++
> >>>  security/lsm_init.c               | 6 ++++++
> >>>  security/safesetid/lsm.c          | 1 +
> >>>  security/security.c               | 3 +++
> >>>  security/selinux/hooks.c          | 1 +
> >>>  security/smack/smack_lsm.c        | 1 +
> >>>  security/tomoyo/tomoyo.c          | 1 +
> >>>  security/yama/yama_lsm.c          | 1 +
> >>>  18 files changed, 33 insertions(+)
> > ..
> >
> >>> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> >>> index 40efde233f3a..c72df6ff69f7 100644
> >>> --- a/security/bpf/hooks.c
> >>> +++ b/security/bpf/hooks.c
> >>> @@ -18,6 +18,7 @@ static struct security_hook_list bpf_lsm_hooks[] __=
ro_after_init =3D {
> >>>  static const struct lsm_id bpf_lsmid =3D {
> >>>       .name =3D "bpf",
> >>>       .id =3D LSM_ID_BPF,
> >>> +     .flags =3D LSM_ID_FLG_PROP_SUBJ | LSM_ID_FLG_PROP_OBJ,
> >> There's a problem here. BPF can have properties, but usually does not.
> >> Unless there's a bpf program loaded that provides them it is incorrect
> >> to use these flags. You can't know that at initialization.
> >>
> >> I have an alternative that will address this that I will propose
> >> shortly.
> > Okay, thanks.
>
> In my coming audit patch I changed where the counts of properties are
> maintained from the LSM infrastructure to the audit subsystem, where they=
 are
> actually used. Instead of the LSM init code counting the property users, =
the
> individual LSM init functions call an audit function that keeps track. BP=
F
> could call that audit function if it loads a program that uses contexts. =
That
> could happen after init, and the audit system would handle it properly.
> Unloading the bpf program would be problematic. I honestly don't know whe=
ther
> that's permitted.

BPF programs can definitely go away, so that is something that would
need to be accounted for in any solution.  My understanding is that
once all references to a BPF program are gone, the BPF program is
unloaded from the kernel.

Perhaps the answer is that whenever the BPF LSM is enabled at boot,
the audit subsystem always queries for subj/obj labels from the BPF
LSM and instead of using the normal audit placeholder for missing
values, "?", we simply don't log the BPF subj/obj fields.  I dislike
the special case nature of the solution, but the reality is that the
BPF is a bit "special" and we are going to need to have some special
code to deal with it.

Of course I'm open to other ideas too ...

--=20
paul-moore.com

Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581901FA3
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jul 2024 23:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720566110; cv=none; b=fyGIz7md+E+v0FsoYTm+t2ZlPXEmV40LasAhdLOYXtwbE1phepTW7R3QgRPP+V6gY+NSZaSDKp2iJbv7Mx5GSebm8MMyGYN9uCHURmo83P+Z+q4hRu67m1+OHKqG64mngJxtTvjplNp18DfK+giGuCqGHu4h3mqqP4c89jSVyYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720566110; c=relaxed/simple;
	bh=xfsahkz+68CQgK8qYkqnSfOfNg9r6cmfW6xWM4zN5bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWHtXZMMs0TN6ttimFLen3VCKghdE/1PnyBnRhLBIPzP24zsFztueE79AudHPSc4s7sSJSgrlXdpBurwsdR2O6ejIfkRxUaeT5p17FKX68hDMMKloLaYja6BM/fUFRa2IVmsvafZ965MZ8a5oq1WkknOtmjTJCyy5F77mleLFvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JIll4rUF; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JIll4rUF"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e035ecb35ffso5360124276.2
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jul 2024 16:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720566107; x=1721170907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNM7KbLkybStXXi58BozkXh8gNhEx5kXhOpAAFtbnSU=;
        b=JIll4rUFisOaNBbYjxG4fmS/6myBzp1IP7dwuhv0zxj8vldsblxWfAzSLFXVpGr6yB
         A8s3p0jw75eM8fhQ9NCp+Cn5dl0tkc+6RyrB5NURbSzhVDXuuh3Ax2By7D13bMVeyQgy
         6Jh42I0C/enZm7k9UOf2wXj9waykg5zpwiIDhSn+ScSqGlP/WStuO4a+PMeWXMQgCbD3
         O3EltgUspMKyvWVEVnCuhCE+mDUvhlarSqKIrhp4JXURXTUbHvvbREJAYODHD/oVDjaJ
         1yhTZ174RE5Pu/pAnPGPBKM9UW1tZwUhsITHiD+dBqcdLwhpqFiKUxz65gjKmWmhTr5d
         v5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720566107; x=1721170907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNM7KbLkybStXXi58BozkXh8gNhEx5kXhOpAAFtbnSU=;
        b=V0t18r4t4oUiixAOps3Unu88rzQ0EuqTkaUr5WFEO61lAIggyWjpZVXEXahLKvzC/c
         nBX6KLRatRJEHhMm+y5ymh9xhBk5PiukwI1QF+Hvte4/J2q/uhsJgUGYhkQg//wJoQNl
         kjO5IAFH7Oa1lQIr4xx+uQKJ3/vwd/RB0yh+e0e3Naq1ZPap6fJ5RsfEeDwdrSOvaoHe
         mYOfhw13OBM0QuQ3yrnXpJjFKnSIZ/6s8sZYC4xAAL9pPN1IkgIx1db0ibVMmbrV66cF
         xu+rpeCSih1tKsRgjKglQ3dQrjM6ZBQ+NZDGI+7SPHkqUDkfz29x+rh2IzWyIPEXUbWO
         Qaeg==
X-Forwarded-Encrypted: i=1; AJvYcCWLiBmq79OrVwpj+2lNyu4fvmg8FwSKOvseS0nAdQ0tGkfmRC+vX9qfJMfScRV5YElUiOPhjOWMt+9gShfdf3mYlhiPKixwoTi6qVJT5UhjkiyiJln+
X-Gm-Message-State: AOJu0YwnXo+NrZaNXV2fvEYvLdvoOi8gVQcsWdGpkNGBQ8/zBMWhiyfr
	NvzZEHmWuk6r9pUn88IoP/7U9qVt9SlDviD/ug68C3Wi/sGk4hQNcgghPsrnIojxPO6+sZGj43i
	2wSax5FuXsFwvYmR7k0Rps2RRAo5I3Vn1Sbm6
X-Google-Smtp-Source: AGHT+IFXSISWCSSOeJKHGfBh6LCNyJ6VMfue7UGX1mzY7LEvRauajMzN0Ye8nkcsNUGt58xO8xa5cs3M775ZiD0hg0Q=
X-Received: by 2002:a25:ab32:0:b0:dfb:441:e03a with SMTP id
 3f1490d57ef6-e041b07d5e0mr5220489276.34.1720566105789; Tue, 09 Jul 2024
 16:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708213957.20519-3-casey@schaufler-ca.com>
 <8088e9a23a22fef35159b86760a9ab8e@paul-moore.com> <af2cfc52-e91a-4d1e-bb74-43322d1cea20@canonical.com>
In-Reply-To: <af2cfc52-e91a-4d1e-bb74-43322d1cea20@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 Jul 2024 19:01:34 -0400
Message-ID: <CAHC9VhQWddz7wtj=XSkCk91wnAST7cyjeP9GzMoZOLYkqBdGMg@mail.gmail.com>
Subject: Re: [PATCH 2/6] LSM: Infrastructure management of the key security blob
To: John Johansen <john.johansen@canonical.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 6:47=E2=80=AFPM John Johansen
<john.johansen@canonical.com> wrote:
> On 7/9/24 15:08, Paul Moore wrote:
> > On Jul  8, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>
> >> Move management of the key->security blob out of the
> >> individual security modules and into the security
> >> infrastructure. Instead of allocating the blobs from within
> >> the modules the modules tell the infrastructure how much
> >> space is required, and the space is allocated there.
> >
> > Perhaps mention that the key_free hook is being removed as it is not
> > currently needed after this change?
> >
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>   include/linux/lsm_hooks.h         |  1 +
> >>   security/security.c               | 41 +++++++++++++++++++++++++++++=
--
> >>   security/selinux/hooks.c          | 23 +++++------------
> >>   security/selinux/include/objsec.h |  7 ++++++
> >>   security/smack/smack.h            |  7 ++++++
> >>   security/smack/smack_lsm.c        | 33 +++++++++++--------------
> >>   6 files changed, 75 insertions(+), 37 deletions(-)

...

> >> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >> index 19346e1817ff..b3de2e941ef7 100644
> >> --- a/security/selinux/hooks.c
> >> +++ b/security/selinux/hooks.c
> >> @@ -6981,6 +6968,9 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_af=
ter_init =3D {
> >>      .lbs_file =3D sizeof(struct file_security_struct),
> >>      .lbs_inode =3D sizeof(struct inode_security_struct),
> >>      .lbs_ipc =3D sizeof(struct ipc_security_struct),
> >> +#ifdef CONFIG_KEYS
> >> +    .lbs_key =3D sizeof(struct key_security_struct),
> >> +#endif /* CONFIG_KEYS */
> >
> > We can probably get rid of the Kconfig conditional.  I understand the
> > desire to keep this to only what is needed, but since this only really
> > has an impact on boot, and the impact is some basic math, I'd rather
> > not run the risk of rot due to conditional compilation.
>
> sure, the counter argument is why isn't this conditional when other parts
> for keys is. That inconsistency introduces it own issues that can cause
> problems down the road. I really don't have an opinion on which way
> is better, just playing devils advocate.

That's fair, since it's Casey's patch I guess he can be the tie break.
While I generally prefer to limit conditional code blocks, I'm not
overly concerned about this one.

> >>      .lbs_msg_msg =3D sizeof(struct msg_security_struct),
> >>      .lbs_sock =3D sizeof(struct sk_security_struct),
> >>      .lbs_superblock =3D sizeof(struct superblock_security_struct),
> >
> > ...
> >
> >> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> >> index a931b44bc959..17bcc9cbf584 100644
> >> --- a/security/smack/smack_lsm.c
> >> +++ b/security/smack/smack_lsm.c
> >> @@ -5010,6 +5005,9 @@ struct lsm_blob_sizes smack_blob_sizes __ro_afte=
r_init =3D {
> >>      .lbs_file =3D sizeof(struct smack_known *),
> >>      .lbs_inode =3D sizeof(struct inode_smack),
> >>      .lbs_ipc =3D sizeof(struct smack_known *),
> >> +#ifdef CONFIG_KEYS
> >> +    .lbs_key =3D sizeof(struct smack_known *),
> >> +#endif /* CONFIG_KEYS */
> >
> > See above, but ultimately this is Smack code so it's your call.
>
> I think we should be consistent, either it goes everywhere or it stays
> everywhere. It is going to be confusing for other people coming in and
> looking at the code as to why one is conditional and one isn't.

I agree with everything you've said, but I personally don't want to be
in the business of demanding things from the individual LSMs so long
as they aren't hurting anything else.  Hopefully Casey will go for
consistency ;)

--=20
paul-moore.com

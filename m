Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009CF1C2335
	for <linux-security-module@vger.kernel.org>; Tue, 29 Jul 2025 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801754; cv=none; b=WnWK063aUZk1VKzQ2KUlLrbOe2HR3R4PCZuzZL9SIS+S7/9e/xmqa29nKM50hAfPupHBTd/z4E3RBZk5kgaBM/0PoG17bzjDQy+HJEt7zlm6O861Pbdc80VXyTE0lxfofdYHbPfGV6oMQ5y+XtXrscl3qLULSSKd+DQ9r72m/9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801754; c=relaxed/simple;
	bh=zuJNRAPFeyA6IJVZOGMjCV+D6yJpmh+V51glzUJ4TKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FU4VIBjF7fyvpEtF2Vg+nXmi/7dWXjxyJtMDgqV3Cer0lre0Jko6i7XxN3231aP+Fdfw3/DSRWZo5G0iZFhe3TGJzQIZmx0BKyL62JFQExPOMdb15ODwEk5lrdJFFnZSfACRQEKGUeIuB80gg3vL2UzEiMCFiHt643FvPXA0p3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Cs6YWwfl; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Cs6YWwfl"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e8e226c3255so1325737276.3
        for <linux-security-module@vger.kernel.org>; Tue, 29 Jul 2025 08:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753801752; x=1754406552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLQbmTKfAtMP+r8dxThnkiPOrsvJMHhb7grP3nOtq1c=;
        b=Cs6YWwflM0omrSYakT5gVNVt+FE85wPapuTN5N+IgXU+Hg9x2/nGj0VV7oSNBljndV
         k7lPvhz5Zr0XI/XWgdBXvfvyod2un0VcGMTSK707WNSeWr63bu6Y3u4V1AbaoRAdgFkO
         W4nal22sZafQPaoSehFU5S6qJwdFPE+ZtK/p3mGa7m8SvVD6kX97FFa0mHzi0mSF5Rnx
         vMbccCZIPVRDi6Ls9GhdKL+IgYlj2n9AyR8JCMR9QjrW1DYrVETXw5gbMBwht2BuLLYz
         IoO0fRy6jQc3hIkfLyCZveprKZzq96ZHOp9v5ZNfwwyZHLyu9H17ix12pWC18lIpbsnb
         byeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753801752; x=1754406552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLQbmTKfAtMP+r8dxThnkiPOrsvJMHhb7grP3nOtq1c=;
        b=T3L0lfkwocXwSC2xu38VrK4rdrS3SQ9+sjZ22TFJrhP+Bm1fYjNuJ+O5I/Mq3J+Q/s
         RrfSZ2Wt2sccyYqyxszuo9RMCjW9xTYDi2c0sC4+kF14y0eYGjimBtDyaeJDOuNiTJ6r
         eOHQm9nVFHhhj43oIhpPFceY896D/KRcK07rjNsnFjGAb2jUJiiXu7Pe0a2e3j4I6Q0F
         IFAuPHgX0qhdEEnsAHqE3PCWzR0qkSTzelMm1lUYyeBe0COHIvrjU07WUcjWY+I7uO6H
         GmmtRWNwNd9OQ+HRCysKtm9MBFnszUvlScdEd5eY90xyuBaJlNhhEjSGogVb1kogfLJe
         n4XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwvvz1rfBd21nP9ZYnpYfE9v50WdHrSvSUN02YoD4G/UqCwk4EK58AVU53zD9WjkgO6Xrpq7SywpFJnEO3S5s1nd7ALBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3wjwTWFRsxM5RJZqvn5audvr78phYgWam4F4A4oECb18HQgIm
	PoewPi8uKn7kJPvDtCDSldX7I9RF2PpGM76AegsDtZ/SdmYVeahjZIV01hlIacLlWl7nxwDwcjp
	s8niV57w/JlIlS7tc8cshfwJfpqeftJ3UroIOQQsM
X-Gm-Gg: ASbGncsF7hID/jXUTmmG2z5W8wCxWZaU5gCWEioHSX3XjUjHpk1uf/aoKA9CeaNGJfg
	WE/JOJjnvgB7d0iUaHHk33s73K8TXfUr25wxRLX6dFqfL3y9AqtOiB991KZWdqQ9d51LraOEpbO
	Hk0+UjrNyHw+NsQk0tvGaQFa0SzFOyQ4JF70FIxp11L9N1cKvPpvl4S0BIvGonMwlXKbFy1ihN5
	r3Mi/Q=
X-Google-Smtp-Source: AGHT+IFxmfEJzdGddKG4BQPd2LIH0BpZp63Qdw1g0WUVb/kFvWaAZRnwZXLkZa6UnWULDrqC8BI1dP/sBW7JbavWfC0=
X-Received: by 2002:a05:6902:4793:b0:e8e:187:c241 with SMTP id
 3f1490d57ef6-e8e314a0160mr74298276.17.1753801751812; Tue, 29 Jul 2025
 08:09:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729090933.94942-1-tianjia.zhang@linux.alibaba.com> <e81ba8e7-8938-4b76-ae7b-bfee6021aeac@schaufler-ca.com>
In-Reply-To: <e81ba8e7-8938-4b76-ae7b-bfee6021aeac@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 Jul 2025 11:09:00 -0400
X-Gm-Features: Ac12FXwNBhPktJtJ0PzDLqsmh5A5sTlKa0vey67atCJTRczlsnGdTNEDK66IhgA
Message-ID: <CAHC9VhQAVvvXUoFu7xnh0uBhmvgYinP=AhiC4y17JJ02M9s5Nw@mail.gmail.com>
Subject: Re: [PATCH] lsm: simplify security_inode_copy_up_xattr()
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 10:43=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 7/29/2025 2:09 AM, Tianjia Zhang wrote:
> > The implementation of function security_inode_copy_up_xattr can be
> > simplified to directly call call_int_hook().
> >
> > Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > ---
> >  security/security.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/security/security.c b/security/security.c
> > index 596d41818577..a5c2e5a8009f 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -2774,13 +2774,7 @@ EXPORT_SYMBOL(security_inode_copy_up);
> >   */
> >  int security_inode_copy_up_xattr(struct dentry *src, const char *name)
> >  {
> > -     int rc;
> > -
> > -     rc =3D call_int_hook(inode_copy_up_xattr, src, name);
> > -     if (rc !=3D LSM_RET_DEFAULT(inode_copy_up_xattr))
> > -             return rc;
> > -
> > -     return LSM_RET_DEFAULT(inode_copy_up_xattr);
> > +     return call_int_hook(inode_copy_up_xattr, src, name);
>
> Both the existing code and the proposed change are incorrect.
> If two LSMs supply the hook, and the first does not recognize
> the attribute, the second, which might recognize the attribute,
> will not be called. As SELinux and EVM both supply this hook
> there may be a real problem here.

It appears that Smack also supplies a inode_copy_up_xattr() callback
via smack_inode_copy_up_xattr().

Someone should double check this logic, but looking at it very
quickly, it would appear that LSM framework should run the individual
LSM callbacks in order so long as they return -EOPNOTSUPP, if they do
not return -EOPNOTSUPP, the return value should be returned to the
caller without executing any further callbacks.  As a default return
value, or if all of the LSM callbacks succeed with -EOPNOTSUPP, the
hook should return -EOPNOTSUPP.

Tianjia Zhang, would you be able to develop and test a patch for this?

--=20
paul-moore.com

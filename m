Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEDE402B8E
	for <linux-security-module@vger.kernel.org>; Wed, 25 Mar 2026 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460213; cv=pass; b=RBmUejeZWm+VlMZ26O5zI4hJhev2hMqu8w3SfzAfrzVrd9mZeJoFEXKPR2MgxWc//rX5b8UVvTmSeyyrH7dHLzW18L//EGEVy/Ti42Ct+eJuGOyZ4MIqjNUY+LYI8q2j23W6lF7LvUBJm3IMBu767PFJ7cqOnlM++ZPfGufKMqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460213; c=relaxed/simple;
	bh=SXXvNMm4OOeTVI5sEJNC7nVh6MOtnfj6hXf10537/DU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMlQcfSKxY9JJ2Tq+bPfdXp0kV23tAnsrR+FRk9PcouVVj/SbLscUiOlE/u2UeQTA1vJqJSshhefP1aLIBkqwOs+8vGdcF6dUkszs0UYMSE3cSAIBNQgddxhnqMIyGIijDf1+oaNxTHuNmYMxzTbYBxvzFMdnA6crciop3lMStM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DD0nH9KQ; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DD0nH9KQ"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8298fad2063so73012b3a.3
        for <linux-security-module@vger.kernel.org>; Wed, 25 Mar 2026 10:36:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774460210; cv=none;
        d=google.com; s=arc-20240605;
        b=AWvexzmo2ZBkHSMmnPcJzKVZZY8qeLDGutfQEBC4use8OSYscky6dAU1xUCyrTV9ID
         WDp4jB/Qbucc59oMhBMc6v2lsyz/WMTolVBu1qv4T3BlsNooH9NtYe2iaBoH/LLpnBFD
         IZ/fxUhuuVhIhyO0Aj15GSq2Ku1+lyFciMc9if7sAXf20hH7QrmS6ei2iA0JTc2LC/lA
         RG1L/fcjotv+opSdkn3sIUvYrkyfL37dthDX/Z+enZVvGp2s1EycAa5FhNsxivBOk/t+
         pnr0kDylBSo+iJIZ4bVJCfzDlY3WnR/Ar9EUC/glSj3K7oI6M4mOIgYAht/upueaIJcc
         Ymyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=560A6QjyhPKgUbe2CXEHtEc1ptAHKSEox2yVMb4TCwU=;
        fh=sysInDRerhB9YkXniTg6ksi749UZ+oYnbZfxqPHL088=;
        b=CBJxQAVkk+W/K/I0Z+NWgwttHkUbxUp1woT3qrASgtcdGmNSqOZ0BCxrVFSF4Lb+xr
         82ChaYusgsQypIlbUoF5mRsp3o75BpmkUkleiUps6VWA+21bk7pUmrUnw0M6bM93inK1
         0+oyDR18QnkdTahMY6Dnx9G3ywHygFBAnmKgC287qT6AnGSdKfBRELsCwyrVLp2RYSFA
         VrWdjUr+8qmT3IgSlFQ+GBdqY8chaHjnkOIpjLQlveSkI7+yP4X+K8TkgPvQRs5u1gMP
         WcRCBtBbOJu5hp3vwYnWf7PFr3xEokVODfh9dvESFvOCHmQGgaEQ17ZEMRJjSHFz+CRR
         EbQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774460210; x=1775065010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=560A6QjyhPKgUbe2CXEHtEc1ptAHKSEox2yVMb4TCwU=;
        b=DD0nH9KQl1IYWPF404uwuX/UIwWdC4xPMi7UnOVf1ppDz5q3jCBTjDJdhfdvWPI3fc
         LIMP3cOmjdPwlRGycoQlHYGk6rQH1RpOqPJjt0IC3iuDQNkNvVVQm/dbKPGlD1UAFZhR
         qdV0RHP73WosmwNpT1GlSz253J1A7GAjwLQQTg2qKjVBpdCL36jNUDIg2HvU2yCbYsSp
         BFYp8s4s4jAA/bI7fyHZZlUCTxYKQcdqCHiP9gQ+ATwH7EDOe/X+8fVlRnWhnVEGLpMn
         MVKvZdmsOlbEjJpKgFV+ZoDBcFnPs6I+9PxG6rxAFW04FS/tT2DuUskI5BxjIV5s/DLO
         1GLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774460210; x=1775065010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=560A6QjyhPKgUbe2CXEHtEc1ptAHKSEox2yVMb4TCwU=;
        b=LKs7+K6xSdx0PcZZkA76KII9cAQsdKsLr50TLKuK/RI13bfcectyqyJBnMQtIf75eI
         M6VhGtSdENGU6oz4CEIdYxfXWzYD0V0aze0Kiuc3N0Qjcsh7mv9r+WsNg5jXYcF51egS
         Og/ri7ktIzPmyAbJ+EYkHKyIkjAq35JHQ0at3sy/a4mpCYlryz4uwbcgahD5qx9UYatX
         YWTasGqUffuZbiewagACmguveQ+f1Z7t6hxVno69hjgQgajXR7rbmcExYlqNch/EUf6E
         asnWxGxGURH9qKsLqL+2CfL7wPKlQJAuwFSDR1PGBWISsa+Dxq8sf514X75KuRYheqAX
         bBIQ==
X-Gm-Message-State: AOJu0YxKrQjdkQ+ly0nlc1Ny3aw3Rs5Ebo3lPt1XcAQk0cGRsyCJyoux
	dRNNUCaf+FnmgBOEjgWXGZWxSinLltD/J08pf0S5zTM91x1CJ47Adwydmc7WLHp7nUUnGemxddZ
	mCfre/+cjNU4AAV+FmFB+HH7hPZ/Kb9SPKnc0yeLb
X-Gm-Gg: ATEYQzwJKUjYRcS2g1bEdUNw5grnb0mWeNCut2jaqN6rJ7AL2zQuISRM0+hby4LSWxY
	7xZRd4HmhuXEVgrXbgMNCCbLZjHKTKziPYH9GbWBqfrAOelMZyrcz10Zerzxa0zCwGLPYHiXxIg
	WnURLfn58HZkPp0XDwg0ky/lmXIEvbmHbozAfU+GVDs9b3U7KjOkseT2/8MiEBUJq4KguMSdLzQ
	/uYar6Z9aeuQeqgscgTKVDw1JOuHZ0QNGawsJZnSWkNuZmZ6EUT5tsoiGtI863C9UJokv8W4jRw
	7lmMmpA=
X-Received: by 2002:a05:6a00:4219:b0:827:2ee0:411f with SMTP id
 d2e1a72fcca58-82c6de7aa7cmr3962195b3a.4.1774460210073; Wed, 25 Mar 2026
 10:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323042510.3331778-4-paul@paul-moore.com> <20260323042510.3331778-5-paul@paul-moore.com>
 <CAKCV-6t=m-8eu1xoTORnLwhG4kQB5u1v5diJDQDFcat=tH8WgA@mail.gmail.com>
In-Reply-To: <CAKCV-6t=m-8eu1xoTORnLwhG4kQB5u1v5diJDQDFcat=tH8WgA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 25 Mar 2026 13:36:37 -0400
X-Gm-Features: AaiRm53RXGI_5fUjjLSR_a0KxLZyxKMzyTIPSX8PFvRbx9JxRVkJ2AR_0Hlvr9w
Message-ID: <CAHC9VhRNOGk0dGERbD+RRLTWebZu1-7cbvB0a2D0njbnqBRNXQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] lsm: add backing_file LSM hooks
To: Ryan Lee <ryan.lee@canonical.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Amir Goldstein <amir73il@gmail.com>, 
	Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 7:01=E2=80=AFPM Ryan Lee <ryan.lee@canonical.com> w=
rote:
>
> Hi Paul,
>
> I'm currently looking at the patch more closely to implement the hooks
> for AppArmor, but here are some typofixes and the like below:

Thanks Ryan, I appreciate the extra eyes.

> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 83a646d72f6f..1e4c68d5877f 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h                          unsigned long p=
rot);
> > @@ -1140,6 +1146,15 @@ static inline void security_file_release(struct =
file *file)
> >  static inline void security_file_free(struct file *file)
> >  { }
> >
> > +int security_backing_file_alloc(void **backing_file_blobp,
> > +                               const struct file *user_file)
> > +{
> > +       return 0;
> > +}
> > +
> > +void security_backing_file_free(void **backing_file_blobp)
> > +{ }
> > +
>
> Should these two placeholders be static inline functions, like the
> other ones around them?

Yes :)  The kernel test robot found the same problem yesterday, I've
already fixed it in my working branch.

> > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > index 573e2a7250c4..020eace65973 100644
> > --- a/security/lsm_init.c
> > +++ b/security/lsm_init.c
> > @@ -293,6 +293,8 @@ static void __init lsm_prepare(struct lsm_info *lsm=
)
> >         blobs =3D lsm->blobs;
> >         lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
> >         lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
> > +       lsm_blob_size_update(&blobs->lbs_backing_file,
> > +                            &blob_sizes.lbs_backing_file);
> >         lsm_blob_size_update(&blobs->lbs_ib, &blob_sizes.lbs_ib);
> >         /* inode blob gets an rcu_head in addition to LSM blobs. */
> >         if (blobs->lbs_inode && blob_sizes.lbs_inode =3D=3D 0)
> > @@ -441,6 +443,8 @@ int __init security_init(void)
> >         if (lsm_debug) {
> >                 lsm_pr("blob(cred) size %d\n", blob_sizes.lbs_cred);
> >                 lsm_pr("blob(file) size %d\n", blob_sizes.lbs_file);
> > +               lsm_pr("blob(backing_file) size %d\n",
> > +                      blob_sizes.lbs_backing_file);
> >                 lsm_pr("blob(ib) size %d\n", blob_sizes.lbs_ib);
> >                 lsm_pr("blob(inode) size %d\n", blob_sizes.lbs_inode);
> >                 lsm_pr("blob(ipc) size %d\n", blob_sizes.lbs_ipc);
> > @@ -462,6 +466,11 @@ int __init security_init(void)
> >                 lsm_file_cache =3D kmem_cache_create("lsm_file_cache",
> >                                                    blob_sizes.lbs_file,=
 0,
> >                                                    SLAB_PANIC, NULL);
> > +       if (blob_sizes.lbs_backing_file)
> > +               lsm_backing_file_cache =3D kmem_cache_create(
> > +                                                  "lsm_backing_file_ca=
che",
> > +                                                  blob_sizes.lbs_file,=
 0,
> > +                                                  SLAB_PANIC, NULL);
>
> Shouldn't blob_sizes.lbs_file here be blob_sizes.lbs_backing_file instead=
?

Good catch, thank you!  I'll have the fix in the next posting.  I'm
hoping to do some more testing today/tomorrow and post a non-RFC patch
by the end of the week.  If you find anything else that looks awry, or
just doesn't work, please let me know.

--=20
paul-moore.com

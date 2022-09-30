Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BD5C4332F
	for <linux-security-module@archiver.kernel.org>; Fri, 30 Sep 2022 14:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiI3OMG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 30 Sep 2022 10:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiI3OLh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 30 Sep 2022 10:11:37 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB44C1A0D16
        for <linux-security-module@vger.kernel.org>; Fri, 30 Sep 2022 07:11:23 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id c13-20020a4ac30d000000b0047663e3e16bso2303132ooq.6
        for <linux-security-module@vger.kernel.org>; Fri, 30 Sep 2022 07:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+02lWUnQnVpnIW75GUY8RdFtLVPFU6flJQgBwpnhGBU=;
        b=rt5DQ1gpYyGWOabp0rvarti0MXhPdro0zgBzGjdJTaVn4/FqeqPqFXgSFzQsik2ABd
         9gsm3BPQAiQpVGKpvObwIPzi9rg//WYfatrw+sxudu9uNLCFZHSsH038qSLByxlif17I
         BwL+l7VEMY5C5gkCZxAU6RyD+YxD+bW/RNMAxit/EbqYk+ZMjyaNb74drfob5aOGywia
         xR3NyIekUQE6WaeyzlsKxuulWSZW76djBTE+3habFDW2TsMc1jnMluI+MSpnlIVE5Fsb
         uYEpJQJkg1pO0wSBzS01JkOGnsjjM4FORQilbPczPZC8TRFrh2om7f4JPILCTsaDuNXm
         dxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+02lWUnQnVpnIW75GUY8RdFtLVPFU6flJQgBwpnhGBU=;
        b=O3QS1DPeyBJWgpH8qdf1wHXn7jj+NYOJQCb9H4UnkzfC/PDq0tO5swcd/iPFC/xKJw
         t6TwXpepk4iwQNC42r6Q/2XK3fWke8yP/IYU15uKGw2Qa/deIU8OB/AFGBdoF+c/h3rn
         9GR9xPet20yb1ZsFmuv3Us8GghV/NhxCUdGAa6LFDUMXXHkQ4XjBZPXV34g67wjTGERU
         BD0KAIZZWKxPihB2IwpZ4YRZrkN4D7yFCdjS210+e2fBze14MoMeJeSBp78GeoNQT9Yw
         RL5ohLKlali7dMYh3DJhlaRALDdTKw5pOdS8+zF4I7uDWhNlthO5NpQ323IU/LY8H4fS
         zF7Q==
X-Gm-Message-State: ACrzQf1dJKzmaW2V6YIRGVqmUAitpSx5zDvzqN2izL915HMbPm/SesgC
        Ltu4HMkCNLYq68TIblGUlITzdRQgNrqmDoDmnm4l
X-Google-Smtp-Source: AMsMyM6IyQ5sGNm/pGDeJJQ5vn5WZ1By4iKoxvFogUYrIwPYfUksEqpPNIf9trER/6ncZB31spquEFt73Tpwxy4slys=
X-Received: by 2002:a4a:c10a:0:b0:476:4a59:4e4b with SMTP id
 s10-20020a4ac10a000000b004764a594e4bmr3452742oop.24.1664547082349; Fri, 30
 Sep 2022 07:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220929153041.500115-1-brauner@kernel.org> <20220929153041.500115-13-brauner@kernel.org>
 <CAHC9VhSxr-aUj7mqKo05B5Oj=5FWeajx_mNjR_EszzpYR1YozA@mail.gmail.com> <53f18ae71d0b8811fbd23c87a80447bc159832e0.camel@linux.ibm.com>
In-Reply-To: <53f18ae71d0b8811fbd23c87a80447bc159832e0.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 30 Sep 2022 10:11:11 -0400
Message-ID: <CAHC9VhRn6Lojr-ct0YJb6R6oO66-p+6Pa9YBY=bxu_wsKs9bYQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/30] integrity: implement get and set acl hook
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 29, 2022 at 11:19 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Hi Paul,
>
> On Thu, 2022-09-29 at 15:14 -0400, Paul Moore wrote:
> > > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> > > index bde74fcecee3..698a8ae2fe3e 100644
> > > --- a/security/integrity/ima/ima_appraise.c
> > > +++ b/security/integrity/ima/ima_appraise.c
> > > @@ -770,6 +770,15 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
> > >         return result;
> > >  }
> > >
> > > +int ima_inode_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
> > > +                     const char *acl_name, struct posix_acl *kacl)
> > > +{
> > > +       if (evm_revalidate_status(acl_name))
> > > +               ima_reset_appraise_flags(d_backing_inode(dentry), 0);
> > > +
> > > +       return 0;
> > > +}
> >
> > While the ima_inode_set_acl() implementation above looks okay for the
> > remove case, I do see that the ima_inode_setxattr() function has a
> > call to validate_hash_algo() before calling
> > ima_reset_appraise_flags().  IANAIE (I Am Not An Ima Expert), but it
> > seems like we would still want that check in the ACL case.
>
> Thanks, Paul.  The "ima: fix blocking of security.ima xattrs of
> unsupported algorithms" patch in next-integrity branch, moves the hash
> algorithm checking earlier.

Okay, thanks.  When comparing against the status quo I usually just
stick with what is in Linus' tree, but I'm happy to hear this patch is
correct.

-- 
paul-moore.com

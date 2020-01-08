Return-Path: <SRS0=+YFI=25=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47870C33C9E
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jan 2020 08:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD2D20692
	for <linux-security-module@archiver.kernel.org>; Wed,  8 Jan 2020 08:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7ILGgy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgAHIV0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:21:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53062 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726486AbgAHIV0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 Jan 2020 03:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578471685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFvHOo+cq1fwfzwNSwczoqHAWJdXL5Ewmn7FvWnQyEo=;
        b=i7ILGgy89oq9XpmFE2Nxc3XaTBAYI86gO4ipf51bNaNZUCpz/GvzCsUxK8MLsGYE10WQIH
        MrXKFy6Lpr8MHc6su9tFDuehSTYoRRubXVK8TcRAfLPKP1rk1WLafI+UnIETtXVaWhbxrA
        21eHqJeSjXZDafSeKqcOzmxyw8c3TSM=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-MA2f-XHEM2emNWxa0pi-Tg-1; Wed, 08 Jan 2020 03:21:24 -0500
Received: by mail-ot1-f71.google.com with SMTP id v14so1300153otf.12
        for <linux-security-module@vger.kernel.org>; Wed, 08 Jan 2020 00:21:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7Se5RL9B0E6GFyUvxUX223EeRafTYuLsBZVuTPT7ng=;
        b=fXIlZ9BEVT/2m7plnfhK8kIxwUgJLxJQa5CWmEkmO39oAcDrVgPxoDUumixUw7/Z1v
         q8FgeaU6MT4OwFXvtlUr01GyJdlv2uu5ykxTJ4TJi7tj9GShy0j6j90ffhgUMndN9ECK
         xqtluimTFfuXTPu8qptsE5taFMSNBtIny4pih+jI01e7YUTSn9MJKW4+fegPNc5lAHdn
         rFMQrv2io9xwbGG0KrxmYh/lSddcdYCZySBt3AinvTsJuy2T3mJcGNk4Jspxl9Y59dVl
         DGerHLZXnzf9lNS8YEDKN8glfajHQBRbmE+ku22ERNwxPhIRSbW34JpHPa3ID9gPU4QG
         xTiA==
X-Gm-Message-State: APjAAAUfr/0jeC4n22bqVikCvajFoEi5419WPrh45Acb5A8EXt7S9DFj
        qEGjGknOZTDRiXAW50EvRk5X4IBEm4t/C2hqbzWhXErVSfbprux1u46UhQSGJ+KB7jvTipnG12q
        SepzaeY0uRxdB67wOMwr8lAWet1TflVViat+0h1ZlDHN/HLyE9sFN
X-Received: by 2002:aca:f555:: with SMTP id t82mr2231938oih.103.1578471683331;
        Wed, 08 Jan 2020 00:21:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqwtFm6rnY9DPj7Xuqn9BiyyPOm+yWADJ3BukCZR93lpup6VdWqBAXHSS9PHX3uV2wfSRhv9U51eGj2vCeEciQE=
X-Received: by 2002:aca:f555:: with SMTP id t82mr2231921oih.103.1578471683094;
 Wed, 08 Jan 2020 00:21:23 -0800 (PST)
MIME-Version: 1.0
References: <20200107133154.588958-1-omosnace@redhat.com> <20200107133154.588958-3-omosnace@redhat.com>
 <alpine.LRH.2.21.2001080653220.575@namei.org>
In-Reply-To: <alpine.LRH.2.21.2001080653220.575@namei.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 8 Jan 2020 09:21:11 +0100
Message-ID: <CAFqZXNvbNqrTJWxdQU4P-7O-kLRcGW+QcL7LY5Ca8rULLm2ScA@mail.gmail.com>
Subject: Re: [PATCH 2/2] security,selinux: get rid of security_delete_hooks()
To:     James Morris <jmorris@namei.org>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-MC-Unique: MA2f-XHEM2emNWxa0pi-Tg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 7, 2020 at 9:00 PM James Morris <jmorris@namei.org> wrote:
> On Tue, 7 Jan 2020, Ondrej Mosnacek wrote:
>
> > The only user is SELinux, which is hereby converted to check the
> > disabled flag in each hook instead of removing the hooks from the list.
> >
> > The __lsm_ro_after_init macro is now removed and replaced with
> > __ro_after_init directly.
> >
> > This fixes a race condition in SELinux runtime disable, which was
> > introduced with the switch to hook lists in b1d9e6b0646d ("LSM: Switch
> > to lists of hooks").
> >
> > Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  include/linux/lsm_hooks.h    |  31 --
> >  security/Kconfig             |   5 -
> >  security/apparmor/lsm.c      |   6 +-
> >  security/commoncap.c         |   2 +-
> >  security/loadpin/loadpin.c   |   2 +-
> >  security/lockdown/lockdown.c |   2 +-
> >  security/security.c          |   5 +-
> >  security/selinux/Kconfig     |   6 -
> >  security/selinux/hooks.c     | 742 ++++++++++++++++++++++++++++++-----
> >  security/smack/smack_lsm.c   |   4 +-
> >  security/tomoyo/tomoyo.c     |   6 +-
> >  security/yama/yama_lsm.c     |   2 +-
> >  12 files changed, 654 insertions(+), 159 deletions(-)
>
> Please separate the changes for each LSM into separate patches (the
> __lsm_ro_after_init removal patch can be last).
>
> >  config SECURITY_SELINUX_DEVELOP
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 47ad4db925cf..9ac2b6b69ff9 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -650,13 +650,15 @@ static int selinux_set_mnt_opts(struct super_bloc=
k *sb,
> >  {
> >       const struct cred *cred =3D current_cred();
> >       struct superblock_security_struct *sbsec =3D sb->s_security;
> > -     struct dentry *root =3D sbsec->sb->s_root;
> >       struct selinux_mnt_opts *opts =3D mnt_opts;
>
> Seems like there are a bunch of unrelated cleanups mixed in here.

These are not unrelated - we need to avoid dereferencing the security
structs before checking selinux_disabled(), because they may be NULL
or uninitialized when SELinux has been diabled.

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.


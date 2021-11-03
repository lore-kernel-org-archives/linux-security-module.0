Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9BBC433EF
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Nov 2021 22:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F21B610EA
	for <linux-security-module@archiver.kernel.org>; Wed,  3 Nov 2021 22:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhKCW1q (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Nov 2021 18:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhKCW1p (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Nov 2021 18:27:45 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A494BC061714;
        Wed,  3 Nov 2021 15:25:08 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s136so3636294pgs.4;
        Wed, 03 Nov 2021 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jihVygVNweEvYj3Lol5vLLtRaZPbjtnCrZIu/J/L8tI=;
        b=f+TDVr1dxCDVIlpTeXrd/XakLi4Fv1BcwK5FeC+7hsZ2FoikjGcCiKvzb9GZR80c9O
         2lroPoP2patWuNjIz5mXDgv4Ec3cRN9WC8Y80302R+2HQF/CbgUl3QMQejcDz8WSmTzu
         7IsJzUJpy7KSChKA6p3GcsxdWJf58Rl5O7DidnKFj0q3qN2VXKRmxZvQdCcnbLB2oBXF
         Ax0MzHheATx8CWv78P7cjvmDnlSYh7GccaBiykwW4Qdwc/cGh37Tc6gAXCAz+Yxk2cPO
         mbVo9q/YhYI9kwVrD0aaDnFa7PGxXlUcfDMg+QxdlS/J/uNPxU3wL5/ohUQi6idqidx0
         bKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jihVygVNweEvYj3Lol5vLLtRaZPbjtnCrZIu/J/L8tI=;
        b=gGptz0CqWn8Xpa69cX22ZOrpNT7NeWQu6otkFCUDN9QpLvXCuVTJaiur4Ql9fBEiqh
         Ia9qWVhvIi7Y/ot8//5ZMtRt35Cai8Aq3OUc1t8Ce4NmiTXL9r30ID77CYz5hkWn5COt
         BslTnhs2VAG5ZbEqpEtXWUYlvlQ24RXpymiTYefCGs9UC55pube+ZA0koB3IWsvo1BTD
         GKGb5QJ/mJ8/u/f1iRoFJL6SQPxFrkT/zu2Bx5qif0rMGOoo3crg/B3a3oNz/vPgLxAa
         FgPTc5yVA6MzvqAbyvxeGpwSRkOCenYrSPLwaHtbfmlICHUIOckSrHfj0He609dYptsf
         OrUg==
X-Gm-Message-State: AOAM532JTn+pFE3jBfpoI4a9022Bxuanx3CtMDIMxhSwI6Bc1XivWGPF
        W5JNrYKwaDbaUcX9Lo7qF9hffKNPAaNY+sEby/A=
X-Google-Smtp-Source: ABdhPJyofOXDYAsy2Z2SHu46tYRMlg0uGRdEOQOdrdKOCRsgfkk8a91UKl2CN2vqiR+C/i+w+tpxnahaqTKq9WUdxKY=
X-Received: by 2002:a63:6881:: with SMTP id d123mr19145847pgc.68.1635978308099;
 Wed, 03 Nov 2021 15:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211103073131.GA15173@raspberrypi> <79835dce-7e15-38e2-5341-2fb246a445e7@schaufler-ca.com>
In-Reply-To: <79835dce-7e15-38e2-5341-2fb246a445e7@schaufler-ca.com>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Thu, 4 Nov 2021 07:24:57 +0900
Message-ID: <CADLLry7i=MB1diZmHXAv3tf8yTMgwceTA4OeuWPVrxt-13wdZQ@mail.gmail.com>
Subject: Re: [PATCH] smack: clean up smack_enabled to be more readable
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

2021=EB=85=84 11=EC=9B=94 4=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 1:01, C=
asey Schaufler <casey@schaufler-ca.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> On 11/3/2021 12:31 AM, Austin Kim wrote:
> > The smack_enabled is only set to 0, 1. So changing type of smack_enable=
d
> > as bool may make relevant routine be more readable.
> >
> > Signed-off-by: Austin Kim <austindh.kim@gmail.com>
>
> A couple of changes below.
>
> > ---
> >   security/smack/smack.h           | 2 +-
> >   security/smack/smack_lsm.c       | 4 ++--
> >   security/smack/smack_netfilter.c | 2 +-
> >   security/smack/smackfs.c         | 2 +-
> >   4 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/security/smack/smack.h b/security/smack/smack.h
> > index 99c3422596ab..dc1726f5953f 100644
> > --- a/security/smack/smack.h
> > +++ b/security/smack/smack.h
> > @@ -302,7 +302,7 @@ int smack_populate_secattr(struct smack_known *skp)=
;
> >   /*
> >    * Shared data.
> >    */
> > -extern int smack_enabled __initdata;
> > +extern bool smack_enabled __initdata;
> >   extern int smack_cipso_direct;
> >   extern int smack_cipso_mapped;
> >   extern struct smack_known *smack_net_ambient;
> > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > index efd35b07c7f8..ba3b46bd2ceb 100644
> > --- a/security/smack/smack_lsm.c
> > +++ b/security/smack/smack_lsm.c
> > @@ -56,7 +56,7 @@ static DEFINE_MUTEX(smack_ipv6_lock);
> >   static LIST_HEAD(smk_ipv6_port_list);
> >   #endif
> >   struct kmem_cache *smack_rule_cache;
> > -int smack_enabled __initdata;
> > +bool smack_enabled __initdata;
> >
> >   #define A(s) {"smack"#s, sizeof("smack"#s) - 1, Opt_##s}
> >   static struct {
> > @@ -4953,7 +4953,7 @@ static __init int smack_init(void)
> >        * Register with LSM
> >        */
> >       security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack")=
;
> > -     smack_enabled =3D 1;
> > +     smack_enabled =3D true;
> >
> >       pr_info("Smack:  Initializing.\n");
> >   #ifdef CONFIG_SECURITY_SMACK_NETFILTER
> > diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_ne=
tfilter.c
> > index b945c1d3a743..82092d9387a3 100644
> > --- a/security/smack/smack_netfilter.c
> > +++ b/security/smack/smack_netfilter.c
> > @@ -70,7 +70,7 @@ static struct pernet_operations smack_net_ops =3D {
> >
> >   static int __init smack_nf_ip_init(void)
> >   {
> > -     if (smack_enabled =3D=3D 0)
> > +     if (smack_enabled =3D=3D false)
>
> If you want to use a bool you should use it fully.
>   +     if (!smack_enabled)
>
> >               return 0;
> >
> >       printk(KERN_DEBUG "Smack: Registering netfilter hooks\n");
> > diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> > index 658eab05599e..7649ad8cc335 100644
> > --- a/security/smack/smackfs.c
> > +++ b/security/smack/smackfs.c
> > @@ -2993,7 +2993,7 @@ static int __init init_smk_fs(void)
> >       int err;
> >       int rc;
> >
> > -     if (smack_enabled =3D=3D 0)
> > +     if (smack_enabled =3D=3D false)
>
> Same here.

Thanks for feedback.
Let me resend the patch.

BR,
Austin Kim

>
> >               return 0;
> >
> >       err =3D smk_init_sysfs();

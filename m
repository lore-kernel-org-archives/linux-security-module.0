Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D0EC433F5
	for <linux-security-module@archiver.kernel.org>; Tue,  3 May 2022 20:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbiECUGU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 3 May 2022 16:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiECUGT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 May 2022 16:06:19 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25021403C6
        for <linux-security-module@vger.kernel.org>; Tue,  3 May 2022 13:02:46 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a15-20020a17090ad80f00b001dc2e23ad84so3235340pjv.4
        for <linux-security-module@vger.kernel.org>; Tue, 03 May 2022 13:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lO/St+o2/PonjjcblNEybj23wOVCI5+m6U1+OI/TnZE=;
        b=PCvGCzsvIlu1EuXOzDqVzSwE4DAmJ15LlcKthP3s6kp4sJdaVpq9wwEcFLGha/McMd
         E2KG//amULHo4ISJDsiQ3tbmqYzmtcZUlJtCvhMEch/LKDRQZK8W0ShcLlfggWS3h0q7
         qkw6Ff1OihT0y0Hk+heZknTEeRzZmualGVja8NdrYSVda816O8WOKHPBRZ1XM0xH48Zp
         pheeFma0vOK2GncA1jZ/fqB0SubqSY44XUX/dLcAp8fUoktfTTqKnq2YJbL+oeV4X4ht
         4lCKXiUK/OJoyFM/YS8HdWvMOfMgFbGuz2D/V8hmJUhMncrWk2CW4UwrQeubLmzIzkw4
         k6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lO/St+o2/PonjjcblNEybj23wOVCI5+m6U1+OI/TnZE=;
        b=Qg6FJHML/l0f2mba167KDXq7iT7aWyjhTF3n+rdQwLomceLlpRxemvyN0g8UbSbRj4
         QBkENQIYVM9yaof6+JKCR0eyHGKRURl+UyupXx+JebUXqTFrND/NpMBj8G4EcBlhdjXE
         zNRpA2Z81cc/OpYb6jEB2cuiUQSeeOt6SSfvpguq7cIxGctNhwtayu8688AAEprCoJO+
         7Ay2gnVHaHEULJRrF9xEJifyK3kpfrL2+d2etcFXleQi0Ji4ju8KTPG/Yi11QuW+iyTt
         J+z1VzekV6hok1uv9HAeDsvb47njVtI6pJcAzMqfVi+JO4s5dscd0A6rn4M1B8dWYA2R
         d81A==
X-Gm-Message-State: AOAM533N4YMczKOQnjR35+kHZcN2/g8vrgC7dSazHPn9A0qXQaxdlqyC
        A3P1qsVnIJ8nYwGAQvEnfv/Kx14gbOasriUvdQwE
X-Google-Smtp-Source: ABdhPJyGr+c8LNlbNNBXcpq/E9lvU6ileaoiIgySTkkuyQiPg6JdjkUnr0umPie0YLBfSrHZOOgapp9FoirQubuXdyk=
X-Received: by 2002:a17:90a:9294:b0:1b9:48e9:a030 with SMTP id
 n20-20020a17090a929400b001b948e9a030mr6495804pjo.200.1651608165644; Tue, 03
 May 2022 13:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220217141858.71281-1-cgzones@googlemail.com>
 <41224e84-2da7-3f69-0fdb-bb309ad6a3d4@schaufler-ca.com> <CAJ2a_Dfqm92Am5PFPh+3itWZmArWRuVadcRO+=i-BPhQ8QmA8Q@mail.gmail.com>
In-Reply-To: <CAJ2a_Dfqm92Am5PFPh+3itWZmArWRuVadcRO+=i-BPhQ8QmA8Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 May 2022 16:02:34 -0400
Message-ID: <CAHC9VhR-Xk65iSfZxVvaK+mJoFszxT2E8vF=cus1aAKcB0EgYg@mail.gmail.com>
Subject: Re: [PATCH] security: declare member holding string literal const
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        SElinux list <selinux@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        Todd Kjos <tkjos@google.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, May 2, 2022 at 9:38 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Thu, 17 Feb 2022 at 23:50, Casey Schaufler <casey@schaufler-ca.com> wr=
ote:
> > On 2/17/2022 6:18 AM, Christian G=C3=B6ttsche wrote:
> > > The struct security_hook_list member lsm is assigned in
> > > security_add_hooks() with string literals passed from the individual
> > > security modules.  Declare the function parameter and the struct memb=
er
> > > const to signal their immutability.
> > >
> > > Reported by Clang [-Wwrite-strings]:
> > >
> > >      security/selinux/hooks.c:7388:63: error: passing 'const char [8]=
' to parameter of type 'char *' discards qualifiers [-Werror,-Wincompatible=
-pointer-types-discards-qualifiers]
> > >              security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hoo=
ks), selinux);
> > >                                                                      =
     ^~~~~~~~~
> > >      ./include/linux/lsm_hooks.h:1629:11: note: passing argument to p=
arameter 'lsm' here
> > >                                      char *lsm);
> > >                                            ^
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> >
>
> Kindly ping;
> any progress on this one?

I've already added my Reviewed-by tag, as has Casey, so I think it's
pretty "safe" at this point.  The next step is for James to pull this
into the LSM tree.  If it is still collecting dust at the end of this
week, ping us again and I can just go ahead and pull it into the
SELinux tree, it's small enough that it shouldn't cause any problems.

--=20
paul-moore.com

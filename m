Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184DFC433F5
	for <linux-security-module@archiver.kernel.org>; Fri, 13 May 2022 18:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383434AbiEMSzV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 May 2022 14:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383408AbiEMSzT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 May 2022 14:55:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D0F6B7ED
        for <linux-security-module@vger.kernel.org>; Fri, 13 May 2022 11:55:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v12so12529045wrv.10
        for <linux-security-module@vger.kernel.org>; Fri, 13 May 2022 11:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qRnRhJJWad0NfkbuCANikaLEmHs3ldU2uccodI8L08g=;
        b=7lXdI+US3yWpFmLmeqGJRUGEETYf4g53DEHrLX2BuR5KAZrwo2kTtL3jehzVzDIG5p
         atM2mL6yCpjkk7fYctlOldK4pKPDNw2zQXmX8/TkSorKvdTk+frGA8eV3rQlMYVqgcPs
         8kfEd/L1CI69abdDvqIQy+tYo183kAiIAoG6QH/Q9bnwWdSHrbAwNrS3CqDYY8juXtEH
         YZZnkCArbT1weqK64wGyQOZufz2CwI33o0YBv5M/sM0MSGcenG1+PeK+AXRZSr9R7oHt
         Dh/2rVpFfPf9R0NUBhDEv5NDZFGJl4B8B50XtRvStKTiPYGN01d+rbF4yM5HDSUKk/Wl
         zvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qRnRhJJWad0NfkbuCANikaLEmHs3ldU2uccodI8L08g=;
        b=RAWKl82OhOcHL2MI6Z8Ipyv70+eFUaAq5YqK1e93knbFzX0m09ju2qEMpJCqiD7ca7
         E+OyfBMjgfWe7X39VZfmsVxHlVXuynxrDponoqYP17nwqteUDcy/m+RYSflibdP/aZfc
         nTDcBuWvat+7/WKOF8APMP03B1YwPy7eDmLZxypbN+enKQwCxf9POVDvhQahqIPI5Zji
         jWr29PI291qDsQq3WltyMndfeQOTeC+JVvLrE9l1joH7HJZNOBqr7M/ueaxlWxGAAKwx
         i0/flt5VsjaWH9+ktL9+RwBotUaoyCidnQCvnJmndkbh1g46m2b5FDuVNbe5JM4+HuZw
         HTQg==
X-Gm-Message-State: AOAM530Vnqo/SI7GgVNs2bOIS6G+/5J05c4FbUze4KEcqKSSUPq1AA8D
        jMItEtLQ5R2xSOQbsa5NTkUKRNEsnG83YT1LhheF
X-Google-Smtp-Source: ABdhPJxpRZpcOpSm4GKLTC1g+8cigIL7wsm6aXqnnakJx39XpYfkGY+a50E1FwTxoLfQGqG3u4IET/RWUwWFW6f/g04=
X-Received: by 2002:a05:6000:10cc:b0:20a:de6f:3c48 with SMTP id
 b12-20020a05600010cc00b0020ade6f3c48mr4974596wrx.650.1652468116804; Fri, 13
 May 2022 11:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220217141858.71281-1-cgzones@googlemail.com>
 <41224e84-2da7-3f69-0fdb-bb309ad6a3d4@schaufler-ca.com> <CAJ2a_Dfqm92Am5PFPh+3itWZmArWRuVadcRO+=i-BPhQ8QmA8Q@mail.gmail.com>
 <CAHC9VhR-Xk65iSfZxVvaK+mJoFszxT2E8vF=cus1aAKcB0EgYg@mail.gmail.com> <CAJ2a_Ddy8Kkp6SHxktguSQ4WqHwpA=zrQUz8UYkajF5-YtPerw@mail.gmail.com>
In-Reply-To: <CAJ2a_Ddy8Kkp6SHxktguSQ4WqHwpA=zrQUz8UYkajF5-YtPerw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 13 May 2022 14:55:06 -0400
Message-ID: <CAHC9VhRqh1oB_9Bhh37fbS=fszzjk8B=T2fHkjnrVUjp=pnvpw@mail.gmail.com>
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

On Fri, May 13, 2022 at 1:16 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Tue, 3 May 2022 at 22:02, Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, May 2, 2022 at 9:38 AM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > > On Thu, 17 Feb 2022 at 23:50, Casey Schaufler <casey@schaufler-ca.com=
> wrote:
> > > > On 2/17/2022 6:18 AM, Christian G=C3=B6ttsche wrote:
> > > > > The struct security_hook_list member lsm is assigned in
> > > > > security_add_hooks() with string literals passed from the individ=
ual
> > > > > security modules.  Declare the function parameter and the struct =
member
> > > > > const to signal their immutability.
> > > > >
> > > > > Reported by Clang [-Wwrite-strings]:
> > > > >
> > > > >      security/selinux/hooks.c:7388:63: error: passing 'const char=
 [8]' to parameter of type 'char *' discards qualifiers [-Werror,-Wincompat=
ible-pointer-types-discards-qualifiers]
> > > > >              security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux=
_hooks), selinux);
> > > > >                                                                  =
         ^~~~~~~~~
> > > > >      ./include/linux/lsm_hooks.h:1629:11: note: passing argument =
to parameter 'lsm' here
> > > > >                                      char *lsm);
> > > > >                                            ^
> > > > >
> > > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > >
> > > > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > > >
> > >
> > > Kindly ping;
> > > any progress on this one?
> >
> > I've already added my Reviewed-by tag, as has Casey, so I think it's
> > pretty "safe" at this point.  The next step is for James to pull this
> > into the LSM tree.  If it is still collecting dust at the end of this
> > week, ping us again and I can just go ahead and pull it into the
> > SELinux tree, it's small enough that it shouldn't cause any problems.
>
> end-of-the-week-ping

Thanks for the reminder.  I haven't seen any other action on this so
I've gone ahead and merged this into selinux/next; thanks for your
patience and persistence on this Christian!

--=20
paul-moore.com

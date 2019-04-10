Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5139DC10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 18:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186B32077C
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 18:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l70syTbN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbfDJSRf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:17:35 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37302 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729205AbfDJSRf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 14:17:35 -0400
Received: by mail-vs1-f66.google.com with SMTP id w13so1942399vsc.4
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 11:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=11oSdNliYQvQIqGjMnjP0X/QOf3dB1AUGEhHWlwBQH4=;
        b=l70syTbNzZ2YNdXlx93skFYDxlYypgMCC+vZnemJwhoPt3QkhYIK687oRRICDvXURV
         ILjPSe7hLcaBTGkRkQPyEMNctvnN9EqQ5GzrO23nDKNw6hxHurFSF8eUZKKhub3VR/fG
         Bd6sCIhGvxBftYDOmlttnaTrQqViEOW5uVUMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=11oSdNliYQvQIqGjMnjP0X/QOf3dB1AUGEhHWlwBQH4=;
        b=DqtnOOtlkA0hEnU6icW6vbzJT+X/8yrhr3cLHxZ/aFyK5pTGOj+X55c+7kUsdU6DXE
         3WOtvTd9CzNKNuQmvpklO8JBbeR2x6XEZ5y9NbuItGiXA3eiPcDfOfAZmerwrZetE5cS
         Bw9ae5lXvLYSa1VvLmCTSN39N5BIORalqGG7h918N/KsGzJ8XxenSX10hXZokGvWeZxL
         QXPUl6D7OeXqlhcygaz5RmPSstj3uaQ1pwfmwLwm6fu2pybkGhxYfi42SmteHyJe46FB
         Mh2EHaCB5GqokByUpm1NYW6nCEGXBVCUubnmNQ/Tz0sGrP0P/5epA48f9t9Jk6F2lzhX
         i2Gg==
X-Gm-Message-State: APjAAAVC/CP5QuS21IiLb0OMvSuI9Y6MN5HbURuWsnzyqUFh+UDVWzH7
        wU4DiEyex6gTt+xzvzoWvT9OF99JWo4=
X-Google-Smtp-Source: APXvYqzoK18H9TUeI3dsyD6NwjaV7up7/ZcxpEM2crBhxFBA5kStMjsu6jaN6WpmYmk4bbCbrpC2Tw==
X-Received: by 2002:a67:83c5:: with SMTP id f188mr23974584vsd.163.1554920253845;
        Wed, 10 Apr 2019 11:17:33 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id s78sm7678838vke.17.2019.04.10.11.17.32
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 11:17:32 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id t15so1108520uao.5
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 11:17:32 -0700 (PDT)
X-Received: by 2002:ab0:2f8:: with SMTP id 111mr23922439uah.123.1554920252083;
 Wed, 10 Apr 2019 11:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190410165619.212464-1-mortonm@chromium.org> <CAGXu5j+HTSPDR0Sp17=Jr3gRUSOX39dohy0bgxwyL+Wbh9swkQ@mail.gmail.com>
 <CAG48ez2gub+rSD3H+XZkd3Wp8Sh6KTzcEStZaQ=g1sG0=Tid+A@mail.gmail.com>
In-Reply-To: <CAG48ez2gub+rSD3H+XZkd3Wp8Sh6KTzcEStZaQ=g1sG0=Tid+A@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 11:17:20 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKoxC9CzWFH41YUZffzvJ1=B71JSqWxMjF+SEpF22wF-Q@mail.gmail.com>
Message-ID: <CAGXu5jKoxC9CzWFH41YUZffzvJ1=B71JSqWxMjF+SEpF22wF-Q@mail.gmail.com>
Subject: Re: [PATCH 09/10] LSM: SafeSetID: verify transitive constrainedness
To:     Jann Horn <jannh@google.com>
Cc:     Micah Morton <mortonm@chromium.org>,
        James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 10, 2019 at 10:37 AM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Apr 10, 2019 at 7:28 PM Kees Cook <keescook@chromium.org> wrote:
> > On Wed, Apr 10, 2019 at 9:56 AM Micah Morton <mortonm@chromium.org> wrote:
> > > From: Jann Horn <jannh@google.com>
> > >
> > > Someone might write a ruleset like the following, expecting that it
> > > securely constrains UID 1 to UIDs 1, 2 and 3:
> > >
> > >     1:2
> > >     1:3
> > >
> > > However, because no constraints are applied to UIDs 2 and 3, an attacker
> > > with UID 1 can simply first switch to UID 2, then switch to any UID from
> > > there. The secure way to write this ruleset would be:
> > >
> > >     1:2
> > >     1:3
> > >     2:2
> > >     3:3
> > >
> > > , which uses "transition to self" as a way to inhibit the default-allow
> > > policy without allowing anything specific.
> > >
> > > This is somewhat unintuitive. To make sure that policy authors don't
> > > accidentally write insecure policies because of this, let the kernel verify
> > > that a new ruleset does not contain any entries that are constrained, but
> > > transitively unconstrained.
> > >
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > Signed-off-by: Micah Morton <mortonm@chromium.org>
> > > ---
> > >  security/safesetid/securityfs.c               | 21 +++++++++++++++++++
> > >  .../selftests/safesetid/safesetid-test.c      |  4 +++-
> > >  2 files changed, 24 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
> > > index 7a08fff2bc14..3ec64487f0e9 100644
> > > --- a/security/safesetid/securityfs.c
> > > +++ b/security/safesetid/securityfs.c
> > > @@ -77,6 +77,23 @@ static void release_ruleset(struct setuid_ruleset *pol)
> > >                 call_rcu(&pol->rcu, __release_ruleset);
> > >  }
> > >
> > > +static int verify_ruleset(struct setuid_ruleset *pol)
> > > +{
> > > +       int bucket;
> > > +       struct setuid_rule *rule;
> > > +
> > > +       hash_for_each(pol->rules, bucket, rule, next) {
> > > +               if (_setuid_policy_lookup(pol, rule->dst_uid, INVALID_UID) ==
> > > +                   SIDPOL_DEFAULT) {
> > > +                       pr_warn("insecure policy rejected: uid %d is constrained but transitively unconstrained through uid %d\n",
> > > +                               __kuid_val(rule->src_uid),
> > > +                               __kuid_val(rule->dst_uid));
> > > +                       return -EINVAL;
> > > +               }
> > > +       }
> > > +       return 0;
> > > +}
> >
> > Why fail open? How about having the policy automatically add the
> > constraints (since the entire policy is known at verification time)?
>
> Are you suggesting to print a warning, automatically add the
> constraint, apply the policy, and still return -EINVAL? I guess that
> would work.

I meant not return EINVAL in this case but just fix it.

> I think it is a good idea to require userspace to explicitly write
> these rules, since implicitly-added rules might make the rules harder
> to understand for someone reading a policy file.

Mostly it's a question for the userspace design. If EINVAL is checked,
then I think it's probably fine, but will that error propagate to
whatever will eventually launch the processes that are supposed to be
confined? Since it's a detectable case, why not just fix it (with a
warning) and run safely?

-- 
Kees Cook

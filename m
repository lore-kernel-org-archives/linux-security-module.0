Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8080EC10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 17:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F73120830
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 17:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IehAXGGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbfDJRg6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:36:58 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45715 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbfDJRg6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 13:36:58 -0400
Received: by mail-ot1-f68.google.com with SMTP id e5so2664908otk.12
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 10:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iBXvQMKe+iTzX2osfs+1SxZdbujWk+YRDKpbD5xQZVs=;
        b=IehAXGGZcshzBcFQXW1h3nrlqZmGuanQ9i+bnR53ssRdcMscOhtsKiAEyRugiGSvMT
         R8BEva7FyIOwj+NoP4A+pXdqSSlEPANVMAZC1Wxf16hsVrQy7VBdFbCRbUVP0+Ol/i8Y
         74HfJPHY8sFQBFWr/RV9jeVc5Tj5l1vuXywDV2RERtGkUEbiyeBUdfvbRx4rzsrqf5yr
         uA6YbZ+IWJBX9a1tOhV9GKc/7MpHsH4FzlhLQ1H1VMgxbmcB6CfoIYpFEFf+snnYfSLP
         Dnaq74z4Un3+wqJD7DA9WQnrkI3vihmWaHn2BOB7Z0iwmZVMvwhy2arFKg7vUnyX15UW
         3k+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBXvQMKe+iTzX2osfs+1SxZdbujWk+YRDKpbD5xQZVs=;
        b=jqIg+V/SaZqqX0jfMESz+VDmuwp3KG3dAeJQQOBQ5UQMDyqPK7lYTzmNDaGQGLcyBm
         qoig/liNnGRgukvRDse91qS9qCUZ04TZDZmW4yJBgG58K5YBxWrrkkuHyXaDuoL2jhUP
         sJ7w+cMz3pODEkdEP1VC7SbAmabgy8yaXAbyclf91NYyiup8a+nbem63xAIP1yG1d6vE
         dItQC4Bs/1bIesMAp0FKqB0kSnkQ7tz0QJe7wo7ExA5sk2Nxr025xMu0i0cD7Q2rs9bn
         w7ZY7SEi0OtNC8U21De//71ESWtdUJxl2c8LKyzz/2BQ0cvrWDiNpofJOOdYFAOxQXef
         /gBg==
X-Gm-Message-State: APjAAAXSAzM3cGnPz5zF4mgPFzTOGCqNf8gyBGdEpnuIvJk88FRXBtVM
        ke7SsCl86V3xLDnFCvH5JGHNknYIB+9US0wXwGovHw==
X-Google-Smtp-Source: APXvYqxN6HWoHwxAAxDl9BG67ysJV5pyyrcl8Qsppy1WbvIp1mSywT/LEliYzHpeYBu8cZBOOgyR68M1pQFvPnKJH0E=
X-Received: by 2002:a9d:6d05:: with SMTP id o5mr29425107otp.175.1554917817410;
 Wed, 10 Apr 2019 10:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190410165619.212464-1-mortonm@chromium.org> <CAGXu5j+HTSPDR0Sp17=Jr3gRUSOX39dohy0bgxwyL+Wbh9swkQ@mail.gmail.com>
In-Reply-To: <CAGXu5j+HTSPDR0Sp17=Jr3gRUSOX39dohy0bgxwyL+Wbh9swkQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 10 Apr 2019 19:36:31 +0200
Message-ID: <CAG48ez2gub+rSD3H+XZkd3Wp8Sh6KTzcEStZaQ=g1sG0=Tid+A@mail.gmail.com>
Subject: Re: [PATCH 09/10] LSM: SafeSetID: verify transitive constrainedness
To:     Kees Cook <keescook@chromium.org>
Cc:     Micah Morton <mortonm@chromium.org>,
        James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 10, 2019 at 7:28 PM Kees Cook <keescook@chromium.org> wrote:
> On Wed, Apr 10, 2019 at 9:56 AM Micah Morton <mortonm@chromium.org> wrote:
> > From: Jann Horn <jannh@google.com>
> >
> > Someone might write a ruleset like the following, expecting that it
> > securely constrains UID 1 to UIDs 1, 2 and 3:
> >
> >     1:2
> >     1:3
> >
> > However, because no constraints are applied to UIDs 2 and 3, an attacker
> > with UID 1 can simply first switch to UID 2, then switch to any UID from
> > there. The secure way to write this ruleset would be:
> >
> >     1:2
> >     1:3
> >     2:2
> >     3:3
> >
> > , which uses "transition to self" as a way to inhibit the default-allow
> > policy without allowing anything specific.
> >
> > This is somewhat unintuitive. To make sure that policy authors don't
> > accidentally write insecure policies because of this, let the kernel verify
> > that a new ruleset does not contain any entries that are constrained, but
> > transitively unconstrained.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Micah Morton <mortonm@chromium.org>
> > ---
> >  security/safesetid/securityfs.c               | 21 +++++++++++++++++++
> >  .../selftests/safesetid/safesetid-test.c      |  4 +++-
> >  2 files changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
> > index 7a08fff2bc14..3ec64487f0e9 100644
> > --- a/security/safesetid/securityfs.c
> > +++ b/security/safesetid/securityfs.c
> > @@ -77,6 +77,23 @@ static void release_ruleset(struct setuid_ruleset *pol)
> >                 call_rcu(&pol->rcu, __release_ruleset);
> >  }
> >
> > +static int verify_ruleset(struct setuid_ruleset *pol)
> > +{
> > +       int bucket;
> > +       struct setuid_rule *rule;
> > +
> > +       hash_for_each(pol->rules, bucket, rule, next) {
> > +               if (_setuid_policy_lookup(pol, rule->dst_uid, INVALID_UID) ==
> > +                   SIDPOL_DEFAULT) {
> > +                       pr_warn("insecure policy rejected: uid %d is constrained but transitively unconstrained through uid %d\n",
> > +                               __kuid_val(rule->src_uid),
> > +                               __kuid_val(rule->dst_uid));
> > +                       return -EINVAL;
> > +               }
> > +       }
> > +       return 0;
> > +}
>
> Why fail open? How about having the policy automatically add the
> constraints (since the entire policy is known at verification time)?

Are you suggesting to print a warning, automatically add the
constraint, apply the policy, and still return -EINVAL? I guess that
would work.

I think it is a good idea to require userspace to explicitly write
these rules, since implicitly-added rules might make the rules harder
to understand for someone reading a policy file.

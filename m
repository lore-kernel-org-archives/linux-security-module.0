Return-Path: <SRS0=FAtl=TH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA39CC004C9
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 15:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E8320578
	for <linux-security-module@archiver.kernel.org>; Tue,  7 May 2019 15:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KaEDgFUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfEGPDT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 May 2019 11:03:19 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45642 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGPDT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 May 2019 11:03:19 -0400
Received: by mail-yw1-f65.google.com with SMTP id w18so13442747ywa.12
        for <linux-security-module@vger.kernel.org>; Tue, 07 May 2019 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KMCFDkYp6l4mLL14SUxPgXFfC0kFP2bhtZWRcCr46ck=;
        b=KaEDgFUGOS/aj4N5QGtJWMLl104Uf2Y41RpnrXDlMM48J8AqNZcWRkYrl4lGfP3qxg
         B2Fn3hsGSZrIf8ORnWcJ+D7PVXGkrahlQ53NBlYgofY7kmH0lviB9tV5my8QQsnRPOIm
         zwF9oT4OAGQfLh2NGPb/UT0pcCCSmlr7x0k0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KMCFDkYp6l4mLL14SUxPgXFfC0kFP2bhtZWRcCr46ck=;
        b=sA1JVgQxb8UpMJ0yrPeVBJyNev+O4jqkGNVZJtpWahPsiQ1ViGY9mqgfVUvn/v+A53
         0docXafsBXq76bOOhGhYEVQkMqkPSXh09kNUnYgTgRNxjyCqfVNYbp3CfD9eXikRltWn
         94/u5lMPbt/FkocSNIWgkCXdbhyQ+TVnv1FAa1Saaa5DQjB43O8pbiJ1fYb47ARJtjtg
         5JNLBxD1UL5+X9Yr1wkQRxQfsHFHX1dP9WiYGl7ABi60lmkxwbKPQcgd9+yqTPrv7A82
         v5lk5dW/M7m8QRgFWsQq8uhA5Qsfj5NDVUMscIka6fH/gnLCSJYO8iP5rRQYLraMWGej
         Fl1w==
X-Gm-Message-State: APjAAAXnnaMoSj52dmtxxzaI86aVhK6rREv0qAgLNht7KShVP0c2nhRR
        unUW55ucdA0pcmnKsXT91B7mZnU9v2BPamey7bSq7Q==
X-Google-Smtp-Source: APXvYqzHpdaxYc/Vk1hgA0kN60q1SLvCfZJRHATVvvtkpHqSenHbKGjtBPxEhKxIiamxJQ9YTrBg7EeHWZnsx/STWtI=
X-Received: by 2002:a81:3ac5:: with SMTP id h188mr1349761ywa.322.1557241397862;
 Tue, 07 May 2019 08:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190411201243.167800-1-mortonm@chromium.org> <CAGXu5jJgQME5-LRzFG1rxr5eb84-+o4HiTuPCf6PWRHWMPkagw@mail.gmail.com>
In-Reply-To: <CAGXu5jJgQME5-LRzFG1rxr5eb84-+o4HiTuPCf6PWRHWMPkagw@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Tue, 7 May 2019 08:03:07 -0700
Message-ID: <CAJ-EccNRRgh2PBqFBa4USKjRaPXWY=x3KxSU4djW18YrqThKDw@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] LSM: SafeSetID: verify transitive constrainedness
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Ready for merge.

On Thu, Apr 11, 2019 at 1:38 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Apr 11, 2019 at 1:12 PM Micah Morton <mortonm@chromium.org> wrote:
> >
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
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> -Kees
>
> > ---
> > Changes since the last patch: Instead of failing open when userspace
> > configures an unconstrained (and vulnerable) policy, fix up the policy
> > to make sure it is safe by restricting the un-constrained UIDs. Return
> > EINVAL from the policy write in the case that userspace writes an
> > unconstrained policy. Also move hash_add() into a small helper function.
> >  security/safesetid/securityfs.c               | 38 ++++++++++++++++++-
> >  .../selftests/safesetid/safesetid-test.c      |  4 +-
> >  2 files changed, 40 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
> > index 997b403c6255..d568e17dd773 100644
> > --- a/security/safesetid/securityfs.c
> > +++ b/security/safesetid/securityfs.c
> > @@ -76,6 +76,37 @@ static void release_ruleset(struct setuid_ruleset *pol)
> >         call_rcu(&pol->rcu, __release_ruleset);
> >  }
> >
> > +static void insert_rule(struct setuid_ruleset *pol, struct setuid_rule *rule)
> > +{
> > +       hash_add(pol->rules, &rule->next, __kuid_val(rule->src_uid));
> > +}
> > +
> > +static int verify_ruleset(struct setuid_ruleset *pol)
> > +{
> > +       int bucket;
> > +       struct setuid_rule *rule, *nrule;
> > +       int res = 0;
> > +
> > +       hash_for_each(pol->rules, bucket, rule, next) {
> > +               if (_setuid_policy_lookup(pol, rule->dst_uid, INVALID_UID) ==
> > +                   SIDPOL_DEFAULT) {
> > +                       pr_warn("insecure policy detected: uid %d is constrained but transitively unconstrained through uid %d\n",
> > +                               __kuid_val(rule->src_uid),
> > +                               __kuid_val(rule->dst_uid));
> > +                       res = -EINVAL;
> > +
> > +                       /* fix it up */
> > +                       nrule = kmalloc(sizeof(struct setuid_rule), GFP_KERNEL);
> > +                       if (!nrule)
> > +                               return -ENOMEM;
> > +                       nrule->src_uid = rule->dst_uid;
> > +                       nrule->dst_uid = rule->dst_uid;
> > +                       insert_rule(pol, nrule);
> > +               }
> > +       }
> > +       return res;
> > +}
> > +
> >  static ssize_t handle_policy_update(struct file *file,
> >                                     const char __user *ubuf, size_t len)
> >  {
> > @@ -128,7 +159,7 @@ static ssize_t handle_policy_update(struct file *file,
> >                         goto out_free_rule;
> >                 }
> >
> > -               hash_add(pol->rules, &rule->next, __kuid_val(rule->src_uid));
> > +               insert_rule(pol, rule);
> >                 p = end + 1;
> >                 continue;
> >
> > @@ -137,6 +168,11 @@ static ssize_t handle_policy_update(struct file *file,
> >                 goto out_free_buf;
> >         }
> >
> > +       err = verify_ruleset(pol);
> > +       /* bogus policy falls through after fixing it up */
> > +       if (err && err != -EINVAL)
> > +               goto out_free_buf;
> > +
> >         /*
> >          * Everything looks good, apply the policy and release the old one.
> >          * What we really want here is an xchg() wrapper for RCU, but since that
> > diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
> > index 4f03813d1911..8f40c6ecdad1 100644
> > --- a/tools/testing/selftests/safesetid/safesetid-test.c
> > +++ b/tools/testing/selftests/safesetid/safesetid-test.c
> > @@ -144,7 +144,9 @@ static void write_policies(void)
> >  {
> >         static char *policy_str =
> >                 "1:2\n"
> > -               "1:3\n";
> > +               "1:3\n"
> > +               "2:2\n"
> > +               "3:3\n";
> >         ssize_t written;
> >         int fd;
> >
> > --
> > 2.21.0.392.gf8f6787159e-goog
>
>
>
> --
> Kees Cook

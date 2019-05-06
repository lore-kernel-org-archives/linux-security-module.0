Return-Path: <SRS0=99o1=TG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355BAC04A6B
	for <linux-security-module@archiver.kernel.org>; Mon,  6 May 2019 23:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0727E205ED
	for <linux-security-module@archiver.kernel.org>; Mon,  6 May 2019 23:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfEFXj1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 May 2019 19:39:27 -0400
Received: from namei.org ([65.99.196.166]:37804 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbfEFXj1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 May 2019 19:39:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x46NdKhJ013606;
        Mon, 6 May 2019 23:39:20 GMT
Date:   Tue, 7 May 2019 09:39:20 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Micah Morton <mortonm@chromium.org>
cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 01/10] LSM: SafeSetID: fix pr_warn() to include newline
In-Reply-To: <CAJ-EccPz3fZXR-485szP28kTsFLN=Y6040GacxdNuSn9io-kPw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1905070939100.12945@namei.org>
References: <20190410165434.206579-1-mortonm@chromium.org> <CAGXu5jKid6ggjD7G=qLoAGdpprxQiXziKu5g=rcGw+d0sUPr9g@mail.gmail.com> <CAJ-EccPz3fZXR-485szP28kTsFLN=Y6040GacxdNuSn9io-kPw@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 6 May 2019, Micah Morton wrote:

> These 10 patches got buried, but Jann, Kees and myself are in
> agreement on how they look.
> 
> Could they get merged? Patches 8/10 and 9/10 have a v2 that should get
> merged instead of the originals. I can respond on all the patches that
> should get merged if that is helpful?

Please do so.

> 
> On Wed, Apr 10, 2019 at 10:09 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Apr 10, 2019 at 9:54 AM Micah Morton <mortonm@chromium.org> wrote:
> > >
> > > From: Jann Horn <jannh@google.com>
> > >
> > > Fix the pr_warn() calls in the SafeSetID LSM to have newlines at the end.
> > > Without this, denial messages will be buffered as incomplete lines in
> > > log_output(), and will then only show up once something else prints into
> > > dmesg.
> > >
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > Signed-off-by: Micah Morton <mortonm@chromium.org>
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> >
> > -Kees
> >
> > > ---
> > >  security/safesetid/lsm.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> > > index cecd38e2ac80..2daecab3a4c0 100644
> > > --- a/security/safesetid/lsm.c
> > > +++ b/security/safesetid/lsm.c
> > > @@ -91,7 +91,7 @@ static int safesetid_security_capable(const struct cred *cred,
> > >                          * to functionality other than calling set*uid() (e.g.
> > >                          * allowing user to set up userns uid mappings).
> > >                          */
> > > -                       pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions",
> > > +                       pr_warn("Operation requires CAP_SETUID, which is not available to UID %u for operations besides approved set*uid transitions\n",
> > >                                 __kuid_val(cred->uid));
> > >                         return -1;
> > >                 }
> > > @@ -103,7 +103,7 @@ static int check_uid_transition(kuid_t parent, kuid_t child)
> > >  {
> > >         if (check_setuid_policy_hashtable_key_value(parent, child))
> > >                 return 0;
> > > -       pr_warn("UID transition (%d -> %d) blocked",
> > > +       pr_warn("UID transition (%d -> %d) blocked\n",
> > >                 __kuid_val(parent),
> > >                 __kuid_val(child));
> > >         /*
> > > --
> > > 2.21.0.392.gf8f6787159e-goog
> > >
> >
> >
> > --
> > Kees Cook
> 

-- 
James Morris
<jmorris@namei.org>


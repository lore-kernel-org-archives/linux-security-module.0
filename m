Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF0CC433B4
	for <linux-security-module@archiver.kernel.org>; Tue,  6 Apr 2021 02:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4ADA6128B
	for <linux-security-module@archiver.kernel.org>; Tue,  6 Apr 2021 02:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239488AbhDFCmV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 5 Apr 2021 22:42:21 -0400
Received: from namei.org ([65.99.196.166]:34454 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233030AbhDFCmT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 5 Apr 2021 22:42:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 5EC70508;
        Tue,  6 Apr 2021 02:38:51 +0000 (UTC)
Date:   Tue, 6 Apr 2021 12:38:51 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Jiele Zhao <unclexiaole@gmail.com>
cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH] integrity/ima: Add declarations to init_once void
 arguments.
In-Reply-To: <f97e397d-5d9f-31c3-c027-d9b89ba9637a@gmail.com>
Message-ID: <c6fd4033-f4bb-40d2-9bd-c3f2d92c3a2a@namei.org>
References: <20210323013318.296993-1-unclexiaole@gmail.com> <f97e397d-5d9f-31c3-c027-d9b89ba9637a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 6 Apr 2021, Jiele Zhao wrote:

> Ping.

Mimi Zohar is the maintainer for this code.

> 
> On 2021/3/23 9:33, Jiele Zhao wrote:
> > init_once is a callback to kmem_cache_create. The parameter
> > type of this function is void *, so it's better to give a
> > explicit cast here.
> >
> > Signed-off-by: Jiele Zhao <unclexiaole@gmail.com>
> > ---
> >   security/integrity/iint.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> > index 1d20003243c3..5f3f2de997e1 100644
> > --- a/security/integrity/iint.c
> > +++ b/security/integrity/iint.c
> > @@ -152,7 +152,7 @@ void integrity_inode_free(struct inode *inode)
> >   
> >   static void init_once(void *foo)
> >   {
> > -	struct integrity_iint_cache *iint = foo;
> > +	struct integrity_iint_cache *iint = (struct integrity_iint_cache
> > *)foo;
> >   
> >    memset(iint, 0, sizeof(*iint));
> >    iint->ima_file_status = INTEGRITY_UNKNOWN;
> 

-- 
James Morris
<jmorris@namei.org>


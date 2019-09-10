Return-Path: <SRS0=YGRx=XF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84054C49ED7
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Sep 2019 15:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665E5208E4
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Sep 2019 15:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfIJPRv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:17:51 -0400
Received: from namei.org ([65.99.196.166]:43666 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfIJPRu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Sep 2019 11:17:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x8AFHQtv003782;
        Tue, 10 Sep 2019 15:17:26 GMT
Date:   Tue, 10 Sep 2019 08:17:26 -0700 (PDT)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <mjg59@google.com>
cc:     Ben Hutchings <ben@decadent.org.uk>,
        LSM List <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Joern Engel <joern@lazybastard.org>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 2/2] mtd: phram,slram: Disable when the kernel is locked
 down
In-Reply-To: <CACdnJuutzv+0nPKeizsiaix5YtYHU4RSoH-hPFfG1Z8sW_yy2w@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1909100816170.3709@namei.org>
References: <20190830154549.vss6h5tlrl6d5r5y@decadent.org.uk> <20190830154720.eekfjt6c4jzvlbfz@decadent.org.uk> <CACdnJuutzv+0nPKeizsiaix5YtYHU4RSoH-hPFfG1Z8sW_yy2w@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 10 Sep 2019, Matthew Garrett wrote:

> On Fri, Aug 30, 2019 at 11:47 AM Ben Hutchings <ben@decadent.org.uk> wrote:
> >
> > These drivers allow mapping arbitrary memory ranges as MTD devices.
> > This should be disabled to preserve the kernel's integrity when it is
> > locked down.
> >
> > * Add the HWPARAM flag to the module parameters
> > * When slram is built-in, it uses __setup() to read kernel parameters,
> >   so add an explicit check security_locked_down() check
> >
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > Cc: Matthew Garrett <mjg59@google.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Joern Engel <joern@lazybastard.org>
> > Cc: linux-mtd@lists.infradead.org
> 
> Reviewed-by: Matthew Garrett <mjg59@google.com>
> 
> James, should I pick patches like this up and send them to you, or
> will you queue them directly after they're acked?

As long as I'm on the to or cc when they're acked, I can grab them.


-- 
James Morris
<jmorris@namei.org>


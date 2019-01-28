Return-Path: <SRS0=3eDG=QE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452E3C282C8
	for <linux-security-module@archiver.kernel.org>; Mon, 28 Jan 2019 20:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFAD214DA
	for <linux-security-module@archiver.kernel.org>; Mon, 28 Jan 2019 20:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfA1UKC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:10:02 -0500
Received: from namei.org ([65.99.196.166]:48776 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfA1UKC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 28 Jan 2019 15:10:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x0SK9gqS009250;
        Mon, 28 Jan 2019 20:09:42 GMT
Date:   Tue, 29 Jan 2019 07:09:42 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Micah Morton <mortonm@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] LSM: add SafeSetID module that gates setid
 calls
In-Reply-To: <CAGXu5jKLdcadm30NwpquX1iGJRsjZY-A5grc65BC64B96RE_Eg@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1901290709140.8613@namei.org>
References: <CAGXu5j+V61YOk7oAEw3Fm5rOxQAmy2-3QqOZaOP_FROLBUk2Qg@mail.gmail.com> <20190116154606.92331-1-mortonm@chromium.org> <alpine.LRH.2.21.1901260714380.27585@namei.org> <CAJ-EccMc3Xz0DZAm_u09VvTzWRzhrf9x0SpJKX=4FR6NYwqkpQ@mail.gmail.com>
 <CAJ-EccMAb-OX3R6mk4me0x6dS2bQw=yZrpKmF7JpzHDWSX5e4g@mail.gmail.com> <CAGXu5jKLdcadm30NwpquX1iGJRsjZY-A5grc65BC64B96RE_Eg@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 29 Jan 2019, Kees Cook wrote:

> On Tue, Jan 29, 2019 at 8:47 AM Micah Morton <mortonm@chromium.org> wrote:
> >
> > I'm getting the following crash when booting after compiling a kernel
> > with this LSM enabled, so I'll have to figure out what is going on.
> > All the "core" functionality of this LSM has been tested thoroughly
> > (we're already using this LSM on ChromeOS), but looks like there's
> > some debugging of the initialization that still needs to be done.
> 
> 
> +DEFINE_LSM(safesetid_security_init) = {
> +       .init = safesetid_security_init,
> +};
> 
> I think this is from not having:
> 
> .name = "safesetid",
> 
> I missed that in the review, sorry!

Weird, I booted my system with safesetid stacked and it seemed to work.

-- 
James Morris
<jmorris@namei.org>


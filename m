Return-Path: <SRS0=hRTQ=QH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1735C282D8
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Jan 2019 00:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F19420B1F
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Jan 2019 00:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Wz22tAox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfAaA2p (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 30 Jan 2019 19:28:45 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35562 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbfAaA2o (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Jan 2019 19:28:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 195A58EE232;
        Wed, 30 Jan 2019 16:28:44 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k5-3HNxwWhHz; Wed, 30 Jan 2019 16:28:43 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 745768EE0E9;
        Wed, 30 Jan 2019 16:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1548894523;
        bh=pCnL6WVUwxoGCZa/2ue3qx7ky3kdOP0WgfifLCY8uaU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Wz22tAoxw2w8PTfK1sTIhXN3dGUYXQfy42lNp9+nxyW5+BT+0uw+DkMequfUIK349
         3uLuyHhLs4nFBU51DFr18dyrmAG7hSI9z5KePT66W/XS44Hsc+ZIHIVySAwJRy8tmh
         NcUHh/1XfLf+8HTwEjNbknD0GsmD3dSg8VqG4E/Q=
Message-ID: <1548894522.2774.28.camel@HansenPartnership.com>
Subject: Re: [PATCH v10 00/17] Remove nested TPM operations
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Date:   Wed, 30 Jan 2019 16:28:42 -0800
In-Reply-To: <20190129123111.GA12883@linux.intel.com>
References: <20190116212342.24524-1-jarkko.sakkinen@linux.intel.com>
         <20190123182057.GA24212@linux.intel.com>
         <37e53df5-4a25-fce2-d3bf-016669d0a383@linux.ibm.com>
         <20190129123111.GA12883@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 2019-01-29 at 14:31 +0200, Jarkko Sakkinen wrote:
> On Wed, Jan 23, 2019 at 01:53:44PM -0500, Stefan Berger wrote:
> > On 1/23/19 1:20 PM, Jarkko Sakkinen wrote:
> > > On Wed, Jan 16, 2019 at 11:23:25PM +0200, Jarkko Sakkinen wrote:
> > > > Make the changes necessary to detach TPM space code and TPM
> > > > activation
> > > > code out of the tpm_transmit() flow because of both of these
> > > > can cause
> > > > nested tpm_transmit() calls. The nesteds calls make the whole
> > > > flow hard
> > > > to maintain, and thus, it is better to just fix things now
> > > > before this
> > > > turns into a bigger mess.
> > > 
> > > Any reasons not to merge this soon?
> > 
> > I suppose v10 hasn't changed anything signinficat. So, not from my
> > perspective. Were you waiting for more Reviewed-by's?
> 
> Yeah, for example TPM space touching changes would be good to peer
> check with James. I could have easily forgotten some implementation
> detail, and it has been very stable piece off code, so don't want
> to break it. Guess won't yet try to put this v5.1.

So the implementation detail I was looking for: internal kernel use of
tpm_transmit_cmd() without tpm_find/try_get_ops() doesn't seem to
exist, so I think this is all safe.  You can add my

Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>

But I've got to say I can't test this yet because you've made a huge
problem for me in the tpm security patches: they introduce a kernel
space which now becomes somewhat problematic because the space handling
moved into the device common code.  To get both these things to work
together so I can test it, space handling is going to have to come
slightly down from device common code so the kernel can use it.

James


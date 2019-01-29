Return-Path: <SRS0=8CgQ=QF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E362C282D0
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Jan 2019 19:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D299F21873
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Jan 2019 19:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="sY8NzhTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfA2TCW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:02:22 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47326 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726910AbfA2TCV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 Jan 2019 14:02:21 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2AC698EE241;
        Tue, 29 Jan 2019 11:02:21 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4lByKAlhP_Qd; Tue, 29 Jan 2019 11:02:21 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8A6348EE0EF;
        Tue, 29 Jan 2019 11:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1548788540;
        bh=sGgVNKIRkFO29u0w1QAQWSEd7Z+WCf91+Wtl85Sx6yw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sY8NzhToUuucFibbuUqEc4b8UcTh/ngJK9xeHkNAvIIduvrWaXzLwiIKVH432uIrC
         YudbhdtUfQiiyPHTeeL0EjnLlxyca8YeW/lXTi49aiej4umemq1xNvBHNdu99u8kum
         Uyg2o8VPPaeIF0hZNYHjUmshfiRsz0w36kSSICOo=
Message-ID: <1548788539.2888.40.camel@HansenPartnership.com>
Subject: Re: [PATCH v10 08/17] tpm: call tpm2_flush_space() on error in
 tpm_try_transmit()
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, stable@vger.kernel.org
Date:   Tue, 29 Jan 2019 11:02:19 -0800
In-Reply-To: <20190129185330.GA11615@linux.intel.com>
References: <20190116212342.24524-1-jarkko.sakkinen@linux.intel.com>
         <20190116212342.24524-9-jarkko.sakkinen@linux.intel.com>
         <1548781561.2888.33.camel@HansenPartnership.com>
         <20190129185330.GA11615@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 2019-01-29 at 20:53 +0200, Jarkko Sakkinen wrote:
> On Tue, Jan 29, 2019 at 09:06:01AM -0800, James Bottomley wrote:
> > On Wed, 2019-01-16 at 23:23 +0200, Jarkko Sakkinen wrote:
> > [...]
> > > -	rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
> > > +out_space:
> > > +	if (rc)
> > > +		tpm2_flush_space(chip);
> > > +	else
> > > +		rc = tpm2_commit_space(chip, space, ordinal,
> > > buf,
> > > &len);
> > 
> > I don't think this is quite right.  tpm2_flush_space only flushes
> > the handles it knows about and those are the ones from before the
> > TPM operation was attempted.  If the operation has altered the
> > internal state we could miss a created handle in this flush and it
> > would effectively reside forever in the TPM.  We should be able to
> > rely on the TPM preserving the original state if it returns an
> > error, so I think your patch works for that part.  However rc is
> > also set to -EFAULT on a transmission error and if that's on the
> > receive path, the TPM may have changed state before the error
> > occurred.
> 
> If TPM is working properly in the first place, tpm2_commit_space() is
> always called (e.g. in a situation where TPM gives a TPM error). Your
> deduction about the opposite is absolutely correct. Thanks!
> 
> > If the object is to move the TPM back to where it was before the
> > error occurred, even in the case of transmit errors, then I think
> > we need to invent a new kind of flush that queries the current TPM
> > state and then flushes everything.
> 
> I think this consideration is anyway out of scope for this patch set.

I certainly agree the problem existed before and this makes it no
worse.

> I'd hope you would also skim through v11 as soon as I get it
> prepared, at least the patches where I've added an explicit CC (one
> or two at most).

Sure, as you can see, I'm up to 8.  I'll complete the review and then
set up an environment to test.

James


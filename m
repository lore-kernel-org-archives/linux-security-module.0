Return-Path: <SRS0=JlTe=NE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BC4C7112C
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Oct 2018 07:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245D62054F
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Oct 2018 07:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="C3CxSR8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245D62054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbeJXQBP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:01:15 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44352 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729270AbeJXQBO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 Oct 2018 12:01:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 03C458EE0FC;
        Wed, 24 Oct 2018 00:34:21 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ToS0c27r9bkG; Wed, 24 Oct 2018 00:34:20 -0700 (PDT)
Received: from [172.20.48.127] (unknown [62.232.21.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9BD918EE0D5;
        Wed, 24 Oct 2018 00:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1540366460;
        bh=f+zD7rXLLeR1ZNTbr6w5cbC2KliS/Np32mQZn0QV1Ek=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=C3CxSR8nPZOPgQh6eR6QWKv1z2CCkidAbWB0qNu4PJ/2+RqTD7/U3iK+9nXl9/R1v
         BhG0FesEWCm5jgBDw7IP4q2IuaJe/+QlymePeGy/ulKvEw4Q+ZQcDjDu+4yLEfJK1p
         SRv825uwZs2iUQQjAOBJwUu9hsshYu7SvcfuK5pM=
Message-ID: <1540366456.3008.8.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 0/7] add integrity and security to TPM2 transactions
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ken Goldman <kgold@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 24 Oct 2018 08:34:16 +0100
In-Reply-To: <alpine.DEB.2.21.1810240303560.8524@jsakkine-mobl1>
References: <1540193596.3202.7.camel@HansenPartnership.com>
         <a8a69222-94fb-7406-d9b2-207079727eb8@linux.ibm.com>
         <alpine.DEB.2.21.1810240303560.8524@jsakkine-mobl1>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2018-10-24 at 03:06 +0300, Jarkko Sakkinen wrote:
> On Mon, 22 Oct 2018, Ken Goldman wrote:
> > Does this design assume that there was at time zero no monitoring?
> > This would permit some shared secret to be established.
> > 
> > Or does it assume that the interception may have been present from
> > the first boot?  If so, how is the first shared secret established.
> > Salting using the EK is the usual method, but this requires walking
> > the EK certificate chain and embedding the TPM vendor CA
> > certificates in the kernel.
> 
> Kernel gets the public portion EK and uses its own key pair in its
> own end so everything should be good, right?

Only if we pass it in.  The kernel can't run an X509 proof on the EK
certificate, which is how you verify the EK:  Usually the X509 cert is
RSA, and for speed and efficiency we're salting with Elliptic Curve
keys, so we'd have to derive the RSA EK primary (which can take up to
60 seconds), verify the same public key as the cert and then chain up
to the manufacturer. Then we'd have to use the RSA keys (so a lot more
code) because we can't trust the TPM not to lie about the RSA public
key but then substitute it's own EC primary. We really don't want to be
trying to do all that on boot.

James


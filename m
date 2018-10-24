Return-Path: <SRS0=JlTe=NE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D374C7112C
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Oct 2018 07:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9572082E
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Oct 2018 07:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="T0ctMPlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9572082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeJXQKY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:10:24 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44514 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726808AbeJXQKX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 Oct 2018 12:10:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2D3B08EE0FC;
        Wed, 24 Oct 2018 00:43:27 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id C4EJOK8R1eNM; Wed, 24 Oct 2018 00:43:27 -0700 (PDT)
Received: from [172.20.48.127] (unknown [62.232.21.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E42488EE0D5;
        Wed, 24 Oct 2018 00:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1540367006;
        bh=yHFd30+t61TfZE0DT8WeA5LaZDGBt/AlPt7LftH9mK4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=T0ctMPlmRRFVv8KB0Bqrh+uTDAhCn75KEEPmAcFUfrlc3f4ef7h/adrIT8lfUxuuF
         m/0AEG1yJ+EBoYyBeMEG2y/gpffcPj/UAKSBxt/ybm1doJmXPSAd4i4Ad7AsS+B8nU
         KJMbSjq6pVWkCm3SALoi8D2Af4RjX9Q2pQf+3bPk=
Message-ID: <1540367003.3008.13.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 0/7] add integrity and security to TPM2 transactions
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 24 Oct 2018 08:43:23 +0100
In-Reply-To: <alpine.DEB.2.21.1810240249180.8524@jsakkine-mobl1>
References: <1540193596.3202.7.camel@HansenPartnership.com>
         <alpine.DEB.2.21.1810240249180.8524@jsakkine-mobl1>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2018-10-24 at 02:51 +0300, Jarkko Sakkinen wrote:
> I would consider sending first a patch set that would iterate the
> existing session stuff to be ready for this i.e. merge in two
> iterations (emphasis on the word "consider"). We can probably merge
> the groundwork quite fast.

I realise we're going to have merge conflicts on the later ones, so why
don't we do this: I'll still send as one series, but you apply the ones
you think are precursors and I'll rebase and resend the rest?

James


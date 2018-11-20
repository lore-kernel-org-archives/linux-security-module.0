Return-Path: <SRS0=2Rj0=N7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90585C41536
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 17:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5311720685
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 17:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="CMQZ/mWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5311720685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbeKUDxR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:53:17 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:40242 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726314AbeKUDxR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Nov 2018 22:53:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1B04D8EE2C9;
        Tue, 20 Nov 2018 09:23:03 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZA-o-x5Y_XQc; Tue, 20 Nov 2018 09:23:02 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8EBDA8EE0E2;
        Tue, 20 Nov 2018 09:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1542734582;
        bh=si7Q+/Idyh/IgNmlKFdxfBYyRSbutJ5CCa3YXzAI5eQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CMQZ/mWtXMPCUZquG+RuPs+GunS59shiWSMxQLNZ7rDaoc4APd5Dpvs3YCssGZ01w
         fKs/2Pf3g2i9MgWmKhXV4NIZKeM0Vq9x66ZFRVRSd4CwuzLmv9VXTZIA5WZhS9iE7v
         xcfRcZPfKuj82Ft/2YtXojXcDiZrGnotupOJzSe4=
Message-ID: <1542734581.2814.28.camel@HansenPartnership.com>
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of
 bus interposer attacks
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, monty.wiseman@ge.com,
        Monty Wiseman <montywiseman32@gmail.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Tue, 20 Nov 2018 09:23:01 -0800
In-Reply-To: <20181120111049.GC14594@linux.intel.com>
References: <1542648844.2910.9.camel@HansenPartnership.com>
         <20181120111049.GC14594@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 2018-11-20 at 13:10 +0200, Jarkko Sakkinen wrote:
[...]
> This is basically rewrite of TPM genie paper with extras. just
> shorten it to include the proposed architecture and point to the TPM
> Genie paper (which is not in the references at all ATM).

I really don't think so.  The paper only gives details of bound
authorization sessions for TPM 2.0 which suffer from no to weak entropy
problems.  The reason for using salted ones in the document, which
aren't mentioned at all in the genie paper, is so we have a high
entropy cryptographically unguessable HMAC and encryption key.

> The way I see it the data validation is way more important than
> protecting against physical interposer to be frank.
> 
> The attack scenario would require to open the damn device.

Yes (well, currently).

>  For laptop that would leave physical marks (i.e. evil maid).

Only if you have some type of security seal, which most laptops don't
have.

James

>  In a data center with armed guards I would wish you good luck
> accomplishing it. It is not anything like sticking a USB stick and
> run.
> 
> We can take a fix into Linux with a clean implementation but it needs
> to be an opt-in feature because not all users will want to use it.
> 
> /Jarkko
> 


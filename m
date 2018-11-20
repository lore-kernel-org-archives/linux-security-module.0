Return-Path: <SRS0=2Rj0=N7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE80AC46463
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 17:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F03206BA
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 17:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="dhF9sb9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F03206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeKUD4E (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:56:04 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:40464 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726314AbeKUD4E (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Nov 2018 22:56:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 512B38EE2C9;
        Tue, 20 Nov 2018 09:25:48 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IAx1oehFcc1B; Tue, 20 Nov 2018 09:25:48 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 932CA8EE0E2;
        Tue, 20 Nov 2018 09:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1542734747;
        bh=UsKG8+AvocsLKzxA9JE3sUkBRkDgvxU4uBh3lbBVHIk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dhF9sb9FhLRfivUnOxtt7hh5FM0YuRumUZOPoUj56Xx9lqvC06ZzvJfp/SBOt90Go
         RZQ27jgb4BZLKakSi4c5we1YjXOtbR+k2BDFOIdZRR7mYRbALwr84RL/+DZraMSztM
         lUQMtcli/8fVx6aJK+H+Rd2CjIN/hKvcyGy/nRfA=
Message-ID: <1542734743.2814.31.camel@HansenPartnership.com>
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of
 bus interposer attacks
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, monty.wiseman@ge.com,
        Monty Wiseman <montywiseman32@gmail.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Tue, 20 Nov 2018 09:25:43 -0800
In-Reply-To: <20181120124116.GA8813@linux.intel.com>
References: <1542648844.2910.9.camel@HansenPartnership.com>
         <20181120111049.GC14594@linux.intel.com>
         <20181120124116.GA8813@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 2018-11-20 at 14:41 +0200, Jarkko Sakkinen wrote:
> On Tue, Nov 20, 2018 at 01:10:49PM +0200, Jarkko Sakkinen wrote:
> > This is basically rewrite of TPM genie paper with extras. Maybe
> > just shorten it to include the proposed architecture and point to
> > the TPM Genie paper (which is not in the references at all ATM).
> > 
> > The way I see it the data validation is way more important than
> > protecting against physical interposer to be frank.
> > 
> > The attack scenario would require to open the damn device. For
> > laptop that would leave physical marks (i.e. evil maid). In a data
> > center with armed guards I would wish you good luck accomplishing
> > it. It is not anything like sticking a USB stick and run.
> > 
> > We can take a fix into Linux with a clean implementation but it
> > needs to be an opt-in feature because not all users will want to
> > use it.
> 
> Someone (might have been either Mimi or David Howells but cannot
> recall) correctly pointed out at LSS 2018 that you could just as
> easily spy and corrupt RAM if you have a time window to perform this
> type of attack.

Not using the simple plug in on the TPM bus, you can't.  The point is
basically the difference in the technology: the interposer is a simple,
easy to construct, plugin; a RAM spy is a huge JTAG thing that would be
hard even to fit into a modern thin laptop, let alone extremely
difficult to build.

James


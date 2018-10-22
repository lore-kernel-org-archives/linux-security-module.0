Return-Path: <SRS0=zjoR=NC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52A5C67863
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Oct 2018 15:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED50120652
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Oct 2018 15:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="g+9Yh07c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED50120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeJWAOR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Oct 2018 20:14:17 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:54738 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727669AbeJWAOR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Oct 2018 20:14:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 35DEE8EE0FC;
        Mon, 22 Oct 2018 08:55:12 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1RE8DB8JGEWk; Mon, 22 Oct 2018 08:55:12 -0700 (PDT)
Received: from [172.22.37.2] (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EA0FE8EE0BA;
        Mon, 22 Oct 2018 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1540223711;
        bh=aa94wY18R6VKxkBibhvOoaJ6Zvo/8Fq5Y3kOVC2c7JA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g+9Yh07ciOZ7IyyabxQzjai16qkZwo5YrbTR0mwtFkLXOISbO/h72Yg1tdVWV6WEx
         UljTrB+cw8s1lEMIQ+R75CBXLaTgUzITL11djvIUaNeCLCbhvxjpMgxAKn+lNKUpcP
         MECAvZAOy5129CMRW/s3ypm0mi+fB5/UA6xoPtVU=
Message-ID: <1540223708.3012.19.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 0/7] add integrity and security to TPM2 transactions
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ken Goldman <kgold@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 22 Oct 2018 16:55:08 +0100
In-Reply-To: <e773aafe-4b12-775c-9df9-0e747880a35f@linux.ibm.com>
References: <1540193596.3202.7.camel@HansenPartnership.com>
         <a8a69222-94fb-7406-d9b2-207079727eb8@linux.ibm.com>
         <1540217887.3012.14.camel@HansenPartnership.com>
         <e773aafe-4b12-775c-9df9-0e747880a35f@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 2018-10-22 at 11:50 -0400, Ken Goldman wrote:
> On 10/22/2018 10:18 AM, James Bottomley wrote:
> > > 1 - Any policy that requires a password (policypassword) can
> > > substitute
> > > an HMAC (policyauthvalue) at the callers discretion.  They result
> > > in the same policy digest.
> > 
> > Right but this requires the co-operation of the policy handle
> > creator, so it's an API change.
> > 
> 
> In case it wasn't clear:  The choice is not made at the time the
> policy is calculated, nor is it made at startauthsession (when
> the policy is created).
> 
> The choice is made when the policy is being satisfied.
> 
> policypassword tells the TPM to expect a plaintext password, while
> policyauthvalue tells the TPM to expect an HMAC.
> 
> It's subtle that either policy command results in the same policy
> digest.

I understand, but the API just has a policy handle from a fully
constructed policy passed in.  There's no way to deconstruct this even
to know if it has auth requirements and what type.  To get that info we
 have to see the policy commands that go into building up the policy
session ... this means the API needs to change.

James


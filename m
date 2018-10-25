Return-Path: <SRS0=wXFO=NF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C91ECDE46
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Oct 2018 15:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E5020834
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Oct 2018 15:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E5020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeJZAQF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:16:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:26201 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbeJZAQF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Oct 2018 20:16:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 08:42:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,424,1534834800"; 
   d="scan'208";a="268748510"
Received: from mstribae-mobl.ger.corp.intel.com ([10.249.254.38])
  by orsmga005.jf.intel.com with ESMTP; 25 Oct 2018 08:42:41 -0700
Date:   Thu, 25 Oct 2018 16:42:40 +0100 (IST)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v4 0/7] add integrity and security to TPM2 transactions
In-Reply-To: <1540367003.3008.13.camel@HansenPartnership.com>
Message-ID: <alpine.DEB.2.21.1810251640340.4065@jsakkine-mobl1>
References: <1540193596.3202.7.camel@HansenPartnership.com>  <alpine.DEB.2.21.1810240249180.8524@jsakkine-mobl1> <1540367003.3008.13.camel@HansenPartnership.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 24 Oct 2018, James Bottomley wrote:
> On Wed, 2018-10-24 at 02:51 +0300, Jarkko Sakkinen wrote:
>> I would consider sending first a patch set that would iterate the
>> existing session stuff to be ready for this i.e. merge in two
>> iterations (emphasis on the word "consider"). We can probably merge
>> the groundwork quite fast.
>
> I realise we're going to have merge conflicts on the later ones, so why
> don't we do this: I'll still send as one series, but you apply the ones
> you think are precursors and I'll rebase and resend the rest?
>
> James

Works for me and now I think after yesterdays dicussions etc. that this
should be merged as one series.

/Jarkko

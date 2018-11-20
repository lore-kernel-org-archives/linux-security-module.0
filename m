Return-Path: <SRS0=2Rj0=N7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E81C41537
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 23:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4132147A
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 23:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4132147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbeKUJoF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Nov 2018 04:44:05 -0500
Received: from mga11.intel.com ([192.55.52.93]:6210 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbeKUJoF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Nov 2018 04:44:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 15:12:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,258,1539673200"; 
   d="scan'208";a="106326623"
Received: from drhumphr-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.165])
  by fmsmga002.fm.intel.com with ESMTP; 20 Nov 2018 15:12:23 -0800
Date:   Wed, 21 Nov 2018 01:12:22 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, monty.wiseman@ge.com,
        Monty Wiseman <montywiseman32@gmail.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of bus
 interposer attacks
Message-ID: <20181120231222.GH8391@linux.intel.com>
References: <1542648844.2910.9.camel@HansenPartnership.com>
 <20181120111049.GC14594@linux.intel.com>
 <1542734581.2814.28.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542734581.2814.28.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Nov 20, 2018 at 09:23:01AM -0800, James Bottomley wrote:
> On Tue, 2018-11-20 at 13:10 +0200, Jarkko Sakkinen wrote:
> [...]
> > This is basically rewrite of TPM genie paper with extras. just
> > shorten it to include the proposed architecture and point to the TPM
> > Genie paper (which is not in the references at all ATM).
> 
> I really don't think so.  The paper only gives details of bound
> authorization sessions for TPM 2.0 which suffer from no to weak entropy
> problems.  The reason for using salted ones in the document, which
> aren't mentioned at all in the genie paper, is so we have a high
> entropy cryptographically unguessable HMAC and encryption key.

Point taken.

I will re-read the paper with care as soon as I have time and give
better feedback.

> Only if you have some type of security seal, which most laptops don't
> have.

Agreed went over the top on this one.

/Jarkko

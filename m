Return-Path: <SRS0=2Rj0=N7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98344C4161B
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 23:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C662147D
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 23:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C662147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbeKUKYi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:24:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:24852 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbeKUKYi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Nov 2018 05:24:38 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 15:52:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,259,1539673200"; 
   d="scan'208";a="92735573"
Received: from drhumphr-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.165])
  by orsmga006.jf.intel.com with ESMTP; 20 Nov 2018 15:52:46 -0800
Date:   Wed, 21 Nov 2018 01:52:45 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, monty.wiseman@ge.com,
        Monty Wiseman <montywiseman32@gmail.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of bus
 interposer attacks
Message-ID: <20181120235245.GK8391@linux.intel.com>
References: <1542658839.2910.32.camel@HansenPartnership.com>
 <20181119211911.GH4890@ziepe.ca>
 <1542663281.2910.44.camel@HansenPartnership.com>
 <20181119214426.GK4890@ziepe.ca>
 <1542666988.2910.49.camel@HansenPartnership.com>
 <20181119230826.GN4890@ziepe.ca>
 <1542675272.2910.63.camel@HansenPartnership.com>
 <20181120030556.GP4890@ziepe.ca>
 <1542734279.2814.23.camel@HansenPartnership.com>
 <20181120213345.GC22023@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120213345.GC22023@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Nov 20, 2018 at 02:33:45PM -0700, Jason Gunthorpe wrote:
> So it really is essential that all steps, including the BIOS use
> secure PCR updates, or you may as well not bother in Linux, at least
> for security reasons.
> 
> And I think you were on the right track, the TPM should have a
> per-boot authorization that flows through all layers of the TPM stack
> and guarantees the TPM hasn't been rebooted and with crypto prevents
> lost PCR updates. 
> 
> But that does require standardization, as we do need the BIOS to
> participate.

These talks were already started before LSS 2018 on chat session.
The idea would be to promote the same approach for BIOS.

I see what James is doing a piece, not a full solution but you
have to start from somewhere.

As an opt-in feature it should be ok.

/Jarkko

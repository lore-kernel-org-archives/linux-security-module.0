Return-Path: <SRS0=2Rj0=N7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D930C43610
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 23:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8ED82147A
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 23:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8ED82147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeKUKNr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:13:47 -0500
Received: from mga11.intel.com ([192.55.52.93]:8442 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbeKUKNq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Nov 2018 05:13:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 15:42:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,258,1539673200"; 
   d="scan'208";a="93640167"
Received: from drhumphr-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.165])
  by orsmga008.jf.intel.com with ESMTP; 20 Nov 2018 15:41:57 -0800
Date:   Wed, 21 Nov 2018 01:41:56 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, monty.wiseman@ge.com,
        Monty Wiseman <montywiseman32@gmail.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of bus
 interposer attacks
Message-ID: <20181120234156.GJ8391@linux.intel.com>
References: <20181119200505.GF4890@ziepe.ca>
 <1542658839.2910.32.camel@HansenPartnership.com>
 <20181119211911.GH4890@ziepe.ca>
 <1542663281.2910.44.camel@HansenPartnership.com>
 <20181119214426.GK4890@ziepe.ca>
 <1542666988.2910.49.camel@HansenPartnership.com>
 <20181119230826.GN4890@ziepe.ca>
 <1542675272.2910.63.camel@HansenPartnership.com>
 <20181120030556.GP4890@ziepe.ca>
 <1542734279.2814.23.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542734279.2814.23.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Nov 20, 2018 at 09:17:59AM -0800, James Bottomley wrote:
> OK, the TPM is supposed to provide attestation of the correct
> environment on a device under someone else's control (the classic
> example is laptop provided by a company to an employee).  The device is
> under the physical control of the entity you don't entirely trust so
> the TPM is supposed to attest that they're running an approved OS ...
> we have whole TCG specs for that situation.

For me the classic scenario would be more like protecting the employee
that you have given confidential data from 3rd party adversaries.  If an
employee that you get confidential data is in fact an adversary, you are
screwed. Even if the device is untampered.

Having less likely untampered device would still be for better direction
against 3rd party adversaries but alone this does not really solve the
puzzle.

There are technologies like ARM TZ and Intel SGX to provide more secure
host side. But if you have such technologies available you can use them
to run the whole TPM and the problem is solved (at least TZ is used for
this today and you could use SGX to do the same).

/Jarkko

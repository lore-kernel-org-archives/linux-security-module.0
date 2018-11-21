Return-Path: <SRS0=9590=OA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E39C04EBA
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Nov 2018 07:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0B02147D
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Nov 2018 07:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA0B02147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeKURvp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Nov 2018 12:51:45 -0500
Received: from mga11.intel.com ([192.55.52.93]:39685 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbeKURvp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Nov 2018 12:51:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 23:18:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,260,1539673200"; 
   d="scan'208";a="110065019"
Received: from ncanderx-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.86])
  by orsmga001.jf.intel.com with ESMTP; 20 Nov 2018 23:18:21 -0800
Date:   Wed, 21 Nov 2018 09:18:19 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, monty.wiseman@ge.com,
        Monty Wiseman <montywiseman32@gmail.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of bus
 interposer attacks
Message-ID: <20181121071819.GD3640@linux.intel.com>
References: <1542648844.2910.9.camel@HansenPartnership.com>
 <20181120111049.GC14594@linux.intel.com>
 <20181120124116.GA8813@linux.intel.com>
 <1542734743.2814.31.camel@HansenPartnership.com>
 <20181120231320.GI8391@linux.intel.com>
 <20181121054201.GB17002@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121054201.GB17002@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Nov 20, 2018 at 10:42:01PM -0700, Jason Gunthorpe wrote:
> > Why you wouldn't use DMA to spy the RAM?
> 
> The platform has to use IOMMU to prevent improper DMA access from
> places like PCI-E slots if you are using measured boot and want to
> defend against HW tampering.

Yes. This is what I wanted to point out. Windows 10 has VBS to
achieve something like this.

https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-vbs

> The BIOS has to sequence things so that at least pluggable PCI-E slots
> cannot do DMA until the IOMMU is enabled.

Yep.

> Honestly not sure if we do this all correctly in Linux, or if BIOS
> vendors even implemented this level of protection. The BIOS would have
> to leave the PCI-E root port slots disabled, and configure the ports
> to reject config TLPs from the hostile PCI-E device, and probably a
> big bunch of other stuff.. Then Linux would have to enable the IOMMU
> and then enable the PCI-E ports for operation.

Linux should have something like VBS. Like James' proposal it does not
solve the puzzle but is one step forward...

> Pretty subtle and tricky stuff.
> 
> Without IOMMU it would be trivial to plug a card in an open PCI-E slot
> (or M.2 slot on a laptop) and breach all measured boot guarantees via
> DMA. For instance, if IOMMU is not enabled during grub then I could
> overwrite the trusted grub with DMA and cleverly make it jump to my
> hostile code, then I can replay PCR extends to the TPM and
> seal/unseal/attest using the PCRs set to a trusted sytem when running
> hostile code. Oopsie.
> 
> This is a much easier attack than inserting a TPM interposer or
> messing with the TPM reset line...
> 
> But again, measured boot does not protect against HW tampering, so
> this is probably not included in the threat model the BIOS uses...

/Jarkko

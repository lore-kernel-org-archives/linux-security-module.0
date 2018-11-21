Return-Path: <SRS0=9590=OA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2828FC43441
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Nov 2018 09:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4A321479
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Nov 2018 09:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4A321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbeKUTsX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:48:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:7169 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726665AbeKUTsW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Nov 2018 14:48:22 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 01:14:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,260,1539673200"; 
   d="scan'208";a="88095330"
Received: from ncanderx-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.86])
  by fmsmga008.fm.intel.com with ESMTP; 21 Nov 2018 01:14:37 -0800
Date:   Wed, 21 Nov 2018 11:14:35 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, monty.wiseman@ge.com,
        Monty Wiseman <montywiseman32@gmail.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of bus
 interposer attacks
Message-ID: <20181121091435.GA10223@linux.intel.com>
References: <1542648844.2910.9.camel@HansenPartnership.com>
 <20181120111049.GC14594@linux.intel.com>
 <20181120124116.GA8813@linux.intel.com>
 <1542734743.2814.31.camel@HansenPartnership.com>
 <20181120231320.GI8391@linux.intel.com>
 <20181121054201.GB17002@ziepe.ca>
 <20181121071819.GD3640@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121071819.GD3640@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 21, 2018 at 09:18:19AM +0200, Jarkko Sakkinen wrote:
> On Tue, Nov 20, 2018 at 10:42:01PM -0700, Jason Gunthorpe wrote:
> > > Why you wouldn't use DMA to spy the RAM?
> > 
> > The platform has to use IOMMU to prevent improper DMA access from
> > places like PCI-E slots if you are using measured boot and want to
> > defend against HW tampering.
> 
> Yes. This is what I wanted to point out. Windows 10 has VBS to
> achieve something like this.
> 
> https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-vbs

Some trials like Qubes are in existence (uses Xen).

I've been thinking should Linux have a thin hypervisor solely for VBS
like use in order to gain wider adoption.

/Jarkko

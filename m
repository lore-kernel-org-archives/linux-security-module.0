Return-Path: <SRS0=hRTQ=QH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89325C282DA
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Jan 2019 16:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628D72085B
	for <linux-security-module@archiver.kernel.org>; Thu, 31 Jan 2019 16:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfAaQMK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:12:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:46539 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388082AbfAaQMK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 Jan 2019 11:12:10 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 08:12:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="112664329"
Received: from rkazants-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.254.212])
  by orsmga006.jf.intel.com with ESMTP; 31 Jan 2019 08:11:56 -0800
Date:   Thu, 31 Jan 2019 18:11:55 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v10 00/17] Remove nested TPM operations
Message-ID: <20190131161155.GF5629@linux.intel.com>
References: <20190116212342.24524-1-jarkko.sakkinen@linux.intel.com>
 <20190123182057.GA24212@linux.intel.com>
 <37e53df5-4a25-fce2-d3bf-016669d0a383@linux.ibm.com>
 <20190129123111.GA12883@linux.intel.com>
 <1548894522.2774.28.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548894522.2774.28.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jan 30, 2019 at 04:28:42PM -0800, James Bottomley wrote:
> On Tue, 2019-01-29 at 14:31 +0200, Jarkko Sakkinen wrote:
> > On Wed, Jan 23, 2019 at 01:53:44PM -0500, Stefan Berger wrote:
> > > On 1/23/19 1:20 PM, Jarkko Sakkinen wrote:
> > > > On Wed, Jan 16, 2019 at 11:23:25PM +0200, Jarkko Sakkinen wrote:
> > > > > Make the changes necessary to detach TPM space code and TPM
> > > > > activation
> > > > > code out of the tpm_transmit() flow because of both of these
> > > > > can cause
> > > > > nested tpm_transmit() calls. The nesteds calls make the whole
> > > > > flow hard
> > > > > to maintain, and thus, it is better to just fix things now
> > > > > before this
> > > > > turns into a bigger mess.
> > > > 
> > > > Any reasons not to merge this soon?
> > > 
> > > I suppose v10 hasn't changed anything signinficat. So, not from my
> > > perspective. Were you waiting for more Reviewed-by's?
> > 
> > Yeah, for example TPM space touching changes would be good to peer
> > check with James. I could have easily forgotten some implementation
> > detail, and it has been very stable piece off code, so don't want
> > to break it. Guess won't yet try to put this v5.1.
> 
> So the implementation detail I was looking for: internal kernel use of
> tpm_transmit_cmd() without tpm_find/try_get_ops() doesn't seem to
> exist, so I think this is all safe.  You can add my
> 
> Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Thank you. I'll send a new revision soonish.

> But I've got to say I can't test this yet because you've made a huge
> problem for me in the tpm security patches: they introduce a kernel
> space which now becomes somewhat problematic because the space handling
> moved into the device common code.  To get both these things to work
> together so I can test it, space handling is going to have to come
> slightly down from device common code so the kernel can use it.

Yeah, obviously. I'll apply these patches right after the next PR so
you will have a more stable platform to work on after that. Stefan
has tested these, and then there is one full cycle to fix details
if we find issues.

/Jarkko

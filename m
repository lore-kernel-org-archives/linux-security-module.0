Return-Path: <SRS0=8CgQ=QF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66F7C282D0
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Jan 2019 18:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CED20844
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Jan 2019 18:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfA2Sxd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:53:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:41684 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfA2Sxd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 Jan 2019 13:53:33 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 10:53:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="129532226"
Received: from rkazants-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.254.212])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jan 2019 10:53:27 -0800
Date:   Tue, 29 Jan 2019 20:53:30 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v10 08/17] tpm: call tpm2_flush_space() on error in
 tpm_try_transmit()
Message-ID: <20190129185330.GA11615@linux.intel.com>
References: <20190116212342.24524-1-jarkko.sakkinen@linux.intel.com>
 <20190116212342.24524-9-jarkko.sakkinen@linux.intel.com>
 <1548781561.2888.33.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548781561.2888.33.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 29, 2019 at 09:06:01AM -0800, James Bottomley wrote:
> On Wed, 2019-01-16 at 23:23 +0200, Jarkko Sakkinen wrote:
> [...]
> > -	rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
> > +out_space:
> > +	if (rc)
> > +		tpm2_flush_space(chip);
> > +	else
> > +		rc = tpm2_commit_space(chip, space, ordinal, buf,
> > &len);
> 
> I don't think this is quite right.  tpm2_flush_space only flushes the
> handles it knows about and those are the ones from before the TPM
> operation was attempted.  If the operation has altered the internal
> state we could miss a created handle in this flush and it would
> effectively reside forever in the TPM.  We should be able to rely on
> the TPM preserving the original state if it returns an error, so I
> think your patch works for that part.  However rc is also set to
> -EFAULT on a transmission error and if that's on the receive path, the
> TPM may have changed state before the error occurred.

If TPM is working properly in the first place, tpm2_commit_space() is
always called (e.g. in a situation where TPM gives a TPM error). Your
deduction about the opposite is absolutely correct. Thanks!

> If the object is to move the TPM back to where it was before the error
> occurred, even in the case of transmit errors, then I think we need to
> invent a new kind of flush that queries the current TPM state and then
> flushes everything.

I think this consideration is anyway out of scope for this patch set.
I'd hope you would also skim through v11 as soon as I get it prepared,
at least the patches where I've added an explicit CC (one or two at
most).

Thanks again.

/Jarkko

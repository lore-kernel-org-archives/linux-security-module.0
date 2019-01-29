Return-Path: <SRS0=8CgQ=QF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E7DC4151A
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Jan 2019 12:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93B82147A
	for <linux-security-module@archiver.kernel.org>; Tue, 29 Jan 2019 12:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfA2MdN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:33:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:39668 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfA2MdN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 Jan 2019 07:33:13 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 04:33:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="111983155"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.127])
  by orsmga006.jf.intel.com with ESMTP; 29 Jan 2019 04:33:09 -0800
Date:   Tue, 29 Jan 2019 14:33:09 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v10 00/17] Remove nested TPM operations
Message-ID: <20190129123309.GB12883@linux.intel.com>
References: <20190116212342.24524-1-jarkko.sakkinen@linux.intel.com>
 <20190123182057.GA24212@linux.intel.com>
 <37e53df5-4a25-fce2-d3bf-016669d0a383@linux.ibm.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9DA818C6@hasmsx108.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DA818C6@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jan 23, 2019 at 06:59:48PM +0000, Winkler, Tomas wrote:
> > 
> > On 1/23/19 1:20 PM, Jarkko Sakkinen wrote:
> > > On Wed, Jan 16, 2019 at 11:23:25PM +0200, Jarkko Sakkinen wrote:
> > >> Make the changes necessary to detach TPM space code and TPM
> > >> activation code out of the tpm_transmit() flow because of both of
> > >> these can cause nested tpm_transmit() calls. The nesteds calls make
> > >> the whole flow hard to maintain, and thus, it is better to just fix
> > >> things now before this turns into a bigger mess.
> > > Any reasons not to merge this soon?
> > 
> > I suppose v10 hasn't changed anything signinficat. So, not from my perspective.
> > Were you waiting for more Reviewed-by's?
> > 
> I'm okay, in theory I've cleaned all my concern regarding idle and
> locality . I'm just want do few more tests on Sunday.

I'm in no rush merging this piece of code, as long as it gets merged
at some point. Thomas, can you take a look at the PTT issue we are
having.

See my discussion with Linus with subject "Getting weird TPM error after
rebasing my tree to security/next-general". You have better knowledge
of the internals so I would really like to hear your feedback on that.
We need to get a fix for that for v5.0.

/Jarkko

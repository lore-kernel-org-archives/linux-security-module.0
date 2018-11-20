Return-Path: <SRS0=2Rj0=N7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A98CC32789
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 23:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD11B21479
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 23:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD11B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbeKUJpE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Nov 2018 04:45:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:13077 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbeKUJpE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Nov 2018 04:45:04 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 15:13:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,258,1539673200"; 
   d="scan'208";a="106326782"
Received: from drhumphr-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.165])
  by fmsmga002.fm.intel.com with ESMTP; 20 Nov 2018 15:13:21 -0800
Date:   Wed, 21 Nov 2018 01:13:20 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, monty.wiseman@ge.com,
        Monty Wiseman <montywiseman32@gmail.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: Documenting the proposal for TPM 2.0 security in the face of bus
 interposer attacks
Message-ID: <20181120231320.GI8391@linux.intel.com>
References: <1542648844.2910.9.camel@HansenPartnership.com>
 <20181120111049.GC14594@linux.intel.com>
 <20181120124116.GA8813@linux.intel.com>
 <1542734743.2814.31.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542734743.2814.31.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Nov 20, 2018 at 09:25:43AM -0800, James Bottomley wrote:
> On Tue, 2018-11-20 at 14:41 +0200, Jarkko Sakkinen wrote:
> > On Tue, Nov 20, 2018 at 01:10:49PM +0200, Jarkko Sakkinen wrote:
> > > This is basically rewrite of TPM genie paper with extras. Maybe
> > > just shorten it to include the proposed architecture and point to
> > > the TPM Genie paper (which is not in the references at all ATM).
> > > 
> > > The way I see it the data validation is way more important than
> > > protecting against physical interposer to be frank.
> > > 
> > > The attack scenario would require to open the damn device. For
> > > laptop that would leave physical marks (i.e. evil maid). In a data
> > > center with armed guards I would wish you good luck accomplishing
> > > it. It is not anything like sticking a USB stick and run.
> > > 
> > > We can take a fix into Linux with a clean implementation but it
> > > needs to be an opt-in feature because not all users will want to
> > > use it.
> > 
> > Someone (might have been either Mimi or David Howells but cannot
> > recall) correctly pointed out at LSS 2018 that you could just as
> > easily spy and corrupt RAM if you have a time window to perform this
> > type of attack.
> 
> Not using the simple plug in on the TPM bus, you can't.  The point is
> basically the difference in the technology: the interposer is a simple,
> easy to construct, plugin; a RAM spy is a huge JTAG thing that would be
> hard even to fit into a modern thin laptop, let alone extremely
> difficult to build.

Why you wouldn't use DMA to spy the RAM?

/Jarkko

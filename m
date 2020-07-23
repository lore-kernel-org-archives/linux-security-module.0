Return-Path: <SRS0=LdBn=BC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940AFC433E1
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jul 2020 02:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F9D20825
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jul 2020 02:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbgGWCkB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 22 Jul 2020 22:40:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:50097 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730837AbgGWCkB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 22 Jul 2020 22:40:01 -0400
IronPort-SDR: Fszeu6/UJJqPZtklAQCYq2uF4CH5pvsyt4zBRsFo22vW+mTu+hvApetUh1EPkuoiU0Tl0qjnhf
 +MYcKjR0lsaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="235325252"
X-IronPort-AV: E=Sophos;i="5.75,385,1589266800"; 
   d="scan'208";a="235325252"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 19:40:01 -0700
IronPort-SDR: v7v2cW3YGBSNRm4IH61Nw2j81BfF4tn9vG2sDk9InOKJE689Puu7Ck4QnV1pPg5MtQ24gVHIFc
 LXr0CbCTfWBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,385,1589266800"; 
   d="scan'208";a="462682361"
Received: from schwings-mobl.ger.corp.intel.com (HELO localhost) ([10.252.33.132])
  by orsmga005.jf.intel.com with ESMTP; 22 Jul 2020 19:39:56 -0700
Date:   Thu, 23 Jul 2020 05:39:54 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Tom Rix <trix@redhat.com>, dhowells@redhat.com, jmorris@namei.org,
        serge@hallyn.com, denkenz@gmail.com, marcel@holtmann.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KEYS: remove redundant memset
Message-ID: <20200723023954.GJ45081@linux.intel.com>
References: <20200722134610.31947-1-trix@redhat.com>
 <2bdd6b8ec731d180023d593b679afc66def19b4f.camel@perches.com>
 <e36c364e-22f4-c520-04da-ca1196fec049@redhat.com>
 <b60f9b3e07b86d0f8631f6990f61b5172c43841f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b60f9b3e07b86d0f8631f6990f61b5172c43841f.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 22, 2020 at 01:20:00PM -0700, Joe Perches wrote:
> On Wed, 2020-07-22 at 13:10 -0700, Tom Rix wrote:
> > On 7/22/20 1:02 PM, Joe Perches wrote:
> > > On Wed, 2020-07-22 at 06:46 -0700, trix@redhat.com wrote:
> > > > From: Tom Rix <trix@redhat.com>
> > > > 
> > > > Reviewing use of memset in keyctrl_pkey.c
> > > > 
> > > > keyctl_pkey_params_get prologue code to set params up
> > > > 
> > > > 	memset(params, 0, sizeof(*params));
> > > > 	params->encoding = "raw";
> > > > 
> > > > keyctl_pkey_query has the same prologue
> > > > and calls keyctl_pkey_params_get.
> > > > 
> > > > So remove the prologue.
> > > > 
> > > > Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
> > > At best, this is a micro optimization.
> > Yes
> > > How is this appropriate for a Fixes: line?
> > Removing unneeded code is not a fix?
> 
> IMO: there's no "bug" here.
> 
> It's not a logic defect causing some unintended outcome.
> It doesn't need backporting to stable branches.
> 
> Documentation/process/submitting-patches.rst-If your patch fixes a bug in a specific commit, e.g. you found an issue using
> Documentation/process/submitting-patches.rst:``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
> Documentation/process/submitting-patches.rst-the SHA-1 ID, and the one line summary.

I agree.

At worst it can cause unnecessary merge conflicts when backporting
bug fixes.

No measurable gain merging it.

/Jarkko

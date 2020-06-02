Return-Path: <SRS0=3Oq2=7P=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1481AC433DF
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Jun 2020 07:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9CDE20772
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Jun 2020 07:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgFBHOO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Jun 2020 03:14:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:36684 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgFBHOO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Jun 2020 03:14:14 -0400
IronPort-SDR: prdJ3G2od+mYzF60Lp5gmCmarEdKcogx96PiHq0jbVeni4hWpV+2h87N3tog9yWCRndsKld6pA
 j/7vmeGmr06Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 00:14:13 -0700
IronPort-SDR: coLgcfUzY1r0gMPZ3I7pF0lKRrgzpKRDvFxeMYNrhrx/osJaKh2dTYlvhflgsEOUyu4HtKmEfI
 lFu58/twi4ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; 
   d="scan'208";a="286546847"
Received: from unknown (HELO localhost) ([10.252.59.102])
  by orsmga002.jf.intel.com with ESMTP; 02 Jun 2020 00:14:08 -0700
Date:   Tue, 2 Jun 2020 10:14:07 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>, dhowells@redhat.com,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Subject: Re: [PATCH v4 1/4] KEYS: trusted: Add generic trusted keys framework
Message-ID: <20200602071407.GB16602@linux.intel.com>
References: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
 <1588758017-30426-2-git-send-email-sumit.garg@linaro.org>
 <20200601021132.GA796225@linux.intel.com>
 <CAFA6WYP55W2xKtjHWWwu6Pbqy2TGY=eymwAoXxQh-5mF8deR6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYP55W2xKtjHWWwu6Pbqy2TGY=eymwAoXxQh-5mF8deR6A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 01, 2020 at 02:41:55PM +0530, Sumit Garg wrote:
> > This, I think is wrong. You should have a compile time flag for TPM e.g.
> > CONFIG_TRUSTED_TPM, not this dynamic mess.
> >
> 
> The whole idea to have it dynamic was to have a common trusted keys
> module which could support both TPM and TEE implementation depending
> on hardware. I guess it may be useful in scenarios where a particular
> hardware supports a TPM chip while other doesn't but both need to run
> a common kernel image.

For now it should only scale to what is needed. No problems refining
it later when there is something to enable.

/Jarkko

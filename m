Return-Path: <SRS0=eR/s=RC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF55C43381
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Feb 2019 13:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE99213A2
	for <linux-security-module@archiver.kernel.org>; Wed, 27 Feb 2019 13:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbfB0NHf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:07:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:5750 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfB0NHe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Feb 2019 08:07:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 05:07:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,419,1544515200"; 
   d="scan'208";a="129762081"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.169])
  by orsmga003.jf.intel.com with ESMTP; 27 Feb 2019 05:07:32 -0800
Date:   Wed, 27 Feb 2019 15:07:30 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     janne.karhunen@gmail.com
Cc:     linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com
Subject: Re: [PATCH] RFC: user-mode extensible trusted key support
Message-ID: <20190227130730.GA12394@linux.intel.com>
References: <20190211173033.2493-1-Janne.Karhunen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211173033.2493-1-Janne.Karhunen@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Feb 11, 2019 at 07:30:33PM +0200, janne.karhunen@gmail.com wrote:
> From: Janne Karhunen <Janne.Karhunen@gmail.com>
> 
> Current kernel key subsystem only supports tpm to implement
> trusted keys. This is fine, but the tpm is poorly supported
> in the embedded world that primarily use custom trust roots,
> TEEs or even white box crypto. Problem with these setups is
> that they are extremely diverse, complex, proprietary and
> in some cases for valid reasons (white box).
> 
> This patch provides trial plumbing to enable declaration
> of new trust sources via tiny user mode helpers baked as
> part of the kernel image. If the hardware based trust source
> is available, the provided um helper can read the given
> device node and act as a translator for the kernel key
> requests and the actual device node can be kept out of the
> 'regular' userland. In the case of white box crypto, the
> um helper is free to perform any sort of software magic
> required to mangle the keys within the kernel keyring.
> 
> The kernel built-in usermode helper key operations are made
> available via new key type named 'ext-trusted' that is
> compatible with the existing userland utilities:
> keyctl add ext-trusted foo "new_umh 32" @u
> keyctl pipe `keyctl search @u ext-trusted foo` > foo.key
> keyctl add ext-trusted bar "load `cat foo.key`" @u
> ...
> 
> Signed-off-by: Janne Karhunen <Janne.Karhunen@gmail.com>
> Reviewed-by: Pekka Honkanen <Pekka.Honkanen@aalto.fi>

I guess this misses an actual workload to look at.

/Jarkko

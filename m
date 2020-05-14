Return-Path: <SRS0=SKQR=64=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04759C433E0
	for <linux-security-module@archiver.kernel.org>; Thu, 14 May 2020 00:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B39420675
	for <linux-security-module@archiver.kernel.org>; Thu, 14 May 2020 00:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733122AbgENA3c (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 May 2020 20:29:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:39965 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732946AbgENA3b (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 May 2020 20:29:31 -0400
IronPort-SDR: WpYdMIteOihFbps/xWUHNHbaj1qvLGVOYqjK4ETfVO8lqXgHSPETYMBxw5WVZFb1FY6u4lruSs
 xl0VdkrdOc9w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 17:29:30 -0700
IronPort-SDR: 1EqgBWkrImoRj+D/m16TKUnq1rR2VzIIzr2ST529/xBIm08IR/EQOmm3DnJbofbxTxY17z8CpF
 1vWhgFaPnyUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; 
   d="scan'208";a="266058759"
Received: from gliber-mobl1.ger.corp.intel.com ([10.249.38.41])
  by orsmga006.jf.intel.com with ESMTP; 13 May 2020 17:29:21 -0700
Message-ID: <f8d77be225783f428983ef38df026b7cd8724319.camel@linux.intel.com>
Subject: Re: [PATCH v4 3/4] doc: trusted-encrypted: updates with TEE as a
 new trust source
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>, zohar@linux.ibm.com,
        jejb@linux.ibm.com
Cc:     dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, tee-dev@lists.linaro.org
Date:   Thu, 14 May 2020 03:29:20 +0300
In-Reply-To: <1588758017-30426-4-git-send-email-sumit.garg@linaro.org>
References: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
         <1588758017-30426-4-git-send-email-sumit.garg@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2020-05-06 at 15:10 +0530, Sumit Garg wrote:
> Update documentation for Trusted and Encrypted Keys with TEE as a new
> trust source. Following is brief description of updates:
> 
> - Add a section to demostrate a list of supported devices along with
>   their security properties/guarantees.
> - Add a key generation section.
> - Updates for usage section including differences specific to a trust
>   source.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko


Return-Path: <SRS0=wl+Y=5A=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BB9C10DCE
	for <linux-security-module@archiver.kernel.org>; Sun, 15 Mar 2020 21:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B112220663
	for <linux-security-module@archiver.kernel.org>; Sun, 15 Mar 2020 21:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgCOV1S (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 15 Mar 2020 17:27:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:12821 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729181AbgCOV1R (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 15 Mar 2020 17:27:17 -0400
IronPort-SDR: zaQPBs/0u5NoQ9zgbjEHGqzIubBry43M/32IDZEU1hFDQkDypmj9DTpOfsn5UsMLr63Nspc+uJ
 WGfBzlh5hmEg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2020 14:27:15 -0700
IronPort-SDR: cpKfKlqvRw8QYMmR5oHUs+ntYZDMAUxQe6fcTImbqFYAKbAQjuvUJmURRpG/zb/SIz7gHTiv0W
 UwnA8bxGOqfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,557,1574150400"; 
   d="scan'208";a="267363680"
Received: from babayass-mobl.ger.corp.intel.com (HELO localhost) ([10.249.90.210])
  by fmsmga004.fm.intel.com with ESMTP; 15 Mar 2020 14:27:08 -0700
Date:   Sun, 15 Mar 2020 23:27:06 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Waiman Long <longman@redhat.com>,
        David Howells <dhowells@redhat.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Eric Biggers <ebiggers@google.com>,
        Chris von Recklinghausen <crecklin@redhat.com>
Subject: Re: [PATCH v3 1/3] KEYS: Don't write out to userspace while holding
 key semaphore
Message-ID: <20200315212706.GE224162@linux.intel.com>
References: <20200313152102.1707-1-longman@redhat.com>
 <20200313152102.1707-2-longman@redhat.com>
 <20200315192104.GD224162@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315192104.GD224162@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Mar 15, 2020 at 09:21:16PM +0200, Jarkko Sakkinen wrote:
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

I guess we cannot sanely define fixes tag for this one, can we?

Surely this should still go to stable.

Do you have a test case that can reproduce this on a constant basis?

/Jarkko

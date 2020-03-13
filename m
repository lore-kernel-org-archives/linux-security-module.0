Return-Path: <SRS0=meF1=46=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7355C2BB1D
	for <linux-security-module@archiver.kernel.org>; Fri, 13 Mar 2020 15:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBBE2074A
	for <linux-security-module@archiver.kernel.org>; Fri, 13 Mar 2020 15:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgCMP2r (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:28:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:54958 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgCMP2q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Mar 2020 11:28:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 08:28:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,549,1574150400"; 
   d="scan'208";a="232450431"
Received: from mlitka-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.155.148])
  by orsmga007.jf.intel.com with ESMTP; 13 Mar 2020 08:28:39 -0700
Date:   Fri, 13 Mar 2020 17:28:37 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
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
Subject: Re: [PATCH v2 1/2] KEYS: Don't write out to userspace while holding
 key semaphore
Message-ID: <20200313152837.GB142269@linux.intel.com>
References: <20200308170410.14166-1-longman@redhat.com>
 <20200308170410.14166-2-longman@redhat.com>
 <20200313010425.GA11360@linux.intel.com>
 <e2dc038b-0283-0bf6-45f6-ad2dd0775e81@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2dc038b-0283-0bf6-45f6-ad2dd0775e81@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Mar 13, 2020 at 09:29:47AM -0400, Waiman Long wrote:
> One way to do that is to extract the down_read/up_read block into a
> helper function and then have 2 separate paths - one for length
> retrieval and another one for reading the key. I think that will make
> the code a bit easier easier to read.
> 
> Thanks,
> Longman

If it is not too much trouble for you, I think this would be a legit
cleanup to do.

/Jarkko

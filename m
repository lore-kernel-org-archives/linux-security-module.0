Return-Path: <SRS0=kEwh=5G=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465FAC4332B
	for <linux-security-module@archiver.kernel.org>; Sat, 21 Mar 2020 00:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171D2215A4
	for <linux-security-module@archiver.kernel.org>; Sat, 21 Mar 2020 00:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCUA6e (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 20 Mar 2020 20:58:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:9574 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgCUA6e (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 Mar 2020 20:58:34 -0400
IronPort-SDR: OPDhC3K0uJWneehod59t8t/OkyE6Onb7izNS+IF3qnJRFohes/RDm+J16MalsbZi+xXD8DODPG
 gYXyq8w7mzog==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 17:58:32 -0700
IronPort-SDR: esFDIly/Lw6QLsxmLW6BlhQWUi4C7fRdlmmnPM4Jrybw+OYXGoreE0IOS/iHsLeFYD8MLeQ9+A
 BVnbEnYggYYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,286,1580803200"; 
   d="scan'208";a="249045762"
Received: from ydubov-mobl1.ger.corp.intel.com (HELO localhost) ([10.254.147.149])
  by orsmga006.jf.intel.com with ESMTP; 20 Mar 2020 17:58:22 -0700
Date:   Sat, 21 Mar 2020 02:58:20 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Waiman Long <longman@redhat.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, netdev@vger.kernel.org,
        linux-afs@lists.infradead.org, Sumit Garg <sumit.garg@linaro.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Eric Biggers <ebiggers@google.com>,
        Chris von Recklinghausen <crecklin@redhat.com>
Subject: Re: [PATCH v5 2/2] KEYS: Avoid false positive ENOMEM error on key
 read
Message-ID: <20200321005820.GC7166@linux.intel.com>
References: <20200320143547.GB3629@linux.intel.com>
 <20200318221457.1330-1-longman@redhat.com>
 <20200318221457.1330-3-longman@redhat.com>
 <20200319194650.GA24804@linux.intel.com>
 <f22757ad-4d6f-ffd2-eed5-6b9bd1621b10@redhat.com>
 <20200320020717.GC183331@linux.intel.com>
 <7dbc524f-6c16-026a-a372-2e80b40eab30@redhat.com>
 <3984029.1584748510@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3984029.1584748510@warthog.procyon.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Mar 20, 2020 at 11:55:10PM +0000, David Howells wrote:
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > /* Key data can change as we don not hold key->sem. */
> 
> I think you mean "we don't".

Oops, typo. Yes, thanks.

/Jarkko

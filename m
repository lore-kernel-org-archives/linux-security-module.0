Return-Path: <SRS0=OFt8=5B=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE356C0044D
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Mar 2020 22:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C670820674
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Mar 2020 22:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732775AbgCPWTQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 16 Mar 2020 18:19:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:8995 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732716AbgCPWTQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 16 Mar 2020 18:19:16 -0400
IronPort-SDR: 50B5skU+j+Nj1lVld8103PDJDfNRKXrwiRt9I9zOcFZzv4zy41d2+IH9+yb+gnz2grMjBzzPLi
 QQ47P+iljhow==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 15:19:15 -0700
IronPort-SDR: wHdjhQsSeIkJPsCQJhsjtIcOOiIgXAqbgU0O4XenBzYIj+MmxXSWgF/lOJ5GbfUYJTmvXmfzca
 mtU12ZLuOkLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,561,1574150400"; 
   d="scan'208";a="247617968"
Received: from oaizenbe-mobl.ger.corp.intel.com ([10.254.149.199])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2020 15:19:06 -0700
Message-ID: <f89b41ea8fc1ab84cc19fd1c1f9b048457bbc28d.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/3] KEYS: Use kvmalloc() to better handle large
 buffer allocation
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     David Howells <dhowells@redhat.com>,
        Waiman Long <longman@redhat.com>
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
Date:   Tue, 17 Mar 2020 00:19:06 +0200
In-Reply-To: <1809107.1584368672@warthog.procyon.org.uk>
References: <20200313152102.1707-4-longman@redhat.com>
         <20200313152102.1707-1-longman@redhat.com>
         <1809107.1584368672@warthog.procyon.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.35.92-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 2020-03-16 at 14:24 +0000, David Howells wrote:
> I wonder if it's worth merging this into patch 2.  I'm not sure it's really
> worth its own patch.  If you want to generalise kvzfree(), then that could go
> as its own patch first.
> 
> David

Also in the sense that there is no senseful situation where you'd
only wanted to pick either but not both.

/Jarkko


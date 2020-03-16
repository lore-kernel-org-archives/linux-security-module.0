Return-Path: <SRS0=OFt8=5B=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D8DC0044D
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Mar 2020 13:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620152051A
	for <linux-security-module@archiver.kernel.org>; Mon, 16 Mar 2020 13:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbgCPNxp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 16 Mar 2020 09:53:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:33118 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731110AbgCPNxp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 16 Mar 2020 09:53:45 -0400
IronPort-SDR: aMGoWVHStLss7L53BmyPVS6m/Kh+2tiO+rZAWSc+C1Yzw8mEJH/ip0tjnfUwkSyAER7usUiT5T
 ytIEsn831o7Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 06:53:42 -0700
IronPort-SDR: jGFiFeyzZ/nIAHur/4zz2Mzpu0mcmDRpMnylLAHx2ixih4XM8qP/kWBDXoYvvbEB21cAISrPUj
 ezvfwJ9oEiIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,560,1574150400"; 
   d="scan'208";a="267577086"
Received: from zidelson-mobl1.ger.corp.intel.com ([10.251.163.156])
  by fmsmga004.fm.intel.com with ESMTP; 16 Mar 2020 06:53:33 -0700
Message-ID: <c1138c83619553d018970a4b2d95f38fccebc99c.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/3] KEYS: Don't write out to userspace while holding
 key semaphore
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Waiman Long <longman@redhat.com>, James Morris <jmorris@namei.org>,
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
Date:   Mon, 16 Mar 2020 15:53:30 +0200
In-Reply-To: <1793253.1584357764@warthog.procyon.org.uk>
References: <20200315212706.GE224162@linux.intel.com>
         <20200313152102.1707-1-longman@redhat.com>
         <20200313152102.1707-2-longman@redhat.com>
         <20200315192104.GD224162@linux.intel.com>
         <1793253.1584357764@warthog.procyon.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.35.92-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 2020-03-16 at 11:22 +0000, David Howells wrote:
> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > I guess we cannot sanely define fixes tag for this one, can we?
> 
> Use:
> 
> 	Fixes: ^1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> David

Longmao, please include this to the next version.

/Jarkko


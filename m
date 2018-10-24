Return-Path: <SRS0=JlTe=NE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2F6ECDE44
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Oct 2018 23:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491E420833
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Oct 2018 23:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491E420833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbeJYHdt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Oct 2018 03:33:49 -0400
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:21786 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbeJYHdt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Oct 2018 03:33:49 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl2.internode.on.net with ESMTP; 25 Oct 2018 09:33:46 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gFSBl-0006L4-Vl; Thu, 25 Oct 2018 10:03:46 +1100
Date:   Thu, 25 Oct 2018 10:03:45 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, igor.stoppa@huawei.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>
Subject: Re: [RFC v1 PATCH 00/17] prmem: protected memory
Message-ID: <20181024230345.GE6311@dastard>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023213504.28905-1-igor.stoppa@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 24, 2018 at 12:34:47AM +0300, Igor Stoppa wrote:
> -- Summary --
> 
> Preliminary version of memory protection patchset, including a sample use
> case, turning into write-rare the IMA measurement list.

I haven't looked at the patches yet, but I see a significant issue
from the subject lines. "prmem" is very similar to "pmem"
(persistent memory) and that's going to cause confusion. Especially
if people start talking about prmem and pmem in the context of write
protect pmem with prmem...

Naming is hard :/

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

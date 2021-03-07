Return-Path: <SRS0=SOac=IF=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE72C433E6
	for <linux-security-module@archiver.kernel.org>; Sun,  7 Mar 2021 15:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E84F065106
	for <linux-security-module@archiver.kernel.org>; Sun,  7 Mar 2021 15:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhCGPTg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 7 Mar 2021 10:19:36 -0500
Received: from mga12.intel.com ([192.55.52.136]:15647 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232033AbhCGPTV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 7 Mar 2021 10:19:21 -0500
IronPort-SDR: rcwVF1zsDWWfeydQ/onW8Q1t7k1DFqOO6V6HjdFh7is5vmZLV2snJ1iMeExH8+32o6TV9mDP9Z
 8Nx8zFLfjWrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="167172190"
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="167172190"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 07:19:21 -0800
IronPort-SDR: VBQ85G5YYI/WVTz2b41mxqzXqF0+ssZMx7MQbDyrg3QsWTdTEwQLosgUq9Ov6r51Cb94QFKhyQ
 E0ZQT8/IMYEw==
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="409008502"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 07:19:21 -0800
Date:   Sun, 7 Mar 2021 07:19:20 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     John Wood <john.wood@gmx.com>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        Shuah Khan <shuah@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v5 7/8] Documentation: Add documentation for the Brute LSM
Message-ID: <20210307151920.GR472138@tassilo.jf.intel.com>
References: <20210227153013.6747-1-john.wood@gmx.com>
 <20210227153013.6747-8-john.wood@gmx.com>
 <878s78dnrm.fsf@linux.intel.com>
 <20210302183032.GA3049@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302183032.GA3049@ubuntu>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Sorry for the late answer. I somehow missed your email earlier.

> As a mitigation method, all the offending tasks involved in the attack are
> killed. Or in other words, all the tasks that share the same statistics
> (statistics showing a fast crash rate) are killed.

So systemd will just restart the network daemon and then the attack works
again?

Or if it's a interactive login you log in again.

I think it might be useful even with these limitations, but it would
be good to spell out the limitations of the method more clearly.

I suspect to be useful it'll likely need some user space configuration
changes too.

-Andi

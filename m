Return-Path: <SRS0=mFfD=6P=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEC6C4724C
	for <linux-security-module@archiver.kernel.org>; Fri,  1 May 2020 07:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57DA52071C
	for <linux-security-module@archiver.kernel.org>; Fri,  1 May 2020 07:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgEAHbC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 1 May 2020 03:31:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:43581 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgEAHbC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 May 2020 03:31:02 -0400
IronPort-SDR: yg7tnfdYYMMef5Pi2LBZ5nak8qlmAxGJ0zSwzBfSy/CSo4L0RvpQ7FK+98eTDUFGGtGUFGuZdX
 T+eh3eK6L7FQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 00:31:01 -0700
IronPort-SDR: dAhag6RkhfHBmENqy7ZVTGekUzQ0MrZStJuQLCFnD/4yvCpNbfnyuc+koV/1Fb0An9VJixA60m
 n8qYq7TVD51w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,339,1583222400"; 
   d="scan'208";a="405679165"
Received: from akontse-mobl2.ger.corp.intel.com (HELO [10.254.147.91]) ([10.254.147.91])
  by orsmga004.jf.intel.com with ESMTP; 01 May 2020 00:30:57 -0700
Subject: Re: [PATCH bpf] security: Fix the default value of
 fs_context_parse_param hook
To:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
References: <20200430155240.68748-1-kpsingh@chromium.org>
From:   Mikko Ylinen <mikko.ylinen@linux.intel.com>
Message-ID: <e935994c-baca-21c1-1b4e-1943c20e24dd@linux.intel.com>
Date:   Fri, 1 May 2020 10:30:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430155240.68748-1-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 30/04/2020 18:52, KP Singh wrote:
> This was noticed when lsm=bpf is supplied on the command line before any
> other LSM. As the bpf lsm uses this default value to implement a default
> hook, this resulted in a failure to parse any fs_context parameters and
> a failure to mount the root filesystem.

Tested-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>

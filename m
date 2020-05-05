Return-Path: <SRS0=J6Hd=6T=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88E9C47256
	for <linux-security-module@archiver.kernel.org>; Tue,  5 May 2020 17:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9099E206B9
	for <linux-security-module@archiver.kernel.org>; Tue,  5 May 2020 17:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N25TB6nG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbgEERwO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 May 2020 13:52:14 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43052 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729729AbgEERwN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 May 2020 13:52:13 -0400
Received: from [192.168.0.109] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 29F8B20B717B;
        Tue,  5 May 2020 10:52:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 29F8B20B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1588701133;
        bh=QB8qYRsILhW1r7wl9jWCXK+Xi7XMZi0BRDJ0n8FHlBU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=N25TB6nGbNVvBD2M35W192seRGGBuBAGAomHZjHk2d27xyPREQyVeG0NiL63+JFV1
         GGywiwiO714V09Ha++okjTigCOEZ2BQsU1joTb8BD9WhmH06F/m2inIQmBRm1Ddbou
         Lyaf37lLK20Db2pb4I5uJnIESqiguP7sdG8hM9RQ=
Subject: Re: [RFC PATCH v1] ima: verify mprotect change is consistent with
 mmap policy
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Jann Horn <jannh@google.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1588699845-6196-1-git-send-email-zohar@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <2ae3adf2-25cb-eb6f-4615-85e3ac493161@linux.microsoft.com>
Date:   Tue, 5 May 2020 10:52:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588699845-6196-1-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 5/5/20 10:30 AM, Mimi Zohar wrote:

> Files can be mmap'ed read/write and later changed to execute to circumvent
> IMA's mmap appraise policy rules.  Due to locking issues (mmap semaphore
> would be taken prior to i_mutex), files can not be measured or appraised at
> this point.  Eliminate this integrity gap, by denying the mprotect
> PROT_EXECUTE change, if an mmap appraise policy rule exists.
> 
> On mprotect change success, return 0.  On failure, return -EACESS.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> Changelog v1:
> - Reverse tests to remove code indentation. (Lakshmi Ramasubramanian)
> - General code cleanup, including adding comments.
> 
>   include/linux/ima.h               |  7 ++++++
>   security/integrity/ima/ima_main.c | 51 +++++++++++++++++++++++++++++++++++++++
>   security/security.c               |  7 +++++-
>   3 files changed, 64 insertions(+), 1 deletion(-)

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>


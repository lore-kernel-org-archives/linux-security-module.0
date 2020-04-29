Return-Path: <SRS0=9msM=6N=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA91C83000
	for <linux-security-module@archiver.kernel.org>; Wed, 29 Apr 2020 17:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A96C208FE
	for <linux-security-module@archiver.kernel.org>; Wed, 29 Apr 2020 17:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DX66KKJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgD2RXB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:23:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33056 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgD2RXA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 29 Apr 2020 13:23:00 -0400
Received: from [192.168.0.109] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2070820B4737;
        Wed, 29 Apr 2020 10:23:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2070820B4737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1588180980;
        bh=dXAt2PJpTkQ9MnX44sOk0KMteaTwRrL51u5353hkQ94=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DX66KKJLYlVCgw3mkUmwBYA5r5p9uA0owtBrZiqT/fvRcYj2ij8ej744ulJGGriIP
         M+TtRbsGp1WRXWWOXXaasL/93q3GfwfUdI4zMPJgNFS6mdR881LmoXxWpJMxRDa8sZ
         U8F3tYpm+QUpp1oP42gQw04i0AJhfgXXhXdh67o4=
Subject: Re: [PATCH 2/2] ima: add policy support for the new file open
 MAY_OPENEXEC flag
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Mickael Salaun <mic@digikod.net>, Steve Grubb <sgrubb@redhat.com>,
        Jann Horn <jannh@google.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1588167523-7866-1-git-send-email-zohar@linux.ibm.com>
 <1588167523-7866-3-git-send-email-zohar@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <5c7a4ef6-db0b-431a-b745-987176fa41ed@linux.microsoft.com>
Date:   Wed, 29 Apr 2020 10:22:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588167523-7866-3-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 4/29/20 6:38 AM, Mimi Zohar wrote:
> The kernel has no way of differentiating between a file containing data
> or code being opened by an interpreter.  The proposed RESOLVE_MAYEXEC
> openat2(2) flag bridges this gap by defining and enabling the MAY_OPENEXEC
> flag.
> 
> This patch adds IMA policy support for the new MAY_OPENEXEC flag.
> 
> Example:
> measure func=FILE_CHECK mask=^MAY_OPENEXEC
> appraise func=FILE_CHECK appraise_type=imasig mask=^MAY_OPENEXEC
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed.


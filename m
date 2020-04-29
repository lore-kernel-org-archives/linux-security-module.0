Return-Path: <SRS0=9msM=6N=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70082C83004
	for <linux-security-module@archiver.kernel.org>; Wed, 29 Apr 2020 17:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3A9208FE
	for <linux-security-module@archiver.kernel.org>; Wed, 29 Apr 2020 17:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KDoQ7LIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgD2RWh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:22:37 -0400
Received: from linux.microsoft.com ([13.77.154.182]:32904 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgD2RWh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 29 Apr 2020 13:22:37 -0400
Received: from [192.168.0.109] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id F2DF9201E7E5;
        Wed, 29 Apr 2020 10:22:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F2DF9201E7E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1588180957;
        bh=sejNNHE6Un9l9iyWcXAw0ccsHgdDT73GrYnZBNmWzVQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KDoQ7LILwDZg8ExtQu3YhpjNlODL4eQ421nHBrTAX4NLHGXa3dy2npY+K9G41Pcpx
         5zSP9w2WDGxsUqMf5K+znWkkxSJPfCm3kGDts6OSh13DFn7JzM5Yb6lBYddz0tk4Fb
         W9OQiU/OhfMMj4lLMazxp988zP/XD12Emxz/D8vs=
Subject: Re: [PATCH 1/2] ima: add policy support for identifying file execute
 mode bit
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Mickael Salaun <mic@digikod.net>, Steve Grubb <sgrubb@redhat.com>,
        Jann Horn <jannh@google.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1588167523-7866-1-git-send-email-zohar@linux.ibm.com>
 <1588167523-7866-2-git-send-email-zohar@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <0708f375-b293-c576-89b8-02379d7a807b@linux.microsoft.com>
Date:   Wed, 29 Apr 2020 10:22:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588167523-7866-2-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 4/29/20 6:38 AM, Mimi Zohar wrote:

> Extend the IMA policy language with "mode=IXUGO" to identify files with
> the execute mode bit enabled.
> 
> Examples:
> measure func=FILE_CHECK mode=IXUGO
> appraise func=FILE_CHECK appraise_type=imasig mode=IXUGO
> 
> Suggested-by: Steve Grubb <sgrubb@redhat.com> (based on execute mode bit)
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed.

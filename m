Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0089AC636C8
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Jul 2021 03:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB9E1611CE
	for <linux-security-module@archiver.kernel.org>; Wed, 21 Jul 2021 03:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhGUCbs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Jul 2021 22:31:48 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:41684 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232447AbhGUCbF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Jul 2021 22:31:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UgTMv32_1626837044;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UgTMv32_1626837044)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 21 Jul 2021 11:10:44 +0800
Subject: Re: [PATCH] Smack: Fix wrong semantics in smk_access_entry()
To:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210715091724.45768-1-tianjia.zhang@linux.alibaba.com>
 <ae938c7b-2f7a-27ec-7077-ceeb517ba97f@schaufler-ca.com>
 <20b7bc36-89fa-d004-74f0-629a42595f86@schaufler-ca.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <f1bc2ac3-2ad3-d854-9b35-ca35cda825da@linux.alibaba.com>
Date:   Wed, 21 Jul 2021 11:10:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20b7bc36-89fa-d004-74f0-629a42595f86@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 7/21/21 12:32 AM, Casey Schaufler wrote:
> On 7/15/2021 8:15 AM, Casey Schaufler wrote:
>> On 7/15/2021 2:17 AM, Tianjia Zhang wrote:
>>> In the smk_access_entry() function, if no matching rule is found
>>> in the rust_list, a negative error code will be used to perform bit
>>> operations with the MAY_ enumeration value. This is semantically
>>> wrong. This patch fixes this issue.
>> Indeed, the code as written is functioning correctly by
>> sheer luck. I will take this patch. Thank you.
>>
>>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> 
> Added to the Smack next branch.
> 

Great, Thanks.

Tianjia

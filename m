Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC54C2D0E4
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Nov 2020 07:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF945221EB
	for <linux-security-module@archiver.kernel.org>; Fri, 27 Nov 2020 07:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392697AbgK0HR0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 27 Nov 2020 02:17:26 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7996 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392683AbgK0HRZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 27 Nov 2020 02:17:25 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cj5Xy4XlbzhcYm;
        Fri, 27 Nov 2020 15:17:06 +0800 (CST)
Received: from [10.174.178.154] (10.174.178.154) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 27 Nov
 2020 15:17:12 +0800
Subject: Re: [PATCH] tomoyo: Avoid potential null pointer access
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jmorris@namei.org>,
        <serge@hallyn.com>, <weiyongjun1@huawei.com>
References: <20201125121043.107662-1-zhengzengkai@huawei.com>
 <cfc96d99-adff-6eb9-9685-422587830eb8@i-love.sakura.ne.jp>
 <01d29bbf-9d77-c787-b2c2-d88a6a5047f7@huawei.com>
 <59e0abdd-88a9-6269-9cd1-0f65792784ec@i-love.sakura.ne.jp>
From:   Zheng Zengkai <zhengzengkai@huawei.com>
Message-ID: <dfb6829e-0fb6-7dbc-5dfa-9707b2f0ae16@huawei.com>
Date:   Fri, 27 Nov 2020 15:17:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <59e0abdd-88a9-6269-9cd1-0f65792784ec@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Tetsuo,
> On 2020/11/26 15:33, Zheng Zengkai wrote:
>> As your say,  I found the function tomoyo_assign_namespace( )
>>
>> in security/tomoyo/domain.c has the similar situation,
>>
>> Can I add __GFP_NOWARN for both and remove the null check for _entry_ in tomoyo_assign_namespace( )?
>>
> Good catch. Yes, please send as a patch.
> .

I have resent a patch, thanks!


Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF5BC432BE
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Sep 2021 02:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF53610CC
	for <linux-security-module@archiver.kernel.org>; Thu,  2 Sep 2021 02:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbhIBCiO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 1 Sep 2021 22:38:14 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:38377 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233145AbhIBCiN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Sep 2021 22:38:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Umym6tP_1630550233;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0Umym6tP_1630550233)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Sep 2021 10:37:14 +0800
Subject: Re: [PATCH] Revert "net: fix NULL pointer reference in
 cipso_v4_doi_free"
To:     Paul Moore <paul@paul-moore.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c6864908-d093-1705-76ce-94d6af85e092@linux.alibaba.com>
 <18f0171e-0cc8-6ae6-d04a-a69a2a3c1a39@linux.alibaba.com>
 <7f239a0e-7a09-3dc0-43ce-27c19c7a309d@linux.alibaba.com>
 <4c000115-4069-5277-ce82-946f2fdb790a@linux.alibaba.com>
 <CAHC9VhRBhCfX45V701rbGsvmOPQ4Nyp7dX2GA6NL8FxnA9akXg@mail.gmail.com>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <a53753dc-0cce-4f9a-cb97-fc790d30a234@linux.alibaba.com>
Date:   Thu, 2 Sep 2021 10:37:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRBhCfX45V701rbGsvmOPQ4Nyp7dX2GA6NL8FxnA9akXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 2021/9/2 上午5:05, Paul Moore wrote:
> On Tue, Aug 31, 2021 at 10:21 PM 王贇 <yun.wang@linux.alibaba.com> wrote:
>>
>> Hi Paul, it confused me since it's the first time I face
>> such situation, but I just realized what you're asking is
>> actually this revert, correct?
> 
> I believe DaveM already answered your question in the other thread,
> but if you are still unsure about the patch let me know.

I do failed to get the point :-(

As I checked the:
  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git

both v1 and v2 are there with the same description and both code modification
are applied.

We want revert v1 but not in a revert patch style, then do you suggest
send a normal patch to do the code revert?

Regards,
Michael Wang

> 

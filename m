Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC35C432BE
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Sep 2021 09:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3551661053
	for <linux-security-module@archiver.kernel.org>; Wed,  1 Sep 2021 09:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243544AbhIAJbi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 1 Sep 2021 05:31:38 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51806 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242467AbhIAJbh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Sep 2021 05:31:37 -0400
Received: from localhost (cpc147930-brnt3-2-0-cust60.4-2.cable.virginm.net [86.15.196.61])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id AE0FA4CE6846B;
        Wed,  1 Sep 2021 02:30:38 -0700 (PDT)
Date:   Wed, 01 Sep 2021 10:30:33 +0100 (BST)
Message-Id: <20210901.103033.925382819044968737.davem@davemloft.net>
To:     yun.wang@linux.alibaba.com
Cc:     paul@paul-moore.com, kuba@kernel.org, yoshfuji@linux-ipv6.org,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: fix NULL pointer reference in cipso_v4_doi_free
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1ed31e79-809b-7ac9-2760-869570ac22ea@linux.alibaba.com>
References: <84262e7b-fda6-9d7d-b0bd-1bb0e945e6f9@linux.alibaba.com>
        <CAHC9VhRPUa-oD_85j6RcAVvp7sLZQEAGGapYYP1fEt7Ax5LMfA@mail.gmail.com>
        <1ed31e79-809b-7ac9-2760-869570ac22ea@linux.alibaba.com>
X-Mailer: Mew version 6.8 on Emacs 27.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Wed, 01 Sep 2021 02:30:40 -0700 (PDT)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: 王贇 <yun.wang@linux.alibaba.com>
Date: Wed, 1 Sep 2021 09:51:28 +0800

> 
> 
> On 2021/8/31 下午9:48, Paul Moore wrote:
>> On Mon, Aug 30, 2021 at 10:42 PM 王贇 <yun.wang@linux.alibaba.com> wrote:
>>> On 2021/8/31 上午12:50, Paul Moore wrote:
>>> [SNIP]
>>>>>>> Reported-by: Abaci <abaci@linux.alibaba.com>
>>>>>>> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
>>>>>>> ---
>>>>>>>  net/netlabel/netlabel_cipso_v4.c | 4 ++--
>>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> I see this was already merged, but it looks good to me, thanks for
>>>>>> making those changes.
>>>>>
>>>>> FWIW it looks like v1 was also merged:
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=733c99ee8b
>>>>
>>>> Yeah, that is unfortunate, there was a brief discussion about that
>>>> over on one of the -stable patches for the v1 patch (odd that I never
>>>> saw a patchbot post for the v1 patch?).  Having both merged should be
>>>> harmless, but we want to revert the v1 patch as soon as we can.
>>>> Michael, can you take care of this?
>>>
>>> As v1 already merged, may be we could just goon with it?
>>>
>>> Actually both working to fix the problem, v1 will cover all the
>>> cases, v2 take care one case since that's currently the only one,
>>> but maybe there will be more in future.
>> 
>> No.  Please revert v1 and stick with the v2 patch.  The v1 patch is in
>> my opinion a rather ugly hack that addresses the symptom of the
>> problem and not the root cause.
>> 
>> It isn't your fault that both v1 and v2 were merged, but I'm asking
>> you to help cleanup the mess.  If you aren't able to do that please
>> let us know so that others can fix this properly.
> 
> No problem I can help on that, just try to make sure it's not a
> meaningless work.
> 
> So would it be fine to send out a v3 which revert v1 and apply v2?

Please don't do things this way just send the relative change.

Thanks.

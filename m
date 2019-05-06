Return-Path: <SRS0=99o1=TG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0B2C04A6B
	for <linux-security-module@archiver.kernel.org>; Mon,  6 May 2019 23:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC42620835
	for <linux-security-module@archiver.kernel.org>; Mon,  6 May 2019 23:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nLd/nIhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfEFXpF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 May 2019 19:45:05 -0400
Received: from sonic305-27.consmr.mail.gq1.yahoo.com ([98.137.64.90]:37767
        "EHLO sonic305-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726415AbfEFXpE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 May 2019 19:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1557186303; bh=diI5gN9HF8JhQMxYkvKfWDmJCDZnQbmqB+ssuJKJVYY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=nLd/nIhCbwwq0qD1egKJODxP/drx8Co2a7MYUt2DU3Q6fvfqsEu6E4yKqmKGlrhbYujx+sr8aWL07KcHZemQXh084l87IozJ9b595RagjWdWpACzHLWHjjYpYVffo9w4xNtpVuZvt0W9rGBtzuwia5RppMkegiVW7Lx3wluTkv+asw29SU0rnJwpJvAxwVTsZUZXUvO+kIWdCKmwkqhE+L04CGUtdB/2r5hWvbkgP2t9sn2XpinG2Xt9JC1NxzoUJXe65j1OLbpGZGgrpHmUiNGlO4wcCeY5PdeXymZpt1tn0n2054i3hEVx1C8CVkjOCE3XsZWpVCheNc4qqzGKdw==
X-YMail-OSG: fG2Wk8sVM1nj6oLdHMvjicFZhDVWrkLd8an2ke0Kd1E1QI43_DXjiAo2hfjPCpJ
 UxU0XfMGsAhttjKv0_Y72ZsXnhlsoJc5CaMday.c7_duagARWUdqpGVyWUGxQQT5XIMqfBcQvhWK
 0ZO04frBXQ2hfXm_DqlfPkHP19mrDkyMp1t2mRUwQ1RSTJi4QPoQbyI4n9DzXKe08RMt4Ud24bdx
 4twj9Xe9.ecWxftpArTRgZsVJUjncCTmJc2_CJZ1JdlNiho34_mU.k3ntHHCvBG6S1S6UsqWRwyi
 4EpsaA75C8hEmEJI6S.57rLeD3n7wThfzJU3vxzzUt6rt0b1VdCWb1pxf5ZLNlSUdunfoxkKbByn
 ZnYstQEDbeXQka5beXFS7pfbSQx1OAd_wY6bmyKxnRfEi2qqkZftcwuoewSW8Wtc3oK6ib22k.Ba
 t7KuGvXGy346WusLmIk0KFp6nM935_DqleE_AikCkk1ytqHcNq8gpDlJ8_GYR81bD6rA5fE3cuQD
 85Krs._3NDDuX9SmI6oPXSxPAi5f3ULopz6RvmdB5ZtoqhIS48KGFq3ge5R62fAMnIdnBKNiEMPY
 fCMEGXSQmHReCB.yH8VWukyAqlBmwYoww02l.FFUQXRS2dGt8A8i7Lj78kLqTZ1G1nbZeJATa_oM
 ePKIElgW_ySM.ShvZL7e5zov0JhgLR2OspyUZen49AmgDtj2Eaixpit0MlTtVLJesLkWpnihRABv
 Xt_DeGGevWNB585R4rb6ufkJGcSp1CFTsGTyg6c9F_jZruEJGEylcf7Tk968ak4vk7KmRgwBhJOn
 fUfoj7kRHHDXRJpnAkUHvWxd0WE3S92Th3VIvfi7m.PYGvSfGE.aqPqAV6xaZ1P4Bo7f8YGgjj.x
 kGKtwlEpK7ZRzGGnDTy_mzGPWbs1oMcCaafaWP5SywDWfQKP1JJKv7yG6od8sDW4E6xOsGLgVqa8
 FtR1gXO7XyKIJRy1fljlEve7WsrwiQSzKclVeI02vND5sqYZgnI.vuCCMEXJCYJiEEd0nwSJjS1u
 B6qasOrqCAHnOEGxVPhf9m9UhfnTOvU8koDCXtj6AemIH7UqIDq2L1HlyQeQbQT5k20jq1BfvN5U
 u3.EkeSJkLONUzlOzx_yk7zpW5crrR.nyMHcytD0QAe6ylBV.EpWv2sz1uQN9Zaz6q1vyB41YPpo
 UZTxVZ5sa7ATI1JLmDiLoYx5dTMd_is3lyL9wmPrUCXLyZ6yUoeURpg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Mon, 6 May 2019 23:45:03 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp421.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4463ea35c52ce48b2d27fd96d2d65fc5;
          Mon, 06 May 2019 23:45:02 +0000 (UTC)
Subject: Re: [PULL] Smack: Repair for 5.2 build issue.
To:     James Morris <jmorris@namei.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
References: <b1d1d0b8-51cb-657b-c8be-aa365a29c8a5@schaufler-ca.com>
 <c028ab99-c042-191c-8a18-d34b8ecfc3bd@schaufler-ca.com>
 <alpine.LRH.2.21.1905070730500.29030@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ba1bd79c-2917-2e1a-1380-3ca352178034@schaufler-ca.com>
Date:   Mon, 6 May 2019 16:45:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1905070730500.29030@namei.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 5/6/2019 2:31 PM, James Morris wrote:
> On Mon, 6 May 2019, Casey Schaufler wrote:
>
>> On 4/30/2019 2:29 PM, Casey Schaufler wrote:
>>
>>> James, please pull this repair for a build problem with the last change.
>> James, did you get this request? It's an important build fix.
> I pulled this branch, please check next-smack in my repo.

There was an additional change:
	Smack: Fix kbuild reported build error (2019-04-30 14:13:32 -0700)

that came in on that same branch in response to a kbuild report.

>
>>> The following changes since commit b9ef5513c99bf9c8bfd9c9e8051b67f52b2dee1e:
>>>   ?? smack: Check address length before reading address family (2019-04-29
>>> 17:32:27 -0700)
>>> are available in the git repository at:
>>>   ?? https://github.com/cschaufler/next-smack.git smack-for-5.2-b
>>> for you to fetch changes up to 619ae03e922b65a1a5d4269ceae1e9e13a058d6b:
>>>   ?? Smack: Fix kbuild reported build error (2019-04-30 14:13:32 -0700)
>>> ----------------------------------------------------------------
>>> Casey Schaufler (1):
>>>   ?????????? Smack: Fix kbuild reported build error
>>>   ??security/smack/smack_lsm.c | 2 ++
>>>   ??1 file changed, 2 insertions(+)
>>>

Return-Path: <SRS0=32Xp=S7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367E3C43219
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Apr 2019 20:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0294C2067D
	for <linux-security-module@archiver.kernel.org>; Mon, 29 Apr 2019 20:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qfJ8TsLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfD2UV4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:21:56 -0400
Received: from sonic310-22.consmr.mail.bf2.yahoo.com ([74.6.135.196]:45022
        "EHLO sonic310-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728928AbfD2UV4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Apr 2019 16:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1556569314; bh=2rj+jlKzCzf7d6rHtSpXAPfbZFTmHmhpF5cPUUJqJ+g=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=qfJ8TsLglFb5x68mx4BEf9+kgVgwV9o4NfXb33sS7xCQEOsrUJrdZLV5kYpyXdgLvI5FqjZ5yK11FeB8TcE3Gq9FrDhl3Dpm2tAzYVJ0nx5Tg9LXd6lO+fI61YLOzH660m6UDQhLDfgDH3rNiAXf12Q2tVrgj6PnLOLFIxo23IxwpoyTgziYfj6RkStLY/L68a3F9Qbt16A6iEmARDg4NlRNTEgRQL9gz6MU/nJYOXJAcCE/LJsQk4lN0/JVsJQZIns4wBoIItkU7HruIQ3L85HYdYxXOYEyWxgdGsboHqdVoWZsDFUTHmueoDLROlOltZiVSG3TgxhrPX2Bfn2oLw==
X-YMail-OSG: ism36MEVM1n_y1qCVZgBXyjuQanhHxSlCSsPMQ5GtW4xfXxeHZkEfGQKNkLT.s5
 axVYcfjCjHcAi_Nv5NED03AS4T3bBx6JMsLdZxsqW5_Yn3TpRxbBbI_HzTJItQUZOoBn650iW2TA
 O_U8FP7oRei86kNZNim5aTikO_kNvmaiAOMEXFovNU3tPGbveebfvV.d9cZc59Wwx.zVxlm0x0v9
 UjYzhNZrJU83huwdb8F96tYil7T.89eCFjb7ZH3BBpcL6Eag76Py17iIqjqMjNMUmlyurEKvD7SD
 B7MVBU9W8xSN5wZrgoJyqejqdmzrmr9lEtDc38IFAFz_myo39Iev_SUWJINYgi2ia8kQtELy_.9b
 oh9pJAq.1OP4YIvsc2n2.u0mNcg9v.SeJ32hCAANdij.4sL0UZ6.shokA5uqqWFtMUHAxPp2zQeP
 r3oLteWJIWuWglF0WGZk7JL23G5gnXX8CGQp2iqf852JQsdBX9OH18tt54OO9O6TPw8k0rsQJB0c
 KSDo3oa2l5MbQI3y1ERzWZrSOMX9r5NnAWmMB06D4SxatsrqxajC9gc80Pxb6.TXxZPo_mH8hUdg
 FCaInfPv_3F5pY5_9XEOgNXUE8100YFravN0YGf333cpWHL1oa4aHIk9MtKa5gLVqafiQgAJHSfU
 fvFC8ahpguJDphhMvL4h5V9kVqT1CZ_P7Y7rpPDZMjPxcXdbJWc.6HZpxIsslYlqhO.ytgdiXtft
 la2juAwdOP0hYpYokD4kKZKphucxfJtOhr2HRLMo0K3n9.j1XNHAxgHCCUBqnp9A2nX2hTlcs0wr
 yJVqdJ.Y2vi1aLcOPR4xnkJO8VEBRlHclZqrafWc95x2kPdH8EXCRQ695Kh6_cQue5wF02EsVNwp
 yyOIBv_Vs7Po7og8hN7PhIjo6sxjPC1bLBD_Bc_pLJqRy1jqNhD5mF9FawpiUz_e9Duj4rqQ1D2W
 l3lfYLpBuvxc_RCso8x21zXaEs9FEnFTmqRSnfrHQUt.x2lkMiRKxjmqtPWv0dcazZD7fqI4UNyY
 P5Cu5T6_fGE.VwTjkVSUhgBsCU_GaKYCkNy9KSgkJItxLV.ZZ_uz7Kje2BZrp839w1HimLqbZ5PT
 5D7.gTIKhSljRVj7sCLV_8QLaZPv6Z1zSdTY_0MvGmG_xNL2mzvPR7srelmlTjeQJjIOPyE.apEp
 CpgcHB7ofCCoqxvRmRrrESa.V8R7B9bJ.rzhd1wvaf4JgWMoj6_o_Wg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Mon, 29 Apr 2019 20:21:54 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp425.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1165f6ec2f6a1a9d3ba55a6c5918eca4;
          Mon, 29 Apr 2019 20:21:50 +0000 (UTC)
Subject: Re: [PATCH 2/3] smack: Check address length before reading address
 family
To:     James Morris <jmorris@namei.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org
References: <1555066776-9758-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1555066776-9758-2-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <738815cc-ac59-63c9-1768-26df95689d7a@schaufler-ca.com>
 <alpine.LRH.2.21.1904300558310.20645@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <fe3a770d-10ff-c668-d8e2-fa857ad1b588@schaufler-ca.com>
Date:   Mon, 29 Apr 2019 13:21:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1904300558310.20645@namei.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 4/29/2019 12:58 PM, James Morris wrote:
> On Fri, 12 Apr 2019, Casey Schaufler wrote:
>
>> On 4/12/2019 3:59 AM, Tetsuo Handa wrote:
>>> KMSAN will complain if valid address length passed to bind()/connect()/
>>> sendmsg() is shorter than sizeof("struct sockaddr"->sa_family) bytes.
>>>
>>> Also, since smk_ipv6_port_label()/smack_netlabel_send()/
>>> smack_ipv6host_label()/smk_ipv6_check()/smk_ipv6_port_check() are not
>>> checking valid address length and/or address family, make sure we check
>>> both. The minimal valid length in smack_socket_connect() is changed from
>>> sizeof(struct sockaddr_in6) bytes to SIN6_LEN_RFC2133 bytes, for it seems
>>> that Smack is not using "struct sockaddr_in6"->sin6_scope_id field.
>>>
>>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Casey: will you be taking this via your tree?

Sure. I will add it today.


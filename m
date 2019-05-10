Return-Path: <SRS0=PrzU=TK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67297C04AB1
	for <linux-security-module@archiver.kernel.org>; Fri, 10 May 2019 01:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314ED2173B
	for <linux-security-module@archiver.kernel.org>; Fri, 10 May 2019 01:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfEJBDw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 May 2019 21:03:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50566 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726716AbfEJBDw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 May 2019 21:03:52 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 78EC7A5449B1DB357F43;
        Fri, 10 May 2019 09:03:50 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.180) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 10 May 2019
 09:03:46 +0800
Subject: Re: [PATCH next] security: smack: fix sap undeclared error in
 smack_socket_sendmsg
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        <linux-security-module@vger.kernel.org>
References: <20190509124628.189228-1-wangkefeng.wang@huawei.com>
 <73cebc57-3947-c438-9316-0c64302e97e5@schaufler-ca.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <7da8fa41-39d1-ad79-44db-9ef352dca4be@huawei.com>
Date:   Fri, 10 May 2019 09:01:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <73cebc57-3947-c438-9316-0c64302e97e5@schaufler-ca.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.177.19.180]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 2019/5/9 23:29, Casey Schaufler wrote:
> On 5/9/2019 5:46 AM, Kefeng Wang wrote:
>> If CONFIG_IPV6 is disabled, there is build error, fix it.
>>
>> security/smack/smack_lsm.c: In function ‘smack_socket_sendmsg’:
>> security/smack/smack_lsm.c:3698:7: error: ‘sap’ undeclared (first use in this function)
>>       sap->sin6_family != AF_INET6)
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>
> Thank you for your patch. This has already been fixed and
> will be in 5.2 when James sends the pull request.
ok ; )
>
>> ---
>>   security/smack/smack_lsm.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index b5b333d72637..ff5b7dc6816f 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -3693,6 +3693,7 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
>>               return -EINVAL;
>>           rc = smack_netlabel_send(sock->sk, sip);
>>           break;
>> +#if IS_ENABLED(CONFIG_IPV6)
>>       case AF_INET6:
>>           if (msg->msg_namelen < SIN6_LEN_RFC2133 ||
>>               sap->sin6_family != AF_INET6)
>> @@ -3707,6 +3708,7 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
>>           rc = smk_ipv6_port_check(sock->sk, sap, SMK_SENDING);
>>   #endif
>>           break;
>> +#endif
>>       }
>>       return rc;
>>   }
>
>


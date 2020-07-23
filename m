Return-Path: <SRS0=LdBn=BC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD83C433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jul 2020 16:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A0F20714
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Jul 2020 16:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pt3KMdpd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgGWQia (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:38:30 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:33698
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726621AbgGWQia (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 Jul 2020 12:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595522309; bh=SYRrS6XgmvY8Ktcfk2etLG+BtX95xd9rhH7uXZLR1zM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=pt3KMdpd/AEOs16zlL4F/p+iXomqcM7JAhtKrP1SDdJ2WGIrYBzo5W/vgN5yepLP0Ii4FAKq1djnR1QBjHHBm1o0QFP9AVLZlbfnjlAm5JmHeH5ucYw1AFBRUiZWrCkCRD48m7foAvEoUNv1GNyy5428nRi5vEIY6INbr/KiMjN0Zvi86QrFIM+rVHj0BnQIuNXpG72jgH1QbQuxWg0RvS6jiO/pawnd8GZ7BtLmVjxKBEQiEEEJha4nBvbtIeJBzHwiBYVgXv3lNzEuHYtEJkTKLm/+mn4ITZrkSmRuR/WNMv4SLMtuh86WnFfNsvskPrcnPp+XPcbcb2Nk9wIqNw==
X-YMail-OSG: 8rhPpb4VM1m6wUX4LAHJS2qe8lFkMcillQM9P3nVueMb_jQnecbX98JLvNOddx_
 UaQqhFr80q0MlvGj331AgLedr9YZtRMxm1xkiX7TUbhQ9VoupT1CUr5iES1ZjxDPUdZdN_.be3tf
 oqFonn1rKHse2Vtdaehu_rb8eOQh2FaSTauTzdD6qaAQe9n4q4pSHQJEpYMbUjYMKF.bYxmJGXL2
 KQ0YRza3n23cbtkN1P2l9sH.tFrw0RfAOUYSH7DXAqx50NHDWSc6ircYjt2SinZLU25fqLTR002N
 209zeCzkLE6eU2FsHdWECMKHfE7m5SN_phRG7_44zsY8g.poVnQ0KfoNlgrc4dqkbR70dMx.8yJR
 ZxvG.zSimCNXWp5LK_X0G1pNgWWm55lPwDk2wZKnTxYnQWyKCR8ZhiHeCK_nVUZbnz8rb92KetP5
 UMt1sDVgGwVHA1Dip4OCWm0upI8l1G.6.v5Q2j5vBsqyHErVuwmx.oBGZgoDKVRPsEyKXC6ghLeY
 iNjsCDwOn0Q0peozYbpIrOO1xiR6x090zHbq8BMTPfi8oIOjVGlyEminDZomWeTvKJ3VwkZz1JKs
 ZsFqC9qtf_T0Vk3jfbKeWBeFDJ0hGMsGlvoO2QH24XiRki7tv3p7LAjkYo8SKWul3tsqPdpjqPNT
 OjCLdRnB6Qp4HIWt_B8HylrdWfyAOi.qJ9su972mvm81DuQOa24zceCs.Qt_Bp6fhA6wr4Lrh_Q7
 LqEh9sp2Ovhuzm3p7FkLvmuqA5tvHqmFplQ_FE7fA78vsxpDMThIYB_S7fBa9yFgZEE5zu9tncjV
 EXAe.yIrIaIxOzZvW2kftT55kDGjZ9ajUbnM0r5Ab7uVpS5kWnfp.iP..i58NuZljY35JXJLOiqk
 74F4iuUXgUowTEezgeXJeWSD14KsZIQKouA52_Q1HVwQ5GhX5oQgbs7VLSAhSslDkz8iPG9hZ0qi
 ZXWUiXXjddvcPK8wL9PW.2i4nmlDYimd7.Q9fShM2KgrUAuMt6ChJz21oqzbJTnLthLoRyTax1f5
 5Wfhl.VEJNRIwoZj.KC8GLGc865MPwKojm7zKbZv_HGGFn_L4nMlnraxE2tLYRp24wzIpqE6owQv
 .G_wSFpgE1ZdEB8mGkTiVQJHTWDC1Eoce7rL5G0Ai8Nt9EIjHre0msPmXoCLamtzOtfxY4BwMmYF
 B5NPRCBW5l99.iHaQB4Y9QbIHQoB62BozwK27KnEhmwVKF4TbXKI9m6UIEDO8UYjxPwrUn_wwbyo
 1_1hBf.R8YIR7chQLZLgHUXF8iKhLSXstGWOMxOG2G5O4Bk5es5aszsw_FFxTVEh6B2mN59ePp16
 qWdPBQlqByP__JevGapL3EImjvQWtskwKI7vR3xXroSeP.elMB07x0N0zORHy_d_4YLEBkylj7qD
 J0FhoImMjCPYc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 23 Jul 2020 16:38:29 +0000
Received: by smtp419.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d5534348c85e4e46cdb46855cd18d38f;
          Thu, 23 Jul 2020 16:38:29 +0000 (UTC)
Subject: Re: [PATCH 1/2] Smack: fix another vsscanf out of bounds
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200723152219.GA302005@mwanda>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a59e6bb4-91ef-db75-f91b-1329b073307d@schaufler-ca.com>
Date:   Thu, 23 Jul 2020 09:38:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723152219.GA302005@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16271 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/23/2020 8:22 AM, Dan Carpenter wrote:
> This is similar to commit 84e99e58e8d1 ("Smack: slab-out-of-bounds in
> vsscanf") where we added a bounds check on "rule".
>
> Reported-by: syzbot+a22c6092d003d6fe1122@syzkaller.appspotmail.com
> Fixes: f7112e6c9abf ("Smack: allow for significantly longer Smack labels v4")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks. I'll be testing these and take them assuming they pass.

> ---
> This check is very straight forward and should fix the bug.  But if you
> look at the fixes tag we used to rely on the check:
>
> 	if (count != (SMK_CIPSOMIN + catlen * SMK_DIGITLEN))
>
> and now that has been changed to:
>
> 	if (format == SMK_FIXED24_FMT &&
> 	    count != (SMK_CIPSOMIN + catlen * SMK_DIGITLEN))
>                 goto out;
>
> so it doesn't apply for every format.
>
>  security/smack/smackfs.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index c21b656b3263..81c6ceeaa4f9 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -905,6 +905,10 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
>  
>  	for (i = 0; i < catlen; i++) {
>  		rule += SMK_DIGITLEN;
> +		if (rule > data + count) {
> +			rc = -EOVERFLOW;
> +			goto out;
> +		}
>  		ret = sscanf(rule, "%u", &cat);
>  		if (ret != 1 || cat > SMACK_CIPSO_MAXCATNUM)
>  			goto out;

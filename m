Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AB0C433F5
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Oct 2021 18:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3324960232
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Oct 2021 18:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhJVSEr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:04:47 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:35859
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233380AbhJVSEq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Oct 2021 14:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1634925748; bh=15kyE09GJEsIucVKESALSRHC669hJjIdHKy2VkPcIYQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZCqS7GHMX4jXk5LhzzXOJcxK3ktpVS2LOUQSdrLdXXyB6xc5cu3WW7s0wlFy2r7sYzTLMKCercLSy2r6xmixCE9j++OsjvB5Ty125DSlfzQFJf4Pwky9q3yBcBtEx9YOFXp2A2VBAtKPunoGEYGfaV/JgpMWKkVyQrKGmfvWHqPfo0yG76lwl0N94U+aB4W5JpYsIAEMNhJosqWry/PPtufhyP10o+EpWKYzYIwRqtZvuVw5s/+WSBXcN+Yu5xWwvFBt3XHjWTpXDw4h3zJhPaNBcuHBGmXUuOMPTX2GdNEkglAN8S2ADbRYZv2ML7TTz1ChInXg4Btupb9s8tt89g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1634925748; bh=tEZifpmuQ2NqlUKc9oMu6Kj8N5piUno32Pw6tAVUBDP=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=njwPtHEgpHU5SPFHsVcjlZteHbU20G+n3roohBgl/xKk8a0aLCE9V9AkEpzV/O+0uQAeHWjrNpGpT/rFlcMA4ny5y51llgfhugbh6DhXm7N8E0N0vfeDqs1jEXhcT9557Jjhu9LKFbQQeXlOoaAUZAssgzMX19DWzABKUs8Iqb2VPvxZqxalj/uTYR5amOpPo2NqzHTjbr2YRR8+zCH8mPAp86R6NnLQaU9b6726cjKoz8ViIS46WMdy5qNaZtzLWqy6UGTZGegdQsCpnvUkXfSTrqqzFXzuA9VRiu5kPu7MVn8veJGXgEa4VraRcYDl26AAfIz+HugYQQpz5I0oog==
X-YMail-OSG: 7RXHQEoVM1kFNQk4taIAs5JU9dqF6_4h8HL4E_i.HIUdasT9_fuLPKufRMXDPNE
 uufWeoqmuVe.5g_2YWXt2b9Uzq_6s6SV.y4k6FTlwvgvdwQfk6RhlfTirwvXzCPkOe2tKXWzgDIf
 _9O6f2ttwDnrf5i_tnj6Vt4IdL9zGoD10poqXTh1rhBL9j8rS7ofD.XFdj39zxwxzx8.T6S5yTgp
 vgOJTPLpDpfa2W0ZFLUl8kDzwUAXxQSRmurUKtVKuCXuh2BUcV0k5z_1TPAIOnPeyzsaN3KmtF7K
 B4tywSIxExCIPdx.DSVpeMC1_XQ2BkqgaR31pX3BKfxpUPzmbxtupU7ZwMfA.KvlFX6goZZajjlz
 T400brPvjaP9WhzCj5kVuYRomHjVKYMAqckj1yXuyYuUApfMwssJ_7HoZKFiCflRL6sIL88MdAUM
 G.HDGwYHH4eYmeC2.qO.g6dtnlmRbUlc96wicOfnEomW0LLDl7Cshq6T_Dhffe7GN_D0rY.IJugp
 bqcpESg7qfmsRD5vJxkRrYpqdm2c47zWge4SEJFNiNJljfv2DtUTiAV5ZyqemAZy0UEddFYs.cnK
 Weu6AR717AO2Q8tPy2Fp0AcU7nn0fwOTS2FT20jKLuUpd9okrePytJvhBm83.U0QDCjgVV8Tf7US
 4uahw8mJyy06xJah0yzVhLa_gPD5K_CwRHKi1nx7pG_nU97lAywRHVBQMFLIONyJ.FZTXr2e5jMg
 _G86RbZpoh5sVWb1O9h3mNSJud588__tAB5.2HnPnD9PzBP0nAVyaC8awmpBlV7380Ux1obHxGL3
 wbl297nVyiJK6AB4pK9FcvJD0NWeIm4Q0Dk_SAPxsNOWTjl9tQi6_lYJF4ydrFxbKMt8pGn6zNsW
 ONwm2rnukS82jcYniXNbTBUwP.Y5x8gYX1kT2HrJ8kbBFkMbYiNsDkohLc3GH5YE7wUsuMnEKrx6
 TYP18Y..LbNGYlFEJnzBIdUhvyJgwpD0YANMenrtlS.EkrANHcXs8P7RrWSkJ5jcRcrFoy6TE_Ei
 YoLou4kdKpB0zYSMz4uFibxjMGnQZCLvMkH9nFhWYct9SEwK2Gi3190u4fq9CXCNygVUJd9nUpCP
 SgyGEO6Uhzf4KkxWH3z8B8_brNSjoZ7.xDBA10COtJFzTkUK3L5dJBkIfX3bDAg6heHdulWrNebs
 51sMCHernuhy0U.xFX0ODTJ.9rmQP435FXC5oBC1xngSTqHT80nnUuAPV1UeH9W3SAv2UX0iCa.Y
 RO6i68eVMSYhjpq4X6IEBKfWGexh_1oT1YHp01ZcDYXYILIl.VFeOSf6v6p6dqgvaHcKpRcX3mE1
 HL2PJ8kZ7sVzx7p9sCvUHQsJNTJr.65OmfNxE8DTETFsfTqGuVeZweZuMxVi5rUBVdMKLVZVj_R2
 oPMhgwP7n2nN6ofVc5k6K94qmkr4wlTCThEovTcWkVWO9hAdTk2Efm7j6W1ZeWrhUf_5i0IAJsm6
 BLjpAD0LvMmAG6QkYr4z9BojJfYtG9VezDsSwbd3JXjOJIwMK3L3GZsYzxDHQLzcVJxHfpi8xmQt
 _0VGUhiQ3hH1WP9fgBj.AR4itv7PcxxMZinv2Xc1TvIvdGJkqpKx9JI00Vel2GDSA.0g6TCqMhKY
 hjJp.LthWs2hjh8OyB6xD3nLyICl5E8tUHKMwuZ9sxxV.pWYmbq870MEYHJIQOzeq9mt.7MXJBwo
 06BphM9Dw2smKdB.IU_3mIp7lUJWhH62uakdRRHEkDdqO4Oc4TElGe7YFZf88hf6VYjjxoalApbp
 vK4iGc9YC49LurP9OWZgaAYJJ20g3yzVM0CeM_3LJDqddMzGcFG5AJF.ytavUxwXaYD9Ef1cxUnr
 s9orr0iN9rqrT218q7e6tQUMAURZfIVDGUUIVQrg88dVAVgMkL6HkacMY0q804XymUf8IEZy3MD8
 u.V.7ykVtelbx79NKcWVjcT_S7jpiI46Z.Tnx1SqmaXERH8oQ3sjt2Zpi9xerse5jcgYkrMYt75n
 CuJavW6di9Gj606YKSc1oSFcuRKBFTKjdhjBxbzPaUnwNiwLebN0H133gCRL7p_88ahS9MJ5kGuG
 CsgI6RDGK2EofvmGrQHAdxIB.BtDbMu9BMp3OQI7kgfFZWr.x8ottBzfFMUn4U.I9hKshAUNUxv2
 aijtMF8m57kYDnpBqTqi_R3dd6_G9gTOXuHd8nOAZWRrpbDGtO2pgSwgEKF_ovljB5QweIzzGiW6
 wYI.X27BCnS8YSkxJEJJL3kB1P8PdneBGYccJJCBicRSGibmjIuDuMXBYZo2aqQUE5t7MoPPkuy5
 1Nh25SIbtEaIU
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 22 Oct 2021 18:02:28 +0000
Received: by kubenode549.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 6bd622872be18523a08fb626739387ff;
          Fri, 22 Oct 2021 18:02:25 +0000 (UTC)
Message-ID: <d1ec69ba-77a3-504b-e2a4-56d0ad7556fd@schaufler-ca.com>
Date:   Fri, 22 Oct 2021 11:02:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] smackfs: use netlbl_cfg_cipsov4_del() for deleting
 cipso_v4_doi
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        paul@paul-moore.com, Paul Moore <paul.moore@hp.com>
Cc:     linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+93dba5b91f0fed312cbd@syzkaller.appspotmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <0000000000004b5a3705ceaf6908@google.com>
 <3be0eeb1-c1d7-9809-ac27-e36fdb62074d@i-love.sakura.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <3be0eeb1-c1d7-9809-ac27-e36fdb62074d@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19198 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/19/2021 4:27 AM, Tetsuo Handa wrote:
> syzbot is reporting UAF at cipso_v4_doi_search() [1], for smk_cipso_doi()
> is calling kfree() without removing from the cipso_v4_doi_list list after
> netlbl_cfg_cipsov4_map_add() returned an error. We need to use
> netlbl_cfg_cipsov4_del() in order to remove from the list and wait for
> RCU grace period before kfree().
>
> Link: https://syzkaller.appspot.com/bug?extid=93dba5b91f0fed312cbd [1]
> Reported-by: syzbot <syzbot+93dba5b91f0fed312cbd@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: 6c2e8ac0953fccdd ("netlabel: Update kernel configuration API")

Added to smack-next. Thank you.

> ---
>   security/smack/smackfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index 3a75d2a8f517..83b90442f963 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -714,7 +714,7 @@ static void smk_cipso_doi(void)
>   	if (rc != 0) {
>   		printk(KERN_WARNING "%s:%d map add rc = %d\n",
>   		       __func__, __LINE__, rc);
> -		kfree(doip);
> +		netlbl_cfg_cipsov4_del(doip->doi, &nai);
>   		return;
>   	}
>   }

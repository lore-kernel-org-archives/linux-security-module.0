Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB886C07E9B
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Jul 2021 16:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C575D610A7
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Jul 2021 16:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhGTPx1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Jul 2021 11:53:27 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:39442
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234674AbhGTPvf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Jul 2021 11:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626798733; bh=QPWqU49npv/R2DjWr1l08Np3ncOCn8irOrMqNLBb7jU=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=qnmzgwm9jqtxhsLb8HB+WogImW0uXur+820iksKXNgrpceZUGJVpeHoFm//MwjJLH3deGzbu1hxImbWi7QTOnooBGHflq1NUTAbWQ4hezm/p0/3zvMd2rjilKJkr9MJDR5Kw5XfSp6qSAZ3OtjcbQNMyQvuJgfCoT0Gve83C91xD4ZURqTR4plyVDwORImllUHG8dmIY1uDvt/qOOb43La7c3rbPnnQCZ0uxhmW6XX0dsWzXIZ8Fi3kGGR7tJQ9XlkaQ/ywjr+SLp5eJxaplz7rWm0JkQ6v8Un6r/50QQaUrHS/QPFpecTFHTqclvQKpHacXwRojr9PoWq0XaAZX+A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626798733; bh=WkoDYeCnvsHCYOWmEzsKV5hTHXpWUtPdxb+EI2mGNsp=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=snpM3hM01ApuVXPD7DJ+LvgF17zwq5iaXSbrU/hHw4hVJapAlfUOadeDqyv34C2t1RH3TsPbWP2FeNOFmYRBUVmwhAt37vL5QQy1u+3QiIKsXXCnFXARPtt0Ee6xyRmrTWLZTEYbf0HO/WUJ93sR+erflwzygdzaBMmZNrocQnP2M/lFNMhoDaFVDucwblCglzNNWkHZ858fBOCpLeA5Ek6OqYBRa60LzdngOuo4/v3bkXNc5kMYw6c2R97K5eQr5N5X1FhPw6ShVG3bgW+oc9G5KTsQz8TJXgwMjZwOnYx/Y7SuAafKZCM2aXGy6dBNJeV6v/dRHR1mnHBg9IB2FA==
X-YMail-OSG: s3Uo0ssVM1mkcLU3y0b9E3b3wg_ryaKr3FwznAy752zvcitRmUT7lSvikK.DEDj
 rEZgYee3MOtqNxTvkDMh62lbyU3Q2P9kPpV2R6PXuOdlei7..vo.nTsZjG9vj6Uhswz8YIXZOzrh
 AIUufEbgCWj9EKZqcVaAH03ksgAlFVYAwOdoSnb5.ouRRNFKlEOl6UhsRLhbMFcYeV_SEHU8rK9r
 tP1ASFH_OuVEjE5hOl9uAw2G_GzPJlln5maIxEWYRqHIUmpRm.NNcrbIZf5fmjv_M6ZfFchgwoxK
 PdCooc0aQRCHumivHptMztFTlq4D3rdzZE7bJ2gTGbg7gHlVoXOa17aGH2q8D.9pYuVejGolG5QX
 Rq00cykcwvvJLtBV_hJmWBnMXUz97N4K7Rw.jtKpvNNVRXCaCgtAjhoaBLhb8CtfnpykGVkBF94W
 6D0prWa_dvJqH7FvqvOXBWgTC7EXSZRGhpDKILGd_k89ixkx7xjNYqsK.3avTqk1QxfOOFscIzAl
 Kbjk6_XFzvfKtOnXbNsKRy.U_prrNumAadFDBxvTNbVlG.4ugY.Pe.M_0ihyIMDcKO0lBEzYL_7A
 xiKka9eQqWxP37A4DNr1i_bfgE6WKjXfowYeOIIifz_xWO8C83qZeIg.lUpaAXSzY5DgNFG92huZ
 PCC79mWaBQl9t3PDe560AyDRxguvfyU8VZFcQxRRhOJBsAj1skGnEii0Y7L_5i.nW5JB4WR7h1Yt
 _4.nfvSTw7Duk2Sjf78NIWot.1un1Yv7xWmk.TPr5.1l_GWZYMXVpOP2T8qNOM._p3mqruXCUA8k
 RSVkmgY6dN6vI6rKfY_eqHi2Ghh.MI3F6bVk8JKLvCHqY6dNL2qq9wFsQOVLzKfduIDJbwA8_vmf
 RXwFiwhrOM.CXWexFN2Y27pNKGHq3Ykt3Vr_gGiQTR4SKwkEQBrQW29rshOHuAjR.mX9ISWALYJa
 MiP3vCoU7cnp3DvnUvf8S8WQzoxphM0EuWKjlhSbWub1J9TJdrveRhSgNRsqTNaUmacbBalS6yB_
 2DJ21TemG1frKtCdjJ9T.VdhuzmJzXaz8UFV3bRK6KequBC2ql6kv5V0dOm.xp2zVaCvk8d3dZPe
 HjwIk9Bcqp7ak0fNARxqzcgulxJ89pWw.Rlx5xga2NGhO19ZnJFtZc1uzMQcmlykj.uBG0PF3mMD
 sh2Gz5FUxqZZcBcoCM2bT3bSD2dUQeXOnN_KOiEqgzvjTUptzMpJc8ej.24XaLbTgLb2Bnlfv1Md
 NlIDmvLn23HkcewEkNNf47WXqPm1rSherzSbCaNWRqbci1kKR_xWFVCK4cC5KvFLrrbSGLdls2ne
 _EyBxu3KPxrEFSHy8nvTpXeyvM_dpF6Opmf4yOk0qbrdQhCRrXganHs_.ylNCOp1C_4gaAcJcpqX
 YyIfj62w2ET1vIu.jtGI0eZrdQA8EpnLzbRF7kd5RG5UiXo0brUBJOPbTfFaqXA14rZCDuJhSc1Z
 MHcRlzGPaPohOIwumTUoYB3GQWzax_IiFAZfwZqcCYkjIVU6gZZcNiNQFNQwuO04P7HfeyRW9ITo
 9XIvAkMzXIj4Z2mM3Tce1MnXE39e2SxqZTLXxCdmjnfykwzj_RmfYmbXQv868OxX8PhwjoW9xGQa
 .2heNUhnhbtLLa3Ai8w8B5EWRW6PQluCd6Q.F5rM.3Kr9R1pEJO04T0IM4W67BadXAWcwx5JGSAQ
 wSkpPNaSU7Uc.edrQK3SSRzGtDG452Sfmlblg.8fnvhmkct8e5cIDnYz83.YimkZl54e2dCqBaK.
 xd8dEHH7nT7FYQZWTv9mk9lM4ZYQGTpqG0LhOcj5I8U4g.E.15Loi7MqWelfuyaJCG7YEZ16QbUl
 mLRgHiiai46wGAlNURqncRizITmGJ9mNA75jnLPZhdyU4rZTzecUAFGbKFizS6hwRV2J5XoqOlYN
 HKydnlRzY8xPGqdPBCz50R3uyZ9IZ4aPwYm5arLdS0w6kw8CVFbuXCMdR417tRjVG.LmTyUV_htL
 5ckkZ35YAu2_4LzvYzB.hFSMNXmxXe0YAQYwoLAh9zHnEPF447eQTIrpteuy9LJ5xFv3ILx1Wcxm
 Ffdt02j5.dhPXon.nVH4EbrBDI3ogJVeUgd8NEnqo4eWt766tmJUyCRXahxJcsOutwhUXKTYdles
 Z3bWrfZcO1CLWoH09nRkg52GWYDI3i9RpX3_mQKRXBZzZha1bDvcWxC3Id89VccHNAlsY8mkJwEx
 KTUmWCrBuodzkiYaipX5aTHcPYMhpbM3_8syzzpYjUm6fQ98OC7336OpmpsKNeT.OLvS34HjpkM_
 lz6w33x8aEDTi80NuB.zk_IJ54U0OvWzLYCa8jb.NbioDktn0wtn90h9XnVZdzT.hweZPrOmijiQ
 oG8M6wDZr5ohl3myu_jrSSyfOofNR7HuiZEUlsmgFpQUeOw8DDUoIyM.Q_CFbPTS_pNmTXnF_h1T
 VvZxJ9SIQOnF.1depg7vvVyOgDKBTQQxjT4upguVJqYoq2Bim7pZ4_.NG5jGeJfByhDuHgwFsIt8
 9oxezKFZmz0KkpNthbyV38wlqNY9mAnCJZBSppCDBHHcBm9LP1dhl_BWqRphUpg8ugFSnVA3HD5w
 c7f3bT8MCSD64XN8-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 20 Jul 2021 16:32:13 +0000
Received: by kubenode546.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 9a63e25fa356d206a73d56ccc807b629;
          Tue, 20 Jul 2021 16:32:09 +0000 (UTC)
Subject: Re: [PATCH] Smack: Fix wrong semantics in smk_access_entry()
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210715091724.45768-1-tianjia.zhang@linux.alibaba.com>
 <ae938c7b-2f7a-27ec-7077-ceeb517ba97f@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <20b7bc36-89fa-d004-74f0-629a42595f86@schaufler-ca.com>
Date:   Tue, 20 Jul 2021 09:32:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <ae938c7b-2f7a-27ec-7077-ceeb517ba97f@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.18469 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/15/2021 8:15 AM, Casey Schaufler wrote:
> On 7/15/2021 2:17 AM, Tianjia Zhang wrote:
>> In the smk_access_entry() function, if no matching rule is found
>> in the rust_list, a negative error code will be used to perform bit
>> operations with the MAY_ enumeration value. This is semantically
>> wrong. This patch fixes this issue.
> Indeed, the code as written is functioning correctly by
> sheer luck. I will take this patch. Thank you.
>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Added to the Smack next branch.

>> ---
>>  security/smack/smack_access.c | 17 ++++++++---------
>>  1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
>> index 1f391f6a3d47..d2186e2757be 100644
>> --- a/security/smack/smack_access.c
>> +++ b/security/smack/smack_access.c
>> @@ -81,23 +81,22 @@ int log_policy = SMACK_AUDIT_DENIED;
>>  int smk_access_entry(char *subject_label, char *object_label,
>>  			struct list_head *rule_list)
>>  {
>> -	int may = -ENOENT;
>>  	struct smack_rule *srp;
>>  
>>  	list_for_each_entry_rcu(srp, rule_list, list) {
>>  		if (srp->smk_object->smk_known == object_label &&
>>  		    srp->smk_subject->smk_known == subject_label) {
>> -			may = srp->smk_access;
>> -			break;
>> +			int may = srp->smk_access;
>> +			/*
>> +			 * MAY_WRITE implies MAY_LOCK.
>> +			 */
>> +			if ((may & MAY_WRITE) == MAY_WRITE)
>> +				may |= MAY_LOCK;
>> +			return may;
>>  		}
>>  	}
>>  
>> -	/*
>> -	 * MAY_WRITE implies MAY_LOCK.
>> -	 */
>> -	if ((may & MAY_WRITE) == MAY_WRITE)
>> -		may |= MAY_LOCK;
>> -	return may;
>> +	return -ENOENT;
>>  }
>>  
>>  /**

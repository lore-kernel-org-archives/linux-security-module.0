Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E643FC07E95
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Jul 2021 14:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C67396199E
	for <linux-security-module@archiver.kernel.org>; Wed,  7 Jul 2021 14:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhGGOaH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 7 Jul 2021 10:30:07 -0400
Received: from sonic309-26.consmr.mail.ne1.yahoo.com ([66.163.184.152]:36605
        "EHLO sonic309-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231643AbhGGOaG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 7 Jul 2021 10:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1625668046; bh=KWZXSLTZqkexTz9n35/8vPBRlnaFzy3QEtINpRa5V0g=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=uIA/re0u3NoguTabk9VAU0dsPlXV/uiRvVPgGEooTM15da4T14CsOMk3sKmKcFv9Z2QPrDbSI5HewJbyhJNGnx/usRUNMi/5ZmQ/YHFBekXSwlU4YR5aAPPs9XDoyLGOLbyLLSsextPCYWlia3bZwdvZezqJWh9KjyW/wAzDA2IX4E12zOW3rNLAavg814xbJdF6iaKYaCp095SXSbj9Qevwu44wGmIXcm3txZehFCwGdInfHUEs7TRREz8Xsho8cKLIQGwzzKZsLV1GiUVMgwtOtpJBdejX1gNeRHP05XMvb3Uz7YiMuSwg3vBklHWFXMh3Hr8qLaS7W7pYH9uT5Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1625668046; bh=z5+rryIi1ttAcLde+6HfivHZNK7LEyJibDl5A4uTWKA=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=XXblwPgz8XJ8lH+2r3kXXD9aaC7BZ4yKkFzumhXfGc2Hm+DICiwT5sKSuHzVTtBd52i/LQR48jowDh0AtfMf2WTTV7GLjbuR7lMvDqvkKYIz+b0uTSYmwsjW2AnZT9wSRAv383dvFe2vPyNxSnK4xBZcHL7pZf4wG7al38AWga3V/EC/tEJ8unZh27wNji836umQaJAxjIzwHQdIdq2clwpcMZvjfOX0J/9pWUsxG+Db0JT0na+A8OJE8FvuhmdJM6Tn9Jh16aaljoz5pN7vRIvGbTuXZDYotkBkGePjspvnokAA9qFqtH6lq3W50S1mYnpwXKrnY4XEX+J3rYhFrA==
X-YMail-OSG: OAYSvsUVM1mHe0cBRAldvk0zm.lQTG3tVraufCPAzi8XK0DZr6g29lbM7cplVwH
 5kX4ynWVWKlZEhW5Inx_o2geeR.B1l_qBpw.zb1Ad3R4VfSlKxc8oBklnJIucKbO9hJ7N6t72SzI
 m.7_CynyQ0eF2v4VsPPRUPddZZNGrPxnQRaRlyfAsVxdcM8Q8yd0Nx.9aJxTooUJYCwUFvLTyPU4
 SiK1o6i6io6furQ6T0ybMV7Fei7tSjMq7xkt4Z3p81RIQC4yeeZFOMDQzPHSb2q81yKwaR9Hl3X5
 UslHs.diGL1wauZtKXf3SSNPNlOEVnPJ877K.8S08JH_P1NpWmPHcV4zUnMIvtw7P77qFyBOLhxU
 9zaAoD2OV_upc6IRgMh.PzYCwKmb5cOLiD0Olbj2F.YPUgfHyqDGguP8IZpnYhSnVwFilVzQPhwK
 .IkULJ_RjscWVS_hFbzIm1pcxq5QdDr9hx.V513K4PQ8mYOm05214CQfA.5vKdjFjUr9ImcC4aFJ
 QFp6ETzqPG1a6OjPQ9A5hjndwbyPOsKqEfujPvEf.5lbdPeu7AeUD65Oc_HXejhotK8PoG8X_FhF
 bZNLvFSQApC6a82JgzAx4vjdiandLcnRT3VTSwY_D7SkNJp10I7zX4ws6u_VkQgeeWdusNDmqNuj
 K2fclUmwjDhtZpX_y00wFtiZOGIH.5zJB3T5p7uH383hJ6SK3q6n2FNkTRuukFLdUXiQnBGVNuuB
 _Fpj_a27.pB8UCIhd.F4Stz3J57FLnltLggRFmsUrnluF5lKQ4QiGpkNe8iav5uIXqt0rQdP_1bh
 .rjZ8qp9JF0fjW7D6Yqb88uj66dJWcQjgvAWVDil6XWYzCfticxjlrPx9e.Mvg1Y8zLxiq__B1tJ
 otdQbisA1qD9YdiHzWB3FtnQkyopjlLtW1YwmKZhp7IHGRYdKzQ9SNq3YGo7U21Vl03euiZQIRpI
 3C.JSw98brnTnrnJU_JtlOvyeJCCpmhI866tf3nX6CVPgnSGX8NC_pMQLJCZ2k68LheF8Ly0BSS1
 t_zmiMGfNvAgRGrhCDUJeNscZQwgHYuN.fxt28tNHj2GDE_I3MK2rY6xaGRUGcCe0MLY5iVs54B7
 ufzqdfeczZXVnwEBcIGffID81XmuAPEDfggV7s2YbYvLDq4IuqZtQ5YT2d9AEd9WqMnpZK9f6EYk
 zJtylCFFJFXUzi7NGzmze.Xh6gH0MTd7QBRxSmggGhF.3ulHdsTuKtxJigAfQFs09wtFesM1sbfh
 3ed5X0C3AlnDtOxII_mtGA0ODhSINhdWmiwXkdDYgrIzdwVF8tDtYDjq0HYoyaSwyo94_SFDn3Bf
 ZPDibLuoGY5n_3XB4eL6DvFxFU0A879gPaFHMR_hUL6gVn3sJcXs1648TjZuVhxc11eIOo8LmOHA
 aJ0DQT6MzklJT5F5MmKLe0kTaDOWs8nJf7C2fnhElL5a31qG68xXa5lIKUIUQ7VEXud_SPV.S8.9
 4BSos5_.y_h04PTiM8fHnsHG6km.vyVZyheS6I9o69r2h3Qcex_6rjU9cMULAetIuGRKeYUgIlHz
 iw66ZoVhYM2g5.6zTD9OS4ZjJBs6P1o_qLjlBbl62N4k8zaYdvDxleNzFzTomsnM0thTxnqhZULl
 KZ35lZ_etfqKNz.rxeR2sQPpQR3Hms6pARAouXTgsD5V1Q7LerIn.86TFQYWfqHV0jp6Een97V2y
 y8PByS6Otbroy5HiQvRvpKA0LI8psyykVf4Nn4iJo5A1Ucip4lbPX.ejIlsvR6ruD.eakj8Z9GRc
 PUy2kriP0wx6TwDp4CQWArb20ycx5ET8KHvEh4Ey.EN7SUmw582CgTYRAO5YHulCi3_J8qyuZ4vy
 HaXPti1fbqCTiY.ql_nw5eAvoGnareunW71.wQRtW2y1C4gL4G54z5HNd2WsmVhWl6Kn8nCEqiDi
 hpcgx3vcfKg2.P8OPLDR903Rb_MtIRWbpPwFBtxmTzpH9lyQHvMd9BzaYAQFmhUsjGN3jQQzW..3
 pfZg2SVvfLZ1JKypNtR8L7UKlrfC4bsRnjDdwVeu0wlWCD1VmImgQIAr5gf7xfCJCkCJ01CoFO5v
 JtgXyQ5LwgyHPGBMreRew57vm1P51y7YkVdBeuN_6qMGmR3ckCf7TnnMImyncmCwXMxO9LBgScmB
 2r.UcKoLmrAJSmTdlL3fRFvLp4twFNYP4RO4x.Nzkx.jcJz0ZgATz3AqYPofGF1fvPT_4FOJ2KMQ
 sHZB_H3SrrQpDt6VgUENpHXiNjOTuPI.92UZAvi1rirbWbPmiD9eodg_ADWNpS6cMb514f6q89C7
 633Ed1kvEQefWMNWDZmMKs6HFl1h3eNlzW0akJftE4fNy5mrf31prsWaJj83BfznPVC0wxc_F0VZ
 MUGsmFG5I.TKknHkqBOgmSiBBpsVAOEyjbHatukoQzGYCGmh1JOxfS9g_S7AJTEGhOgLkyl1HZN.
 UUPyw9hnAOJbSRkzFJnut8FODnPnoylVnhDxRzGcNswPwyXrRJ6UxvjgJW9fMnAqFh8.QBhus501
 .OtddjWdcz4w3Yc7ddv27a0fuuj7uSkmzkfid58t9nok9.ij4Qtduw.X47YGsV0AaLzmmHhIAz5z
 apO3rqC5A1H3Pr1PJbq6zyC35ATtwaVj9h_z.adfbPE2yiKFS0XeGIOlemTSSPrTgdL3jrHvPyPp
 kNZRaL3ooLwUP1Jgl7UaIdlkdvCvYTAzHZm8Qkrvr2fl3ME768TzLqwZDNGiO4O9B5dcz4EZynLL
 cXyXoE9sW7haYOufkOW523tvmIUnBvgpI5gv8j_YMhop53kbpQs2y_ZLi.YDp1EQHLGNS0HcNOTo
 b0BAleSlNrg3MWmVTHZfnLK6w0trKLX2_PrWbGUez9EcjOSu0ZR4.FugJ
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Jul 2021 14:27:26 +0000
Received: by kubenode516.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1a742fe85099dc2bc57dc9ee9f1f5498;
          Wed, 07 Jul 2021 14:27:24 +0000 (UTC)
Subject: Re: [PATCH] smack: mark 'smack_enabled' global variable as __initdata
To:     Austin Kim <austindh.kim@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@lge.com, Casey Schaufler <casey@schaufler-ca.com>
References: <20210629134144.GA1168@raspberrypi>
 <CADLLry4_qB607aC2WdjvH6+QWijPNU4cQNhacr-mLOBN-heZAA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <304f06e2-ee01-2b25-0d5e-750d2df6325e@schaufler-ca.com>
Date:   Wed, 7 Jul 2021 07:27:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CADLLry4_qB607aC2WdjvH6+QWijPNU4cQNhacr-mLOBN-heZAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.18469 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/7/2021 3:14 AM, Austin Kim wrote:
> 2021년 6월 29일 (화) 오후 10:41, Austin Kim <austindh.kim@gmail.com>님이 작성:
>> From: Austin Kim <austin.kim@lge.com>
>>
>> Mark 'smack_enabled' as __initdata
>> since it is only used during initialization code.
>>
>> Signed-off-by: Austin Kim <austin.kim@lge.com>

I will be taking this patch for 5.15. You should see it in next
shortly after the 5.14 merge window closes.

>> ---
>>  security/smack/smack.h     | 2 +-
>>  security/smack/smack_lsm.c | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/security/smack/smack.h b/security/smack/smack.h
>> index c3cfbdf4944a..99c3422596ab 100644
>> --- a/security/smack/smack.h
>> +++ b/security/smack/smack.h
>> @@ -302,7 +302,7 @@ int smack_populate_secattr(struct smack_known *skp);
>>  /*
>>   * Shared data.
>>   */
>> -extern int smack_enabled;
>> +extern int smack_enabled __initdata;
>>  extern int smack_cipso_direct;
>>  extern int smack_cipso_mapped;
>>  extern struct smack_known *smack_net_ambient;
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index 223a6da0e6dc..cacbe7518519 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -54,7 +54,7 @@
>>  static DEFINE_MUTEX(smack_ipv6_lock);
>>  static LIST_HEAD(smk_ipv6_port_list);
>>  struct kmem_cache *smack_rule_cache;
>> -int smack_enabled;
>> +int smack_enabled __initdata;
>>
>>  #define A(s) {"smack"#s, sizeof("smack"#s) - 1, Opt_##s}
>>  static struct {
>> --
>> 2.20.1
>>
> Dear Maintainers
>
> Would you please review the above patch if you are available?
> It might not take long.
>
> Thanks.
> Austin Kim

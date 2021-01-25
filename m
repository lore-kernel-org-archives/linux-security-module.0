Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3366DC433E9
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Jan 2021 18:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D953B22583
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Jan 2021 18:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbhAYSJe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Jan 2021 13:09:34 -0500
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:43975
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731247AbhAYSIz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Jan 2021 13:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611598089; bh=7k3qtU1Xy8hjVNSaf9l4d6inNey0G9clrCt1MH1ThgY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=tyHWDaDCSMb4fzLE5WBdWP/SdCbYmUcEJMDjVRSZ8pWVvy0NHGHdW1cpEJti1hr/Lcc0u1ZuHF6Rt/iM0DrOPg5R8w1cORNw663PumfU5VOnBCmINImE8DMAhPh+0sq5m71fG/Ymeacc5BhbKzkFQRZMdDmY6MIi/4dttSpgGmfkcjPLTU2Rs19y96xtf5WRwSmxFy2d7qt4oG8YOGfqlafS2UrfPLs8eOFoYBP0+ZooAVZnkUu+PdWVumoxqxGsSMIxOXA7XYsppCHBQRuYjQY/IHrkG8TTwRvfQjQJn+iJdBp7navKmvcVilq+fe1B4tQALGpJ/WacGanIMb0Tfw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611598089; bh=Qtl8yjqwRzz5iHq2q2pYoZaAm1cJGTjwgpAfuS3ja+W=; h=Subject:To:From:Date:From:Subject:Reply-To; b=Pa9mUiEyhXnr0CFxZ2lhm1f217spo6X9IhW5QymA1qbLxEk+wXKIkuHDROAVyF0aRaN0WhxF0ooDhzlnYBRBGOfLKeCnm18Dei0azlwYMy5O1UGebw+JlGQxANts+7MwCiCsB9zjRQ8/23X5KDmN87CS3YwRTVeW+8vvJ0Bmsk9/X9uQG/xwR+0KBDqqp5dRg7Rgx61bup/ux+vnLR0XNiUDK0ZYjxjG32W9O7qpfBRLAZ+1gV2Eao+IS99gpSBix58z79claLQbdIFuaOtOssPra+4vJG4N0kPnLjop2iLBdE8n2jGFUm0jga5crrUFqig3krioQ4FE2LCkOCBsTQ==
X-YMail-OSG: T9.5.BQVM1mNLDNbv51ErhE4pGWyI2aHy7yb3aCO5IycuuVFZh4EokYU2aJk22Q
 veDI7h68EEq87BnDzjoZEvaOCsiehvQuECj7zoStI.LhZLl9GSrjjvFrEt5iSrBB4eCVikLOurGI
 MCELmiJy9.UFG_kEY2CGUYRk.xpvh_eOrJTpHadxTLvei.46rCcFOK6VqPaQRru9uy3aA1.F.eZ7
 mikzO9KKG6EQdbNOYibcfdSdAZmiiv6nDX80DeOUe_zkHJxKRc8vKc4MH4MqGXWpfTkvjBUJ5hNM
 zQyqZtqtBK_exeADSJozR5AjsPjZ.RXOTkGMDD2eh5duVhZegnhCWFETa6YUWZNuhzOucIg5AQ1o
 xUPrq4dfCFeERzcpk2BQF7hdOhdv8f_s0pfgx6L2o0Fq.4jZIS0UgiPp6RxyTnkzxWTJa4EkUUS8
 RdOg8SpP_umYvzXM3dn0qCEqrMiJY_4qd4LLiF9KQ4.AglmAFqe0XbZfEbjg8WcIZWY068yu97P1
 d4n2NM3r5VaZJqk1h2e40..Ay4Z_hG6X86ZqoimPcyLbUq2qTwu2YvYMfVYa_mUyAuERYNu3zXtR
 O0unnQiBps1XLfnO7AJrHAXHRXS31puDOxVGSBZqjxBVOiZAa_p2YGpqkQoyr6ln.RnLCDqQ7TGj
 _zbRwllDHivkTTyn4PbVMSCrqaBYav2a2Ywm91H7wyWL9PvDzxj1Z_e9LrJZIyzPlMpOWeuciP_n
 OotfZxgu8CqPenq6.bsE.gCg1mpE3n31x0yI_qRFsVrOVyx6Z0BA8aAqUnDB3CgQctofRlvGQ_LH
 MyqfK1p2P9PsnoZ51faGGYmrDxItDGh1Z2M8GP7M6KeX8f69hyM.n3WHomoqSSMBrH8mZFekEtJt
 5Gf3X5nLASbaflYzQDEMZt0TwnQFko.UUVFifSGZ4I8QtMWvn7i9xNmTtjK_wP3otHHQ1uNK5uhb
 rIyAVcD2DPmnhNAjEEfo6Pd1X70Xxn8Oxd0dc.BKwzYZfoT6GY4cy2cHIogtRiKcMHDPMC8YYPMD
 lyqeQw7pw41zbEv8RpoYNyVkiOrNCuckpeScJs16LfVx02wCNS2BlZ.M51ryzqvGqar0Nbnwmr8Y
 pd4sRegbJ4vrE.iZgw0iXNY6_2coQ93wEubudmM4B_e_omwd7i9xIxiSb4ojdMYwuEeH_cYNmXLn
 ikT18D_wywHuFN202m_Q1QD4Wv1wRE3JUYhHknvnzpIOwtWvJCpdGoNweRHqENxj1tcNwlBoYpj_
 y7GoqMzjAW.HXGuKVwjkSQAYAn4QAnyXEnMUmAtTfHrabXl2OwyG42IWsqsHIav8svJg66v.LrPf
 yEZg6BmW6iYkTgowBQz.7J8p8WtpPtUIcv4cEM5L87reuWeUkS.QzhIlEQYB2M4qSS3OBXx_Y6mH
 pqUIRV4Xph6zE5sC6YDJ8W0yQ97U9gnQUBXzXSYBOoFq7TMHYF8sg.drosX7qbEBUyaEz17z4Szb
 6qU6crUT22S9YjD95JyMDzcsL7o2KfZuTHHXtBVyo1_WzMYcVFDrCiYRDfL82l1z5Qj6sVeelPdF
 AhDN7H2W1N.vn_HACj3SLptDlALdoahxMOz3mn136w0apYTJqwYhCb8tRDNAXD3H_v3RGezJXibq
 UB9bhp.ntY8Q7nj_zy7RQdC2RkzR2UyCKyLftB1F4WXq4ndiu6J7U1LuWnPC1aiwlD8Q9XEvHUDX
 J8NA0AOWkgpWHR47NnYszZS2wAnYch9hi.G297Az8eWX4wZiXE7EToNe1XRK2C435e0TJtKrzUAR
 4NgVevYK86pUXp3MD5y2CcDTAz_tINHboLyIsXFt_yzAHrc_LWkOfkhBXKMZjhubZRWNhXyrw2Rk
 HyfdUCXg96JtmeMLdQVJKn4iXI3KYZjr1F90CcohLRyW00RHPYP2MDGP1XDsyVwrUR3PP6o68.fn
 oEz4vrimO8em70lyF1yooka7Zt.c5nCznzrzODkQhFMLeN4jBUa_fmuSI5wijs.IEAHhJvauY9Ap
 UGlqs79mLu1dgOKIgH8jW46Jvrtxi7_R2P13wNu2BwK5DKqRiRtP.y9R4Qe4lq.atpk1VWlyMoaL
 CzT8CA3T1Nqqi0A8on4Os2KGklhN5LuByJ.jXGQV.VxxMqxt0hmbh.wB3QSIT9dUvZxv8U5qneTq
 90zH.QMBXeB332O6NJFXtMYf5DdKvUsnUt5AKhxghiBiXpV5hGWXsyP40461LJnx1m.wItzJO8nl
 BkJNuloW5ESomEQSkHdq2.1SbeUmfJV8x8cuGaSQwu4Rnf0Gx4faRTVMTaB7s.rnOU3c_VSavv16
 pCD7cfBsfahQ28IH0r1AT8wCOs7oy15x6ZBgpkmUTPCZrNnj5KZNZtOZINGHWGHhV6h10OiE5zn8
 VFVMmJS8pEMi1iKdssFYqNDis01ZHpi9_qmKI0SJHqg8rmYAl7u8q9pWDxNeOYy82yuo9Zf6_mig
 JoOf4W7J9g6_S9LrqZlXQ0k32tgvjpWE6CxfnToBuc3ZMdGgvupawIxHDBmQLqCa89TRtT4khmZQ
 ByInVtyyGhzcZXseK.mXWQ5t_rHU_FvuhZNWcvAR2jsEbvPuhrUYUhGc80n65PjuTd9o0LAcKT0_
 RhFbipFwa9GF4r0KcfTPbuyCT_3LsZ.cn1CEhwu0mITGeUqobJG0iucjiIxPRrsD_De79Ylsbf6H
 hC5nmbJJc8ZdyU27qSddNh_XFltIir7fBtGr98WstAbDyY8yx.EFZ5MifYlGMdXDN7KzdQKM8h_c
 o3OeFNuxiiEtOPEJ_6wULnOj6yU.GXfnmYiAe.tbH4WA8xzaC1_1Cu7lbHE1Otjqj5.DyWSaIa2F
 kJcUMkubHMtZCWC1LwRn0dM8CBq8zDsQFFRC75FvsIdAk6tWtVI16F5NTnbVhwbuQyJMpzX1G7G0
 3TeqtlOemquk7PunmAQ.4mMqE_7htIry8AV2PPAcJRTuRZTcNcyDEgCPK0_ipI1lymqOPamIX5U_
 fVTE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Mon, 25 Jan 2021 18:08:09 +0000
Received: by smtp424.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c85fe59566cd80b945b0392e741ce000;
          Mon, 25 Jan 2021 18:08:06 +0000 (UTC)
Subject: Re: [PATCH] smackfs: restrict bytes count in smackfs write functions
To:     Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc:     jmorris@namei.org, serge@hallyn.com, andreyknvl@google.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+a71a442385a0b2815497@syzkaller.appspotmail.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210124143627.582115-1-snovitoll@gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3f33d3a2-c84c-081f-c1c4-424e5eeeb8d2@schaufler-ca.com>
Date:   Mon, 25 Jan 2021 10:08:04 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210124143627.582115-1-snovitoll@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17630 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 1/24/2021 6:36 AM, Sabyrzhan Tasbolatov wrote:
> syzbot found WARNINGs in several smackfs write operations where
> bytes count is passed to memdup_user_nul which exceeds
> GFP MAX_ORDER. Check count size if bigger SMK_LONGLABEL,
> for smk_write_syslog if bigger than PAGE_SIZE - 1.
>
> Reported-by: syzbot+a71a442385a0b2815497@syzkaller.appspotmail.com
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>

Thank you for the patch. Unfortunately, SMK_LONGLABEL isn't
the right value in some of these cases.=20

> ---
>  security/smack/smackfs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index 5d44b7d258ef..88678c6f1b8c 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -1167,7 +1167,7 @@ static ssize_t smk_write_net4addr(struct file *fi=
le, const char __user *buf,
>  		return -EPERM;
>  	if (*ppos !=3D 0)
>  		return -EINVAL;
> -	if (count < SMK_NETLBLADDRMIN)
> +	if (count < SMK_NETLBLADDRMIN || count > SMK_LONGLABEL)
>  		return -EINVAL;
> =20
>  	data =3D memdup_user_nul(buf, count);
> @@ -1427,7 +1427,7 @@ static ssize_t smk_write_net6addr(struct file *fi=
le, const char __user *buf,
>  		return -EPERM;
>  	if (*ppos !=3D 0)
>  		return -EINVAL;
> -	if (count < SMK_NETLBLADDRMIN)
> +	if (count < SMK_NETLBLADDRMIN || count > SMK_LONGLABEL)
>  		return -EINVAL;
> =20
>  	data =3D memdup_user_nul(buf, count);
> @@ -2647,6 +2647,8 @@ static ssize_t smk_write_syslog(struct file *file=
, const char __user *buf,
> =20
>  	if (!smack_privileged(CAP_MAC_ADMIN))
>  		return -EPERM;
> +	if (count > PAGE_SIZE - 1)
> +		return -EINVAL;
> =20
>  	data =3D memdup_user_nul(buf, count);
>  	if (IS_ERR(data))
> @@ -2744,6 +2746,8 @@ static ssize_t smk_write_relabel_self(struct file=
 *file, const char __user *buf,
>  	 */
>  	if (*ppos !=3D 0)
>  		return -EINVAL;
> +	if (count > SMK_LONGLABEL)
> +		return -EINVAL;
> =20
>  	data =3D memdup_user_nul(buf, count);
>  	if (IS_ERR(data))


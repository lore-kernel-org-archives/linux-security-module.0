Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB70C4338F
	for <linux-security-module@archiver.kernel.org>; Fri,  6 Aug 2021 20:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5753D60F22
	for <linux-security-module@archiver.kernel.org>; Fri,  6 Aug 2021 20:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244379AbhHFUCU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 6 Aug 2021 16:02:20 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:40176
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244341AbhHFUCT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Aug 2021 16:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1628280123; bh=Vg9BkKAcNzgovnO+fVYtGiA8sh5A5OUYbb1Llzm4qH0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=JxITSMMB0PHw3lAkPbT06SjkgE0z6nbtgZaCESYxTNP5nfPSaM2S0NZ4jZabxIA2ka+u8sNXAhM0X4pJjOTM24cMAFOlYFgzzNP12oFiXj1J0aIN2oAKMAHeK738teo87pXBbSoJDkJBmij3kwGMAEyefUjBn+DsIlrGJlqDsSRtd3lJtR4pQ/lnjlOBEsZDUVC5MXMbceyeawuySHlqNoyoA1SMUW9pCf7ByUAY9lKKt9cF7lf/FN1ihQE3SQOl+6NM7Ilan7N+fxLUW1orqyeSg4Zlk8flyQqyaUOSMPS5uXNgk6w063Ju/Y4O5dWs273R8fab5YcU5fN7wGlPiQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1628280123; bh=XnhZYstefZh+0OC5uSMvCS4Bz6ROTBE7iDd0n9vXcla=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=KapbI12QHa0XbxZy2pJU1qkYVGFW4z0i5HkqxiRc9l363+Sea5M43v7ZP0pZE+KwXILr240hFZmSZpKU81b6rlR1yQs+hGvW2Zzf6woN1MHaLXkBjxJGrSzpVwS6VZHh5avh6Udelp8CTjCg71XwOvbWM80feY6kFyieR+No0BHRRhIWtvbMOZTY15LRL4KsYOk+95OOSEH5M6rp7Erd4iacTeueYgJfdzOdA3z3CB+z9sqha+00QF5EQ6dD0yxW6gbQkhi5SCqRP6/aoA3pTIaaRhOCPgyxgnrsCnpWjR6l7FMNjlI3yag9e9MmuX6tVKqd+YAYx+1H23xstMUTjw==
X-YMail-OSG: KpEx1jsVM1nWFTBYhj3IuapmfreRB3czHysdUUiO9Y6jzmmgVnqML6beSKjPgHt
 0JkIk.TlapP7xcY2ObN6zP66vgqviz98KIGMmsXloLdRDsxCfXwl2HD9mIsWLsPbDaSTLD4gY4Bo
 ZUb4z1N1PmOxdxaEK3BZ6tZ2UJxoBdcU6gi4AD7jcik219y_8mLZ2tyn6yRem5DAm9PpvgHb._Zs
 PEHBhwVv6nFtqu0skbZBNPBmG8TcpZyCG3NuSv.p9sT56xvH.Aq5M6kBNFGrW4hsHq.SmZhZiU0Q
 oayM5s7JHe9dXME5kBuDdDShVr4kgCivhnHH4Fz87zulHb9w9KrifAITt8PLK6R.tkPRTJLUaao9
 lMLSdFsQmEFP2f2xXOLYEQtsqKmbEMxhqc9FicUpqMjIyu7dHQo8YrBcTejYLFINASZoS.4Eqtx8
 Wp0_oyCgDprt9fK4hppmXSG3FNeMTJaesIroITb.vTrS9SujkRev3NpaCenXoSYI816PCMVmgD_X
 I097teUWcgQY2IJ1Dhtr.gf6F1fI0ZU72inh_72kFSEdY0HcY4cZxMemY_LQviqA1ujtRx6Xh7Ve
 z4hPzfja.Yf8ecxenn8unyGSBTM9WOmlUPNUGialpKmctCgFrysjXXRLDHbeGtjz_fd0bI0jnQPQ
 Fr45Qkn9VXIwMN.bTSuotESgjT12oLZufw_UFNn0YiC4cbFMQiCEXihBT_A2EYGqwvFp8kJZqei1
 h5g2PxbzRFyBCryu9_kNL3kB9t6Shcds0Z6Glby08jw9y1Xlsuwm75SI96JFX30_HolcDpnStbrz
 f.7YEWnZ0q7gBIIRDFcOH2kzKoBglrpG6a5b4pLu5aqX6rZDLS4Wy.9tHgFYTyL3PXaTCI_ULTeN
 rnHZ1PK3w2zc1NdqgGm6LmZFRGt06.khpTLvv.PO4Lk6fct79P9LmCYSlLrveNkNfQ75raGFTiI9
 lxNpcpIpI8EmD1Op3oo8Q3GSGOlRgb.GCCtQIA4omVcBQLDqETRyKoB.IAfWpLpIwQuB8WGAd9n8
 ut6i6T5M6GZjPcOO5w_Hq9nuAbjPBD80VJhY7Tcd3.qDXpi00GJqRKxKrTrQBomdGv.o9p.AgqrY
 skA9LkRn_dE9j2UzTkbf_DJCdgjU7yo9XTPHxd5o.a_WrgPRYwm2oNsDlrXk13s_jgQS3H_NEPKc
 l0diIW1YJAvTP9axshaEU7o._TfNrFMKxIpEvnBOZQOjWwlBQ5sQBYXIMVxThOm3XOPI2tbX29xK
 Hja.9STgCgIqHbSKsANj2nugISaTZDpBTvaOSyHby6.KbAjxtuQRUkbZVUdBoUpQIv2GxHrNcbZx
 FYmIQ_9eYb0WMXk2xab2AnyPznnaf5VyAVI3_agswrg1a7saPnGlTwV2TjU67OkHkZHhHvO1GFvz
 Xl34UYfDSeA3Pjgrdb6Hn8vIaZ6eR5FlABi4OvkvcPqTceQB4zfRWIPndgXMMk.djytWgu9vYjYK
 OaF78mrQDslu1DmEuN.4VFqO0yTR139_tbVZBfMhw1EFao9bgpfCYKlpBvuMuAk8qJp5q6FyrOTO
 6C8BQRxltgRFm6U0jQHnysee1mKzEpAD77Lc1K7LTNZ7glShGGA0KvIXI7bxwzGkNWUvu3AhGKSU
 cuSVFCTwmHR2u4RNBw3lRlanZAoxjvCIUKUVVFK8DWSRzBGTW8t.u.JtNl5fY7scvGfYsJQAKltb
 UVs5Bo1fZJ7ObUKoC1lv0AnwRWuTGt05MTGWkYKlX7IN6deSiZRM_Z7GGbibbAKDWafGMy9nerZa
 8FlCGPrH9ufWpeMp70Z8cKLiJC8rVr1oaQhVqS5SZG8fB76KHUlS5cb4cccd6YSORBPclfO5R8nt
 wfeVFz_WgY53xHGUanqpdTaYunI2XRyOPzqgCuQK47rL53K3GcdWoPVVJVL5aEK7alaEYiFdpNbr
 j8.XXc3gjc_Xl.y3VuMHlg6CVszBZqEhaJl3dXHZRImFmKfeOx48zlk5nIZUEzvzOOzsNkbkXYY8
 xjXqRY8bGgyNA.nWWdUxNSupRdyKAxjJvGRhVProLf2yKEP6gna7qxouyllLa4PgpGJITs8KfrsN
 fDaZ9qA77tTxdyaS03hYuyO6X9ya5xlB9mKlkyb.iBsau3DuNjkY6G8jvXkw5LYE3KwCTTk5umus
 jocsIyKH1mWPuYNWXcFZqMwxS_64HBtb0dcgN7HBt9hr_MCWqAkGs9HmYlFFCl96AmTfv_pCxwya
 YkdUFw0z39y1gMYhoJVW9E.PM5UfFyZxtr9Of10gHUfiAI_YQj08XkTr668W.HhgjjVBsmn9R417
 FgtXcwizmV.RzCe1eWk984pdxPFx6R4vvisGTO3Evk3jJuaC6vkLk126yjaHLN4HuUKhAXAgiTmQ
 j4Hn9ANd4jB_0tVmwkbubFsjaS86nSdS_fTnK96N4TOqxT.RDkxvUPp.U5HkKrUhkS9kyx0LdJcF
 xdA_TrJJhgReZdhaWb.tJKdMur28VTWM5Sq9B2iqqIZInocuG3p90rGxxJImJiVoTkLIFZlLp8J5
 3dWVrusbupyHpp.afDFmhJTxSV7NpHNqaKVZ8bbbBWw932Gopy30A29trG5oIDWd4IvTdjA9wwkB
 ywEvZxcePctKy.Ew3iXThzCP_jeRCBpi8KUSbwSeV
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Fri, 6 Aug 2021 20:02:03 +0000
Received: by kubenode586.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 75abe7e8df9ee73895c7c4d930a575d8;
          Fri, 06 Aug 2021 20:01:56 +0000 (UTC)
Subject: Re: lsm-stacking: fix broken lsm audit
To:     Dmitry Mastykin <dmastykin@astralinux.ru>,
        linux-security-module@vger.kernel.org
Cc:     akovalenko@astralinux.ru, Casey Schaufler <casey@schaufler-ca.com>
References: <20210806070245.26338-1-dmastykin@astralinux.ru>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <f2eacf08-d1a1-e8a1-eae0-28e4e54b50ff@schaufler-ca.com>
Date:   Fri, 6 Aug 2021 13:01:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210806070245.26338-1-dmastykin@astralinux.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.18796 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 8/6/2021 12:02 AM, Dmitry Mastykin wrote:
> Hello,
> These patches address the problem of not processing LSM audit rules.
> Problem was introduced in lsm stacking series.

Thank you. I will incorporate these changes in v29.

> These patches are for cschaufler/lsm-stacking repository branch stack-5.10-rc4-v23 
> Some UBUNTU distributions have also this problem.
>
> Kind regards,
> Dmitry Mastykin

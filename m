Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01060C433B4
	for <linux-security-module@archiver.kernel.org>; Tue, 11 May 2021 16:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB2056134F
	for <linux-security-module@archiver.kernel.org>; Tue, 11 May 2021 16:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhEKQIM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 May 2021 12:08:12 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:46714
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230315AbhEKQIL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 May 2021 12:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620749225; bh=Enu/4VpigXahAHzpvfI9ItrovKMhKUZDViLNdG2sehk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=a5ow1uG09fCmqFCJmKoTbOQYrDWc1D6oDwrxYKzmfyFkLpPRtdlihTquCby5cu/J9qAeXBZnI8nT434BdKmoVe/IyEG7Znjdc7VAGfGJbUAkT8ZKsF4lbJbgcY0TGpZV7Dima+RcQ24chArfwFP+NiR9X98AJDZW/68TQtlbicLD0LnHhiOJo02du0ZQuXnQfnABhiQ+gcmyUss/qJ9FxexDdIP1j0zvH/eNM2Im19GPGszc6LV9+9L2sJOReLa+i0K+0JfMm0+yvk3W1AzwnUTCbyJqxFKl1lWvWWkaXtSxNwdxzmoRMjGLmrb7YetGOWu5bEQrFAPySOhSbnL1MA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620749225; bh=TQOtRQ9NBbYAokHCm30WRGNpYXPcZ8QiRAY+ajJV9gi=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=VkiyQtFfgapfTZqDcMtr07Q9k2bg2BWgewr1sCx6lcyxVlTVmJ5Aj6rZd4TE6Yar3vNoDdQBawLgY3qbeghLtwPbff+0SrbGP2RAJn0lWzVj91w0OAAbev1G5/MMUaV/v2RvJJIOj6skSC3VrFiPKS5g0UQNXzWY0IdcKtfXlnZYU0RtB1p6FHyOV5EQl+SEfTNOlJZ/LIp7AekrLdbpBGOXjVB4IZ+OX9+MHBVovaS6CJev17K0NhBg9vYNu4NGs3rffaTpFi4fJ//PqCPlJbE0fgEBw1vGtLLPvsb3mTUnbWItjtE8sNVDwCNTDj+NRDaafTf8JBdry9QsWf3G4w==
X-YMail-OSG: C18H2sIVM1mKT0tUzW5eHo_GOX_F1Z759yWun4_4i56RuNpzJOuBE.phtrQ_3Ba
 cSmvI4ofoJMduIcfV0YaMt24v3mnEfbVK6cN.0rE_eyghhTmchOjojcjUrltVGlVvWROy7LR2CN.
 M5kKk0Hfwjd_TV91tGhCsdCjlBq18cnmtXnWuWWsX4.k0SV1H8dbEYrvTDAhVSYqHZB.2gzoHECj
 CNlJAHhZeuhriLPTMaryx.YBXPq4RRgtnOcNkDz.Y7GUH.u._Hg_5rDF_c6vdIK29Zt_r0vTEMr9
 dDEd21oPfkha9RRK2NOodyU2QKFm9OTv7wTMB3Cz6MdvP5bIK6JQLeW_E0ek6cp6sJwz9cHkaJod
 GzqjyPasZYr_ZACk2w3Egg2R_o2zHYSZ4THZbaqxou8Kf3Dbm4Oo1FvmVYaYoNwiyJc8rdbbPAhc
 vSekgh9E3EFvF.FMkaaG3sk.KZ8qNb6HGdw56ChG.FXbZHIt1rLi_qYj5I8ZR7x1Ry0BjrpPKI57
 aoXjRLa_kqOkaW4jYrOk874xDvYcD96S2U6K3jYibGS27RzWLd9wTNbgrgsR.a5DqnjlDl02xBq5
 ywJ90RPI1daHHGn01XLyyad9dwPZ3DXG2uq9Vezf7q6hoLrzNWhc2kxLmG.TgWBtw60pUnEY.B_l
 O3oWDyxrQaAgTsQLlHIYlUBnppt2KYv3xSUGBWaeRDSLM5vuxePLDc.4LzSuDdx6zdHt9Lxijkzc
 nlAAtUNdqHTReAa35idDgHfc7Gq48rMdr29WRiezkREaAOXEbJ1qdEKEg_l5bMK_AmJ03xDdwli5
 4x.VSO5YN4eidkd9sL3bauKIU4CrymIRhtXmT724WshJLQuGQTMqEO5f3XUBiUbpH6dfobH1QbYV
 C1lPH8Q6eJEjdbWIn1geyaqxG_YsmeYye0XNcQhf3BjXd25CJsnTFpHB22CfADlGuLa8avHdcWoQ
 DiCVMuV0EAW5jorcnqP0q_1LprUmeKH6QTDVDxWJ9r58dVS6juJKf58TRHad3uW6VMdyh35SNn5g
 Wc0i627LzVimc_jdKwRlon_PVIW583lLq8I5N8fv9sbGvLDM6o5VhLqmwDPbLWtw62Pb3_.LAn_c
 VHK2o3JUvFqAm37QdXZJgo5O_QXVSYabE7pitpf1F6CspiqiHs2EnzRYPi1kQJINIZeSH_rSlK20
 .VHgTPuMgNaU2OkGdfLUBXk2s58IkcUrYfEzLnpXdRXkMNM9m9RVf45PWcCYpkntcIkKKlaM0W3b
 jiPqWHDCUnM6So5ukXQsskslx0GB8weWQuDRoAAL73.GLnOnpsXH1f0yh3imLi98HAnM.AxK2xDK
 9JeRYruqPCltRvFIaKnlMZ3IaRmofoSLORD3edM.9oF0aLGHIuRuq1XhOr._x5ZlCjYYFcoJYuKv
 Rv4KP5YhISo2EB7mcZEsnDN7F5P3qURKFGZYBsRj7wX6VnjfpJhrBYVcxFxyj89WW6UrR8w41ysB
 S1IW7mxTAiPDWDYoZwfvQqWnRmbBSigiT01yU_W_e7udKE7LCTwfQ4laqwlnB6ykPZoBLptAkG0U
 _m_xtUtSw3_0RUyZUx38oQBJSh01dzT64z8flG2R1ri88QaW.ng3m2M0E0UQuX15KgwyflVeGBIF
 ArVMmxULRv9JKuztW8mjoY25OheQpaX63sXTS1izCQS7DN8PNYtQ_bSgsupB3x2Uj6xcvKwi.0Px
 tw_zNyYhEI3muHO5ths8WNWli6eOUbtx0hAa_90P_GfqmDXxu_.DbDFxNkw13BvOXLwkwq9NnBD1
 SCCJ2FUnpYsITaQLaANu2sUt.mgGspH474obpv_USF.Wbdixmr2FoV0iagb9YqLA6ExZ7owAbPGL
 WqUNH.FrNUh_2AXGo.6J7vUtxrHv_Fg6TMr_op6PfsyfbUCtOJ5Tep1rr0YcbLcx9zgqZN8Ndh0D
 Dv3wVHiGZ_LVJ4ILhdqhIwPh93Vi8hnaxxEp5S7mNgTgHU.vKKVyGguKLsGfp0thKUyMuvjsog11
 nOos3wUoqohsk9p5OCDzzvItYPbhgKJpPKCFJ6sq8gLUAkBMnD2g7oBF1grnOjCj0Z71nr_B30O6
 SpX1FDQslfhq1oQkIsruGyRxjHlZtBxC5hax3_I.GsCqavimMhRf9QSe24IIZujmk.PTvmS7XWsK
 YhpcCG1FsAese64BME6UgPHpyHQebbEN0Oy6cIs4LszIapktETzutP7I3Gf_v_nPlMjqR66pBVs1
 .2VC6IqkEdF03qSjBGHoU8EzaXAO3kvT2WypJABmUxJkhZYLbMYFdmVn6Bj5YNCsFivmA0S.n0oe
 p738mRXv1SrWIf1QLOB.IWs28BpVw8GHspnmcuZeXHQ5ztnoMb9YKGNLd5eCpKpCcZaPviNd6eQT
 M7vnYUs2fZrgbiDPz7BdqAgfJzjMn6VxcfWhoZpLgPkXWKypRj9VjycISRm4.skymrmA9CGxvau2
 X5rW6FIx8jAIzJ13KsAVn2_XRl1RJ34E.x5OC6RznAo1ZOrdlFciw_BHgVDzSO1Gg10mpCUwFkN2
 8KLubmQVyaLlyD7_d0SiLMd30qnx4FSZe0faMxEQtGo.hZkqiSOSaX6laJ8xS.F6S3E4Mls17ngz
 rCSSk9PccRE88VIQEqeK51YDjo2eFnm8UuYJ_A7foY5kKHOnqmUCbHpwTb_PcsoAwutHUbE98.dF
 l6q_Vi7eexVeI0k37uhH6nGw6ZYt.NWL30ATQJc95I7U0N26ilKteWwwcDtXCXx6keIZHHMMwZ7Z
 wjnXwD464_scrou3cdW6SmZf50wrnv8U6uQr_bLmDUInd3Wf6a_j3bTFd31pAsgMo_nJJHwKfwe3
 1tcqyoLIrW5MVmrJmMI0qCmPBEXoNO93vA51U8zspyJnc9T7BgNVXmyMKXZUuwmzq7E7.wgEvHc6
 R5na6LeHNY_d5Suuuz_uYLamntoatkqgHFuVl6mte9K1pcHdvPIQZmMhfjGm9LtgNkxqHBhG6jc0
 .BP6TpuWfeYxpIO3Lk6yb0x0L4ly5rYwB4Y8ip6LKG5bfSxlyrkUBlzjrurYFf5ntDGQN025D
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 May 2021 16:07:05 +0000
Received: by kubenode575.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c050a91aeed93f70d3a5ab397ada3264;
          Tue, 11 May 2021 16:07:01 +0000 (UTC)
Subject: Re: [syzbot] WARNING in smk_set_cipso (2)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     jmorris@namei.org, linux-kernel@vger.kernel.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        syzbot <syzbot+77c53db50c9fff774e8e@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <000000000000d06f2605bfc110e4@google.com>
 <d1d73239-c549-c6c0-5b24-5d701b69e3f1@i-love.sakura.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <9d3b4454-a12c-7578-c079-80338ccfbc2a@schaufler-ca.com>
Date:   Tue, 11 May 2021 09:07:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <d1d73239-c549-c6c0-5b24-5d701b69e3f1@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.18295 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 4/12/2021 6:28 AM, Tetsuo Handa wrote:
> Commit 7ef4c19d245f3dc2 ("smackfs: restrict bytes count in smackfs write
> functions") missed that count > SMK_CIPSOMAX check applies to only
> format == SMK_FIXED24_FMT case.
>
> Reported-by: syzbot <syzbot+77c53db50c9fff774e8e@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Added to smack-next. Thank you.

> ---
>  security/smack/smackfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index 22ded2c26089..1ad7d0d1ea62 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -855,6 +855,8 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
>  	if (format == SMK_FIXED24_FMT &&
>  	    (count < SMK_CIPSOMIN || count > SMK_CIPSOMAX))
>  		return -EINVAL;
> +	if (count > PAGE_SIZE)
> +		return -EINVAL;
>  
>  	data = memdup_user_nul(buf, count);
>  	if (IS_ERR(data))

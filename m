Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A184FC433B4
	for <linux-security-module@archiver.kernel.org>; Tue, 11 May 2021 16:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 659936190A
	for <linux-security-module@archiver.kernel.org>; Tue, 11 May 2021 16:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhEKQK7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 May 2021 12:10:59 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:43004
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230435AbhEKQK6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 May 2021 12:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620749391; bh=pe6Q1aF/N1DY6RK/gXq9v35gxNan0VBcPGFDU/pIcog=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=kMu8KWXaloIQaxkW7hlR7MZkvqRH0nFUCPnK+J6txF0tYaL/ew71FO48SMzJbim3cqoYKqU1QvgCLE9Kf/KbO5yrqmEsKJhm5epk/uewXsOUQKJezf3hZqAuxzKeLPs8c0HnVE5Cbe/YSUpTNbT52LUVdLLJGC/iyQJiKKHe/I4aLlNWAMTdkcLVioRdgca/LtEaAtnb+MRv9jwSCdl0XPAX3QAlC90s4+qTilJO2XAdHKPiDxTTqBZqPPa/qkkc1Li8L1FG0R7ni1aFks1eao413DumKoHoRYyY6iUeoMxuT+2BS/oDueLlb2EvrCGH/s596mmuPmYpvypCAlmh1A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620749391; bh=dKT/ewubhLMdKhR7Kvwy/qzEO4HLONazgM76QQLt7vq=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=NSQ8wPjeilKshkXGpjwBiTS4oJkhsY660rUYFVrLcCOcISfM+7ZHoSE+tAskwFd9d0zeNEilLBwm8ww/VOYfqkFD/ImrbwhY+Mmxb03aZKK4Gu80rOPg7JdoxH6sKvz6ya/DpW9o/StReTXT0ejSzJuWtGUODjQszU24QijrnuvaXGUjS98+nHi9+XEW5Bu5Mh2LLVx9C8or+8zszDLOds9rsVRtza5paVDxbaCHJvAYzs+74gAKGtGV/wL1vgjy2FkCL2z1BGNsrvftVRl+uIChGF8J202YwErt47Ptz3AP2Jd0nru73jIao7/JYUJn76PfZSFiZu5Euu3y1GP4Wg==
X-YMail-OSG: LA_dw14VM1kuVffsX3K2J_DYbVL6XDIcyv0mQIlDLc6W8cTf.ql0Y38_hbqeXRU
 Lca5IdVK5dylyBQtSUC8TrbGxf2WDXz2YKUgqMxsdih4knt9k.kQKravt1GQBCGIS2_JbmGLEnuS
 uFiogLjjS_NAXfIWJx90r4hazr3s6KxJoPaGPEFS24AdfOA3MNIhC63W5UqaXPKK_drt2ETiEIEB
 RFz3QKLh10yKQSL7vq3nO_7oQiBkJfpwsnlbgO5cr2_p0t4154emtS9ZNKetjhlb45J14IouL72N
 WK0jiXmy.KzCYJrItamxKqXKNFrNsbcBsldKvzHgpEmwTtvhSl5HkxcKhjL_7Ny__crH4.Po7WXL
 fh_mUMDeYBzKXAyUYuAf49BaDK4F6VaGLWLCuf3lS7THp4sZSNMK8Besqoiw5mN09iOHI8qp.wTA
 vFTgqGBEo7qAOr3GBd06EuS1QB7p5UtbQVg7GgX8UUst5AZ1xfS.YlR1Yf6LvOpbUvZ.kr8zOT1Y
 z2E5NyMWsMTnQrRkCTkqJOxLmhCcHKk5nopBOlvwPiu3CHrP7draYIfo00TSIPrp3GJ17RfPPRNT
 1RMVwCVRkAl90IHMMOTWZTvQ0NlPmhiLdx.X4xs3fxcnkHWWgiGZsnMuF44V.c15xdHiXVp44aJU
 xSYFokUpD2cLt0NsZFTN0UVYTfS6ljqy.YPWizEZ_GIwjoJZTrWPRz_fppH8WQXfyml_UzO0OAVX
 v3BTvnlrLy_iH7SAWQhrrOGyTjgS.ft1cQfACjKOUdnX2sX2CNHQYW.90KxRujnUF3FO.OeSAOO3
 tyPRMiZmjNSCtrNPdkYyvPGzhflsr.alzazYyoiP19uWsnV.dpYMHt5cyKYr0eyq_jsp.zPNC.NV
 T.pU0nQ9HRsN2qYuBrFW_4A2gzXTBbRcY7om10FbCgV_rZeF9FHXwI2Scu5zh4ejuGaW0TeGMF6x
 BnY_cJtQO.3Dh1Y_4Wym93dl3osux1Z0wP.TkKHf9RfVQ059QFBnh.C0qi_rLIko564rhkkkiNEw
 cdF7n2cc7ONEPwJwufiadFjOYfWDqaq08VyOmzM_RLlJ.Q1Ip68h1sWFOX3msOAXJQLvbsWU5pla
 3GCheb8XNF4bJf58_36gaC55vzXPrWK1QwI3ySxey_EY_L3qs8HyLGcXffzqaEYgDUyRimuoY6Ol
 l23EZMnyhCuwfI7m0AMm.3iDCSLz1gHoCm0v9Te93G.j4wPiYJgb1m3pJPuJ97KjfIHGxQQh_hOy
 WofZ0MrdCPkKywe9jWl3i1e4qFbxG9q7VuFDMbF.BvqDPtG4pGvNen1q6M9huusstV.Y7Cjhx8_e
 K.tUknPzuaRZlrN4g40cZLxUkevW7VS6kiK2Hbv0PFjc2C46tph.cAD9yose_yacZhukTbDjpWM0
 1YDR7gSO_kZKnduz0HzXb7yllqTD4U6TwpL1ZcWGx3CaARfR6mppVuWx7jrRlREuGEzEyQ4lpoYt
 mDPki9r11OzKlzNRvOGgl4RHTsv.NR7a69FvXMLLjNO9h4w19Msyl4ZUwQ.jpA3iKz0Kf2n8ouVD
 ryF4II61tusGCQRvgdrkqYNpe1P4q8Y2po6gLLnSfNqLsSsGqzrt3fVlFocNyPqZT9nSK_O9P_SV
 1Uz0PK5OnPKtgwxxebDj3zFOrVp1.07mF_rL2hNBMEqGQzis8M.TJ3G3wxNc2oRtNBErCB2.yjd7
 KMu48GSLfiasvuZ8rkYBNshylL2a.GmGU97D1BCQE_hDtEXUTpHOEZKFdsGLf.pQKbIgcIrGOv41
 Chx5DvtNJhXWW35DfEt_hU.S9J5z6JfoIVMDGUPoNjFoPb6cX40xv8S_iOdYfEk1etdm6Tjoiku3
 mIBXhyQ8oZUkpB79Zj1XIJS.VzCuLjtU8vyAXEpNLFrRdnCsdIxZTkwusFb1dAuZWY51b8ZkN95A
 pL6Jx1Who_XR8UPGLcmqBpGdBCHzyMHpHvyJ2RqhRhu3ZQQL6vb_yft2Zvqy4y_Qr1MX_ZPhZXjx
 1QXZW8PvZ0LYP4xeTIEhKm5kK5Br8LTlv.s.iMlOiEU7oFj4BNXO3MhMaDdHMxvm8KJ8OY._zdMM
 TclY9Zt.L_Rhw9jwN3huEGM1ZnPpe9QeSLKq8j_fO3cUjtg.w4D7ULA86OmyKIrL9kiISfTcQajm
 yR2.Ijaa833sk7du21a8340bu9loI3hHT7GkApt2Jb.ZA57RVnKqdkEe85FUPo9owJMDy_6l6BEl
 1cBHmB7sl8awVnA29HGSFK4BZCnWpUjc_W.6Kp_27lv5.RaeOxMHKZn6tKyyZvZVkZvZXg3dcebL
 1F6nnVbtb76UTZIzk76qolJvy1ShRxLvGLLysmYp4qbUV5Eca6CTla_QwDAB9FEDLAFDWN9L.0lx
 pSaNwL5zu6Nni1WdOhTNLHcViBBevh6jx73SRx4cT1b3z9S0Y81w5UCdYaq65sjn1dBERXZT7y2x
 0ia4yVfj.DB_DAwJkO8HY_2URsV0IZkHKZpL0y_VXX7xO_cCAXLmfjKheJMvEpQ1Qy.2GBKKjFqL
 zb.43mA3n4_tXVEn7lpjKEKRf8hIoHlorTmi_W3AvOuBr9Sv8X6lzYE6En4fVc_zJ2My9pj4UNH5
 tJYEB2TpCAQhcllxy7DjB1XQMQO0OxmVTpSBEv52K3mw4_Wdvu5GdTV41SJ8QyRTxBXFlTk6xdMi
 6AJIFB6.7LmHgQrQjJf.Qk8pLYU5xZrELwu9aYicK_AZVcgCRkIfSFXxrJCosTRr3U8awMltijaQ
 ZSxPLk1tqdaFjz_RSxpzZK2X_eMif_ov8VOvb.1HpYwnogJo4JOejhkqWE0txEH.j7jEHwn3VX.b
 2KiPpF7ohW3Z6p8PmyjoktBn_sQQsLmqJXDpb4wDSHVLi61oZa1GxMykJ6pYzQ86Khr6JYgUU1.T
 zo2sMGyqAIC6nM9uTo6OomgGaWf1Nnlms2gnsyO2V5LfNZ76bHQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 May 2021 16:09:51 +0000
Received: by kubenode562.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2211720ec52ce342b9b5052105b4ac20;
          Tue, 11 May 2021 16:09:46 +0000 (UTC)
Subject: Re: [PATCH] security/smack: fix misspellings using codespell tool
To:     menglong8.dong@gmail.com
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiong Zhenwu <xiong.zhenwu@zte.com.cn>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210318111024.472126-1-xiong.zhenwu@zte.com.cn>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <aeff2e07-4780-8d4c-581a-fdd1756eb64a@schaufler-ca.com>
Date:   Tue, 11 May 2021 09:09:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210318111024.472126-1-xiong.zhenwu@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.18295 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 3/18/2021 4:10 AM, menglong8.dong@gmail.com wrote:
> From: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
>
> A typo is found out by codespell tool in 116th line of smackfs.c:
>
> $ codespell ./security/smack
> ./smackfs.c:116: lables  ==> labels
>
> Fix a typo found by codespell.
>
> Signed-off-by: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>

Added to smack-next. Thank you.

> ---
>  security/smack/smackfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index 22ded2c26089..ef8625cb3f2a 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -113,7 +113,7 @@ struct smack_known *smack_syslog_label;
>   * SMACK_PTRACE_DEFAULT    regular smack ptrace rules (/proc based)
>   * SMACK_PTRACE_EXACT      labels must match, but can be overriden with
>   *			   CAP_SYS_PTRACE
> - * SMACK_PTRACE_DRACONIAN  lables must match, CAP_SYS_PTRACE has no effect
> + * SMACK_PTRACE_DRACONIAN  labels must match, CAP_SYS_PTRACE has no effect
>   */
>  int smack_ptrace_rule = SMACK_PTRACE_DEFAULT;
>  

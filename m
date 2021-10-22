Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199A3C433F5
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Oct 2021 18:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E78AB61073
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Oct 2021 18:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhJVSFZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:05:25 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:35697
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232258AbhJVSFZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Oct 2021 14:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1634925787; bh=ywebkqIxHRu8SFaY27qIHqbi9s50OnCZTePY0DJq4B4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=DbMSO+31XhpN+K7BJUiIvynVOpyqnv0dlnihsYQh8ovuLMXC7e32koiEslkMGmOj7tlJWJd0NWA/FV3zpCehbMjCNJxSpuhrjSsZ7TO98VPUJlMd7zaFY3v/OmmFUgZ7t36LYlPW10MmjcqLpI03ljs68SGBjzy2qd7+uBkfGVs+tey67+XQMlRx9z9lY3CGD800M+GHr9OP98d3XdgRBmnETTVvxJx8Z846BPOk+tmwR+Kq9pc637jwWJFuQVFJj7vnTC2rNCqfqiNtPKBK3chkBKUjEU3YguqTNYE47Tg9EdkniPTCmb90VCLlADuSZPcOy5CMBsUCAwnY6Pkb6g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1634925787; bh=/z2VujCwms5Q9jPFKlBdfQLjaZ3WLxlpZhuhAWuBQ9S=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=PixzN1NkvP4sqVOND3SUJVTmYXGivLCK8w95ZWn3RbGD4tzj9FPxas4e5PAuz7W98oMnwZpKSJHZFCVP9gOCBHrkEYwzzt31kgWidcuijRZ0/7ZK1+kjCPHy7cCXIsdzxpzM2A2JDq0eZAhT1vlyI07QJ60Zy6w7B/bwZA7QyrjjxCSTam8xXRZF40JMitoHH5qGP9MKGEAts2bR/d1J6aHY8Nr+LD1pevWfv2TyIiAE6By2nROX13EV89XYomCMgjhMgvRPJguLKaIFwA5plswUggy9AMv5UbJ0X2H0DGTBQTd+YOlKWQPxVgeHKyAOEWLvXC+rww9ClboSWQupIw==
X-YMail-OSG: ciDd2MEVM1l7Br.QINHNzmtPWg6D.XztlgtReL8yPKE6HVuo1iZdDb6KwZYg3WN
 wDQ8ybuw40OQyWYowrs1W5rP1LytFv5HQRQcbspwXcsOGjHkXok612v5kDFFvd835CMtjB7UNx8F
 4pS0T70x0eDIumVeTHj0ZbHVHBq9rccIEHgdlW0h9S5BhfT2suGws35UjJNsMkwaJkFeuX1xRq_t
 GlTLLWUYxf4u.kbjeA2bFDaNtXm8orfrMJK.x3Upqg.OBXhNkTIHWT9l03Z_mney4AofpDwxIDEs
 NH0KtTzx0uGHC46mUnjuE7MmQ2E2q_f_h9B2KAbSKAtUMhDklHkROYo.r_fxOt4rdvGLr2T5M2HB
 DzEPfP85k_CumR5aBPkI8mtCT0vXlexWtkVT2mvY5WS8gkqXDhufKgve4C5jEpDCX5XVGfw2QQc2
 H90JRzCpgDMVp.2FkPFpWw0jH_JO1gi4Bn2RqM.q6RZLZXGMLArfRdUUVgeOYyDshOQF2ctpciBf
 Pmpe0r6OdLa1WZviXvU2znIoWZnidEeTGmQXWRXi2tgOweTPsRvoEUU_ABjqqEHc8Kqin3o6TniJ
 WgKQGsc8Q_ot1cq5sNE_7j.0Vfc5_NvmFK2gjDWbVmn1fYLEqeIeW7TpXfEI46.ZQ2uug9iWK5LY
 X_2Qj5Yl0lZu7OnxgLCd_7uZu7vXEh4OwQvPCMnAkcoLNvlYvf8Aw5D6ohaud62j34tZYYztLQo7
 z18BlNc6kZFvrxpZs3CelH2o_a0K4237ZlP1NlP7Qven.GRwIDPAJUh0eOn0b3Cz6oCS2VmhIAB3
 I3APdk5.5gOzvXOkMfttLsy0hsvhr5bjjgGNHJnttYBpMT3nq9zfOEZKlGI_.6IWoeTM4RrLIGYP
 .7TNi79Tu34S4jQdkyfbNhqgUN7uqnyMDKvF1y7ywN4_6sFOB0FjLjmJmpaAMT5K0TglmXNENrQa
 7Ij1fnVzG5UzJfX2WySIbDW6LriM_lFpf_7n49_Iv2UFrVD82Foev2uyl4fU.6kLCiW3XGfhj.Iw
 Pu02EEz4rihy_jCh0cKBH3hKEIcuoBwIgxiBZVI7ySwFLo4l0DH2f.rTIxgAc5i5m2tF993Im7ir
 AvMhDu1NM2JvH6_n_F7TJWVJ7S59PiKzTQ2QzAmGMHA0Xi7p5s7nQkNtkPqpoRldq75SuGXOHTYH
 lw3PMuC36hiUrMpyzkuIE8eFjlv7dxs3Q93MBC5m8Sjd9AotXI.ZfEUnWGk3azntwsFxylBJ.xKC
 KMAYFpT2WfuWI_QAu8Uyy7Dwdka_ZCXHiuE5rRUp5gt6l0APgfUELZm5zSfRTG__alBIDuNZ2DRI
 Dmr8xgaGWLmcAcuoGj4TDQ_4nFASuC.qlZerDXVS.r2ZWtq6wW8LM9KR0iQ1MkmsiYV5VWfaPwte
 TXvDbDqWXBWgyl3Hz7GJjxEdedo1oamJRSee3M1rvd.WPnYv0gKSmsnP3bqD1UUrzEaxd82Wjfwi
 saAlCbxyMqLRRoAm9xBKVWVL1pYm3085j4GHmIUz9wVPMcE1pQWTXdfb728Hn3Eap35VHa6kQDlI
 YFaCuxdpEHZHlOfuzdLmvRR2XN_qQXaiRd_gmbT8OK0SPCgKo6n4ER37i.Zb21hPQxiophNUvNA7
 _fvkqs8H9z9QlztsCgTIfp4FB3v1un71_lh4yDQiXT7rwiH5_tiFM.VcV4vAXOq3_AXLuxqNRepD
 7i.UwyJA0UhcPQnpBmNiSZY5iHd.Lvny0agWNOsih6aWizPhOGo7lzrQSArCrRv1xvRDuUv7tXQ8
 Fk23JiZErZnL1kQsr1Hx8Hx.Q4de47GisYAl0D9mcyMZr5FU54ciDtse.pzKe.oLul9YshSFdnhL
 BM7FX5O7LeIkcqyfxoLCAZKbcAH00a.13aOn7HR_Wvo4Zjj1iOuJwtJMiMYHrE0ZDtV_5sABBSkc
 H58KdwUio53g8kzJ5zYETCmBIXCMvHg2rfpEdOsT.ZNoOCHjPReKh40vhbCsxb5GP_pfINAdAkO3
 BzAGFtfb9tcyxqeBtZfGEafRKuORzvdpljlLHp3M81cWrP84LblcFI22PMOxA1HnB48RqvSAj6ZR
 Sdx9gxz4JMGAIAiynmy8wJ.YLAwq0xxU7AxzlwQXKLB8KqrRvPTncA.bAl82pAZ6AEVotFOX4cl1
 vtvrLUwi3ThkzhegxCe4GOi4CTuCzSePXjuKRja6_WWX9Jm3NCM9CjVvoKzzvzTbcCRHL0_wFMxM
 UTe4W99b5Eb3jrb5w6jR5_a.yjM4MgRQrs6bnohI-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 22 Oct 2021 18:03:07 +0000
Received: by kubenode539.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID fe31b24a65cbdfdfe6ca7338a2c34446;
          Fri, 22 Oct 2021 18:03:04 +0000 (UTC)
Message-ID: <2953e225-9b4b-317f-a994-30389341a023@schaufler-ca.com>
Date:   Fri, 22 Oct 2021 11:03:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] smackfs: use __GFP_NOFAIL for smk_cipso_doi()
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+89731ccb6fec15ce1c22@syzkaller.appspotmail.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        serge@hallyn.com, syzkaller-bugs@googlegroups.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <000000000000db448f05a212beea@google.com>
 <a293a766-4329-f6de-c8a9-1a5051217c45@I-love.SAKURA.ne.jp>
 <96c25c43-a419-bc5e-839a-7ff484b1c22a@i-love.sakura.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <96c25c43-a419-bc5e-839a-7ff484b1c22a@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19198 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/19/2021 4:54 AM, Tetsuo Handa wrote:
> syzbot is reporting kernel panic at smk_cipso_doi() due to memory
> allocation fault injection [1]. The reason for need to use panic() was
> not explained. But since no fix was proposed for 18 months, for now
> let's use __GFP_NOFAIL for utilizing syzbot resource on other bugs.
>
> Link: https://syzkaller.appspot.com/bug?extid=89731ccb6fec15ce1c22 [1]
> Reported-by: syzbot <syzbot+89731ccb6fec15ce1c22@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Added to smack-next. Thank you.

> ---
>   security/smack/smackfs.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index 83b90442f963..3e6a198dd3dd 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -693,9 +693,7 @@ static void smk_cipso_doi(void)
>   		printk(KERN_WARNING "%s:%d remove rc = %d\n",
>   		       __func__, __LINE__, rc);
>   
> -	doip = kmalloc(sizeof(struct cipso_v4_doi), GFP_KERNEL);
> -	if (doip == NULL)
> -		panic("smack:  Failed to initialize cipso DOI.\n");
> +	doip = kmalloc(sizeof(struct cipso_v4_doi), GFP_KERNEL | __GFP_NOFAIL);
>   	doip->map.std = NULL;
>   	doip->doi = smk_cipso_doi_value;
>   	doip->type = CIPSO_V4_MAP_PASS;

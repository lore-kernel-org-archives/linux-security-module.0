Return-Path: <SRS0=wNUX=P2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC95C43612
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Jan 2019 00:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFDC20873
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Jan 2019 00:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="V6J6R/9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfARAsB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 17 Jan 2019 19:48:01 -0500
Received: from sonic314-20.consmr.mail.bf2.yahoo.com ([74.6.132.194]:44947
        "EHLO sonic314-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbfARAsB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Jan 2019 19:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1547772480; bh=1viDzkYj+hoJ0N/kuolSjmJeRO5coObOz8X8njet8ng=; h=To:Cc:From:Subject:Date:From:Subject; b=V6J6R/9tgecqS81MThdVH2OkD6Z1VuoY5+ymHREYOzNtxAkkR71rtZL5n2LtP1qEIKj1wNiGogx3HIN4QuRhifgefB1naWYP+unBZOVweOE7g2cFCmQaKs7ZxnNCyiIZwUy/twXP/+f2TbARSSm3eRVCrz7hVZfQXfsHQVoYF+6sbWKvLUq06kL8f5oU/yKSTlxZq2UnAGKjzjZE7xX8GBd1UPqgE1I0Jhs9mLzaWsYMUeaq/4ww7gXseMA0lv2Fg+hfWEYiMZJfQkeSjNczzLqIdwZklGlTd9b/j/LMyWSqRp8BnbK3PcKRoLY2jkEwxxOGH/EpdtmCQmBQ2/Bv1A==
X-YMail-OSG: 9HqnDKcVM1mFap.f7b9Ifn0VVh4Cy.WZJlHONbWc9VH7VsuHEESQaxZec86WGHQ
 FLmk.yC.69T0WZokHUZs_wNSxmcCOKDnqF4JRExl9lbB48gm9ybu4wUMiBDO8.I4fu7T8Puk3TvJ
 xw6QZ_312Rm5Ls3jGW2sGmBp0bbyJw71nZ.aQNJbMGf7F_beBguk6yaS_4kcZ2D9CEuzNNzlJfxH
 Pu1jtftv2jW9G76j1ggA92ew23Q4m6KJIMAhzD_NQIELVnOr2psuCf4fTpoPUhH4tuDQmmgUAM7n
 XqyX2BpKq0WEJZv1thgB6ZRXiOvOQtZq84bvfmmjj7gEBS3ERS3gwKjzLdaZ4cYOyxxkUjNrInC2
 wMDOun2QEjY3o_ZQfUANUzwJOWUjP5buAf054l.sTm6Fbi6yu9XcNu9gqmKmq0seWe1E_gD1qbBK
 IvkDZy7tbWLNpBMQh6aRUKL3jdDweyQiNtxWcg2mpvjHgUbHLwYnYCPgYaK89WLYpiAM4IoGfF4I
 zq_9suj_p0U1LCjP_w2rnkURElMAZE4Q8AVnaF7CqnqjsyF4UytF_ri5ye7M2JYyoZVe3AEJAOpd
 0I10tfW.SBaEhgJN_dJQexy68diJyp34dqV9GoG2.QstafwznSQ_ZJUQDATnsTc3PPjP5DTdLuPr
 GBdIVO.JmvhKmfDgLmRYOjildoqqnbcg2y_T2oXSrcVRfybrgPl_iC4nY9v3CNXsLBC55JTuHI1N
 _xIZUL.PfcGsv62xAuzaStAgKKA_1169B5xH20bA4Brm5PmcrVrcnTklCYTePDfQpwFOS9pBq2RN
 BuZQaGqj0eXrumcXJwKQSZ3Beaee6jQqqvzyhlZBa2iYAfkEaSByC2jKbGXshUFcEeCI3fK0XtTP
 pBv0OendiO.oyV4wQFn2kHqenf57XBZR3zcLczCUMOSKoTCwOvLUekkqjEqK0bc1P4ywCq85iOIN
 HITw4kL7wLieuHIXeYX5Xxw5gtNonjnYgav1htPcfMgAS8PEALQLW3.Zz6AyGbCm50WJgZtt7jrs
 iAYItj9dw98BNDXtAkMMI5sS.pVWO_ZKAM76lLTMRX9QO8TZof66YSbNwv9aAwFYI41xm.tc49th
 j6aNaaNjJyZyF0g9Stew-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Fri, 18 Jan 2019 00:48:00 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp418.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8f070f91114a6a50abd65d6bde1c0dcd;
          Fri, 18 Jan 2019 00:47:58 +0000 (UTC)
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: evm_inode_init_security and module stacking
Message-ID: <f1a86814-716a-d02d-42ce-8ef64d680feb@schaufler-ca.com>
Date:   Thu, 17 Jan 2019 16:47:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

security_inode_init_security() currently calls at most one
of selinux_inode_init_security() and smack_inode_init_security().
It then sends the result to evm_inode_init_security to create
the security.evm attribute. This isn't going to work on a system
that has both SELinux and Smack.

I see two options:
	- create security.evm with the information from all
	  security modules that provide inode_init_security hooks
	- create a separate attribute for each module,
	  security.evm-selinux and security.evm-smack in the
	  current case.

How would you like to have it work? I am agnostic, although the
separate attributes would be easier for the infrastructure.


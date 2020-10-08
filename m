Return-Path: <SRS0=sAtF=DP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437C0C433E7
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Oct 2020 17:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5259221FC
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Oct 2020 17:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Jf0OQxWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbgJHRGF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 8 Oct 2020 13:06:05 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:46502
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730442AbgJHRGE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 8 Oct 2020 13:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602176763; bh=MXcVsDbW+cuk3Ncav3f+ukK3Mscnf7MOLf0ejEHQ7+8=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=Jf0OQxWLxucJztYhdCIEI+pp/+r3qecx4+19/JqEdxe9+rus13mpfUKbn3mlkHj3LzyGYJpDSiD8AL8nk+KH8dDlZyZAI/QkW12QarSKELxxfYMoYoYSZmDf4jbW4uBrUFohZ4fJIEee018IrTmCQ9PZcpeqv0SJeyKj55wQrXUWOey++gbUNfv40yF9OIp7FuvdL3QYyFfN+kt7ZvnYayBuwyOa7M+9ICjS+YUZPDpynpSmohf7XkSpIo7PuL4+HcxXai48rHdQpfXH74r8gN9XOP5ZWvxijCB67j7zVlQ8VHf//vB+SLMczgJMBLcEVW+Wq+23mPc/CD/Gj2Lcng==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602176763; bh=6G7Eis8DRRAbXr4eTinDEWWgnqStui+IxUT3+PWWavr=; h=Subject:To:From:Date; b=sDFoDjY/vuxV10qaG8GeKFOLidQeJOWNNvooP17u2Tajgc4itoQLg3RB6aEn7f6cR9zh90E2pziQzEDf5zNuiF320hoHEAA8gOQ4ivG3VP4jrxnUUED2sdlS8tuNUitAc7fzD9BIplMwlLR9lKno2pbvgXNHyKLHOTTbhA4GA8Ft/FrxeN5nLqGAyifnmwzPgH+tpEz2DNAgKIc1PEspQnsKPvwsIcyEmoSdJT5iPKZW3cV/B900BdfOS+VLOSfT/74ya5/5uNp74xvA35Hy4DirHmuzEEwD6lRmQGBSoBgkDMEatun8DpLp9+t6bpcNEv7347CWpGy5iSCPy4w2UQ==
X-YMail-OSG: eb3qq.UVM1kZMEj78FExV2jcoApYMfCtZawx1wnOhGzKDhp5_Jj47LtWgiljTX0
 KtrkwXbbH.YLZ3.2_omkQriHuRDCWqqSaHp.P0Gw7cfqQVDwHEdSeHusXzebi9TvKACLnixH_nGL
 vAqf79pASlz_OLuBCIThaF1tAC_iaYSlswEvIZYfEbkotD5fjq0Sg5pepsZwt5hDTnGVwVyHmNwV
 lpPZRGf6K6tQN.JtKJzWQt1ebumHAqVHhB1jYih2FZXTLIkbgoDR4ZYNVoy09RjXSVoDyjstWsXd
 teNxJ5uwejRrl5RWz2_0DF7xmrKtMBEJgcHt4o_CJjuHopoNABab038c.Eb5t6QvxGzgFT.ktk61
 6BUIaoVp1kztyYmFGgJjjcacJfrHJEr0ikdl4sqmz_PY9T.O4MMKd2dO0fkim7BerIrgkN3hWOUQ
 xZund59QHko464rCCCkhJkPss_8DW3KjR9T47aGzBExWF.kOuwoCKmtXmLIbjOmSoNYvNBwAEOVX
 IpXS.t_R7M6kRuj6_yEXF17Pf0E7bGfXY9C9v3c7AKyhGZ1fxEciKyfLJCEDLtcj.e6cvTzyBCs7
 td8FVNfIKXGs9OBvqfk93oc_UkHhDkrvsd1G0VdoJJHhwAe_ETrIucopsSSOJlbMg3zhdmJXF7Jv
 RfFf31CTudq.VOSaqIHVJZrBsCzh9Jebn8zXYCuUGfnTBxcZb8R4w886bZoP2Opm2Yyl0HUI_cAI
 0NFaV7h0w36B_vaLu5iIsYSyjKhmxEnTFejfasMqCTeCrXTTchsaGRylsLa1aFJrd.EEPrRBEXcx
 hWePz0wkU6NcCmHu6XnEWMgmtu28csqCHs1fNc6nBKo1vNMxnZrTbZuTpQ3oAqhXjsDNpnHScV41
 iiqIX94QryLaHZ.0DbAAZn4UNe4WiB50vZuqKgjGClIFDaU2xeNXYvOKAlGIPO2K4voCWq6aTF0w
 yUz5EgsSLMSlx.CcF_8GiMi0up_j074uNMyPvMFotQgIWoZurEu1Jp4UO15jjCjqlkfNDZG.PtQX
 BcYCPHy9EFQb8_KdXKeoMcSzyzrjT0Oxm8AUfQuLeEd2bD07aasyhsWPC.7YBwB4PFKSptGLNLQ2
 4.qiB3m55Av7pvgiMBixUjBIevxR1RnniTcy7dUJrqM9tjCBp37mixuSYbw24S.Kt1BWBzjfySVh
 7dqD9NA3zRn4j_DXTAmwO1psGUkMPVWN9l121qTFKz5d11bmTG_pRbC1y3krUbEUFJCiFjqu3442
 x5Vb4GM0h4qz5UBUIocrwB0crHEYdypfzcUkHKwA9ggKHeidEF_6mbyuQsfEqsDYU80n1i15f3kf
 UDJAVUQyQcjAAJoN6ktP4zBwZ1wSwAZyHXY1CRBBDxy1hgyPlBz.xfarKJjn5QoB_m9Z22OV9T5b
 0UHJsR9RjWwHN.ii_0Szvru0vLbcVfYX9wEcDzPWzTtPaAMBdlwhV6qHXz0VpBXfWB1LV6EXjazh
 ULIKIfebotbGXKPz9h2TeV9QBHDBr9w5VaQ3aM.85vq3OMNMCQdONXjSJ.OsB5iSOfPGMA3FwDiA
 gYx.Xig--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Thu, 8 Oct 2020 17:06:03 +0000
Received: by smtp405.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 62472fd73eac99dc9bda59ce73e8ea25;
          Thu, 08 Oct 2020 17:05:58 +0000 (UTC)
Subject: Re: selinux: how to query if selinux is enabled
To:     Olga Kornievskaia <aglo@umich.edu>,
        linux-security-module@vger.kernel.org
References: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <18b81f83-5fa2-12d1-1f0f-7933d2ecc6c4@schaufler-ca.com>
Date:   Thu, 8 Oct 2020 10:05:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16795 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/7/2020 5:40 PM, Olga Kornievskaia wrote:
> Hi folks,
>
> >From some linux kernel module, is it possible to query and find out
> whether or not selinux is currently enabled or not?

% cat /sys/kernel/security/lsm
capability,yamma,selinux

>
> Thank you.

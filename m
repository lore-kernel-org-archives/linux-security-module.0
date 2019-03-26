Return-Path: <SRS0=+HMg=R5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470D7C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 23:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1136F2075E
	for <linux-security-module@archiver.kernel.org>; Tue, 26 Mar 2019 23:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="l6IcYr2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbfCZXzw (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:55:52 -0400
Received: from sonic301-9.consmr.mail.bf2.yahoo.com ([74.6.129.48]:46014 "EHLO
        sonic301-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730333AbfCZXzw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 Mar 2019 19:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1553644551; bh=JchG032BE856JG7rhgFMhL+UVXGWgjosfsoEXZcUKKg=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=l6IcYr2VXC7uuhFy+/AlhHefW0PzMZLJB0/AWd1JpJZWNNIi7pBPFGUcwSjMcR4gx3FW8if2/hnJ8d6oTUGju94F5nJzJwNZmMyMQpHKE8gFPnJ2ilKLvniG5j22ruz0PSNazXSq8UC5UAs+Yx40cXwZw/Wf6m16Skwfs0N4BM6fmq/T0rMnkTbTi4+qRiPUxlDRi/pXTn2ko1UFPd+DGhwKIc9IO6by+B4+o7PbPzwZfNTU09+vRC6YQUi7KI7O7LKsr1GbUoJL81BxvIsiPtJAUkulV8KeOzLZJSH6wdN9orNtUY57b5EVJBeER9s5nebA8V0w/NnkC4uP72Kdkw==
X-YMail-OSG: HTPy6dgVM1kE58acyxTFGRaVx4IPQkZrfx.eOkpkb3TcMQfSx1k2wy5FSlqg2MO
 AenE9y_dAFm_T6b6eRH_OcAb6Au2rLdMjuAgRg8aJc9iboFoDVDvnFrGk0SwIp6POmGfrr5Tqsmr
 nYKGVEYuNz3R_cjSKg4ZplCYLcTPByXrokR03iPbmjVpK.TTS1MUZ7bG34idNAkLhyQPVfl7Lu3x
 79HHoPdrfpJFW475fhz3nt_xE.DBs.TbIYb_H5iCn4ablxYT1mOFIG7RJC0Qp7jc9ZCtkv2kJUur
 7o59PH8MdIEt12v1dpnqeck0__PW2UzW.fMpvauR3QWr1bHLgQjgQbC3Ifr9OQChKR1_ff2aLmew
 zkUnFbcsxm3j4EOkh4gIZquJUEPKWrLYIfgMDTy18sWP6WYnACrqdIuIMAyPtXKM0Gq2LaonPtPz
 pR6BV8c3ZGCjMrjehMtf6o272OaCoLCS.H4.JIG8x.sK_nHkaG1e6sHATE6oJuBtGAkyJgkhCnK6
 HVlQ507qfdcm94GmPDlsdiHE_3NCuvIVI1j.f.5aNQLvRb5j_zl80U0y.0fAeWGtX3t5uYc6Tiye
 jwXxDxQL5DWgLJEqA_rTMNRdLLYcwO_HTHLNRaf59lEpn.xSrtWEwFS8KXrkL4h2.cNEpxF1ZsET
 ru2GlpCPJKOagVqJIW7icex1XfAQhtfKgufFjpX8xDdY.TNYbjKp_hEkkFCg6GVQdl8SO8ArKrSV
 3awd8u8kyd_lDKAOAkLnWFS6DjC5H6lKTRvfwdahtAX0mZzBuGdWSN7alWUCM3pWiRPP1WnLIUf0
 Oz7Y8BJZxh3ovw_tvLbZHAiuHg94_9gd_q1n2hVo.HgXJctOiBVrmpq8iHDDUTrH9d1iJ04CmBEq
 lkrrM3D4JjDNu0hG5G4EKOe.q45Sdbtcept8dDOIH4..xAjZ8OKI8bbcROeUcLWmigaVLW9SSJoa
 ji4KIdlVk_tYsIMjgNpJmj_AxnrSOIG8HBxOn992NQalE_YoMozyQeIYqnh6UxIkbuEXrt.9zcnM
 afGJaQf1hSUDhGoiXrOVu5G3wozCzCwWHsAUGDHFR1ZjdgTgPOLDmw4PrHNkP5mg1FqddssjN5zq
 aC_LNvGh.YWJ6_fMsk0GbustjDCySEdjwtzivtFM2_06ZJO8YbxwSmMw4MI_B8YKoG3ENSI.EIe.
 F1hFFl.y5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Tue, 26 Mar 2019 23:55:51 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp426.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a1d7d830a8079ae8160d5bd377e55b0b;
          Tue, 26 Mar 2019 23:55:50 +0000 (UTC)
Subject: Re: Linux security subsystem tree sync to v5.1-rc2
To:     James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org
References: <alpine.LRH.2.21.1903271036300.9951@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <03d9986d-3a92-ba15-30de-89fc49a6f10f@schaufler-ca.com>
Date:   Tue, 26 Mar 2019 16:55:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1903271036300.9951@namei.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 3/26/2019 4:37 PM, James Morris wrote:
> FYI,
>
> The next-general branch has been updated to v5.1-rc2
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git

Thank you. This is always a big help.


Return-Path: <SRS0=XWg0=XT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231C3C432C2
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Sep 2019 17:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D3E2146E
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Sep 2019 17:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ih/5SXkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395021AbfIXRN5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Sep 2019 13:13:57 -0400
Received: from sonic303-8.consmr.mail.bf2.yahoo.com ([74.6.131.47]:39056 "EHLO
        sonic303-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394988AbfIXRN5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Sep 2019 13:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1569345235; bh=HnQqbS6gGiAvYv2VSIJe/BCxyqhAczaGxw76MAVjhOw=; h=To:Cc:From:Subject:Date:From:Subject; b=Ih/5SXkHAB5y6P+jxYbuPPDPXVmzNHTkpfbNIn0Id7DOeUAkG0ta+MCfTXb/2ftMO7Y1SXi8cgZAyRgSPCEjDLcDxUpGTayxAImT9kvoZ/TcI/Bmhn7AZNCsTcpUX9KTsnSPcMNUN63wCfGGASBPsM8pATjCA6B/40VQ7zxN2BAc5GnSQM0wFUAATxhp774ewQUcOoboCaHOTUBVHKgZKWKKUWwnjJAYzdzaKzU8I/HRURF5KgrLAhGmsvhSut0uQGu9bwxRp8r9tjvU4ZFmZhUq3MmiMe6PobG4nES9UyklrpdVdr9CV4hpavRV5uhPX1ykuTOTk43kRArW5pdkJQ==
X-YMail-OSG: RmwMDi4VM1kzbDKXYSqe7dIV2uKXQCadf.ApiLR1YuY.zENwSGAK6QmMKb3IO.6
 lW4.MLa0vfsBTW08cRkLOcHspVPdglIg4Jx9WGhVL6OfikowHMDcZ2lySFE6PdAvS1gMKfr8_hUh
 kl3LY18ueSciTwQdM38JszxDG9ifORQmkQoi_3fcbGs2ggLpuVPWCSQSx4YG5FRsJWD4Zi9IDt5x
 ddosWzShr1wfy94YSDb2IWTefmLzf51UxaC62jejx_SEx6o1rrycegHdxMxKlYwE.PrnVJu5w_fR
 2P4la6aZKyF_aaR9UAUBziyB_UV8za_nI0I6IUwFXTTL0xxym.gCxD918EZ7wFO7Uf0NB2M7iuq4
 lAimY_BEXBLk7DgmDFrvUwfuOk0MUxIGb_sQkhM_xEYlpCMbOKWsvNMz04MR5hEfMaSWNmi3hBr5
 E5a_fTHEGSiOBGQSlQPupgtPvDogDNLSN7bWGsIFJZBUPxokU6mjqD3LqYCfslJlHKsD67j3zOiv
 gk.O.cpBOAIePByzrftLvAEmaMqhVkGpOqVvtrVTOfVvbF.uZuANstQyJ9UX5EQlt3pOf4UUZS.Y
 eWxdST4kqiJr3.D3whNLCyW5WlT5lxzc9lLjV3Xi2x8Pnrv2ehrKbuHxcL6mVqr59w92vcPCROBn
 NAghxaxOTbL8bJty.hFMCp8a8.PQVoGWcOI95fmEFPU7h.lSHlTcBnngARfTQegZtGNFWUCuUuY_
 WauOe9j3r0OoyJhDexQaSCTltzI_O2segd90BjZJfp8nHrV9QJCWdxjhK0kkxaCwSCB5hP2dXwJf
 hNDeR9anyUQKGB4bYrZu_mtpsiW8HlIgJOMGjVA5wovZQF8X54JBuKM.f0i_0UKN4_tYXH0oHBc4
 aldM3J7GhGzbKrMJDvVnc.MVnHKwmJzPYgHuQaaxFin94EPiOlkNt_keRiT3EZPIZ1zyRR4IyUjR
 6kwlv0MpZ2e5mP7rAkm753j2MK7AI9Yv2Mfo93RYQRsVtHm8C1VnAcbTaA3eQS_Cyto6KBkS4NPe
 964tlrJKGXbpcOUPoR3el_0F3YLDCI_k1xRUg4T0NvCfFRcDd9PEBzS3m.Onh9ELgAjRN6KNxkcb
 zW4X9ESbZ53uCAqmJqJJaRZL_Jv_r1RJZH_J4nRflf0QFinS.OhoZIppV7IxyC3y9M8y.TGIg1Uk
 Mhtv6RxBaS3paogEmSHK8PTxM3eKYaV_YzagQXyicAoo_onN3u2Q.mv55zaG8NdHviLTOSf9xAS6
 3vCclW8W3yNvEu8fTJ48jxyD2fa_gQa4FT.s2fy.L0tei7BNQ0yicruA_p2lQHiEbxUxJd4RyWGT
 8Gjkk
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Tue, 24 Sep 2019 17:13:55 +0000
Received: by smtp423.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 968d0b756dfde1f3f2d4262a5bbaa648;
          Tue, 24 Sep 2019 17:13:54 +0000 (UTC)
To:     James Morris <jmorris@namei.org>
Cc:     Linux Security Module list <linux-security-module@vger.kernel.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Do you plan to rebase next-general any time soon?
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <260cc0b6-f19e-36f7-b8e4-dad0dd0c5ded@schaufler-ca.com>
Date:   Tue, 24 Sep 2019 10:13:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi James. Do you have any plans to rebase next-general? I'm
working on the next revision of the stacking, and want to be
prepared for whichever way you decide to go. Thanks.


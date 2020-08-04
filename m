Return-Path: <SRS0=B0YM=BO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521A5C433DF
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Aug 2020 21:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 396F422B45
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Aug 2020 21:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pS/D8xIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgHDVnZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:43:25 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:33471
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727092AbgHDVnZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Aug 2020 17:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1596577404; bh=FUdYe0IBctUZEGwqD3LywKgSj01JLkKeBk54wXzszqw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=pS/D8xIcGppJzVXlbBX9+mvlHHuKsnvd+EOKQUGTZyKJ1Es+XWLJekzRTn/RCJ7vvpd+CI6TbH7472Cnqq7SV8kvfiPXkw+L6DgWD+YAs+qohlPZLzjIWmEja2W/Nw6/39jKhJbSxfrM0HJFflwVKRkdV394ZnFIXOI8TbHhljk0ffq2yHuOWTTeszuDNWPdqR+799VMD0Nm626G1MvOSGETga/xZToEZsqqqBpcCwJQ/HxFhUEPc2Z6EeRiStwMe5SnmZ1aBYLtCW643gAsJsKFS5YhopZ/GKKjUBVQqPfPXkeRxfmb5ZVCoN1jAhCgIeLwp/6rppXxGsYApRznUw==
X-YMail-OSG: kuUr3KwVM1nN0ELkdL3PWjjv0jvx90sD3cXNNxYU8gWIR3DJFyL7JKle2wizLgn
 QKqftlZKZl4gELGAI6ZoCaaW.lMZZPFFmREK8aKLc9isPiWKPCKAOaIAIDoqObiYy.UjX4COE6LS
 J0DaLx_jkA8cjQDXb2_Md1om8Y4bg_yCFa6uXstklN8ADh8mrfcZtXUwTc_g5gXOFrLFgmNwk.fg
 uVITJdJv9aGxdr.6.99I2w8zQ.cDfGsC68VWLj8ev7T4hyiH41LGtnxnerVhAZDNBb1cp1pxMU2h
 PfG8DPakZ1_B2F_6Ech3VcQcgTrRXT5FDvoyB5kKhCmpnWbSUP.OnMSu9XJcyIoxs0qMkHJYsSEr
 eLWeloNSiBQcrfEpf3skfRiOGrTDIMp0PBVhsEcEACeCFSi8BMj0PoeFflgPu84vbUTA9SsnnHfy
 qKBdrMhfRnIit4pdbw8Cnv.C7ZKrxyUBTiUe3IOuV43JDhSu3jNSdpINRISTpXRLLnn6dQQMrUoF
 I8v0KFc9zsqpqRbSFoYe.aki8tW0C5Ap2LoDbQxHpN76tj0MGHdi307BTr0JuAQMIH43cHi5SUcY
 PfWCcaN0E.LuaUYsejBBA3X8kUuf6mwcUMvpAlLZqz3eqX_c17PJEm_6F_pPBh2WnKUyW52gsl2D
 EZYLsKlq9Q3pfVrwoCUz3hi51IQlndGkDV8otwOPv7beuYUv28TlEi6yye8q6g.CCXy0LQ7Fhtum
 14Aw34IU4183imtyWJMyizqzHcP2SGpyg6xRHXScd0HnclaD09qclXP7BT5fX1tPK5W3kS_vhZFB
 rN82R89jrVDKvxA2uRD1WsXm_8kTfDRP3zs3_vRXpiMJCbuaRqLY4b7ZJoeUgI2h_fTPA.5QUI.9
 ybJRuDBLbWFFhPnu1SU8_Hdvq2E8_VbpnM_l7rMQo1aoh4b8C5HlQSlOHaDGZP3m_rjrX9gW3ql.
 Lb8rJAceXqiRuAY4CFjec0RjP0EZ6OQIKG9x2GagJ8KAEIvw_E3PfYTIhC2HH2piEdpYjDZ7i0kc
 8crfqc9TDk5uGvY0nw7flPsYnNgQUW06l6veq5R5LWFEN_r4W.odwaPSZvLwelQP3x5QK38WwyQt
 t6.JWPN6EYMVs8aytZ2IBDOdEUQ9G6i7RGCqsC7yc8zZXg350aheyXhDCNgObzzj_jyY9.1vD4gS
 RzLqoyqGEi14OG5kkatpFvsaQFeRh8knejwRWrLuR1A95nkh23nN4TeqcfAyOc3G.0XJqjzJRyD8
 qAxwrqThlLV0feUq28Q4fwHf7iGhvkIefVuOll4F4CthZo15Br4ZmRACF_296P1r8.y7_i3Pm8RT
 2zjSY7qpCUWku4_CVcMnlcskewC.TDS4Tzc897IzRClgQAM.VoQzBgw2knNbJuMH3R9N9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 4 Aug 2020 21:43:24 +0000
Received: by smtp420.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 08988a7113e655af56d674f4574816c9;
          Tue, 04 Aug 2020 21:43:20 +0000 (UTC)
Subject: Re: [GIT PULL] Smack patches for v5.9
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <8ce85723-5656-0ee8-67a7-35597d9df0dd.ref@schaufler-ca.com>
 <8ce85723-5656-0ee8-67a7-35597d9df0dd@schaufler-ca.com>
 <CAHk-=wjkuGCCk7DCNP6836FYeOaKZR9KLOBzr21fPOVNnOZiKA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a900626d-be1e-55cb-7fd3-2de444c30109@schaufler-ca.com>
Date:   Tue, 4 Aug 2020 14:43:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjkuGCCk7DCNP6836FYeOaKZR9KLOBzr21fPOVNnOZiKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16436 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 8/4/2020 2:26 PM, Linus Torvalds wrote:
> On Tue, Aug 4, 2020 at 10:49 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Here are three minor fixes to Smack for the v5.9 release.
> I can't pull this: that's not a signed tag, and I don't pull unsigned
> stuff from open hosting sites, no matter how obvious they may seem.
>
> You typically have a capitalized signed tag, but I'm not seeing that
> this time. Hmm?

You're right. Tag usage failure on my part.
I will resubmit. Sorry for the extra work.

>              Linus

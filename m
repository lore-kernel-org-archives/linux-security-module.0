Return-Path: <SRS0=l7tI=NN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A61C32789
	for <linux-security-module@archiver.kernel.org>; Fri,  2 Nov 2018 19:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B0D2081F
	for <linux-security-module@archiver.kernel.org>; Fri,  2 Nov 2018 19:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cP6nSyjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B0D2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbeKCEKk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:10:40 -0400
Received: from sonic313-20.consmr.mail.bf2.yahoo.com ([74.6.133.194]:34781
        "EHLO sonic313-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729898AbeKCEKk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 3 Nov 2018 00:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1541185340; bh=9VADx1hjsrNWDUHVy4mOwoYb23n6f8qxp8GnHruBRhc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=cP6nSyjph5hm6baL6IH01w2KVCAan5KIkO65svjVGpC22z2FgnOYcK+uflqH3HV6eBeJYVH4Hblc7xjfeoOosfjudUedzUImg08clOztvQTEFATfXCHhMIXNmK6ZdMwp0xO8+MZyovCwYVEbeLOphEq0x2QouJVCb5AsAfEu9iBlPeENRiGqCD9YEhzgqTXZiAD9ZwJD+FJlmgI/agn/TmgVtBjPQD42lPvyi9RtNvqiyva6GvLxAtqtI7F6qLUJej1vBTeUs44qkEubAzkW44/OMNO7HcUK5M0pUUhSFQ4rBiwRp7dKtk7+T24IYyJ5ELdQ62GGu6OnlJZaMaVcpw==
X-YMail-OSG: BkLOnzEVM1lUjK9Av3IaHweXKsFjGwq3gwYcghV8HFPGQXPjp.RqhKKoXFXjc4f
 v1Ok0NAZEjP5j4WpDnhI5CxoVZDq4AaXl8.YgcTjvIpVupjD6PKtL.n4ZswpjuhJ_F7C3iqdAo4d
 AqvVKv5ycN71Rw1y.mRi1s7F8e5jRWJ99zh0b4fazi_FnWZQeTf0.4ASOFpQ2XmDu64DejelFBYG
 9gdxyloPWxv_wkeibJ6dNN7B3PG.fR5NcDDbmeSdqGgaTZ7uNuyYOhbdIHCkx4A8wo0StgcXEy6G
 J3ba1DQiKQaqHbY9mGBO6xwtRIlN7227ZCnbuVEcSQa6pvav0M7kciqblX2r8XFNvddJ5O5OGDwD
 bhUHzP1n.WRriCRFS7O5CZQAhV2Zb_gvXEFpAuDXtxccDnJraCLEwIMZk00b1rK4qJ5Ou1QYjS6D
 HF2Znb6AGYqdI1AgTgABlQJfxiTWvwUSYj_J2778cFe1Q.EEk_GIVZNhv0a_l6MfnDP0RjNZM_qq
 MfBU8ZPFkAn4cJnhNBk4UCDOR1VdhMwoVjQyYrZUl90cEuss.Zlp.Q3P0k0cl9GlTozFda5dCCN2
 9Fh.lnqh04Om1dIT4l9HDbAUgwts0TGnewFDcJuCvEVznqZ.Rl2XfW3u9tX15_Tu6yyk03MfIWfX
 BxGimaaMtdZynRPWb1zNcfdJb2G6_.i2pUEmaXtqxXOpjU1UysgWYVHKgf56R7d.5ob1IWpyU98O
 JHXsQK3s7Y0PYvA4PYqX3s0In2ngtrVQ3X_.Ep_N0YQy8isWf1AEL5eR7fzcVcf6J.eGpk1C1SkA
 cL5YeqqPDqx_jGC94xzc8V6IH2HynKys6TTINwaVfQ54cnNfg_yQxm94mvZLwJuiOlnDP_2tbgEW
 rv7sHtavxyjaOuICtsR0zXgzCrQ4ngPPwDGg0BQBKz3j_GZyD2bPQPozJFEYBKz.Q0LmucVNUlca
 Q7SmsmfZP.ot89Gxa5Wv4i6j5YGnMcrvXH_81k1H8MsP4a2G1HWzUg5VzvqY96wZETh2mPV7k0QM
 4fs9sFr1e_mIIiK.V_u2QtSGD60G._tihh5yJ_jQSZ2rMJjb9Gsv5DuMD6ktQ88o5jrX61M8jylh
 _GJ10csxZLQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Fri, 2 Nov 2018 19:02:20 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp412.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 148f8e47bacce886da41bbaac902af8d;
          Fri, 02 Nov 2018 19:02:16 +0000 (UTC)
Subject: Re: [PATCH] LSM: add SafeSetID module that gates setid calls
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Micah Morton <mortonm@chromium.org>, jmorris@namei.org,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org
References: <20181031152846.234791-1-mortonm@chromium.org>
 <20181031210245.GA3537@mail.hallyn.com>
 <20181101060737.GA7132@mail.hallyn.com>
 <CAJ-EccMaAu+g55Nuh1nZqt3Ld-YEgDiT_ewdQzGtFGmzRgXckw@mail.gmail.com>
 <41daea64-03c0-0970-c405-d1a5ae134181@schaufler-ca.com>
 <CAJ-EccNO8DeER3VUyyxO-CD_qBmzasMvZuUsbdWgcfiAjRcsFw@mail.gmail.com>
 <3a3231b3-44b3-b330-2cda-d4246bca35be@schaufler-ca.com>
 <CAJ-EccMU9mtyA1qwXYEqHP9vXZEBiuCfdG3KTrAA-hQ+Y-CANg@mail.gmail.com>
 <5c7e1a80-c534-6adb-be19-58bb0d97084f@schaufler-ca.com>
 <20181102183056.GA20738@mail.hallyn.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <b1f95526-d0f1-712e-e0a7-9710cae7e1f0@schaufler-ca.com>
Date:   Fri, 2 Nov 2018 12:02:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181102183056.GA20738@mail.hallyn.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/2/2018 11:30 AM, Serge E. Hallyn wrote:
> Quoting Casey Schaufler (casey@schaufler-ca.com):
>
>> Let me suggest a change to the way your LSM works
>> that would reduce my concerns. Rather than refusing to
>> make a UID change that isn't on your whitelist, kill a
>> process that makes a prohibited request. This mitigates
>> the problem where a process doesn't check for an error
>> return. Sure, your system will be harder to get running
>> until your whitelist is complete, but you'll avoid a
>> whole category of security bugs.
> Might also consider not restricting CAP_SETUID, but instead adding a
> new CAP_SETUID_RANGE capability.  That way you can be sure there will be
> no regressions with any programs which run with CAP_SETUID.
>
> Though that violates what Casey was just arguing halfway up the email.

I know that it's hard to believe 20 years after the fact,
but the POSIX group worked very hard to ensure that the granularity
of capabilities was correct for the security policy that the
interfaces defined in P1003.1. What would CAP_SETUID_RANGE mean?


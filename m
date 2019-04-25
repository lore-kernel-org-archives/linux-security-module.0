Return-Path: <SRS0=DaHd=S3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE40C43219
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Apr 2019 15:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3832088F
	for <linux-security-module@archiver.kernel.org>; Thu, 25 Apr 2019 15:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jD+g9yJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfDYPwF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:52:05 -0400
Received: from sonic303-27.consmr.mail.ne1.yahoo.com ([66.163.188.153]:41456
        "EHLO sonic303-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbfDYPwF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 25 Apr 2019 11:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1556207523; bh=6F7cgqWKJ5X40Ob7nwqUhqwP50oVBlnQbrP3L3vxrhU=; h=Subject:To:References:From:Cc:Date:In-Reply-To:From:Subject; b=jD+g9yJEpzVbwdC0eyMve84+zLdKhQOikpuZX85+IdYPfxLwgQo+VjmSfSWUJG6G1gjt7VUSaPFfjWoRWZVFG4/Bj/m2oGohec4olqEWqo/Y8gG/70S7PT0dziOPEABzfqYd6BYukEh+GOSpTVkS/FIbmo6aFgXwc0+32cxTdsDF1t75KjAdcajQjaFSiyuMM38M64JwEWru4RSRqsCf7qxmb9iEDqZGtetaDV73YJ4T1dBHcVJOinmGaiEjQaldYWOuBaLOOOFO1vDZfkPslCbHtKqMzO75nBvw/+oVGMDeDkDCEdZ9hRM08yfUSCGnbv/HHuDGWTmWNeV22R+A1Q==
X-YMail-OSG: 8.GWXWwVM1mNd.Ow4ZGzEDYY6y8ks976fXFb5PWBl7M9mQMQpklYyC98TX1EQQB
 kjKNW_t3SychEWEKC3kp.lgDlUYVgtnSi35TsRkVcwuwyf5n5l.N71eCiLcLDhw.90LoP2QffHs1
 7n0vwZIkaRX6kkHvO2TIlCOJEUgaOutHNRjiInQfrcSYQbqtiPxGjxFD7Ouq86.qIre_I6eeC84h
 5fP5u99DrfU1tGwe1zlMM_gLKcPKaPKwYV.CJhrcrMGsILTqaA48sjfjhO1Mm5Ct8n59ZafeUpe6
 KhwqhbfbOq_fEsUzQHkNpKLgiyX7_G6TKBpRlDkjO5Um_2S7YRt8ahEqm13BbJBdZjDV87UtQm29
 1oB0l8IDpTLO1xQHwv2Go0r_5qhRDdtvEWhGvQLu3OFDdwMw8F7KKDNZbzQVmBVKPOalBg4ziGSH
 RqeFIwp7aTwVX1mrJDBnT7kAUmskiGFwZSrJ_mBLr.ixj6dPZNcWymTJKi1IGAZp58eOptVtTaoz
 EBFp4hOFvbPuzjG6k0uPLEXVYBCPpzqk5d5J.QREi_oE2SOepyiPKPdTvp.MjnrhS.mIAkSHD15B
 xMkyAxH1GTOKydVkv2TzDiHMQhlDK.ZOosvMuYvKpjGUF1QURO5KboUAJAg0zCln_ebxESX6CBxr
 Pd37UHSJxOO147oi67soihFsGcBJTAHTbVUmrvPyis28AznjsoBmtVzuxqX7BrkHLm_0unJDRM55
 tVypYQTYvMejJ2ZTYdVhveFK7FpKBxcb3CoscOwikAWplGcEXX4kc.WBrHSjC2GlDhngfsGnJhz5
 30duTKtxEzUGpOaTg27hyIxeT8BHieL6Ww.3BIiSooDk9ct2SXGdc_Zf9zEb_4xMr3OOTOmqdqgU
 43PYt7RS0B49AALmmlv72jzEd14AaCL9BVj0nTcR0faZU8s2Xh_GHFx4EQ0HxOcd1sHkigQ3CiXb
 5tdp72u5w_Su.1v6pbiSZxy6dC2ubvwnNHAH4Mh0uBv9k0F2z3mXl4BVWGc.gR26DZzdSIi2.srM
 dWqnxCjXOVNqGig.6nN.mSo93fDWLsxu14Y6mEPnA8i4wSI.LoCNofhIl2NeM1zqDHsr.qYhGWge
 fgUXYgGuQgUF6jXGrLe4HDaGOAsr3ALQdfJkimNwH_ebN_uYblFWtWXWXTpk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Thu, 25 Apr 2019 15:52:03 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp430.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2e90608732f07839f6804a2bda555c8e;
          Thu, 25 Apr 2019 15:52:02 +0000 (UTC)
Subject: Re: smack ( on host ) + apparmor ( on docker ) - possible ?
To:     shrawan kumar <connect.shrawan@gmail.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        smack-discuss-owner@lists.01.org
References: <CALuYEFrJfWAqr=po=ELqvMsFftxpoO0QHA5_CJgd5e2p0h0euw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>
Message-ID: <8234adc6-18c6-feab-ca04-d4cfbc64373f@schaufler-ca.com>
Date:   Thu, 25 Apr 2019 08:52:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CALuYEFrJfWAqr=po=ELqvMsFftxpoO0QHA5_CJgd5e2p0h0euw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 4/24/2019 9:37 PM, shrawan kumar wrote:
> Dear Casey ,
>
> For one of my embedded project ,?? the requirement is to run a set of 
> process under *Docker* and each process inside Docker needs to be 
> sandboxed using *AppArmour*. However, the host from where Docker is 
> launched is *Smack* enabled . We are using *smack* as default security 
> on host .
>
> Is the above combination possible ?

With the current upstream kernel, no. You can't run more
than one "major" security module at a time. As of 5.1 you
will have more flexibility, but still not enough for Smack
and AppArmor to coexist. Development is underway for the
next phase of module stacking, which will be proposed for
5.3 and can be found:

git://github.com/cschaufler/lsm-stacking.git#stack-5.1-rc2-apparmor

With this patch set you can run Smack and AppArmor together.
What I don't know is how you would configure AppArmor so that
you can sub-configure your containers. I've added John Johansen
to the thread. He is the AppArmor expert who has been working
on AppArmor namespaces.

To the best of my knowledge no one has done what you want,
but supporting your configuration is an explicit goal. We
would be more than happy to help you in your efforts.

> Thanks and Regards
> Shrawan

Return-Path: <SRS0=hu4j=BY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCDEC433E1
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Aug 2020 00:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F2802078D
	for <linux-security-module@archiver.kernel.org>; Fri, 14 Aug 2020 00:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LgqJ9zuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHNAcR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 13 Aug 2020 20:32:17 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com ([66.163.186.154]:46348
        "EHLO sonic302-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726546AbgHNAcR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Aug 2020 20:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597365136; bh=/tUiIFw3uQloUliYfL3jkaa4Re76Fbfx2PnuzfbhRds=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=LgqJ9zuCcKwyoz2nKqce7/fuSXLlhaMBrWcCw+FihH9T+epHjtUAwEb32I3JIPZ4n05t3Fpmvk8Ip+y4iOlHp+63ikGNjOyFWdwKpZwf8ws5SerHjYGw6n2DsU/x11Cy9wf4U/TcaFnsrjMLVV0xOr+1yBj2bXulnwLwAh6i5JV0H1fWc1/HAL1Rhr7mLTMzOv6kaCFVxMGJjbY221UX21pQOWE/YZlFDP9nbzSTgqToUAhbLBu+vtQcPP0lJue7YIG7uOenRotu0oJ/kOsi8Rx03d4I4NWREodYr93yX29aE7Afr/4hJ5JFF6DzD5MVMsARWjUcy09m8L5iXHg0Lw==
X-YMail-OSG: 1q9_im4VM1mtq8DkWjwZcFLK2XeIFR5aZSOUehP2l.9Kq3rziehXLs.pIQPZxSR
 MQreI2fPEQQY8QKDLRUJ5lmDjAUM2p_39sosZg5sPzItF6aTVxwSCijGTJG4UIkMremnT22dtWgH
 slZEdntlbWawjQb1IYridGDRWvhXGpzAbP_EXeKWAJ29ySOQ24adkrQv.fJfbHCYk8H4vA_D1nIB
 O0z1Jz8zAIdARSGKezKyd6cPBN0.0uGHQLs1ThgF7aEfCTr9lJeqdwQBioDxnWCCCBKNncN6GqKl
 XwmAwxTRc7gBT0v_q_8cLMZ4yELX1XIfJHmCi_62yRC8KKtKdS704w91TDXMQi8yMP_IN2DiV9Ew
 Sn.bSyGL14z1d3aBx0XTIEpfkWjGuXHSNyyztSEXPgrICjFDbzjfVBZEbSrhBtCnG1fUjl5Bv9H.
 cHUQfw_yM5yPSG_f_f0gubsedPfw1dYvl.ka9eAe5TfeHZd.V4iBO.dGqH2j1ds8733ukWuoLp5u
 uLyPvSMesU7x1TVjDCNYcvkEXixoUlY5z0xE0TV6AjNVb5O7G0wFFzFUpy5Cs1HtoF0Pesfgz2iT
 YLdoNddE.Y1BWweiW3YpzLFXKRxEsghP4VKoQ6LeecjOFG7Lz8O_kDrkqts_1Wp9ftG.qiHDh0w9
 lYX_5DoNWj4wU3cWK.r90ET4Ufs3d5P6rnknCvmDFPK.56FUsYxJJRZY_wuw2AG5FF6cysIkQWv9
 hceesaPZW_eJpakzTv1KCORaLRs1TOP8lh.D3Er7aTKS4wbP9HaLmPKQTjwwKX4Auy6jMr4Lehel
 WeIpmv2XIZ7NlsiWIbdliSrOxoCuRM1ewLDRl0s2TXPOd1rZ7BD8cG_B0c3ClA7sihRr9YV9kiZa
 qv2mywDoCNQR33NGLH4M5t.HlZrNTT4EKn8dToM7zPbnwI0HWQLkgYDKGnyHqgu6L7Y1jxVQixD_
 vt8TIOI_xDNDWx6kV6fbL0lr6gCCnJgh4lsir3Mjiq.y6g8TyEenOA8fs8LVqnv.nOuMBHuwPL34
 2D4QkIT6cCXvWQ8OJFYsI9ZhO8c5JJGQYDZNakfTsmzSRDUfgdZqUNJfy26TntzXuqpd3ggtqNKE
 m2rkXFnaBQCZKRa4O.WgvUtlTtAdv_ONIv0n6znIRWz1.XrIcfDaLY.ATIWlMY0lycpLzX3oHaJ9
 7.AFqevqLW8cnY6i0MyFsYwpv_IPdv1oh41GOOJAYCzzF2wH2mbJiwJt6SCw3MSSawczZ1SrIkZ4
 kOjJ_KXZOf230Os0I5kKh6ITqTcR44FmGHpy9MGIxEsl54r3bwnYcMDb0DchKRfyKYgK9sVQ56Ft
 fTapHQu36pvnDeA7GDgDCZ6mxO4Va9UbvEzgl1TEzIhiStncqxEHlkjyos3NVUYgh5VhUdyRgsHr
 G8qimE9odagJepbdow92PI0JmOQIOt36xmSKHvKDLpHUO6Fwhv4F9afkmgfsqkcnKrZsx76RtY8H
 NjRGoUmHDcB..KDQcvEiXWusO
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 14 Aug 2020 00:32:16 +0000
Received: by smtp406.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2fb544d1c7b2b7befbe9fb65a8d5e36f;
          Fri, 14 Aug 2020 00:32:14 +0000 (UTC)
Subject: Re: [PATCH 0/3] Smack: Use the netlbl incoming cache
To:     Paul Moore <paul@paul-moore.com>
Cc:     SMACK-discuss@lists.01.org, linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200812003943.3036-1-casey.ref@schaufler-ca.com>
 <20200812003943.3036-1-casey@schaufler-ca.com>
 <CAHC9VhTq66h1LsNBuhXG6WFiKn7hCBApciG6sVawW=jDwqDDWg@mail.gmail.com>
 <fba5a257-599f-b2e5-d4bf-57269fc7734b@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <b1fcf225-83f4-dbed-8d70-f2e0194e70db@schaufler-ca.com>
Date:   Thu, 13 Aug 2020 17:32:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <fba5a257-599f-b2e5-d4bf-57269fc7734b@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16455 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 8/13/2020 9:36 AM, Casey Schaufler wrote:
> On 8/11/2020 7:10 PM, Paul Moore wrote:
>> On Tue, Aug 11, 2020 at 8:39 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> Update the Smack security module to use the Netlabel cache
>>> mechanism to speed the processing of incoming labeled packets.
>>> There is some refactoring of the existing code that makes it
>>> simpler, and reduces duplication. The outbound packet labeling
>>> is also optimized to track the labeling state of the socket.
>>> Prior to this the socket label was redundantly set on each
>>> packet send.
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> ---
>>>  security/smack/smack.h        |  19 ++--
>>>  security/smack/smack_access.c |  55 ++++++----
>>>  security/smack/smack_lsm.c    | 245 ++++++++++++++++++++++++------------------
>>>  security/smack/smackfs.c      |  23 ++--
>>>  4 files changed, 193 insertions(+), 149 deletions(-)
>> FWIW, I gave this a cursory look just now and the NetLabel usage
>> seemed reasonable.  Out of curiosity, have you done any before/after
>> performance tests?
> It's early in the benchmark process, but TCP looks to be about 6% better.
> UDP numbers should be better. I'm not expecting the level of improvement
> SELinux saw because the label mapping from CIPSO isn't as sophisticated
> for Smack as it is for SELinux.

UDP looks like a 12% improvement, which I had expected.
On the whole, worth the effort.


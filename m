Return-Path: <SRS0=/I77=BX=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7938C433DF
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Aug 2020 16:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B17E20675
	for <linux-security-module@archiver.kernel.org>; Thu, 13 Aug 2020 16:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Gikl9oeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgHMQgQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 13 Aug 2020 12:36:16 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:37326
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbgHMQgQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Aug 2020 12:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597336576; bh=zCN/TUyCj1YWT3xH+06L8cKftVbHWP6zkDyJdzTZlRE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Gikl9oeouIRsH+dIrazr+ML5z/1Llnro1bzmPWWwlK9bSdp/c0Zoc58yTMkHXz2s/CfMWucIBFEPgIENix23cYQh00zCD5V/UniyA5RW5jw7zxT5tKiN+yMiyrlta3v1Jscp2TpG4uX/LmD+IiDE3Iai8SWfSiQqiyQIOAfMnAC0cxIieaOchi3dev4/N9Fy9xe1Mxvw9+HIU5XJthEooWcq3O3y+zmNVn7Qbe3v5aWIiYpRp1kVvtIh3owgHkwB1ozpSILDZ9Kb+aAunRwx0UrgicQnzKfc/cBYEPPx4muCsWxMWsM2zbubptfIbqEtQFKO7TMVwgIprq/6kSKVpg==
X-YMail-OSG: eky7JpgVM1lPepa72UixwqOYGKOLes51aYmJBjdbbhhbI6HmSAcpJnwM7_hcp3C
 HxK0mdMv5vK2xnnN8_BsSrfxdKYtdDc_NeujAYU4c.LUNVHBGzp2jMhDkINm0xeDRPY5cwR7TG3.
 FVaFZ9s3.E4n8RuSPst9uPn8aXvaKSvC92Y6pPKHe6VlMJLPW.H4kERCAu0E4HMtfByECynYrWe2
 WWXOFQsN8lSQvXs27LuQtI7x8DsumS2ev93we2debL_teZljxkjDOGI4SjcPdXq3FTox08C1v2YU
 mFv2fTfcvA_0PgvKMqN7nyU1FAw.gVRQIOA_Z6CgjhHskgi.4Wk6jLujPON1uVrT36PVrtvTUUNG
 1MA_zd_EznpdC4rxuqjQa99AOhvJMTakaNiVF7Ju.7rVxCPiO.R3lUmpBC9ks9ea4N6oLeGohVOj
 okFSOpMZUM.DGM_X0Qf4w5913wnU6uyI_lLOn2klVyEE6jApfAkqE9lW6ycvcSGuUdpXU0k4VXL8
 S1jHM_kojLEzh.zJoKcoeSlXa2CUKiGHf3.gDr5gl0kVncXb2G5sNafyOZ69YOii3Qamsvje8Cft
 k0ykU7vlzcQf.jTvxoJRfPF.JlMbokjBZh6qGIPQeI3_5te7j5L5bevQ_fKRT2hdsu3MdWoo9uWL
 MdZSKSmo0eLLxuN2xswM99_0VxO1HNfv5fAvMd7jPxyilQ86hGPmXyxu_5w1WigcT2eBsozBKELy
 ozneyD9bYZV7iB7g6JgZYWU_PHpRVNvKM6RKFRxTXQiNEl0qkX_HX6wuRtn_VnLS2lu1K6Zymd5J
 3qitoM7GG2OAs8Ye8QBXl3Fq2wiWHn6rTWOjsoY9solEsoN_Cmx.zkLELNLDo2PbeCSbCFwRP9Tj
 h9bQG8F1BAde02FKZSdt3C48896MYpENCtrWAQJ_NJDDJeaqEVpTyBLBCLqvF8vf5Tdl4_7w2VIw
 NI40xhbdOPh5Litf5Xnycx36X2E6mGq7qn4VB59DutU0MOM4ppfy9WVt7tgAEo3Dw7EesegdEC.p
 1fysIJ2i5LJCzU39ZRwknyKt90BE7yxknEDS.L6G7AWQ_Cydv3xODA5JsO91P7gb_J_uTZcwAZkz
 uIWaY1OviDrAgLViv6TMoSw0Q7P02iKhPZxFit32slZIQnpavNxQIfxaYGULb4ARxMFpJ8FJON1_
 nWTOsws7q9kKHl1b6irgqN9ewQJ4A.00OBaKdYS5VyzhCudXSE7TB6Fv8vyWhWJjYrmiHf4axszY
 X8vgbwfHOsV82a3aDZ13hCojNU_9XE0btc62yY_edl1AretsOjrYubS_MtYhaaiExAvx2LhQZCkg
 3oYA8Rycgen95ExxsChyrYsKqeYQ.BoHBDhXibfoVR1cp4IOFaUFZPF8Kt.UWfUqW70NYf8iOIfR
 ToB9.26LEvCJMS7xWtx1.wAwIdg17IFIRwPpzsbjVyQVhxN4j5kZcS75WOObGsM7hIxS8ITv3drR
 XRvQaDvTUaqRbJcU6Pc32ZvhXRQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 Aug 2020 16:36:16 +0000
Received: by smtp408.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a6485934c092d0a1415286359509e0b5;
          Thu, 13 Aug 2020 16:36:12 +0000 (UTC)
Subject: Re: [PATCH 0/3] Smack: Use the netlbl incoming cache
To:     Paul Moore <paul@paul-moore.com>
Cc:     SMACK-discuss@lists.01.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
References: <20200812003943.3036-1-casey.ref@schaufler-ca.com>
 <20200812003943.3036-1-casey@schaufler-ca.com>
 <CAHC9VhTq66h1LsNBuhXG6WFiKn7hCBApciG6sVawW=jDwqDDWg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <fba5a257-599f-b2e5-d4bf-57269fc7734b@schaufler-ca.com>
Date:   Thu, 13 Aug 2020 09:36:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTq66h1LsNBuhXG6WFiKn7hCBApciG6sVawW=jDwqDDWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16455 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 8/11/2020 7:10 PM, Paul Moore wrote:
> On Tue, Aug 11, 2020 at 8:39 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Update the Smack security module to use the Netlabel cache
>> mechanism to speed the processing of incoming labeled packets.
>> There is some refactoring of the existing code that makes it
>> simpler, and reduces duplication. The outbound packet labeling
>> is also optimized to track the labeling state of the socket.
>> Prior to this the socket label was redundantly set on each
>> packet send.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  security/smack/smack.h        |  19 ++--
>>  security/smack/smack_access.c |  55 ++++++----
>>  security/smack/smack_lsm.c    | 245 ++++++++++++++++++++++++------------------
>>  security/smack/smackfs.c      |  23 ++--
>>  4 files changed, 193 insertions(+), 149 deletions(-)
> FWIW, I gave this a cursory look just now and the NetLabel usage
> seemed reasonable.  Out of curiosity, have you done any before/after
> performance tests?

It's early in the benchmark process, but TCP looks to be about 6% better.
UDP numbers should be better. I'm not expecting the level of improvement
SELinux saw because the label mapping from CIPSO isn't as sophisticated
for Smack as it is for SELinux.

>   It was quite significant when we adopted it in
> SELinux, but that was some time ago, it would be nice to know that it
> is still working well and hasn't been invalidated by some other,
> unrelated change.
>

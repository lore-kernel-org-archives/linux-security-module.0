Return-Path: <SRS0=XO9p=ND=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3042C67863
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Oct 2018 19:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F27E2075D
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Oct 2018 19:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="smIgNs/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F27E2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeJXDaB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:30:01 -0400
Received: from sonic313-26.consmr.mail.gq1.yahoo.com ([98.137.65.89]:40651
        "EHLO sonic313-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728441AbeJXDaB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Oct 2018 23:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1540321520; bh=H1laKsD5UZDPVFerugLJiB83UhuvjeUFPVeNx0++dWM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=smIgNs/wDQtQiVxK4eC8nQfJdgsY+kRUD5tnTxKabCFr/k9CIybrDxY35/POaS/cliaTAyOrGr+cxb/aqKGnSAW8b+bKAX5Kkt1WKouinfYu809sbR+nTH0QyC4wenEEmhphOKBN2h79yc3la5CV2Bs/JaOHshxza1AWsqn1DnVGody6SwkXl+rNaTV/ClTDdzE8qZY3fMTkZ9y15/qukasITZ/kPnD3VxqJzGD777jpOXdwKydpcgajgt/2pdG5iV28IMs6fUe5fsdKg6FIIxziivvSdZDiWa5kArwFM2B25eUMeaN4w7zjzYJ/0xLWALD9CszlzSlS8D4Myy3Xbw==
X-YMail-OSG: 7zB_jpUVM1ndDWNZLKcgYrx8lzN8A.54CMf8dnG.zLOCX2Yr8GR9klVoLP3x9rO
 RRYLZ.ueKiHyJtEhNDLV36toaLE5QH0steut6gdm_0FRzDsewmhbsDTfKdu6bmY_VHg.Dw1oXMSN
 4Cx45r4tl15uJubUheQqCfHyzl_WonzvOOJBbZmggdkGcfTtuxDkPj3YgjSGLK7SoQzlWsd4HPQt
 WiN3jNPplZ05WdaxQTWJkM1l8Ewp7pQ7c2p9s17hh6Q6pYo3dJYzxAiKpN3tw4Mdz6nH51jMdP9p
 MwzkvhnHTHg42YLhFPwjlVnoXW8oTyIdcOrumTSmCxCUCkequA8TF6.EKOZl960wei35wvk4aXW5
 iQXGGhYQP_G65Uhnkyf29fJxQSxvxerqR8XhrqJUCee6FA0kc4qOPWbFDND28spNo4FDiIyszzqH
 zsWvVWfvhdbsfmvsmYW0xHGGjAsOsa_b3WIFdRwcgN3d91At1VA5AhuvcT6amA_dSRVK8TrRcphl
 0D2U7JLcjA.mogCet7QI44.O1PAYElm2NYcD6VCE.DY2RJwTBydlza5KUqIcB2D9kMeANQwP826U
 Nbh7PhV3J6oVdR6y51pPQiigG1TE1MP.ZHTZtZWYFVC2NQiX35YQV2TLOhqTHV5gJqt2SqCGhT1K
 x8VKQWozhe6frCALwO3GQdHqfmHgW8U2SzGUzKC8INY60uqu5tLC475T582HXMlfgmhDeeWVdmOY
 WTYKpUCjs0LVXZkq9R0YbYWbSYNs6sRGTLLcIwWNdzn48HtPBSrbiooi7XF6D2gezOjpUCAkcJik
 IAb4f3i.MyUO.LVHABhdUrOgYWEMbwYeHKzbDy.Fxce0lxhnDOJhUaq.yWJQyTC4tnp46wze6ie.
 LFCdDlhgAH79ontQP6Xcz9hK3P1qNsCQMCKpowlMOwFwN6ZP61oTUyK6z9EVnxPIXqLoSxaF_kJv
 5kXoajAGHI2VXILea4sOvS17wA1lgPY_S89v2d2vFnYTmM8f9_BpAjwYZVCq4DTu6HXJXJWVFi6A
 JNzcnRFYSKOVeUdRw2UzsgVVLyDjxr.BWvTFPjlcN37DHhwEaoQ9PrU0T7K_h9Wg2g6OqucD.tza
 YHaePalc2LNRBaFECeC2vDcHCJ7rOqPBnD4tjKduuMsVnyuejxbWbf4U-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Tue, 23 Oct 2018 19:05:20 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp408.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 97723a383fa3c53d97cee5cb127bcd58;
          Tue, 23 Oct 2018 19:05:17 +0000 (UTC)
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
To:     Kees Cook <keescook@chromium.org>
Cc:     John Johansen <john.johansen@canonical.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LSM <linux-security-module@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20181011001846.30964-1-keescook@chromium.org>
 <CAGXu5jLBaHj5MhXaK-8zdu6Rgo2B6rEq+at17xZ1Puct+YUajQ@mail.gmail.com>
 <ZhaXhoElmWQlsxHmgFHpB2xSWzJYFZWBasrSKQNjGj4_T2A4AY2F9v1rP9LkUfilUbZ0ExWXX9koLNjUM8S6baX6xfSSMPXY_CpihbCetVc=@protonmail.ch>
 <CAGXu5j+kekUdcE2EhUu__8MXJ1O+D=-zTXLGNCRVa_VyDxePpw@mail.gmail.com>
 <f68e5f4b-6360-a9e7-597f-89d1d3ca73c1@canonical.com>
 <32stV62RmME8Dj5jKB8Z03zPe_Et72kMo71D8SpgSOHUo6SaROc8DomMWdk5jDGpyqVd8T63NIIK2NdDw95clpF8Uj47Wca2FBFItXDRh7E=@protonmail.ch>
 <38dde301-d77e-35fd-88d4-5cdc5b570ee8@canonical.com>
 <_CkJnKYmEZ4ZF0JtsSYuahAd9sgnX9OtcstjXaeqb8wn5uxfimc6S4jomly7If9VqnOXqXwaiCbJ9ttS6NiqE7n6cQUlwLvfO53paLmacvU=@protonmail.ch>
 <8251564f-ba7a-1777-a606-dec472b32f35@canonical.com>
 <CAGXu5j+2yVZ5DQHyqvJKnSYYqRCzeMtEabBwYFOWkTcwMUWhEw@mail.gmail.com>
 <96e92224-aedf-5026-d6dd-b29121b4dc0d@schaufler-ca.com>
 <CAGXu5jKFqtV_NFRaXPKVgNQt3F1pwFqopDLp1ZQJDGM_Bdid6Q@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <63410d08-d0d1-8cd9-5d9e-70d95a1a8ca0@schaufler-ca.com>
Date:   Tue, 23 Oct 2018 12:05:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKFqtV_NFRaXPKVgNQt3F1pwFqopDLp1ZQJDGM_Bdid6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/23/2018 11:50 AM, Kees Cook wrote:
> On Tue, Oct 23, 2018 at 9:48 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 10/12/2018 12:01 PM, Kees Cook wrote:
>>> On Friday, October 12, 2018 3:19 AM, John Johansen
>>> <john.johansen@canonical.com> wrote:
>>>> It isn't perfect but it manages consistency across distros as best as
>>>> can be achieved atm.
>>> Yeah, this is why I'm okay with the current series: it provides as
>>> consistent a view as possible, but leaves room for future improvements
>>> (like adding "+" or "!" or "all" or whatever).
>>>
>>> I'm curious to see what SELinux folks think of v5, though. I *think* I
>>> addressed all the concerns there, even Paul's "I want my distro
>>> default to not have extreme stacking" case too.
>>>
>>> -Kees
>> Looks like I should go on vacation more often. :)
>>
>> I am generally opposed to fancy specification languages.
>> I support the explicit lsm= list specification because you
>> don't have to know any context to create a boot line that
>> will work, and be as close to what you've specified as possible
>> for the kernel configuration. One need look no further than
>> the mechanisms for setting POSIX ACLs for an example of
>> how to ensure a feature isn't used.
>>
>> Had we the foresight to make security= take a list of
>> modules when Yama was added we might have avoided some of
>> this brouhaha, but there was no reason to expect that stacking
>> was ever going to happen back then.
> This sounds like an "Ack" for you? :) I'll harass everyone in person
> in a couple days.

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> Did you poke around at my combined series?
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=lsm/ordering-v6-blob-sharing

I hope to do that on the plane later today.

> -Kees


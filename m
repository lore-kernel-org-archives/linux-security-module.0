Return-Path: <SRS0=2Rj0=N7=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FFDC43610
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 23:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6544820870
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Nov 2018 23:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="q4Zh2lKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6544820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbeKUKIE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:08:04 -0500
Received: from sonic303-10.consmr.mail.bf2.yahoo.com ([74.6.131.49]:40408 "EHLO
        sonic303-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbeKUKID (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Nov 2018 05:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1542756978; bh=JLFiMu63rJeinEE/xeJto1FGgWu6foRtz5WKH9K1JFU=; h=Subject:From:To:Cc:References:Date:In-Reply-To:From:Subject; b=q4Zh2lKiAVsSxWID+xpYSRBBa72J+E1qQ6TqC0gZ6d3JTXF+uuEjNb2w1wU/7d4CVvJvpPjk1FJKK2kdk2W3GlrbHz6wm8NrCg7Z96Y5IomEOobpP3IXIwVvtjpSCt30TIb5xpRdUCNgCANNrc53C+YmagflrdRvfa4g1oAQZ3SV8DuDSEQ81X5/rE1kf+AIH2VCMu7DJLgM1r9H1FauncDCmVoJi6r1v88BUlV/TnikM7tNdjPOS61F+XwL2NvMdq+ESr55wCmDGIoOdJ/tL9IJDBrSg8MhWv0uK6Tek6a9dznHUX9ZsBMXJfIcWx89AB7Mf9NBb8kN4YfMOIQ2mQ==
X-YMail-OSG: D4JI.IcVM1nSRGlS9Ik.JWUyRXIuM.1fbhxBxXyvMfMxPrrmKO2OPVsE5sdfeN.
 p9d2d_BvSvgYn1vk.Ymj1Sq5oZmPcdFUhW4X6q1ZQGwbYsIuxnkadxSm3CrTKvFJYzp7Uf8RA_tD
 3wxAlc3YKNQ6Kr9xPnP.xZu3W4kXrjQTZQasQtZX.HYKf.y8xt0hYUHtS8O7NshnEmitcLk.Q3zK
 wbsRgPo_RfWAHv.ZiiLcgDUeRtdTHO7eWougKf0RNc25uee1ghMxtqUZMnmf5MUTQP_qRKEyl.R9
 PT3cCcRymBu1oXYv9tdESM.vlGnRXdkxreBG50o4eGFC2hx7q8u2bmRkR6tienFdTHtRREiaKJhT
 X6flcr6DTluAfQqenfLAHGXrWQlODHaPnQr4VpvU78iPrhKSquJ9IKpMTHWY987yPKJSgc_ysGjv
 i7vVgrV2p6KxSVHLLgk0HVG_2cpKt3e.tg3Y1m1XKdSkN8jFPXPAPKtvzcjUJbDTeHZABEzpewg8
 Yg2q2VphcQN46c_rfJHVEkiubhbFTXrCKSUVNwkdvrfoyH2uUkKroV6xeIqIXv7iD9mAte3s7jqw
 d.QiIUrAw3z8Cnb6uAFHwO_dQoiBQWC8rZ2ciHoTsIPDW..9LslCQsy.3NJqxjYAyRujRCAt4Qfs
 0r7658g6nsDUXIhnuiGbkzSEGvXEUYx0EUsuSyzH1YrHw9LSchZlRPr7W7J3qcY2hpU4amyvpbtJ
 PnMOY1Rw0IVRZAuKPDKEpKohjLmT3iEjjkAB3XcLXH5q9qaVAV6tTmu9ducYNyzIc0q196bVzV1B
 U4Ixzz0Fpla1c3Ma5a9W2eTKdy4GuNSfCfZZyvHCygnP5OGWqKCKe3EZuNzgvpn1ZCeYL6FstbNG
 GFXzY1L3l5QL34ssssoOTK3mjdkaOVwrt7dvRV62CegWoQh5lCFLHhtTh3W4uyJzwdhl3zSmVOVK
 3NiUR8XrF.h9oDyjl5cz5gRdWeIw64m4qaJB4cymazhcvvJqJ5UitZv8BVOKhirdSvOoGwvh7L75
 4Erz8Sf88ZXMqU6hEyjH7yjcMgsmbezhZmRZBq5lSWAqvseLP_Z1LqYkg9L6h9xj00wIsgzKVkBX
 owRjPXi7sWlCvEyEQ6dmEG_6.ljP_YdDoJqTNNZe66_gDkknAGOHvVtGt8N_c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Tue, 20 Nov 2018 23:36:18 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp417.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 822fd97e1eb4757f94b00d25d0ed12ff;
          Tue, 20 Nov 2018 23:36:17 +0000 (UTC)
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
From:   Casey Schaufler <casey@schaufler-ca.com>
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
 <CAGXu5j+kekUdcE2EhUu__8MXJ1O+D=-zTXLGNCRVa_VyDxePpw@mail.gmail.com>
 <f68e5f4b-6360-a9e7-597f-89d1d3ca73c1@canonical.com>
 <32stV62RmME8Dj5jKB8Z03zPe_Et72kMo71D8SpgSOHUo6SaROc8DomMWdk5jDGpyqVd8T63NIIK2NdDw95clpF8Uj47Wca2FBFItXDRh7E=@protonmail.ch>
 <38dde301-d77e-35fd-88d4-5cdc5b570ee8@canonical.com>
 <_CkJnKYmEZ4ZF0JtsSYuahAd9sgnX9OtcstjXaeqb8wn5uxfimc6S4jomly7If9VqnOXqXwaiCbJ9ttS6NiqE7n6cQUlwLvfO53paLmacvU=@protonmail.ch>
 <8251564f-ba7a-1777-a606-dec472b32f35@canonical.com>
 <CAGXu5j+2yVZ5DQHyqvJKnSYYqRCzeMtEabBwYFOWkTcwMUWhEw@mail.gmail.com>
 <96e92224-aedf-5026-d6dd-b29121b4dc0d@schaufler-ca.com>
 <CAGXu5jKFqtV_NFRaXPKVgNQt3F1pwFqopDLp1ZQJDGM_Bdid6Q@mail.gmail.com>
 <63410d08-d0d1-8cd9-5d9e-70d95a1a8ca0@schaufler-ca.com>
 <33754ab5-5c7a-b174-0ad6-195323a169f1@schaufler-ca.com>
 <CAGXu5jLyn6mLKFK+RuBkYWenm8sXXR+yqJ3VzVCpUqOVmru_XA@mail.gmail.com>
 <1df16f7f-aabb-9581-d41d-25d0582cdd06@schaufler-ca.com>
Message-ID: <c353fa85-eb76-721b-26ac-431513d138eb@schaufler-ca.com>
Date:   Tue, 20 Nov 2018 15:36:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1df16f7f-aabb-9581-d41d-25d0582cdd06@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/14/2018 1:04 PM, Casey Schaufler wrote:
> On 10/24/2018 1:12 PM, Kees Cook wrote:
>> On Wed, Oct 24, 2018 at 1:56 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 10/23/2018 12:05 PM, Casey Schaufler wrote:
>>>> On 10/23/2018 11:50 AM, Kees Cook wrote:
>>>>
>>>>> Did you poke around at my combined series?
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=lsm/ordering-v6-blob-sharing
>>>> I hope to do that on the plane later today.
>>> I had a chance to poke at the combined series and it
>>> all seems to work as advertised.
>> /me stares at John, Paul, and Stephen. Hurry up and get off your planes! ;)
>>
>> -Kees
>>
> Now that we have next-general updated I'm porting these forward.

I have ported Kees' set forward to 4.20-rc2:
	https://github.com/cschaufler/lsm-stacking.git#after-kees-4.20-rc2

There's one bug fix in ordered_lsm_parse() but otherwise just mechanical.

The infrastructure blob management required for TOMOYO, Landlock
and SARA is available:
	https://github.com/cschaufler/lsm-stacking.git#blobs-4.20-rc2

There's nothing new here, although I had to make a few changes to
account for Kees' changes in the preceding patches. I will post the
patches shortly.

The full stacking changes based on this are still in the works. Netfilter
has added a whole new use of secmarks and I'm working to make the individual
patches smaller for easier review.



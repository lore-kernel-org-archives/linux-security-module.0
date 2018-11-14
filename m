Return-Path: <SRS0=+5fq=NZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86408C43441
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Nov 2018 21:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D306223DD
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Nov 2018 21:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fxPqAwhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D306223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbeKOHJn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 15 Nov 2018 02:09:43 -0500
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:33625
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725756AbeKOHJn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Nov 2018 02:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1542229492; bh=c4iz83+/aSrOLLUgaslUS6o3ZT2UGqAkTO5LBXGX3wA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=fxPqAwhGVNPNFom/ebVNOiFkuP1Djwm6NekXKYht3Z3huswGi+pxlBGJx263zv7cYEwanH6e2OyBUyLO97GYXxzeVFUVekVMH6pEpQ2UL0sDQ3/LYSliC2RExoHrUEvugTHnbAU572rrBEstv5Uf77dvXDegjTCVYCBmuWUatsO7M4DtJ3UCJqm+QVfMjC3Ub+/5y8swWpX7fp++bKas9kgbDklHz+4T95Y0c77A9xFIrVWcriwVve67o9okSaNAN7o+d9DAnAwD3SRuBQs9qPeWvcNgVPNKzuycDiTXAAg0D1mTkb0XCsQq/6xrioxLafj5aVLuyUTxITi46FXfhA==
X-YMail-OSG: O2H5mZgVM1mtbuFGNFOMy4_6MFwB9l3ti5l_bRgS5Yib4GtKpwK8fnS7PSHorEd
 W0k.r_pl1nKv_Npj0bsYsbdweruB.uPumZwuEl035b4pQwNG_cDf5so9v9s0T6L3B1vx5YFwrGDF
 IOVaFH7_qVxMrrfEkHiTQ59aqul0Zia8bGIQoya6lfXcHyhkmrGCS5Q3hXpUSMKXpRx1xKjLDFIh
 cJdnk21Dj5eQvj3PiowQjfZY4YoPiFlnv8LY20mnZEiy8FyP1rjqYKjBqkJVOX6gnaXim9j6H7SC
 ypyr9hxwIoltSCQNi_sBfDtIgT.z8nS3lYUsVxOK0rUUacvIPQwZndqYbMiQpUkwjLVDxN_QrR8g
 goo.tNkACiB3Kn4I8TawcY1NKwpdVfbU7lJFN8g5lQ2T8gH27zAOWV4dXCh7kxiO7IK2bDGG3UV4
 VJ9ms7CAII4A8yk2rEvLY113JTlfNDsqV3GVbNNg0cnTkUjai62mdIMtO8lmb4bykw8M.ExSQkNK
 3S5MpnTqMaAL_gSzaqvQL3hQOQI2qzYHHTgaaQU.uyzFvPjvF0ASGUkxx4uPpnxtN5UjRp_qRQjl
 ePjFnqhgZV5iLgDoJMo3cra4Hq2x5dPqHtU1ZaXbN9tk5M3Acnb9zPtIoc0G5UE02LJJv49tG7NA
 RMaDMoMvn5Xai9hBxOajc40XPiwoW6hTSU05mNjKVOc6KwgaBjZ3tI4fCz8uc5zZXP2CfU5eJXe0
 x1FjTcvr4XsLjwObyMOecjg7VXfCWWAlZLHvp5SGG2_pdRZi121EGMSdfKsDe874OLwgCNNpXuj7
 b3FxYUnPvIecuts3YzKeLnigS9WAQCawC1Qub5md_t_AAwJFYSl1aiOv0QNgxMdBfuSD3TarR_VN
 TOHGu.gWsh7K8hT6D3ZBKhGpxAOOlQbpDaSyYLfyTGijWxXO0JY6nFazCTyAzvtKPBSQfbX26X.a
 HH83M6Drt.yaQlnnK9TiCSi16lAzzRCFizJx3OaHLKlC9IVgUGmJ3CKH0CycVHpvYlXa5XFWLPnJ
 0RVfoBWQC76pD_DXeJgm1ZpsTI.SjYaIiRmGpRGRq6IHc4z6Cm5KOqSDRCrlKJ1ALNvD5labqGBa
 bEbi41HONF7NtPqmuc4.JWuW9VBq7oCQp8luPUYNKLF_dsDWeHka16hw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Wed, 14 Nov 2018 21:04:52 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp426.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 87725a50a4242352bc39be78a0a1161e;
          Wed, 14 Nov 2018 21:04:51 +0000 (UTC)
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
        linux-arch <linux-arch@vger.kernel.org>
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <1df16f7f-aabb-9581-d41d-25d0582cdd06@schaufler-ca.com>
Date:   Wed, 14 Nov 2018 13:04:50 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLyn6mLKFK+RuBkYWenm8sXXR+yqJ3VzVCpUqOVmru_XA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/24/2018 1:12 PM, Kees Cook wrote:
> On Wed, Oct 24, 2018 at 1:56 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 10/23/2018 12:05 PM, Casey Schaufler wrote:
>>> On 10/23/2018 11:50 AM, Kees Cook wrote:
>>>
>>>> Did you poke around at my combined series?
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=lsm/ordering-v6-blob-sharing
>>> I hope to do that on the plane later today.
>> I had a chance to poke at the combined series and it
>> all seems to work as advertised.
> /me stares at John, Paul, and Stephen. Hurry up and get off your planes! ;)
>
> -Kees
>
Now that we have next-general updated I'm porting these forward.


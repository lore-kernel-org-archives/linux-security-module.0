Return-Path: <SRS0=JlTe=NE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07048C004D3
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Oct 2018 09:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C4420824
	for <linux-security-module@archiver.kernel.org>; Wed, 24 Oct 2018 09:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kdCUZKo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C4420824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeJXR2a (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:28:30 -0400
Received: from sonic308-51.consmr.mail.ir2.yahoo.com ([77.238.178.187]:33567
        "EHLO sonic308-51.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727583AbeJXR2a (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 Oct 2018 13:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1540371673; bh=7i7W9r87cyd1WQbC7E+uXbkD1Kmf1evaUZ9WbDOGmms=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=kdCUZKo15bXF2eNW1z5Ui6oNw6j/hFIdy704gXrUey4jTtDVHGuOy6mG2UyTdBXElFBgBtUc3UBvCgR7F5jmwgJ/hLeiWdWCVW6+f1EFrfNXnKdSBUitz3ynmasMSc4Cx27Rzn9s0KyOMrAeMGPmEoCgeFsFalxh8seUVhDx+EYryQHc4wbmjdRAXpC5oMB9MnxeI3SF++Q5Jbnu8ObLYhfWw9IOvQyFhyJ5Sm5eltaXORsM7mr7DZ/dIpqfm0ezQ+Zm8ppskiPOQJjeAni/YqTIJAZgbkLjrbzKukIM56YG61O//+kCW0oB4GkgaaFa+md5YNRTehul9iPd69+SJw==
X-YMail-OSG: anJzjLEVM1nQ32JbJXW9hxZKS5jSR9oG8JMWmWy7MjSNoag4ya2UROdHTJ5QdXl
 3XZiY21npEIp1K14i3Ig5lX7.6Nxk4Q8OfE3on6OmKQYtvPT8D5ELYfLBXGBrRlzZWxEsQNwexNL
 SgE5BN.mZd6l4KoDPzpO0MV1sPeH5dZPYZKj6Q9p_p1c63I5ccuBSC2u3Hi7r8qhIJNcauPKWlgQ
 IKgBU8hL2B0Dvqymvn9cOMGYWHwx2x51hFGvpNRCw_FyIkPuDtw785nxDliY36YTjwmp5xWDfmCR
 fP9Amclvm0uUPglt26AieXyAD1GSBij_tJeaTVfEEt3JMUQhpVweZToyKfrpyuWPuIXsOonyy0Du
 t8B.QEKIKuePS_t0uL_K7HaigoIO5PGR.1IHLs5HuB5AhoKNmB0OkGX1dBTAYL5hfYg1YZL47Y7q
 32ZtJ4J8Vjegh0.FuI_vecpM2_PoPfL0OnKbaEfdkkpyrzQNMWMD7LiY6MIt595kLavCmQNouEd7
 v6xo_XLdVoLVO7fPjprP2j5d5PsgPueokrlfQjZFveF48nZvyEuGa._EHC2mZOUWbm6WfdG2TVX0
 JvLKqnrfwuJRvXjBXCkUEkIf5lJ7D8Yk2D6e2EDHSMsAU8bGsEs2OAFiqmKPzvDPQ7o2Snduo_Mg
 lyCaFDPnLXTltW7pPIG0FrdEN76G2aX40sJuKeGUvAYWIaCXusCjP3f388L.WrSb_bnd7_TPgTBO
 NhedD2RwQzyKjMq..xXIT8valmbZ0MPc1yK.5aGrw09ySxhd39T66ZCKLLSpp8f.POzzbrXH_4Lk
 ZeGvT_gqLcrLts3vGZPHws2fcH6dC1TtJO3_m822.l5mr1_wrWWAxpS5rEbiBa6KBrpntR_756WC
 y1DLX1ltd0XApkk3QN3BKOsNVgVLVuMwiNC7FCiv3nBWAMLfBzkBkn1MhSES9ZOm66rq3PrdSWcX
 TtPYuEwSGizrxSYQN498S.YKJa6IXQVZX9RDrMGtQC3M08J9P.RswwrbdHECxf37rrr.oGiIcfsH
 od2hCloNA8OWRkNfFsBwYFUxGpgnUxgPbl8GDwNzxFSXcrFSBHaouLF8_vAcvdTDKGNyfin.DDKr
 KYINKHjv4jkcoLzcdJjrkIDRihoa6iW9kwO3b_V6eb8r3sUxXEZW4aDMIYMw_9_qdBV_HDDS1nvT
 ROGjyJe63iN7Tdu_k36FPozMycMCSq8xf8wlJ5NiPJ2Y-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Wed, 24 Oct 2018 09:01:13 +0000
Received: from 88.128.82.89 (EHLO [172.19.249.176]) ([88.128.82.89])
          by smtp416.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ad239ea74ed2ccdf805308993c90ba59;
          Wed, 24 Oct 2018 08:57:11 +0000 (UTC)
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
 <63410d08-d0d1-8cd9-5d9e-70d95a1a8ca0@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <33754ab5-5c7a-b174-0ad6-195323a169f1@schaufler-ca.com>
Date:   Wed, 24 Oct 2018 01:56:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <63410d08-d0d1-8cd9-5d9e-70d95a1a8ca0@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/23/2018 12:05 PM, Casey Schaufler wrote:
> On 10/23/2018 11:50 AM, Kees Cook wrote:
>
>> Did you poke around at my combined series?
>> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=lsm/ordering-v6-blob-sharing
> I hope to do that on the plane later today.

I had a chance to poke at the combined series and it
all seems to work as advertised. 


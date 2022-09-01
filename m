Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC69ECAAD3
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Sep 2022 16:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiIAQ0c (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 1 Sep 2022 12:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiIAQ0b (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Sep 2022 12:26:31 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB0146D97
        for <linux-security-module@vger.kernel.org>; Thu,  1 Sep 2022 09:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662049589; bh=k6tc313Bmyk1ZqlTbuQVAiGoc+b6bdtHzASCp4bH9rE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=L57f7gCP3tNOZV8OvZpoLYl75Gscd955bZiCQeAf8/z7daaKfOkqsgW+x3fNe53+7uV0Py3eIPF1CD/89SHedrotO7KKbsz6CAFRW6GZlZnXs48seffCP/o3G2nt8ZvxZ8GHWqEykrShchdRmhb9HhemfKNM87+MZDC8sLiMOuoyy1jlRC+g8JoEl1M8hwFrFXfYYVH8V+q+J/k9SIl6+0N0GGYjNKZnD3DJhzvj7Djs1L7PU3jPlAQpvRWrd89O9IwUmpHOTPXwH5beR3sP1u9e1hIMjTZ992kxmQTFyLHYXu3parHaS8W725yTUoDREGGtccvkewBTnaQOSj/Opg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662049589; bh=mPKQcRB4E8CLAP1qzjvAlxRLPyT32cYnMNF+Rbb5GPm=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Za7RS/7UEFreDFdAnW8OvIWH+3oW+9j40dvgOcGC+Qq7yAFkmojy71kGQ1jYmJfDSAZnFC4ITiQFlj5E8SgprRTpkcI1729dm/la9Xx05mnsk3CvhalYD5ya0/u7Ey5gFZsVI9XRQOgtH5qoQqQdgUIISU6fWrvvzsV/hGZvEq0vhbW2yqprN05eJX1F7RZnJBKy5Q1SYwCKPV49z3leJMITEeHMQX0/+auZcI2OGYZEMd+wqWYo/iHVdwatvvJrcrnEaR2hmdrDMRexDtNvJXyUQJKhIbwJBgOhseX6l4xih2JVtgL9DCJrgNIQiX7/bKISjaZQoZdXL0qg5pGoeg==
X-YMail-OSG: YCNv37oVM1nxRp0UiopusIfmqRcnDp.VSQorkG.1NJlfUlEGAiXzjcq4cpu3K9X
 alub5QVsiEgNONjkfu0uG6nBmg6Lu7wYpl7Smkgn2avOGTLpPELdRs93nVJa8pwUMZ5X5UsJ5QO1
 4MBdvvYHChOVrWaZEdECX3Ztvy8XrwG5xCBrwviaXmU4n5ersrDK6LD_MTgRmb2JuudL02PPfMEJ
 TGr5Za2S2SUA2hSQWZlR2Fi7SfcNTPS0m3iOJD33h.LoMtCQ_16mNCcdpaYgcoxUW7RNJIiv9nCi
 X8_vwvfk8d_K6BCAiQS8E8t78eqxPKYyLns3zCv0Zh3aSryDE8BEI5GF9wgur3mwAPM223pvfnCK
 7OCuzWGcULKk.dTmELldeR5LEkH47NiIi7EJB0R26Xg4CIbaO118ChQnFFvi3qV.4TBmP1BcmIDP
 8kd2ot6op9S27X0JBIpUpIEuJCaJLR7XL3Dj3xwnthj1Exkw3MOJshu4hRkZYbXwsVtPLox1h15q
 j94DOi3M2G25YKmai6szQbsKuybFXMYnzheF7Q99WBtdmxMGTMQhe7YgqakN5GM6MseeoqZKTClF
 v91nQ9lNsQtVfmr04vfSuKVPJtWy9miJFSiCf8LWIptMPssF3dSHXVFjzFS.slM6_ts3AcGkc8UJ
 K7MuOWQs.XSIA96.TYE0tFxMFvcB6PbGEaQkj18OulniYjSAYv4w2uJn79TRWb_GXPkeSezu3lvC
 cX3RSVIXWibipbAOq1eAN5j4DOoqP_OtFvzHIVuVyPa0NMun35hi0bJ8rtQfXyTrguC8gLQX0gAO
 Dicmy6W.ykr7ltEAwOnXMHnk5vA1wiciIgVOpcDm4bRMClzBL9Q.1SRokRe1bgs9etOwSswb5Uiv
 APFhzdAo2dU05qvTi0z7cA7sbGChpHXbBRMESzWWrFzbnlNyJINuafpnVvEN6LED80oac3y92e2n
 kTX9oTnJAKiqGRbridEdV.YYSBFY1_CWGpkJ5Z1P9eEQZNhQqt6l0yWJhnt6lbt1aJGZdnw5AVoC
 veeu2bNqVv0XXfOLtXXF97uDnHgIuWcmbcZmvrpZgSEpgMpjIxv8pUWXExZC79DiJ9DfrlSDKDZn
 rDxfH.5tw4WLCCy7RELLVLP6cndyNA_cuyRgaW3HZREvqoYDsNgK_IVFbenpqkK2l0fjnDdmn3go
 VtRJTuhDOGUmEw0H0VbV0gr.VS18y0jHsm88.NZuseZ5jH2_C4DxPYnSxgauAZX0Yg9oOZoefcRG
 HK5fcHmreY.lFK8r4sv13Ij469r8OvDdt_oe1ZlSanwxFID5vZ4gjBhFafcQ78XtHLdlojteNr.v
 yHdBownEvKcljViZCOzBbFqOsCpfThWyMGYVCokEbWZBS723IvSma8NtUkDYb2kS6.305x_0ZGWE
 ZgcpjWb9C_olUv7d3JmkaC6LYDQPVkchUZlo.arf7b1DTX0F5ukMbQHEUnTcqWTUgoxsitCizfDd
 cIrCmmCzS25sfHIFqzPzmNi6ErabJhk_UWybP.mQq6ZNPfHcYZL3DRJMdWmo.n1G7iWM5FZCSWWD
 6wPbUDFdq0SvmbeEWSJBMU6m2Sb7Cf5ifQwwgQboDQmbfLP9zIWNun9tmamFFXBV_JpKeeoIDMcy
 .DfTX088qAUXMlBsUjBN5FGTVkuM3goVcAKKkL50YvSxnvx2UAdqmj6s3mVSEQZCemqK7LlZLYCQ
 3tqu.GPQpyLytZdukflh2VmAWVpg2.nmuFZq59Jw4Zv8GYWGIRh3RLTvz1vTCjlMJjTpbCDY8JfX
 krrpu8xZGe98OdytID8al9vWmqc8KzcLYWY6yD8P.s4dH7G6Ll9hQgzRaFvpqiVt0A_.cJ47Mwmh
 X_pcEpliMhFLpW0HToQ_wkakkz0FXk2FwYUFKPh.YiO9ZwEdj5M8PFJSdwjnmkNmutgwc1gF50XZ
 1eeuaHpZALiMc3EGxZPP4zhVNntBYlLCqwGwW4mVQ8FU2AGN.i7j3BxVIuGTLnlD8VcEFi_jCeD6
 29SeNInsSPHGNKv6r012g3dsGRr6WDsxHClsyibxcJfPZGrOWfBLVx2EEx7C9WvnO51wPzWRBcJW
 8ahR52CKhoW3mrmFiJu9RtjFoO51ejGP.CE1LXNsiBLRRjy3_cvyy3S6i3Yo8qJ5MMpXDJ6XAYpA
 HiUDrM.9mCtn1.mqZmssdchiLF4MGtJo5UhPwfMPTveru.IHtHa.q7CPEVgEwrw7e_t1YqIRTIzA
 BZE0uZMLztYFxaOsSavptV7sapZVLvWId
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Thu, 1 Sep 2022 16:26:29 +0000
Received: by hermes--production-ne1-544744cc75-m5z2t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1f4bc832a5e7cd51b2b456107d2f5574;
          Thu, 01 Sep 2022 16:26:27 +0000 (UTC)
Message-ID: <634fd39d-2ab3-3505-03df-bbb9c18f4c20@schaufler-ca.com>
Date:   Thu, 1 Sep 2022 09:26:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: SMACK LSM checks wrong object label during ingress network
 traffic
Content-Language: en-US
To:     "Lontke, Michael" <Michael.Lontke@elektrobit.com>
Cc:     "Ostertag, Martin" <Martin.Ostertag@elektrobit.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        =?UTF-8?Q?Wei=c3=9f=2c_Simone?= <Simone.Weiss@elektrobit.com>,
        "Valleru, Yuvarajesh" <Yuvarajesh.Valleru@elektrobit.com>,
        "Irgang, Thomas" <Thomas.Irgang@elektrobit.com>,
        casey@schaufler-ca.com
References: <0ff932aeb13400fcbb8b1ce346504e860cb031b9.camel@elektrobit.com>
 <7fabf823-bdac-789a-09fb-325e60e79976@schaufler-ca.com>
 <0e3266a5c93229b29c10a0a7b68232000453aabf.camel@elektrobit.com>
 <2d4958bd-dc67-8244-c688-eed4feb64ba8@schaufler-ca.com>
 <61f18d5513bdb68748e635470a41eb4e2dadb915.camel@elektrobit.com>
 <f6649421-a901-de54-ece6-ae107c0ff1cc@schaufler-ca.com>
 <6324997ce4fc092c5020a4add075257f9c5f6442.camel@elektrobit.com>
 <dabd5646-4afb-5df5-ea4f-3d4c7dc7a43f@schaufler-ca.com>
 <bcc11e5fe5a15017d12e396436c778f0f6d3b0ec.camel@elektrobit.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <bcc11e5fe5a15017d12e396436c778f0f6d3b0ec.camel@elektrobit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20595 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/1/2022 1:40 AM, Lontke, Michael wrote:
> ...
> Thank you for your feedback. If your tests are successful you can add
>
> Signed-off-by: Michael Lontke <michael.lontke@elektrobit.com>
> Co-authored-by: Martin Ostertag <martin.ostertag@elektrobit.com>
>
> to the patch.

Everything looks fine. I have added the patch to

	https://github.com/cschaufler/smack-next#next

for inclusion in the v6.1 Linux kernel. Thank you.

>
>>> From: Lontke Michael <michael.lontke@elektrobit.com>
>>> Date: Wed, 31 Aug 2022 14:03:26 +0200
>>> Subject: [PATCH] SMACK: Add sk_clone_security LSM hook
>>>
>>> Using smk_of_current() during sk_alloc_security hook leads in rare
>>> cases
>>> to a faulty initialization of the security context of the created
>>> socket.
>>>
>>> By adding the LSM hook sk_clone_security to SMACK this
>>> initialization
>>> fault is corrected by copying the security context of the old
>>> socket
>>> pointer to the newly cloned one.
>>> ---
>>>  security/smack/smack_lsm.c | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/security/smack/smack_lsm.c
>>> b/security/smack/smack_lsm.c
>>> index 286171a16ed2..8eb47396376f 100644
>>> --- a/security/smack/smack_lsm.c
>>> +++ b/security/smack/smack_lsm.c
>>> @@ -2348,6 +2348,21 @@ static void smack_sk_free_security(struct
>>> sock
>>> *sk)
>>>       kfree(sk->sk_security);
>>>  }
>>>
>>> +/**
>>> + * smack_sk_clone_security - Copy security context
>>> + * @sk: the old socket
>>> + * @newsk: the new socket
>>> + *
>>> + * Copy the security context of the old socket pointer to the
>>> cloned
>>> + */
>>> +static void smack_sk_clone_security(const struct sock *sk, struct
>>> sock
>>> *newsk)
>>> +{
>>> +     struct socket_smack *ssp_old = sk->sk_security;
>>> +     struct socket_smack *ssp_new = newsk->sk_security;
>>> +
>>> +     *ssp_new = *ssp_old;
>>> +}
>>> +
>>>  /**
>>>  * smack_ipv4host_label - check host based restrictions
>>>  * @sip: the object end
>>> @@ -4710,6 +4725,7 @@ static struct security_hook_list
>>> smack_hooks[]
>>> __lsm_ro_after_init = {
>>>       LSM_HOOK_INIT(socket_getpeersec_dgram,
>>> smack_socket_getpeersec_dgram),
>>>       LSM_HOOK_INIT(sk_alloc_security, smack_sk_alloc_security),
>>>       LSM_HOOK_INIT(sk_free_security, smack_sk_free_security),
>>> +     LSM_HOOK_INIT(sk_clone_security, smack_sk_clone_security),
>>>       LSM_HOOK_INIT(sock_graft, smack_sock_graft),
>>>       LSM_HOOK_INIT(inet_conn_request, smack_inet_conn_request),
>>>       LSM_HOOK_INIT(inet_csk_clone, smack_inet_csk_clone),

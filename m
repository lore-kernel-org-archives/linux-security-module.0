Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC320ECAAA1
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Aug 2022 14:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiH3OG3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 30 Aug 2022 10:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiH3OG3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 Aug 2022 10:06:29 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A80F72D0
        for <linux-security-module@vger.kernel.org>; Tue, 30 Aug 2022 07:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661868387; bh=aOOGQAHxUbk4bldmywxVZcV0i2bnH7pOKH/JuyTrj4w=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ax4/OyU4AgzTKHw69vywBxULDe7g+C9RrnrWkhoJHi0A+0p3413bTxgb3hZ3z9WU5d1RFa3HEjm6UlOfk36sr3QJ974X5JgGtBbicM2B1cCTvkEG4GYK0cpPkpyfkQh81XKLifLMF5kKvPkpqGRP3gnvpm7qyNOxpHQIJXkw3Dkd7hN4UYqIVo0JOgIHcz5pjykSM/o234ocAvNuMmYit16QR2r3XXrO6w/KsuzGBPH4fhmlE9/Mi6YHegiz8tnWEK0lt+ulyd/do/gmnsqkH4aTMn3FcV9DoXMtTTNWs5WFFTxVTJPEIFnOtcd/4gvSZazrz4X774/VyDcpxaW4tw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661868387; bh=BXdJmfuV2i7Ran+e6ooR1PE33bSH1wV+eI4fsbkWepv=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=tK/vuvkyM8GcW/VQOvKAdilnRE+p9uExORaLpYhVLv7B5rHfRyR76prRSgh/6Wsf9tgtWoLhmW2Qi6PuIyG+zCmapOik596/QHHo3JNDqXLmKuljICRlEUrfSYaTdWu/0p4ILAfG3ZHg1lwCEG4aEmQi9VCtOd+lva3DQAjKtkBwJe9/KrNmH3B/n5MtrusRCLMBfG9NjnSmhxWrGMiVY5aIfn79DIxtabbJ/PAhxOxev+4fesPpQ2+6SVkUaqTKG/pNBtRCLUe3/xmh2kpgKtUEA0hvB2vedl5kIhaAjf3MIOAkkQBHZ4cxk2paSKIs8xID4/ktV2mn/1akjZ0DFg==
X-YMail-OSG: 9fdVY5IVM1n5AshMiFlMVklg7D0MuB92kXw0w6ZwvNT67dRCmJvNL7H9eU6yH3f
 SsmwVESkuCOdW7lhpFCeQr1C0lgVzn.USRJ1fZgmSvQrRwzE69Q1x5NTfyPu2dSQCDo6TjCVuU9F
 f_7TqAwh4vZVrPn9C15SXUlu82avJDnPbwln6j5XHPQmlH5yXo3VIzaO1K7kkQp6Cl4vKy.MQV.w
 wnESlyF2jMNCKIBQCb3gKR9rsyOk1vwlisAIQKmcbA9tedQEGRaMtLXtMjZCTnzdbfs5lONt1Afu
 hnOCrdUTeXQ_q2uzDl103SzfqEvZiTqfLmWTVo97bKkKFihSXzEVEOg1Srpn2YubaEC52vBRIsDL
 p06NSjCSfBw50aD4kl3O8FIyZZgwcUpsV9tuxKXBDNLzjr08zbWsesHQDam59UgR74e5a5ZiuRjT
 gaM3zUJuzG6lnQsoO_OryoO1S0W95RrnQjzz3fZ5Chj0bpXwHaU.WsGIbxCMMLVBdP3Xx9okMNBd
 1acEdvohfyv0REx2rplIa4hYOiKJ04bu3.jcUddaJ64Wd0D93RwdZwmQ5QaJAfjIeOk4O3BcN3jq
 sA823yRhsWAkfmN2T8KVf7KU.4MdeaTFULJIPxD83j6BaDjhOA1xF7n14xO6nBeWxZ8rvDnBltvs
 AvGu7cP6QH1GxqWQS1RjhNFrJGYpEunO5GHE_4oMXhbEAhZ1XYWKHq0RzhYthscPZT4_AVKmBTXH
 vwpze8lhytEGf3EpQ482RFI2YWifuD5ATNIf4PEbWFS0dqexqz8mQJf3JGfnCOWO3x1X5lowfq7O
 mE4sPpm8IE2NZ4YnxxJLl_dG90ZeodIBLTSWTA9QT.vfAv2deACb8fqlOlpBug2gn0P02nT3v.aY
 GAn8XtobCv5B1i_Hat9.8B4I1KBOf.e2Z_4KyX3rjMOKTWu9HqIMUFXNhrCUyH557HcdEIxO6cgL
 Yxe8lwXHSQhaDVqhjWhvBRzVhNC4Czc.jFwg0JFw5n9Imw5LR.8oYobK85eFxJ19MqOL3UkYmDlp
 EfUnAX7DnbSjPuNwhQPLuIiNBrETDpteYnthq.VlgVK2VArss6B4XHIs6CgLa9U_2aD8t1n7oalS
 iklmqWTicsH8JnfUPRQKiEvKwln8AlT85W7ZIPbi_AKb.svCZQYTOPim89Ep8d3gyXpG1_hbUDr2
 xRIjUBLM_JBtUNT53hcRbk_7uClYqkBAYzhnXlP6mNeufgqtISFKDJB0Hq5CVHxW2LeCk4o1q8GE
 ybBu7dbvKoNFSoeM8iDaj3PgQ.nE2DTDwv33FJ6RCy42XVRR_mpOMKJGhx8G9VdHFq.WY38LEGTc
 LoC1sjbbMoSCzToRcjHtnEIVMd3PPENzlAtXLyczRrB92HwRFiBhov4JRWlYQlGTayHsrurctNCG
 _KFG_tlLnMDGQPOaojxyvfcaIJMW33rhBvxfuigoYQe.HIDPi5srnWxN2ypt2vrz.306CMg4QDAA
 ZUFeJpDZ4M3zY4akU_4fQx1tB9HEoXZESApXCyKdjIrRS_K_y6pStyFN_kzJSX.UqqWIiPzRmrKT
 WQABXdBWQjQnJDw81Be2wQaSDY3aYaPmWuxWS2s5CFPD9jfm_ig0zuMJzvR8dYBB7cEDq_L1Rt_Z
 qAqJRzqyyQE.ZDAGx827I.ZkkHzvolv2aSHXL_S9Y.wXWyfmJbMU7WS_bNiGqj5IJc3vVTprWYm0
 DrwtAolzglKnIQfQuDBLXCz9oUiRerzF5Uq0VywHQaIbQMJh94DlgZS_s7FNkb_Wbzl0C2AyREdI
 bbrBGx9Axp5c4Jip7UOOENsWnUq2jnkwWd2ZaFVSFABq3kDAbGlMY3Fpn5vxpsJiruUZwRrp9SIx
 FTQMS2JrfQ4EjMvjs_mmJyPFAs45uUVfIW9N9VSiw9PpAAPurs8NBFo.4qamS5vVld9clggFJt8S
 t7Tg2CPXrRoNVBdahb0V9SdTwDmTwZa6Q0nUNPJaDqTDwM2Z8hHYPNllUYiDijU7pfQv6dFQ6M6V
 kaV_H22OSNZQ3ydhzDAyxTix3OJuKRoA076pvWF1wzopZAjffSdeRxhB.sU.Foi06LWwbZqCjc2O
 dogiXZpA4usH_.Ow5OMH11I_grKnTOtTpITAJOAF9CMuWrBzt578a1i6o0y_IP8eRt6Q4I0e9rkk
 cApaLPOHBBcf.CPE3Dv5u1SomL6_2MwkMS3FGBx6sU_pynJ6zLAdIZlkg.RIZhFxMgsYxTXBMCQW
 y2RHOXF5WRHQ8KPKy3qa1zTBNdtKX5vBYzQfBWhAf
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 30 Aug 2022 14:06:27 +0000
Received: by hermes--production-bf1-7586675c46-944ms (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d74148ae45693ef332212a9fff3116ff;
          Tue, 30 Aug 2022 14:06:22 +0000 (UTC)
Message-ID: <f6649421-a901-de54-ece6-ae107c0ff1cc@schaufler-ca.com>
Date:   Tue, 30 Aug 2022 07:06:18 -0700
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <61f18d5513bdb68748e635470a41eb4e2dadb915.camel@elektrobit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20595 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 8/30/2022 2:30 AM, Lontke, Michael wrote:
> On Fri, 2022-08-26 at 09:15 -0700, Casey Schaufler wrote:
>> On 8/26/2022 1:40 AM, Lontke, Michael wrote:
>>> On Thu, 2022-08-25 at 08:59 -0700, Casey Schaufler wrote:
>>>> On 8/25/2022 2:25 AM, Lontke, Michael wrote:
>>>>> Hello Mr. Schaufler,
>>>>>
>>>>> we observed the following behavior of the SMACK LSM kernel
>>>>> feature.
>>>>>
>>>>> PROBLEM: SMACK LSM is checking the wrong label when receiving
>>>>> network
>>>>> packets during high system load.
>>>>>
>>>>> Full Descrpition of the Problem: During a test scenario
>>>>> involving
>>>>> high
>>>>> system load (cpu, memory and io) in combination with ingress
>>>>> tcp
>>>>> network traffic, SMACK is checking wrong object labels leading
>>>>> to
>>>>> denied access for valid scenarios.
>>>>> In below test scenario the label 'stresstest' is only used for
>>>>> the
>>>>> application 'stress' but appears in SMACK audit logs as object
>>>>> together
>>>>> with netlabels.
>>>>>
>>>>> This issue initially appeared on hardware with kernel version
>>>>> 4.14.237
>>>>> but was also being reproduced with qemu for kernel version
>>>>> 4.14.290
>>>>> and
>>>>> latest 6.0-rc2. The used rootfs was generated via buildroot
>>>>> version
>>>>> 2022.08-rc1.
>>>>>
>>>>>
>>>>> KEYWORDS: smack, networking
>>>>>
>>>>> KERNEL INFORMATION: Linux stable kernel
>>>>>
>>>>> KERNEL VERSION: 4.14.237, 4.14.290, 6.0-rc2
>>>>>
>>>>>
>>>>> KERNEL CONFIG: smack related kernel configuration
>>>>>
>>>>> CONFIG_NETLABEL=y
>>>>>
>>>>> CONFIG_SECURITY_NETWORK=y
>>>>>
>>>>> CONFIG_SECURITY_SMACK=y
>>>>>
>>>>> CONFIG_DEFAULT_SECURITY_SMACK=y
>>>>>
>>>>> CONFIG_DEFAULT_SECURITY="smack"
>>>> What is the value for CONFIG_SECURITY_SMACK_NETFILTER ?
>>> # CONFIG_NETWORK_SECMARK is not set
>>> therefore CONFIG_SECURITY_SMACK_NETFILTER is not set as well.
>>>
>>>> The implementation for IPv6 is much more robust for the
>>>> netfilter enabled path.
>>> You are stating that
>>>
>>> CONFIG_NETWORK_SECMARK=y
>>> CONFIG_SECURITY_SMACK_NETFILTER=y
>>>
>>> and therefore using SMACK_IPV6_SECMARK_LABELING instead of
>>> SMACK_IPV6_PORT_LABELING path in kernel code is more reliable?
>> Yes. The netfilter version is used in all known commercial
>> deployments
>> of Smack, and hence has gotten more attention. The port labeling code
>> is a "clever hack". I hope to replace it with CALIPSO now that
>> CALIPSO
>> is supported by newlabel.
>>
> Today I tested with your suggested configuration (secmark + netfilter).
> Executing the same test case I run into almost the same issue:
>
> [  288.200206] audit: type=1400 audit(1661844069.376:742): lsm=SMACK
> fn=smack_socket_sock_rcv_skb action=denied subject="net_host"
> object="stresstest" requested=w pid=185 comm="stress" saddr=<host-ipv6-
> addr> src=49812 daddr=<qemu-ipv6-addr> dest=42511 netif=ens3
>
> Instead of defining the netlabel via /sys/fs/smackfs/ip6hosts I added a
> nehosttfilter rule to mark the package with secmark:

The netfilter rule is unnecessary if you set the host label. Smack will
set the secmark based on the host label. The approach you've use should
work just fine. Seeing that the problem occurs in both cases will help
narrow down the possibilities. With the configuration and cases you
provided I am able to reproduce the problem reliably. I am working on
tracking down what I think is a lack of locking issue. Any more information
you can provide could be most helpful.

>
> ip6tables -t mangle -A INPUT -p tcp --src <host-ipv6-addr> -j SECMARK
> --selctx net_host
>

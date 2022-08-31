Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF146ECAAD1
	for <linux-security-module@archiver.kernel.org>; Wed, 31 Aug 2022 14:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiHaOis (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 31 Aug 2022 10:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiHaOij (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 Aug 2022 10:38:39 -0400
Received: from sonic309-26.consmr.mail.ne1.yahoo.com (sonic309-26.consmr.mail.ne1.yahoo.com [66.163.184.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3565265830
        for <linux-security-module@vger.kernel.org>; Wed, 31 Aug 2022 07:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661956717; bh=xCBQ7FRBavrjslCeO5XGj1Yth2EL2CMuj3XGNfwfzD4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=jOaMj0R8An0ZrZRIImV6LqAY2j9Rb8pKo5fREPtDvlna7GHJDtTe3HCf4ttI/eiZrfp+8Kn7pLKREAnP9KmShR89InWbPoAH0BpVXcRZGfrGemNsS7fGiTsUlXqecTPD+LiS9o8c62PAKjpArRjtdmjP4er59as/otx7N3Ev6jYkQhOM0Y5omWqqVT+qr4Gx5GKyZgBiVoJ688lku5S347wmhHoIt6i8kB/SWOUuoqzIsvJaJsRyHe96uYbuc9bKvd4rTczwOE9OWHJwFJoLiuQ+2nZhb9nISOkqU89PacM1xclYrG5HiUrh5Zt6/t5MHwrQjoPkEtuOMCYFe83oWQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661956717; bh=9d13n0gwwtWEz9B4rdRDWhrZd2ytmodtWSUPmGbB61D=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=BjDEj+eq10QeXebyweqOxmKRUGjGVUiUiOzt2dOGyXAqbt8HVX+pRKDMHGpBuDj1iHmGYC5ORTbfK29GEY6uGvthjqmPSg96s9OxzGoDDuMbPP9YZyGiblqagGmED01NTPyLXPVoycJXMF0bMn5TImZkmcpzFI1iBY9kp9GNy4rSD999dkbrNNMlQwSHGW4gywL6Va4cAvk/W2suDvhZ3Od27YmUU2Zx+BWmdphwPmUvY2aJV6m2+SuA4BD1ql0pezq7FUypSQRPFnTKtlGV/dBTOUx9qLW+D2JH3YuOkARS3Rlr3T47jKFGEc9NHiH0ankDsDciHwk0IjuSSWWVLg==
X-YMail-OSG: .VrpulYVM1m.XvMCryHW2gkj1LpjBKvHEiefhB2hKoS3uc6i198Tm9r1ql2tNjC
 LAG_fn.nhvt7UgtBbDJjYPjY7eT4XgpXtOMKkkC.RsmkEHMxD.KQki7GyDsLpM31WjIt8E7lUJcf
 FVuuQM9LsY2vOxbiTaZmzJ8.7ndMwqoUlFs8zNH_g3eNFF1d2S5nWtssxGydQhkeNZnh3VYpHqGT
 DkxAYAwcwraWkoNagfOc42vxdxOCj2..xu8fJCKHZGxpGWx345ydy2womAUXWF6NfVwWb6M59xmc
 kv.8DXUBaHa.KJYC7t0F93qJMKBnOfXaDWVX7P9oSljsv_Oztr.0UjusbStzM0iVyG4atG68OrBm
 DIBtencgKRHWfTScA2rGlrYQZy4EkXABna_DV3c42XG5rRbL0_FolMlG8mkwJZrLVQ2Pay_aSIFs
 Lc8wEqUlRhb9VKU5vsVN6GWbBeIN6BFQPmW5waMv3pNpbGJ2w1_XCGJ2bmTPq1n.dmMPnM8z.74f
 zZH2i52yxfv2xJqBECkSwFdV22.iBXRa.eV.X4dUKRjCFjVRQnoZ0HcV6DtPCcfk07vM8pK6yScI
 mFGe__DzEroOWOmdXNfLjozwSXDbUSLkYtZkCGsms5.DdyYYrsyTxQb8FDZJFuMo.JuOHRHCK2NY
 g79W0Q3HzXgJ.8g2lXPsXghtgAfBsS0Bag.I.ba4Q8_7Cj3w5i7EQEZU9wwgYAx1VXcyrKVM_ujk
 cHPxkmeBmFlJlqDlTI5FqRcmnkxrMx_eMcrIb.sAEd9kds8W1.vbMwe0qx5kYZ7Dxjg9YlrLz9mh
 .AR8.6zq.vJTeZedn.IV391pu.d2AvEQukf4aTPI._q2rugx4DwRsvlqhhs8In.q6Kz0mhHIjpox
 KI1mNUgSCvOGbXzYNU7PgVioZFuTK8cEGNmTW9EUua8OLD0ZA4lwjbn84b3pureotGXOOPFQyres
 PDXY5S2Y8VtPkuuksVBBfaugSDhqY3FZvnpaoDLnSgjiR7LFBl5Rg7nif34xHsCDlKRV6DjVyduc
 EE1AJb9mAAyUXzSg2PvBi7Im.i7cXbAcXe9oxF0tCtF0_tPj1x9eSORIeqa.xxyu3fUdhxWjgHe2
 bxcUMNPJt7JitIlozAWF06CeF6aVwA9dCyvP8SMmEToawum21.jw0xDGuaxh.o8NrJ1b5xkph0Jz
 3Mi26zY_Sp0Jb4l2a241NpVJ5W3854L7ETG.r7Bd9KjRt2z1B566_kuX7AVqHT_RwiT5OeLNtSKU
 bW2o5Sz.Utntv2k.kffqOgx.eCITpQad3fcXzA2Ei4SuWacrDXBDJ5b.oHpZ5xejdFVYhIYeVPra
 8oNfcG22_.CVmlb73Z7s5dvDweFLifAvLZJeRKE73mw.l98w50uHXOiQ6I_GGFxTZ79PXdYF1xkn
 UWhGbmrF5yFxmqfQ6s_FBCOZkqklFCopRJGur9eM8N8TufHf0ee2aiK86LLVuUOeT3_u8YfOgloo
 DXvusp4ggf5AEigRzAPaCqlnRWUzO_ICSBG4FjtKgdiJ8fEkHaddy9SzVPixjmBvkFvfEYdDADxy
 KjbUdH0dz_qcKjMLijdFS.eg8BSXMO7ytTioMJJVzEwkVPv5eJuRPqNnIOl_J78Hy1xXmHezkfHb
 Ow5sTD2_URpaGXaOzWhAbAvYdp8jBsxnMpkxpPdApDxzO55YD7uqY4zj9BNbCMW2CfqL2S7erLh4
 ueMF.lOXlrUeABDM1h5ykJYRzfsMFPdJAjk.6P5CnluvSX1D36iml62FItGcfAG.j0R3a7lxlqs9
 BBCeIdDjZMhIvf65vLxj4LfOP3jvJMDd9m0sM0zG5hI.eVoJu53_xey53LfREBHJQH3FwLFq43qO
 9dTCmv5XQHiea2yeldsXnDYGxXOaaIgg.y127L22YFFVy9NqGemPK9f7c4a4u.1z1QA.PKBcQAW.
 X95R2WMmFL8UtIcnYcnT_pMc_hHW77wavZo0DHbhv0DAzuFcG6Joaq7bNJu3NuylVgdGbpoWp5dI
 rWLGQugpbwPKeFYO3WSz35SnIQVb_BhBOC4HJ0y5iPV.rdYQhoT3rqnqk_DliX5E3Bh_dL0WOEWb
 epueR9e1C2ocKQR6LLpXj981pYGpN_SoN..bIU0yP7Z.MJ3nAZEcmTTkzKEJCygsesVFRa9JAd.R
 PZbqMXMn1HM83R78dIFPpZqChZkWC2USDL5KkZ7wqRU6Mt0fktQ3NUvlg6GnEx6MR3mgXVtrQfgX
 T6cAL4YIkjVidAIdxD9urNWbq0t_kfDaKHA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 31 Aug 2022 14:38:37 +0000
Received: by hermes--production-bf1-7586675c46-4x8tg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 19e91f5c78bd62fd5b3bf75e1dd5a8af;
          Wed, 31 Aug 2022 14:38:34 +0000 (UTC)
Message-ID: <dabd5646-4afb-5df5-ea4f-3d4c7dc7a43f@schaufler-ca.com>
Date:   Wed, 31 Aug 2022 07:38:32 -0700
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <6324997ce4fc092c5020a4add075257f9c5f6442.camel@elektrobit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20595 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 8/31/2022 5:13 AM, Lontke, Michael wrote:
> On Tue, 2022-08-30 at 07:06 -0700, Casey Schaufler wrote:
>> On 8/30/2022 2:30 AM, Lontke, Michael wrote:
>>> On Fri, 2022-08-26 at 09:15 -0700, Casey Schaufler wrote:
>>>> On 8/26/2022 1:40 AM, Lontke, Michael wrote:
>>>>> On Thu, 2022-08-25 at 08:59 -0700, Casey Schaufler wrote:
>>>>>> On 8/25/2022 2:25 AM, Lontke, Michael wrote:
>>>>>>> Hello Mr. Schaufler,
>>>>>>>
>>>>>>> we observed the following behavior of the SMACK LSM kernel
>>>>>>> feature.
>>>>>>>
>>>>>>> PROBLEM: SMACK LSM is checking the wrong label when
>>>>>>> receiving
>>>>>>> network
>>>>>>> packets during high system load.
>>>>>>>
>>>>>>> Full Descrpition of the Problem: During a test scenario
>>>>>>> involving
>>>>>>> high
>>>>>>> system load (cpu, memory and io) in combination with
>>>>>>> ingress
>>>>>>> tcp
>>>>>>> network traffic, SMACK is checking wrong object labels
>>>>>>> leading
>>>>>>> to
>>>>>>> denied access for valid scenarios.
>>>>>>> In below test scenario the label 'stresstest' is only used
>>>>>>> for
>>>>>>> the
>>>>>>> application 'stress' but appears in SMACK audit logs as
>>>>>>> object
>>>>>>> together
>>>>>>> with netlabels.
>>>>>>>
>>>>>>> This issue initially appeared on hardware with kernel
>>>>>>> version
>>>>>>> 4.14.237
>>>>>>> but was also being reproduced with qemu for kernel version
>>>>>>> 4.14.290
>>>>>>> and
>>>>>>> latest 6.0-rc2. The used rootfs was generated via buildroot
>>>>>>> version
>>>>>>> 2022.08-rc1.
>>>>>>>
>>>>>>>
>>>>>>> KEYWORDS: smack, networking
>>>>>>>
>>>>>>> KERNEL INFORMATION: Linux stable kernel
>>>>>>>
>>>>>>> KERNEL VERSION: 4.14.237, 4.14.290, 6.0-rc2
>>>>>>>
>>>>>>>
>>>>>>> KERNEL CONFIG: smack related kernel configuration
>>>>>>>
>>>>>>> CONFIG_NETLABEL=y
>>>>>>>
>>>>>>> CONFIG_SECURITY_NETWORK=y
>>>>>>>
>>>>>>> CONFIG_SECURITY_SMACK=y
>>>>>>>
>>>>>>> CONFIG_DEFAULT_SECURITY_SMACK=y
>>>>>>>
>>>>>>> CONFIG_DEFAULT_SECURITY="smack"
>>>>>> What is the value for CONFIG_SECURITY_SMACK_NETFILTER ?
>>>>> # CONFIG_NETWORK_SECMARK is not set
>>>>> therefore CONFIG_SECURITY_SMACK_NETFILTER is not set as well.
>>>>>
>>>>>> The implementation for IPv6 is much more robust for the
>>>>>> netfilter enabled path.
>>>>> You are stating that
>>>>>
>>>>> CONFIG_NETWORK_SECMARK=y
>>>>> CONFIG_SECURITY_SMACK_NETFILTER=y
>>>>>
>>>>> and therefore using SMACK_IPV6_SECMARK_LABELING instead of
>>>>> SMACK_IPV6_PORT_LABELING path in kernel code is more reliable?
>>>> Yes. The netfilter version is used in all known commercial
>>>> deployments
>>>> of Smack, and hence has gotten more attention. The port labeling
>>>> code
>>>> is a "clever hack". I hope to replace it with CALIPSO now that
>>>> CALIPSO
>>>> is supported by newlabel.
>>>>
>>> Today I tested with your suggested configuration (secmark +
>>> netfilter).
>>> Executing the same test case I run into almost the same issue:
>>>
>>> [  288.200206] audit: type=1400 audit(1661844069.376:742):
>>> lsm=SMACK
>>> fn=smack_socket_sock_rcv_skb action=denied subject="net_host"
>>> object="stresstest" requested=w pid=185 comm="stress" saddr=<host-
>>> ipv6-
>>> addr> src=49812 daddr=<qemu-ipv6-addr> dest=42511 netif=ens3
>>>
>>> Instead of defining the netlabel via /sys/fs/smackfs/ip6hosts I
>>> added a
>>> nehosttfilter rule to mark the package with secmark:
>> The netfilter rule is unnecessary if you set the host label. Smack
>> will
>> set the secmark based on the host label. The approach you've use
>> should
>> work just fine. Seeing that the problem occurs in both cases will
>> help
>> narrow down the possibilities. With the configuration and cases you
>> provided I am able to reproduce the problem reliably. I am working on
>> tracking down what I think is a lack of locking issue. Any more
>> information
>> you can provide could be most helpful.
> I added some debug output and stack dumps:
>
> [   48.056297] SMACK DEBUG: smack_sk_alloc_security:2321 -
> sk=ffff8feb1cc3a200 - smk_in=stresstest smk_out=stresstest
> skp=ffff8feb1cc51000
> [   48.056792] CPU: 0 PID: 1544 Comm: stress Not tainted 4.14.0+ #9
> [   48.057085] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.10.2-1ubuntu1 04/01/2014
> [   48.057463] Call Trace:
> [   48.057600]  <IRQ>
> [   48.057741]  dump_stack+0x4d/0x71
> [   48.057936]  smack_sk_alloc_security+0x109/0x110
> [   48.058165]  security_sk_alloc+0x3e/0x60
> [   48.058364]  sk_prot_alloc+0x53/0x130
> [   48.058553]  sk_clone_lock+0x19/0x3d0
> [   48.058737]  inet_csk_clone_lock+0x11/0xe0
> [   48.058953]  tcp_create_openreq_child+0x1e/0x420
> [   48.059172]  tcp_v6_syn_recv_sock+0x91/0x710
> [   48.059380]  tcp_check_req+0x3b2/0x510
> [   48.059558]  ? tcp_v6_inbound_md5_hash+0x54/0x1c0
> [   48.059782]  tcp_v6_rcv+0x4c1/0x950
> [   48.059954]  ? ip6table_mangle_hook+0x41/0x120
> [   48.060172]  ip6_input_finish+0xb9/0x420
> [   48.060374]  ip6_input+0x2b/0x90
> [   48.060535]  ? ip6_rcv_finish+0xa0/0xa0
> [   48.060718]  ip6_rcv_finish+0x41/0xa0
> [   48.060892]  ipv6_rcv+0x31d/0x520
> [   48.061053]  ? ip6_make_skb+0x1b0/0x1b0
> [   48.061240]  __netif_receive_skb_core+0x33a/0xa90
> [   48.061490]  ? ipv6_gro_receive+0x1b5/0x350
> [   48.061687]  __netif_receive_skb+0x13/0x60
> [   48.061895]  ? __netif_receive_skb+0x13/0x60
> [   48.062089]  netif_receive_skb_internal+0x23/0xb0
> [   48.062305]  napi_gro_receive+0xbd/0xe0
> [   48.062485]  e1000_clean_rx_irq+0x1c9/0x4e0
> [   48.062686]  e1000_clean+0x260/0x860
> [   48.062860]  net_rx_action+0x11b/0x350
> [   48.063031]  ? e1000_intr+0x78/0xf0
> [   48.063202]  __do_softirq+0xcf/0x2a8
> [   48.063376]  irq_exit+0xab/0xb0
> [   48.063528]  do_IRQ+0x7b/0xc0
> [   48.063679]  common_interrupt+0x90/0x90
> [   48.063854]  </IRQ>
> [   48.063977] RIP: 0033:0x56307cef0baf
> [   48.064135] RSP: 002b:00007ffcd9734540 EFLAGS: 00000206 ORIG_RAX:
> ffffffffffffffc4
> [   48.064466] RAX: 0000000037581fac RBX: 0000000000003a98 RCX:
> 0000000037581fac
> [   48.064765] RDX: 000000003b388e7d RSI: 00007ffcd973451c RDI:
> 00007f2023c62680
> [   48.065033] RBP: 0000000000000003 R08: 0000000000000000 R09:
> 00007f2023c62024
> [   48.065326] R10: 0000000000000000 R11: 0000000000000246 R12:
> 0000000000000000
> [   48.065625] R13: 0000000000000003 R14: 0000000000000001 R15:
> 000056307cef2004
> [   48.066462] SMACK DEBUG: smack_socket_sock_rcv_skb:4057 -
> sk=ffff8feb1cc3a200 smk_in=stresstest rc=-13
> [   48.066852] CPU: 0 PID: 1544 Comm: stress Not tainted 4.14.0+ #9
> [   48.067142] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.10.2-1ubuntu1 04/01/2014
> [   48.067507] Call Trace:
> [   48.067620]  <IRQ>
> [   48.067738]  dump_stack+0x4d/0x71
> [   48.067898]  smack_socket_sock_rcv_skb+0x269/0x270
> [   48.068109]  ? default_wake_function+0xd/0x10
> [   48.068301]  ? pollwake+0x61/0x70
> [   48.068464]  ? wake_up_q+0x70/0x70
> [   48.068621]  ? __wake_up_common+0x68/0x120
> [   48.068806]  security_sock_rcv_skb+0x36/0x50
> [   48.068987]  sk_filter_trim_cap+0x2c/0x150
> [   48.069156]  ? tcp_v6_inbound_md5_hash+0x54/0x1c0
> [   48.069356]  tcp_filter+0x26/0x40
> [   48.069510]  tcp_v6_rcv+0x805/0x950
> [   48.069663]  ? ip6table_mangle_hook+0x41/0x120
> [   48.069856]  ip6_input_finish+0xb9/0x420
> [   48.070029]  ip6_input+0x2b/0x90
> [   48.070174]  ? ip6_rcv_finish+0xa0/0xa0
> [   48.070337]  ip6_rcv_finish+0x9a/0xa0
> [   48.070498]  ipv6_rcv+0x31d/0x520
> [   48.070651]  ? ip6_make_skb+0x1b0/0x1b0
> [   48.070832]  __netif_receive_skb_core+0x33a/0xa90
> [   48.071028]  ? ipv6_gro_receive+0x1b5/0x350
> [   48.071214]  __netif_receive_skb+0x13/0x60
> [   48.071396]  ? __netif_receive_skb+0x13/0x60
> [   48.071595]  netif_receive_skb_internal+0x23/0xb0
> [   48.071808]  napi_gro_receive+0xbd/0xe0
> [   48.072001]  e1000_clean_rx_irq+0x1c9/0x4e0
> [   48.072197]  e1000_clean+0x260/0x860
> [   48.072376]  net_rx_action+0x11b/0x350
> [   48.072542]  ? e1000_intr+0x78/0xf0
> [   48.072709]  __do_softirq+0xcf/0x2a8
> [   48.072881]  irq_exit+0xab/0xb0
> [   48.073041]  do_IRQ+0x7b/0xc0
> [   48.073232]  common_interrupt+0x90/0x90
> [   48.073433]  </IRQ>
> [   48.073544] RIP: 0033:0x56307cef0baf
> [   48.073697] RSP: 002b:00007ffcd9734540 EFLAGS: 00000206 ORIG_RAX:
> ffffffffffffffc4
> [   48.074007] RAX: 0000000037581fac RBX: 0000000000003a98 RCX:
> 0000000037581fac
> [   48.074297] RDX: 000000003b388e7d RSI: 00007ffcd973451c RDI:
> 00007f2023c62680
> [   48.074580] RBP: 0000000000000003 R08: 0000000000000000 R09:
> 00007f2023c62024
> [   48.074875] R10: 0000000000000000 R11: 0000000000000246 R12:
> 0000000000000000
> [   48.075157] R13: 0000000000000003 R14: 0000000000000001 R15:
> 000056307cef2004
> [   48.075903] SMACK DEBUG: smack_sock_graft:4185 - sk=ffff8feb1cc3a200
> - before smk_in=stresstest smk_out=stresstest
> [   48.076643] CPU: 0 PID: 1634 Comm: socat Not tainted 4.14.0+ #9
> [   48.076892] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.10.2-1ubuntu1 04/01/2014
> [   48.077329] Call Trace:
> [   48.077485]  dump_stack+0x4d/0x71
> [   48.077654]  smack_sock_graft+0xe9/0xf0
> [   48.077834]  security_sock_graft+0x28/0x40
> [   48.078024]  inet_accept+0xa8/0x140
> [   48.078198]  SYSC_accept4+0xe8/0x1e0
> [   48.078372]  ? __audit_syscall_entry+0xba/0x100
> [   48.078580]  ? syscall_trace_enter+0x1c3/0x2b0
> [   48.078781]  SyS_accept+0xb/0x10
> [   48.078933]  do_syscall_64+0x4e/0x100
> [   48.079105]  entry_SYSCALL64_slow_path+0x25/0x25
> [   48.079314] RIP: 0033:0x7f8d116b85ea
> [   48.079465] RSP: 002b:00007fff87c2ef28 EFLAGS: 00000246 ORIG_RAX:
> 000000000000002b
> [   48.079778] RAX: ffffffffffffffda RBX: 00007fff87c2f160 RCX:
> 00007f8d116b85ea
> [   48.080063] RDX: 00007fff87c2f134 RSI: 00007fff87c2f160 RDI:
> 0000000000000005
> [   48.080363] RBP: 00007fff87c2f134 R08: 00007fff87c2f134 R09:
> 0000000000000000
> [   48.080648] R10: 0000000000000040 R11: 0000000000000246 R12:
> 0000000000000005
> [   48.080903] R13: 00000000ffffffff R14: 00007fff87c2f160 R15:
> 00007fff87c2f1e0
> [   48.081236] SMACK DEBUG: smack_sock_graft:4193 - sk=ffff8feb1cc3a200
> - after smk_in=tcp_test smk_out=tcp_test
>
>
> It looks like the socket is already initialized with the wrong security
> context. It is later corrected by smack_sock_graft, but tool late since
> it is called during accept.
>
> We looked into smack_sk_alloc_security and thought this line could be
> the issue:
>
> struct smack_known *skp = smk_of_current();
>
> Looking at how selinux solved it, we saw it initializes with a blank
> security context and later copys the correct context within
> security_sk_clone LSM hook.
> At least with this patch we don't see our issue anymore:

I will run the patch through my tests, but it looks reasonable.
Assuming it passes, and I expect it will, I'll add it to the Smack
next branch. May I add your "Signed-off-by:" ? Also, let me know
if anyone wants to add a "Reported-by:". Thank you for tracking this
down and contributing to Smack.

>
> From: Lontke Michael <michael.lontke@elektrobit.com>
> Date: Wed, 31 Aug 2022 14:03:26 +0200
> Subject: [PATCH] SMACK: Add sk_clone_security LSM hook
>
> Using smk_of_current() during sk_alloc_security hook leads in rare
> cases
> to a faulty initialization of the security context of the created
> socket.
>
> By adding the LSM hook sk_clone_security to SMACK this initialization
> fault is corrected by copying the security context of the old socket
> pointer to the newly cloned one.
> ---
>  security/smack/smack_lsm.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 286171a16ed2..8eb47396376f 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -2348,6 +2348,21 @@ static void smack_sk_free_security(struct sock
> *sk)
>  	kfree(sk->sk_security);
>  }
>  
> +/**
> + * smack_sk_clone_security - Copy security context
> + * @sk: the old socket
> + * @newsk: the new socket
> + *
> + * Copy the security context of the old socket pointer to the cloned
> + */
> +static void smack_sk_clone_security(const struct sock *sk, struct sock
> *newsk)
> +{
> +	struct socket_smack *ssp_old = sk->sk_security;
> +	struct socket_smack *ssp_new = newsk->sk_security;
> +
> +	*ssp_new = *ssp_old;
> +}
> +
>  /**
>  * smack_ipv4host_label - check host based restrictions
>  * @sip: the object end
> @@ -4710,6 +4725,7 @@ static struct security_hook_list smack_hooks[]
> __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(socket_getpeersec_dgram,
> smack_socket_getpeersec_dgram),
>  	LSM_HOOK_INIT(sk_alloc_security, smack_sk_alloc_security),
>  	LSM_HOOK_INIT(sk_free_security, smack_sk_free_security),
> +	LSM_HOOK_INIT(sk_clone_security, smack_sk_clone_security),
>  	LSM_HOOK_INIT(sock_graft, smack_sock_graft),
>  	LSM_HOOK_INIT(inet_conn_request, smack_inet_conn_request),
>  	LSM_HOOK_INIT(inet_csk_clone, smack_inet_csk_clone),

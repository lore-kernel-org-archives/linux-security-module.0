Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04062C2BA4C
	for <linux-security-module@archiver.kernel.org>; Wed, 26 Jan 2022 17:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243811AbiAZRgz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 26 Jan 2022 12:36:55 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:38891
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243717AbiAZRgy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 26 Jan 2022 12:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643218614; bh=X3Oha3albcBP2pYJoWrVNpGhwSbSqHt4dS8vkH2UO0Y=; h=Date:Subject:To:References:From:Cc:In-Reply-To:From:Subject:Reply-To; b=soQvJibuO1OVpJyUkqPe0TQG+WGxPkFFtEMlTYtGk+gVTUHuf5PTKf+IXD6tDcyo5frQCF93g9ThXirxiRv27fx1SVD1zuxqXLdJvUjFtl32Uj5qTwdgPbQ6x8AFJk2neA481E7f/38pEloj4nWVaMo8dv4RYbMmUIudMXkLxg2zo3j461xpw5hzbs1ORRx5t8gU4jB81I91QavYcqqmcBBS3iVU18qmQRzeFWAMpGAQSk9WqdnM2D59tAirHtlsi82RJZO2MH6s72NwL11uF/4TjlQ4XM4VzeYVMS6VfyvpRgAV2/TrpUtNAkH7er70SCE3ENMwF84oNXCQmBdm/w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643218614; bh=c4QESCFRt7eKrtA9u14IdCxfh4210PwNRC+ojHW59xP=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=tb/ocP2szAzw8wE4OKZqbJwMzQsgKJXujwPX7kNChLebNn/VpsqJVa+vt8N4ZKxsaP20HWKtg37dIXUobIfZoG/uGRuLv/+87XcghKKw2gatipYhYcS8i1k44qFhp7MpWxZvdiaf2UiFX7s9z4P+J10M0t6j+aZ87iSj9fDZQyk2Pn3EWzF8Nfb9H6lcGDHSm7L8ZtIZ/r/NZG4SRN6Bbq5s5nDmXWVClYNfOcv4jioaIO7p0dqraQH4+1oIqf2UdUOJ1bftnneVqs0UuuV8TyFenTTBWlpJShdNppDZjSbOu0pGMykntfURCtPu5phfQRTT2gn5HulAkOwD+5DRZQ==
X-YMail-OSG: SrB7SsQVM1kIjz0MskmPf1sVjxl78Z43muMqwFU3RzV8WBcC62Ioud5gwcyKldl
 KCbnD.7PRN6Y1akutKeVRLp2sYjwRggeeEUZf1weNF2NQdpvaeVEA_.nmHTe79udiECAV6eta4Li
 zeJhs.DNV8kLbT67AfbwA2rUUsw5_nX6bDBE2Om3Cixw6sPKNaCZsyHCWY0efxMEzVTwJpcrrwLW
 Ot88NerwS7Fg8KlrhyL_cHi6Vm0PzZsrI0i0BFziw1OMaWezjQMcGWC0v9NR4r4CYBaQYWUscP2K
 s5drM7shhmxay4YRoU0OEjR.8D6R9Y8v9HDkzg3gWy6q9_zozJL3kMZcZPre6KQSTLJNjPMp0Uhj
 .VOVmzXZMrunhJqBMvERTFQUHYLv1sfc0r.iceJ7O6kV55iTYLmQUBYq7h_0koI28ogoTdyPBqBD
 yX5AZkOhHwMqmk30D6jhV1evCCffbXdsLUeJ4cWdQ4y6ye858l2IygErVAIZMZIevt3ptN95AZAN
 i..3SRQRYYXjYTFZSn2IxOZIoXLrByfcD_cPuUoJ9LSG0gUPNl8uXorfuJO2Rk4.6JS..CWwV0zl
 bH08bu28JPK79a6JfyvUCLZpkzw8YcGE4A6BBT2jXJf6NDzQRGx39mWvfXNqzz_NgO7yVpIglc.p
 xIF4k83TSDwrp7eCKn.af2MVR53pz47OGOy2vYmuISlagO8nwK50DSRNgZLx7SWpdsuvxTP1TsdR
 NIpkOToRzH5f6p0adfKBzFxrlJHwPry9Wryscy.1q91.ObXshMDO3_s8q.ZgrzWFZ4h2nTGXjWeq
 qqlyYkSwOUvE_4BsdIRvPbaZkKGEo9KCnB94SZ.jU84VVmn2BEZXhG5LCI5l5ZEQsyLjqmTsRDU6
 AqQF1A3HzQL5XMOIC.RqsKIFzSbLlXxEVLpULRd11YmY64iQN9RzVkiSgmUfjxc6_euvTNZF6Zc.
 2fXgkkfw48FQ6cvnoiFUUk30gLjh26Gi0amHlMMuX3VNf5vqXIRUsL9eOcHX0awpk3kN3EFtcw5d
 UkLCHWYyTgqNEBguInlHv8Bdty.dyaLKVTnX1tept2Txbr8.CWtUM0WFWeb1xMj2VP9lu31l0yvC
 zIJrhOtLzZfs1g0RsJ.HheJuK6SrzqtCEeyIYGd7JYn0.uLh.C0aU9yGMnFfrCSN3VZUf5tQynuf
 L33vFv4h_lTnZQSd9bZOfECbSMNMbjTW6JlcldNIVcYaO64nClIti2g1asqgpuurKqUZI3M5IBAB
 DDzQZku7woJsESxPzXSE7BuRytBOcZuFJdY1YLEKFPOMgiELsATDIsjK.gUFp1OtK1RTxNNKV5Vs
 HVWEyvgXU908R3fSzu78wDRhe0LyrcQkydXsk7FKBwLpby7IkOJTdarV_930MSiNuqadHw3c1ZlM
 xI5zr_2tAuISoTrkF74qGJavXq5MYexw1oV9VFrS8vIs6q_ZjriEI5qpp2djU2_Md9bzh5jJsvy4
 RKtw_TlMT0QaA_WRZ1EoJZ2oMLDJ90ktHGqXNfwV2HhgVJRjZ4UNWgzTKA7vnakvWts0j02bErXL
 7E7l1H9rmmgj4ECIQoYD_1EoTGpbZ8TougWb53yrWURfJYGwyNliUKKsoqWbhdXQIgo3Ltus8qC8
 2fBRSti93dBHB13tr1ffO2ZQ4Lgwh4wGGYDLxEbvjvzmeNO4MCHxm6cX8sEK.SmLQBeHz.33k_nW
 mLZVFYbIkyFPa72isGRHXHRIY1SjD4C_k9y4_JmH9BYZQvP7tqksvisdq.b_RFaGkbSCWMM.OWnh
 _DFJCAGc1RIRDZciw5f1kxJH5BWKxYXgdXT4xhdDavzCE3WGlzgU85dFCkEJJOUQOFZqJPuNOZHz
 3Vvzl0EQJzAW0RGXJ4ytJJaQYdDERNv2sq0q0_z1lI7Xp_9wQPd2fkUhbEZzTRhgbD72I9q4f1Ej
 OBs977X39AxPVeNDVDsmqIRUN_KQoKSDQu2MDzBes7j7Vr7IFIu8zkdba0HdXEHZK65o6moyfjUy
 V1DUEnhEov3zN_XJ.1S.6Hael8hQoAOV3XIueIrtP50YL3Gs8BuM02Tk8Mi0Q1hjVX32VlRCuhru
 8bKLBMc3MX1mgwSQME4RbMXPZ..ZI.blNmQ3TtCjV.ZmInReyRV87BZ3snyU3qQwQwouEqKTp_kU
 743myLvfO3XDq4F5wOMc7KKeZL_o6gtkJ.IJHypY2KyWXKBqIkQzfeZKRt99.EL5fJT95svj4DHt
 CZZx8OgQeSK355xoX_Unh
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 26 Jan 2022 17:36:54 +0000
Received: by kubenode525.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5ae23319dcf69f05dead9935fcced5bd;
          Wed, 26 Jan 2022 17:36:50 +0000 (UTC)
Message-ID: <80224b36-52ac-e43b-f26d-a160e2887e7f@schaufler-ca.com>
Date:   Wed, 26 Jan 2022 09:36:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Custom LSM: getting a null pointer dereference when trying to
 access a task security blob
Content-Language: en-US
To:     Denis Obrezkov <denisobrezkov@gmail.com>,
        linux-security-module@vger.kernel.org
References: <c4cbfdb3-f904-b587-d407-268650e6565d@gmail.com>
 <028166ec-0921-977e-8990-4134b5920cad@schaufler-ca.com>
 <882d62bb-1cc2-0019-cc8c-cdacea31e8d3@gmail.com>
 <15530231-a608-8299-7dd1-a8b0155e5e29@gmail.com>
 <82883631-9eb1-2660-afe3-e7308ef1ed45@schaufler-ca.com>
 <9db2a56a-2663-41bf-caf3-5fef2ef7c577@gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <9db2a56a-2663-41bf-caf3-5fef2ef7c577@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19615 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 1/24/2022 1:51 PM, Denis Obrezkov wrote:
>> I'm curious about the value provided by KeyLock.
>>
> disclaimer: it's mostly for educational purposes, a part of my phd studies.
>
> The main idea behind KeyLock is to be intuitive for an end-user. So, a
> user should be able to attach "lock" labels to files (objects). A file
> security context might look like: "label1(rw), label2(wx)"
> Also, a user should be able to attach "key" labels to tasks (subjects).
> So, the context of a task might look: "label5(r), label2(xt)"
>
> A subject will have access to an object if it has all the keys for all
> the locks:
>         Task (subj)     |     File (obj)         | Access provided
> -----------------------------------------------------------------------
>   lbl1(rw),lbl2(rx)     |    lbl1(rwx),lbl2(rwx) |  yes: r
>   lbl1(rw),lbl2(rwx)    |    lbl1(wx),lbl2(r)    |  no (see masks)
>   lbl1(rwx),lbl3(rwx)   |    lbl1(rwx),lbl2(rwx) |  no (no 'lbl2' key)
>
> As you can see, actions like r, w, x are also accounted. So, firstly, in
> order to provide access we should:
> 1. check that all "locks" have corresponding "keys"
> 2. logically summarize all permissions for each "key-lock" pair:
> from the first example above
> lbl1(rw) + lbl1(rwx) -> rw
> lbl2(rx) + lbl2(rwx) -> rx
> rw + rx -> r
>
> So, with that system we can get rig of a rules file. Also, there is a
> chance that it would be easier to use for non-IT people.

You may want to have a closer look at AppArmor before you go too much
further. One of the most significant usage issues with Smack and SELinux
is the curious relationship between filesystem objects and pathnames.
Your approach looks interesting as far as it goes, but to be useful
you might want to address the age old problem of what happens when
/etc/passwd is modified by copy+replace.

> P.S. I know that it is possible to do similar things in SMACK, but for
> educational purposes I decided to implement it in kernel code.

Smack and SELinux are designed to enforce policy on all objects.
There could well be a place for a system that has a different
approach.

> P.P.S. I tried to do it using SELinux and its policy languages but it
> was too complicated for me.

Yes, the granularity gremlins got hold of SELinux in about 2005 and
have never looked back. There are people who write policy, and who
say it's not hard, but all I can think is that their minds work differently
from mine. That, or they're just smarter than I.


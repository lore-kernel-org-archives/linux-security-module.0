Return-Path: <SRS0=sAtF=DP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC393C433DF
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Oct 2020 18:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 686A5221FE
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Oct 2020 18:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OQS+TMkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgJHSeD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 8 Oct 2020 14:34:03 -0400
Received: from sonic312-30.consmr.mail.ne1.yahoo.com ([66.163.191.211]:42812
        "EHLO sonic312-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728464AbgJHSeD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 8 Oct 2020 14:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602182042; bh=z92MucwcJqPgcO4LHUrzf8ue0NBnoaJYTWmPjutlOs0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=OQS+TMkWL6gEkJJB3UbsubRGQoe8n3c/P1w7MSI6gFcVTBmvi/HbqZf1Jb++ZV3jMyzC1AvJoD60cll0LcbZhPIEar2D2TH/GxTLV0LN+o4SvmK5jFa477vNLyrTK7WYcLK2dB7Q8+9kfDQHHyOmGb1Rr1UP7oaSB/yhLadRvmsUxp6zfV4m0iawcGXzxfce519LygqBxvhJoQ9DsazwN16wNIbQ2gMHX8XemxG8zzwSmSA0agd8pm7WQ1NaLzmQMmPW4hsdX0/7eNO05PnCGUUWZEJ0EdlE99TWci5RSBKOHmX1h1mlmOS/Z94vfG1yPXZEKn5g2echW/VYgJnwNw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602182042; bh=+HMECr5yX/6OmkGZa5mG3+2itF9dyGG/UwOumVH10E9=; h=Subject:To:From:Date; b=THhXPenJntiwld7X9wnMELZy39d8bZWA85CzBnDSa6NDtyOY1+14xzjx4okTAmfoQC0FFajiAKLhUdYL57FMrqEU+Nwg8Bp19qQNYGjaRZ+MZ+z2xmiBG6rzICeb6T4/+E6zeJnTY5Ih7nRA0zc4OqBShTwKSERMG1INXMeJKYmSs7cRNvrnqh1oPnwCgze5bx6KPviAH4PzmKPs6wcdA3fAnKg/beVvOEiZYJDUJr2S/pBgKbkKc1UwWLjvPBF5lenSSO3MsQUXxoFjAzwHDEr9SRr0DYEITNSk6A3NckuYrl/13KWvrWjEd0ulsTinOwzy6MSOxxXIiaotceBLQQ==
X-YMail-OSG: VjJZP8EVM1l2kjtUpu5rWIlEQJLsbaJlVD7oNjGa4DZyoBysAIcQMdGW_1MSSva
 oBiQaBjM3At9mwrImaxnUS5AiwnlaYaw3dzQHz26RPxiwFys0bzGGIMKAILUniSKDeDSRWn2bQ7i
 hbPfB.n5QhYizNLMdZ3RAqEmApU8bVJJUXteh_JJGTXg99_dKSxBtaVZ0nqGGYoxuXdgKsreDoRs
 7hD1UMByQCfToIzpeUrh4L_AJPr4Nn4q4Jm244PomhIrbtPgzBprdh_BsqRSmF2rfSccbqLjiDi4
 9PPoKAyZIxeCV8jN9qSsVZrFjOpZ5Kv61yKr2dIfhEPY9XOHcz2wqf1i96BXFfAT_KIAfr6rkxsN
 9BAESefORsFdu2lnm8eHRE5sYknahRxeMKcQ1c5xkHdqjs2soTbCtpUe4_YW4HeTU6qU4Iwz4BAQ
 9Ue_pIvwMocZBdLMXg_saUYuyKVtfQhLLniGeMeQPf3KTFkuJF1uIAZV5y2js4CS82bsTewfbZVG
 .ClDLYKTIAYr1G0iTFw6icb.OnnfJnnZtaihiGbtBafHykzP3SZ3T2PDHJSYAMHNas953UtcPGk0
 IoQCe1nX7SwG6g8vcwQr7V3ip_WH4BUna7xpEQX47HdYaPYi8iu14IxnNm4MuyYSNcG1qLk1CsM5
 XSSI252Zii56BqhzCMVMYV05buSqsrkKtjfGgzfHlHCGilg_6_ElOD.XGrb1sL8B_MltylBsBzu4
 qcbfPg9Wiu4IfAAA1wli5qJcyyyUQtL4EAqdop3CXzqcfvH7psthty3Rr5lUnK0CU1tYdHf89MA8
 sstDLrzinYYBqUnqZNB.yzoDm.hY6NXR5q52avKsJ1ctnrEVYZgeoRUE7YPaUGyP_yip27fMJOpH
 t.MUWfkrh4pvDCClOWGBwR6jl3cqXLcDjCfU2FH9hXLet7YhSwrihXMtIr4Yz5CbzyxeaWWKKMXa
 qqsNuz8Es4vC_.IEY2aC8MtFE14ItQOKiO_Tz5G0iM2JimVQFoTP3IV57IJ11OYefCYXfYSeeH5v
 _11410gxXiYKQk0xRKgzjq4AlgU5LkVwiq4fXH7xMzRkNYg4uAK9yV5_om7LeBzX_Oco1esakUMQ
 UsIGMECj42lfewE1a8kkweqoI81JPdow18QMplotOyc2jLFF1t8ny4Ewo5BhBtrcB.TFqRp0rjTk
 5Fyf8b1ZQ0k.3YmM00VcULM8mX3GPxIaIJBZbBpSG6YAL4sLbXw_bOsXJoKS.FNeMTb66ZtsjlsD
 KQZUDzOpHEZATJtGg0ORqCreP2.IB23Qwc_TVTyW6ELkCxdW7awc0ycWGv2cAYvvIvJbBDxl8YOL
 vQGeBrDNTmDvxImibccve6F9RynnpU1_sUOSwohb7ot3oaurq.fT_iRA8Ob9MZ.IAVLAZC3gx3gF
 NoFrYc7zjSCdC3hBQEXJRJo0oq2xhWl8SBq1EusXmI1TzTgyokmEgBZwqc1Mp8IC9FXtQEg4hS7H
 g.2DmsMDbXrlTUg0gmKEZPsxv_8_oK1J63eee2.IfHWXZE5fbruoUbXXZuqksL5DLaBKG3._Lb7D
 ZNm8c9CgtSNHxPpIJFLcQEUo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Thu, 8 Oct 2020 18:34:02 +0000
Received: by smtp418.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 13471fb92b616a7852c23a7e08d7e1d9;
          Thu, 08 Oct 2020 18:34:00 +0000 (UTC)
Subject: Re: selinux: how to query if selinux is enabled
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-security-module@vger.kernel.org
References: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
 <18b81f83-5fa2-12d1-1f0f-7933d2ecc6c4@schaufler-ca.com>
 <CAN-5tyEUUpLv5nzpfOZ-h-afsCTg8QLxpgnFqWhU0JsC5ZEFkw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <996b82e1-67d2-bc62-e6bf-afa1a1dd325e@schaufler-ca.com>
Date:   Thu, 8 Oct 2020 11:33:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAN-5tyEUUpLv5nzpfOZ-h-afsCTg8QLxpgnFqWhU0JsC5ZEFkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16795 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/8/2020 10:40 AM, Olga Kornievskaia wrote:
> On Thu, Oct 8, 2020 at 1:06 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 10/7/2020 5:40 PM, Olga Kornievskaia wrote:
>>> Hi folks,
>>>
>>> >From some linux kernel module, is it possible to query and find out
>>> whether or not selinux is currently enabled or not?
>> % cat /sys/kernel/security/lsm
>> capability,yamma,selinux
> Thank you Casey, but it's frowned upon to read files from within a
> kernel. I'm looking for a kernel api to use.

The list of active LSMs is lsm_names, exported in include/linux/lsm_hooks.h



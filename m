Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E04C433EF
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Nov 2021 01:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C0AB61881
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Nov 2021 01:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhKQBzn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Nov 2021 20:55:43 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:42793
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229791AbhKQBzl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Nov 2021 20:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637113963; bh=7IefSrs4sQ+/sdaDh3ZwbvI5TR9Vgjl8PNWbxAhUdn0=; h=Date:Subject:To:References:From:Cc:In-Reply-To:From:Subject:Reply-To; b=gq0ISQIq5OvUPBhaSWX7d8eM2nFRsN5mtJl1HAtaYR6vdPgBUGCasm6YlqNv2e/Ao6S8JY5p7pKBXzhTvOiywmGq1JjlgTKqXCvOU5WovOEUzqKu9kzoXM+avOUQtwthhXEuTa/QN/d1f7LMQsmsV/bhCUnG0fJb+tdW9pat/xJc6z8Xj/ip9n37a4JPjWvWbF09PXo8yqt+dz2GJXt1b/bnLe9x2HFburauadDwCodMTEa4ytxoYoo5Lid8EzV7eDaFi9/H1BM/r1Qe5EjddMP+Wk/xxcR9HC8QXWkV3JqD8YKXn41l6d1sq9h7FZ5uivSPnkPj+JdpW1hit+6buA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637113963; bh=vSg1qibxM29+5cVDqlZO9lRd3v7jB0ZahGBULmOR8nm=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=fHwtsx9AcB8GONF9zCWkiqaWhO4C5Q3pIJ14NtesZFZsaYgoMl5Cy3MGVW/f27Iq2l9v5fQvUM/nEAJlepX5giMUvkHkqDk2rTtu9SmzdvWFiCfytzGcAztmONjK4oCcUk+y3z1eGnBk9UFlbP7GKdrxljYop5DHbehTb/ErpM9KrBunEaB3UOWTkgOIJHbq7D3KXGnfZ2CBUEDvcIKV7+ic55DslMj8/Dcow406iiPvExUHXnlzdlF5/cbzr9oYKhPqywBm8iUS4PDP+WxEEsjHsqGtgYBOB9hHNKgTmZp5v8FcQ+t8vc9GH192OBDlmlwAHe11fha2hLaonZCl/Q==
X-YMail-OSG: qCkvN_MVM1kY1ry9Kx7GLdmU75SqUIsuRS7hUOSNd1lqewUYXgK_erBQJ1V6h.8
 .hRRYE5X.x237GZWk3Ld_o2fP2oj4KCQhQ7zJ4cQQRy.DI_A0.kVI0V109yngVsk0EK1ZDUL96GG
 BZmREgQukGhXU7QCeRSaLjlyjHCQYZLldB5dwYvB_aPSWLAMsAhEJEhOPLlQqV2dUjXAyzxYm2OH
 Oc8R2oZEwZM6xKQgZ9FJZeeo_3y..6HPSpqkOfx_h8ay2Sd9NacpJ6L44u3tWpvLsFAvgTqBX5uq
 5vE6nXNCHQOxT2L2RjavZ2uV_KnkWtegzsvbdFoJgLHLNjV3JvUKivEKpmRDw6LPv8EI3H9MJPG_
 BjDiAJ6swZkYV6Jn2_EoCjq_7RE8v.2noqSwTI8YDxxS3RuD16QJlIUk49Vol2aC6NU3U7I1ZglZ
 hdzloCI7y_Q509iql.ASGUl5lcdxO9aGpuzLPQ1KoExRJilZRW5bB86SgIKPlAOoIu9DS4TItM_C
 g2KqDlDWgF7ZW1NcneCDoEaq.v2kdnFmQeMeAcSEh4HP73AlXnSv6Jb.cVijYlhubvAyjPeShGpY
 PiEWFEBCKfkRxGXHIP6G6vyil0fiIbZ8UPw1PMthsJzOihB0pbxGoxA3IfEDYOMrl.I1evNTUdbL
 5LmSz9lm502O0Kat3ja6MKeb6YhJK_F3awejO3BX2Ri1WW78Kd.MfDxSL2qS3yCwBWFRy3n7Md9M
 IEWvRfDmX9fgxJ52HBa2qnIyYyVWHijvWBc9jL6UG60YHolZGn2qS1nRiDjnIu7Q.24VW8_b3bhL
 Yya_U8SzTCer0tI4WL278TYsdTgXB0eqFrtJdxk.3A81SUexlbJR8zkR8vv37kfNUR0ZcOLJqZjE
 woT.VOy.u_BmvKWAYetXm_3IKxDjwPSKOqhujlSYJHkax1hik.ZASVHkPd2ZHF69s1t_EKxg.eI7
 IOAiLAPmJyDv1wwG_Xa85cslZYoVg_d_zGf219AIuIUpyuphnGeNcNz5IW6pjAU2fbLbPSIgN56M
 vuIoRp7ToYgL6c0ndVCG8g5jmOThr6U8GATw0n0I7XBFZ69N7XsROY3TkSHkAoOfxzfRzqURTq_z
 wDivhnOwsJe5FkHjvDfHFMZZocbxRVeOsGR5nH1mAnUgFq6Prt5Y1NKdlyGQMu9BBZlAGQv5wQ8N
 BmOGNyrtnmc_c4OBDtOU7U5HiaEIAURyondkO7XC2kryULxBza5hDkrYdpccwJe2ahvKK3sG7yeA
 tZc2Ep_ioUasGukmt_1I9dYt5wVJNh09Wa26g3i7fvKxwoPd1XJ1KPEsDGIDmLPNvE0nWw7_qL0b
 14s8SQkjw4tExjC8NWUwsngXHbbNl7k5mSsZVMeHEC4J4N5QLvvTq659H_PKIRbYHIvFIEtQBe5J
 DEyHt1._B_CK9_kmv_G6_n9N0IzRhUY9V1_BZDp4pxH31UG6hmOGkgTaievBYHtZzuWGDU8fxSPX
 ZfL7DrPDgHjDU.YsUcT2oB5fRyJWmAKSTGCNJLkoLHOhllfImWVr81uDioXykWUWKQ.9dFELMKxi
 8R4WZIACDekPBMKNaX5lOwORMCjrazJ_g7j5MOg4KfKos1eQQdOm6nH4AHux7O6dFShtx20rS0Rp
 vYiSUBAdvUkQkNKLHZ9Wsppch7cek7Xtf.f5JE.YxqRofA4ZD8VmBCkj6WpLXq_XDz7e5xjdI.fg
 KBAZaziy4T0K1MlXKH1sEY0SFiK8yu7h_wqHpAV66JWh_Mgu2uCZbRdVOWSWJHz6VsJ8YH7ubVKH
 KcTquCRfLwDZ8j.VhXPeWxJWaoDhqEPLxKeIfl30pTi0k6UogwiCduMja28fKsCZhmWNbaru4k9h
 iaHp5ScN7yEXJjd9W9MqhCDiz14pNndUz4kaNyAXCoEbrK4W30CLsYc.KTmIFN0GfT_dImsqIy5f
 eVvRLAXGXFJEEx0xcjGMoUvok2Fx4DOf4T2Ysp81GEUmrgOwFdKzk5Uww5_gEDsn7y0gSlM6t8Oo
 h_KNkI9z2sh9xxftSiJZN49wHNp9IkUmVUaiuV8j.3lv1gI7x1tGFdM6gVfoLvXtuANrRyUviQpX
 tJkyb0_nYpDzK8usAfxW4fGoiFkXBKl6HztbjdLtivFyKpNYLDYRM4yX_N6qLG2WQw6ijhdiDLsF
 TPOR9gD7O6.YnHjjXrOoSAZxWq2ntSx8bgL6A.vHknT.qOhiwTfge0P3CHRWKnxDH3yaC6pcEJ4h
 elMjkUBt_3mPHbPmMeQhHsfFKRw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 17 Nov 2021 01:52:43 +0000
Received: by kubenode550.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID ab6e3596d8a773ce225187d1bb9f9cc9;
          Wed, 17 Nov 2021 01:52:41 +0000 (UTC)
Message-ID: <bfcea6fa-4f13-8499-49ed-6cc690b6fb67@schaufler-ca.com>
Date:   Tue, 16 Nov 2021 17:52:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: SMACK: access is granted while smack-utils report that it
 shouldn't be
Content-Language: en-US
To:     Denis Obrezkov <denisobrezkov@gmail.com>,
        linux-security-module@vger.kernel.org
References: <3b0bd664-fbb5-0182-bc3a-89058dafc164@gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <3b0bd664-fbb5-0182-bc3a-89058dafc164@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19306 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/16/2021 5:18 PM, Denis Obrezkov wrote:
> Hi,
>
> I installed smack (enabled it in the kernel and installed smack-utils)
> in my Linux From Scratch distro. I am trying to regulate access with it
> but access is always granted.
>
> I created a file and installed the labels (with attr -S -s ...), they
> were attached:
>
> echo "foobar text" > foobar
>
> # attr -S -g SMACK64 foobar
> Attribute "SMACK64" had a 8 byte value for foobar:
> objlabel
>
> # attr -S -g SMACK64EXEC /bin/cat
> Attribute "SMACK64EXEC" had a 9 byte value for /bin/cat:
> subjlabel
>
> I wrote simple rules, reading is forbidden:
>
> echo subjlabel objlabel -w--- > /sys/fs/smackfs/load2
> # smackaccess subjlabel objlabel w
> 1
> # smackaccess subjlabel objlabel r
> 0
>
> but when I try to read the file I succeed:
>
> # cat foobar
> foobar text
>
> And the relevant output in dmesg shows that the access was granted:
>
> [ 4341.952360] audit: type=1400 audit(1637110820.839:108): lsm=SMACK
> fn=smack_inode_permission action=granted subject="subjlabel"
> object="objlabel" requested=r pid=427 comm="cat" name="foobar"
> dev="sda1" ino=820571
> [ 4341.955501] audit: type=1400 audit(1637110820.839:109): lsm=SMACK
> fn=smack_file_open action=granted subject="subjlabel" object="objlabel"
> requested=r pid=427 comm="cat" path="/root/foobar" dev="sda1" ino=820571
> [ 4341.958411] audit: type=1400 audit(1637110820.839:110): lsm=SMACK
> fn=smack_inode_getattr action=granted subject="subjlabel"
> object="objlabel" requested=r pid=427 comm="cat" path="/root/foobar"
> dev="sda1" ino=820571
>
> What can be the problem?

Smack is integrated with the Linux privilege model.
Smack policy can be modified by a process that possesses
CAP_MAC_ADMIN. This includes setting labels on files,
changing its own process label and creating Smack access
rules. Smack access policy can be violated by a process
that possesses CAP_MAC_OVERRIDE. Today's Linux distributions
give root processes all capabilities, including these two.

Your problem is that you are running as root.

You can restrict CAP_MAC_ADMIN and CAP_MAC_OVERRIDE to
processes running with specific Smack labels using the
onlycap feature. I suggest that you defer playing with
that for the time being as it is quite easy to create
non-functional systems using onlycap.

You may find the Tizen documentation helpful:

	https://wiki.tizen.org/Security:TizenSmackReferencePolicy


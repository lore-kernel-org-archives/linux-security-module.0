Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F039C433E0
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Feb 2021 22:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5488364E07
	for <linux-security-module@archiver.kernel.org>; Mon, 22 Feb 2021 22:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhBVWrV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Feb 2021 17:47:21 -0500
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:38305
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232216AbhBVWrR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Feb 2021 17:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614033991; bh=VyyoXVNXtgndS7QD+W4lojP5Q/wvztcmosFU2dHEISU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=e1yKXTAK92z4lTFKaAOZEDC6rKjN2Go/UdqesZC4rxswVk+m6g3BZdhMtn2/UG4b9bULSrS3RR9GYH32GAb8HgTolNz4XVz8PMNGWtNBkMT6vggq6+/e5M/P0DfQSmq+fZLPPp4HuYN3f8XBxRTA7XT2tyW//MG0NHvNv/Oa/Kz9ZkI95VrZtPooH6lS1xwL4LCMs/7Ny313FG3P9fpvVKvtLqFauaswJBFcFpQTohPnrD0jaKJyhj/Tynjz/xMdvbrfzxFYS//VSJ4QxFr/ZTJE5sEHWmDPkX6R5zctD22fPtMysP8SMSCAvuZNvAQZtU2aJnt7FGit/dm9pLbvrg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1614033991; bh=qVzK+RH++QZctQ+yB0m6+S6pvKZ4d8XGacp7CYnN4Ja=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=QWgjl1B0dHk/FPegz2U7yzhQMCNEg9sLo1ybg8EkZPXSEVWfD9YNQhsoQ3Qbh3ZkG1LMYxi5+GryVOdpOK3qPcjSfIuI5NeTUAbncQqiiSsWUPh1wOUj65y1nMH0ZpbsvX7si+UslqiElvvJCpMDnsdJypTckHLiOErXzOLjq1ba2eHNKwH4+McfI/4ErXzm+8sNu3CoVpWcHUo5lFtbo813Jrs4QWtbjeFyWXeQ76Rh2UA+uddFQFnVDKv6dh2GWDUlmWU0MLqqdPWIAR5UvxbYRdBAnBY6vZMX3zk7r8XggOqMrmRtZtmv+sh1bHQR5OKf41h3AyeH0V6rO2+SBA==
X-YMail-OSG: JGZ6DqQVM1kPykpCK8IQJX5PaMQ42lj8qgXIODxSojGgzIneSDdRRguMOCCcvwo
 ccrKoHh_GNlrDNggHM9JnZb_MJ0Ac8iyDT6jtqKaOKaHsbQhLRI1QX13o1oe7PVUAkzFQcNcqWos
 fKZ._NRKsuOXUtSx5RmJlhxi63pY58Hkd20stSKqt7kC1XsnhmMypZ_M1Ssc4p5DuXOwY41aSo9T
 i4EjyK2xlTkU6GB_.HPeU79y1vpbqH5Dm8R_pIRgPlHtyPQuim4JZYnPQKgQd3RVqtal9nUZTJl1
 y2.gdsWYZkaxlBdzPzsb8CnlNtncyfkF0iqiLOLUUdVJXOWXoiE.B3WO7o51ENhXyIh5WxAn2pOo
 x9L.J3jjsBEh1JTrWk8fGUyMWtN1fc6ht2rx_NBcGwv85fye.75kedq43UaVeTzbzXTH7mCwvsa8
 ks63A_Qr6Jx1zM_uWYDket7gW.2PmDGeFaYhPBHtGYCFYXn.b0RMJesrxUM5ybElFMtmzkmZys57
 6TRmI2h209MzoNZBh8Ke_AzQpJVkIi_7bCuFy3gzGYSZ8.J_4rex.vSJxDJcQDF_EWAThguAmovj
 ZjggvUaPEO.RLnXGtCWtXgFl6gxB5RR.wEFByqiDYdMr0cBfL_Qq5Xh4UDbYdW33rwZ3z1CFx6Sg
 .M0O92d_mFF18U2vJ_Ulz2kddg4fdLlvL1HmYrkHzsO_eAGw_ZFA_T2LDSaF41gJnhsBPyrrHrzK
 xfM8OzFVfd8__E1VI6.J26NSwg8vmeJ0f9fO0bCgJaJzW7oImKUGl9bQzAfm39.1cQzqTsGQf9nd
 xpi_PpgibI5YZQOOHzV9cKNicjyoWV36xCcdgB.TCbaUNPh_6X.3nrI4vjY8TmOo118HWsg2fVw4
 33m4t9hM7XDE8aZVe.OvrqWVFdc625QmmO_bmsO7cxSc2XccR4z8Rg9Vm0OZfd1wd7XEJQvaDkp6
 V0oCwzQRPAez_zpBgZteNBMQh7J8isWnoY13pA2XWDOp9pIWHgwXvIF0xYkRxx8X_MWxYGfRvMNy
 gZuweox7T37w3zMbbfNAm3tUJK.Mq66rEmvGY7ABVRaqwZa20F4Q3YpnzXs9TpW7NrRfpwQqkOHA
 SdOPWxLy7YOO6eTHUWsWfPwC5rklPjvrhAAS0qzprLShwxHhKQ53Dcfbt4qxf3aU0mK2QqMu8yic
 ZMl0DkQR9jfXRbnoVR6SvcnXAexab79aqpKzeC47.EW7Je.A6w.nsViSbJszP6IZlJuaNFeqiZdr
 BsROrF650Mk2M7T7IlrXWbgWjwtRprgv9Q6hFNFJXhhuMF5Tue2_cM2mT62PcjQJJMyXKdE4Y4Z9
 krEn0fl10uBHODjpYSbxBDXymHCs0zkQkxlLso3n31jgVSkOoa5gZh.szqL9QWrUAO.EFNNDvIbB
 GuZY13K2ESUURRaSp0OrdOOUJvLXJp0O1OGHvNkahOwDXjMe_uJ6xREVblfhtuhDCLP728oQEkFm
 i97QoyUW4bjHSScBwL.LyGwXR5DmsnQNDWcQ4Y2_4ECRcfe.Z01n9JjU92XzAsjHz1SKkXXOV6lL
 XdhqEGVJ.FB8flUwphkarUaowQ9W0T446VD.mTfK_1O_rsdcs2KLztF07VtkgMWFfUBZZdRvVITi
 OnPRIMjde.IEw0uoNoNZaoNu933qsIBap1D8m2kbKhoKSBo_dlHxnj1lzyFaZQjDs0x_8gc6NyNB
 tEyOl0w3vYOIz7oVQOekPpkly95.5sj6Ys9ojr95EbgpShdBPvhAk2fPnhEs7fqjIvYaBokGN0so
 .UeHOTZrv9qQcJY_G_yHmY6hn0mEH4QANo19M8pEsNXbf4YHs7C3cTT09dt.eGF9WatIL8D6YrnI
 z26kTBI8qqSKF.EaP902VbYo7_wldow3a.Gqp2Foxy5P1wxQBm_EV_Dd2YKX6zWwQkhGch.lCUzg
 GJljtMGXLkTkZvckohu_.RDrmBM73BFuHEElbDe9gHnFatYM1QZAQUNIRGdJrtswijgmKMcZp1jE
 Rocl.Ky5krgzsaUT5K_qk1V2MTfiHmuJv63XolEAhzZkAWHnBeP_ZUKPKuBaup1n5lSiCgxLd9ia
 L5pEtp6j5C1dUPnuBbLAzssZ.dvypQHYlydsghfKRAvy3vsBqFvkA1yKnXtgnxPfNNYb.eEQlxq6
 ylskSYDK0p972GKf.viDom3oKH.Mq..C0JBzaH7Yrj4LrPA4lcs25hVwr8L2ZoO9cj7MRA4v2Cra
 ecY4rKj0aeSJPE75n_tul6jEOpQ4IYffRLmJWz9PRNg4C76aZTJZCWpTnGMu60bZOMhQ4uffOQSh
 eYxSbjaXvC_RBips7atOwhePrtzgHAdTEnhtOSM4_ZNhNHMdAud3yTs9kXaG8q_L.UwFK.VqQmMW
 BY6gKQvD0sQwdKpaRzgLKU43twlkj_by7EsY6UVM_ykmqfWCbkEVkjfM_3LVB02SEkU1yuaIyb3D
 K5APQ7O3n9KyUKjQMwA2CshmRLlcVHE60b.FMfKP_yA6BqIqifHQ5Mfe9hukXOQ1TagMiVydjr5B
 fbytvGLCPAimy1HvtXJbwRzcCkJsOjqVGmAyMQ3RUnL9J2voaDYJFz5Pjyi0UVXkI1Huy42cPn_T
 PHzu4GLVX_xkAK2XCX00Z4_9m3mnOAO4zMOp0ka2sehx.SziFbDXfpscQtxq.NLcq18QFm.kwNmp
 i3bFBU7qefbGJRQaP_4wZNsr3MohaCqtGEzJHe5ei5vhxI_XrSbkv1EYHd305APg8eAsTrxxGGsx
 _NEHxlLzhbI3UTMqhEDhSnq_DAATrnQqKTIU8oMC396udiB4wwmML3kYw.kZUKP9ozP5J4PpXVYa
 8F5IUqAuTco0OdhB.xnR6co8RbgypkyJBIr3_pwBkStwjoKLBmKMUKdhsDcOj6WhuIoN69kOfp68
 5O076T1A7r6iXj6Z6SEKIWYfpGYpNtRxZeDJqsPUo_PVAsEH9ghVReX_R3odDoQufRgwv0oKD7sG
 uvCmVsaLUMEclUfKL3yGwcPX0YfHhsLALxzNpGfm.mNU1QhMMlPXmc9rcIy91E3WiRmGDknmLuEq
 z9Pdu1rayGDO_gnQsR9Sh1ln29jG.zO7v.U.a
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Feb 2021 22:46:31 +0000
Received: by smtp409.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 89f52efd02cdc1d669262f83d5bc412c;
          Mon, 22 Feb 2021 22:46:25 +0000 (UTC)
Subject: Re: [PATCH v3 1/1] security: Add CONFIG_LSM_AUTO to handle default
 LSM stack ordering
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210222150608.808146-1-mic@digikod.net>
 <20210222150608.808146-2-mic@digikod.net>
 <51725b44-bc40-0205-8583-285d3b35b5ca@schaufler-ca.com>
 <ee461f8d-a02d-0782-8f31-691853a57f00@digikod.net>
 <7b67163a-9de1-313f-5b5a-8c720cef9b73@schaufler-ca.com>
 <CAJfZ7=n5FOxHXMLRrDQ3F-kDqbYngNoYKcz6_PWi1rPa0_8WpA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3b97e25b-303c-d732-3e5d-f1b1a446e090@schaufler-ca.com>
Date:   Mon, 22 Feb 2021 14:46:24 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=n5FOxHXMLRrDQ3F-kDqbYngNoYKcz6_PWi1rPa0_8WpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17712 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 2/22/2021 1:12 PM, Nicolas Iooss wrote:
> On Mon, Feb 22, 2021 at 9:32 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> On 2/22/2021 10:31 AM, Micka=C3=ABl Sala=C3=BCn wrote:
>>> On 22/02/2021 17:51, Casey Schaufler wrote:
>>>> On 2/22/2021 7:06 AM, Micka=C3=ABl Sala=C3=BCn wrote:
>>>>> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>>>>>
>>>>> Add a new option CONFIG_LSM_AUTO to enable users to delegate defaul=
t LSM
>>>>> stacking order to kernel developers.  This enable to keep a consist=
ent
>>>>> order of enabled LSM when changing the LSM selection, especially wh=
en a
>>>>> new LSM is added to the kernel.
>>>> TL;DR - NAK
>>>>
>>>> Do you think that we might have considered this when stacking was
>>>> introduced?
>>> I didn't dig the detailed history of LSM stacking, but you are in Cc
>>> because I know that you know. I may have though that the main goal of=

>>> the current LSM stacking implementation was to enable to stack existi=
ng
>>> LSMs, which works well with this CONFIG_LSM list, but doesn't work as=

>>> well for new LSMs.
>> It works just fine for new LSMs if you treat them as significant
>> features which may have significant impact on the behavior of the
>> system.
>>
>>>> Did you even consider the implications before sending
>>>> the patch?
>>> Yes, and it doesn't change much the current behavior without user
>>> interaction. However, it gives the choice to users to choose how they=

>>> want their configuration to evolve.
>> Automatic inclusions of new LSMs would be counter to existing practice=
=2E
>> It won't work for "major" LSMs.
>>
>>
>>>> This only makes any sense if you want to compile in
>>>> AppArmor and/or Smack but always use SELinux. The existing Kconfig
>>>> model handles that perfectly well.
>>> This patch series doesn't change this behavior if the user doesn't wa=
nt
>>> it to change.
>> Well, there's the question. If a distribution/system uses the new sche=
me
>> "users" are going to get new LSMs spontaniously. If they don't it's up=
 to
>> the "user". Unsophisticated users won't want this, and the others don'=
t
>> need it.
> Hello, sorry if I missed something simple but I did not understand
> what "Automatic inclusions of new LSMs " and "get new LSMs
> spontaniously" is about. If I understood the kernel practice
> development correctly, when a new LSM will be included, it will have a
> dedicated "config SECURITY_MYNEWLSM" which will be default to "n" in
> order to respect the "principle of least astonishment". How could such
> a new LSM be automatically/spontaneously added to the LSM list?

It wouldn't. But compiling the new LSM mynewlsm doesn't add it to
the list, either. Today no one should expect a LSM to be active if
it hasn't been added to the CONFIG_LSM list. The proposed addition
of CONFIG_LSM_AUTO would change that. "make oldconfig" would add
security modules that are built to the list. This is unnecessary
since whoever changed CONFIG_SECURITY_MYNEWLSM to "y" could easily
have added it to CONFIG_LSM. In the right place.

> I understand that this is a tough issue and that the subject might
> have been discussed a few years ago, and if that's the case, it would
> be nice to have pointers to some clear documentation or past emails
> (and it would be very very nice if the kernel documentation was
> updated to document the current state of LSM stacking:

I'm not going to argue against that.

>  for example
> https://www.kernel.org/doc/html/v5.11/admin-guide/LSM/index.html still
> documents the "security=3D" kernel parameter even though it conflicts
> with CONFIG_LSM and can be ignored by the kernel in practise).

You can still select one "major" module using security=3D if you
don't use lsm=3D to specify a full list. We put real effort into
being backward compatible.=20

>
> Thanks,
> Nicolas
>


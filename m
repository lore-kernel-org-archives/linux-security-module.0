Return-Path: <SRS0=m0b+=VP=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F082C7618F
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jul 2019 16:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3923321019
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Jul 2019 16:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="paZC9tzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfGRQN4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:13:56 -0400
Received: from sonic309-22.consmr.mail.bf2.yahoo.com ([74.6.129.196]:45365
        "EHLO sonic309-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726649AbfGRQN4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Jul 2019 12:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1563466433; bh=veM2Wty6bms3qHsY/G8yEreQO4dE4sT6ZXj2x9ntes8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=paZC9tzACLwGiyZvRG8mdVPDSZ5lvpmGjS60Nrm7TLgNWypQgKPb78+zyeOVU9BL4urXnBWaFMHDv+1Gm5lqqyqLKJm4VuCynOPm9yrP403mnzoc2WRc9KRZwabAb0v3acH/FcFsPAm8DGNiHRpNUtWxOF8C7yEuSIXCz5bHHh13kG7RR8Fhykpfzo6MNdHBfFymkGcdU1ucJhc9h26UDe+IWd/BSbzGSpcjWd8MSIO4Fng1nDnWY61fxEplroHSEcaiH9fMjYfaaO62x/UWTyTgBm0F8FLnoT5n8VD0X07UgarqvW8a/IRUs4zBaLBfCSYzM7wJ7dLQQRVpLJUxpg==
X-YMail-OSG: GAp1KmYVM1ngRheXpZEmepvhVtcB0xvshk6osptSfeKUXsnUK5jFXcMTRz7seB6
 Xo5janrGZTch4RDwKH03NF94_XkAVrq3n_DMnNj.MpojIZ91CD4sOfX0MKa6AGIHCdVK7Ww468R5
 _19cl4jqL8MvXbngca7YF5Zr3_Wr3nyim4ioTRDUCE3yaO.lKo00zPWLuZvgP1y0zs5d6sATUYXv
 UGTFb90uS1oxyl78o_tdRamdKPfoj6L0z14fvj9fFjKBop2ebOdyohsQs0xu.zhlNbQxBDpOAmfI
 AojqIsB3Nd.r4mFujuQ0Prp6mZXTy.Noo6Ze5XB3_VaGnS8EuozdwB6JWOjrndXyBR6Leh7xCFnq
 RHfj4TkDdDkAzT5HXL_p2U09k7q9UjUZi5lOPC3Jgf5oFKPuZjJC2Yqvaf8arZo8Zc1U5clz7dBd
 oyXWkJ3yacH_tQhN1i6H1u5lKdAIMKw5vQCipfLf2bhbfHVg8YGhmLjYnEwST6jMoZgsucNyhA34
 Wb4DZtClW8r6Meh1Z6AgZ9DEnDRlyanjLP2rKV3xrS7c7ehVTCJfCf8slYpxHPxkruMYMUlW3MZ7
 G7DnTOqnVV.sY4vdj6SUEYKlBy3wYCSAVwzymPZL_ufK84LwE2CdcNQqqPDW3GhDzvFvjNcM1g.E
 fDsGXCQI8l5LfjaEpDREl8DI5TbH4TcQTIIcq4le5ND40tkpU_PiK._t_rHNjQwEDrZcqegsr554
 Q6MliW29RGeija_X84XnthbxzBASYAixSIGLPq.p4pV2hCShM5GQ9_Abtx0MXY01fRP6o6y2u8oA
 cXwBxs5YoGBDJfsi9vohNZsa7Im7n.5RiS64SwCcYn5EvAR_.tjnLjHj8CLWHYoOIw711Uiwa3jE
 3BAdeDwyuG0LGTZP9ym.Pm71mAxh9_7MWlX50RoxGrjqLEp.DOgUhU77EYUcq7COWPU.bntxfVz9
 mDrrdZIz4zVNHjuReNGkD6S9hPkYS9EVQqCvbfMfjN3MpzQwxmCpgZ77kiPhdklR1Mc.gBDpVohE
 TbWa26p4gZrHC1Qyt1zWB0KVA8XMiUcT9DVTz3v2zvzi5LeBZIHSrl3XRK85vLS_7kebs5mDoMLk
 DuvlohRmvGiI8km6HKldalX7h3Uvk4dmr4NPiGSAuHsTdkieghO1v2G3LeqWiB7tHTTaQ45UP.uL
 zzgO_Gz85lm5092fDDJ4VVj.wytE9t9ktH2hyDSAw5d95NQgyKRoPexYbe.9U3RpWMuUw.Ewtr0P
 3JtMb_.piVw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Thu, 18 Jul 2019 16:13:53 +0000
Received: by smtp423.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d37e8aeadaf09fd9c9f0e8436fe50686;
          Thu, 18 Jul 2019 16:13:53 +0000 (UTC)
Subject: Re: Preferred subj= with multiple LSMs
To:     Simon McVittie <smcv@collabora.com>
Cc:     Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, casey@schaufler-ca.com
References: <d1a237d3-4b72-48b0-27d6-fb168354ad31@schaufler-ca.com>
 <CAHC9VhTQLihNQ1iGjJB=LAn=C6BQokFsjsRcj8O_O9AjqQ7HBg@mail.gmail.com>
 <2517266.eHZzEmjMsX@x2>
 <27e2c710-efe6-d9cd-d4f9-bc217df5ede3@schaufler-ca.com>
 <CAHC9VhTpcnyGg5j3b6Z7Yi0Ob01JETRiBmz1AuLqPWqP9tEAnA@mail.gmail.com>
 <5ea2a25b-364f-3c30-79c6-cfb18515d7ba@schaufler-ca.com>
 <CAHC9VhQ9MSh5zCkhMja4r9j0RT952LwKSaG5dR-BqXzXrtEAUw@mail.gmail.com>
 <e9cf875a-0d0f-a56f-71dd-c22c67bdcc2d@schaufler-ca.com>
 <CAHC9VhQS9We1TNqRfuR_E-kV4aZddx9euaiv5Gzd5B5AkiDAUQ@mail.gmail.com>
 <f375c23c-29e6-dc98-d71c-328db91117bc@schaufler-ca.com>
 <20190718131034.GA12581@horizon>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 mQINBFzV9HABEAC/mmv3jeJyF7lR7QhILYg1+PeBLIMZv7KCzBSc/4ZZipoWdmr77Lel/RxQ
 1PrNx0UaM5r6Hj9lJmJ9eg4s/TUBSP67mTx+tsZ1RhG78/WFf9aBe8MSXxY5cu7IUwo0J/CG
 vdSqACKyYPV5eoTJmnMxalu8/oVUHyPnKF3eMGgE0mKOFBUMsb2pLS/enE4QyxhcZ26jeeS6
 3BaqDl1aTXGowM5BHyn7s9LEU38x/y2ffdqBjd3au2YOlvZ+XUkzoclSVfSR29bomZVVyhMB
 h1jTmX4Ac9QjpwsxihT8KNGvOM5CeCjQyWcW/g8LfWTzOVF9lzbx6IfEZDDoDem4+ZiPsAXC
 SWKBKil3npdbgb8MARPes2DpuhVm8yfkJEQQmuLYv8GPiJbwHQVLZGQAPBZSAc7IidD2zbf9
 XAw1/SJGe1poxOMfuSBsfKxv9ba2i8hUR+PH7gWwkMQaQ97B1yXYxVEkpG8Y4MfE5Vd3bjJU
 kvQ/tOBUCw5zwyIRC9+7zr1zYi/3hk+OG8OryZ5kpILBNCo+aePeAJ44znrySarUqS69tuXd
 a3lMPHUJJpUpIwSKQ5UuYYkWlWwENEWSefpakFAIwY4YIBkzoJ/t+XJHE1HTaJnRk6SWpeDf
 CreF3+LouP4njyeLEjVIMzaEpwROsw++BX5i5vTXJB+4UApTAQARAQABtChDYXNleSBTY2hh
 dWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+iQJUBBMBCAA+FiEEC+9tH1YyUwIQzUIe
 OKUVfIxDyBEFAlzV9HACGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOKUV
 fIxDyBG6ag/6AiRl8yof47YOEVHlrmewbpnlBTaYNfJ5cZflNRKRX6t4bp1B2YV1whlDTpiL
 vNOwFkh+ZE0eI5M4x8Gw2Oiok+4Q5liA9PHTozQYF+Ia+qdL5EehfbLGoEBqklpGvG3h8JsO
 7SvONJuFDgvab/U/UriDYycJwzwKZuhVtK9EMpnTtUDyP3DY+Q8h7MWsniNBLVXnh4yBIEJg
 SSgDn3COpZoFTPGKE+rIzioo/GJe8CTa2g+ZggJiY/myWTS3quG0FMvwvNYvZ4I2g6uxSl7n
 bZVqAZgqwoTAv1HSXIAn9muwZUJL03qo25PFi2gQmX15BgJKQcV5RL0GHFHRThDS3IyadOgK
 P2j78P8SddTN73EmsG5OoyzwZAxXfck9A512BfVESqapHurRu2qvMoUkQaW/2yCeRQwGTsFj
 /rr0lnOBkyC6wCmPSKXe3dT2mnD5KnCkjn7KxLqexKt4itGjJz4/ynD/qh+gL7IPbifrQtVH
 JI7cr0fI6Tl8V6efurk5RjtELsAlSR6fKV7hClfeDEgLpigHXGyVOsynXLr59uE+g/+InVic
 jKueTq7LzFd0BiduXGO5HbGyRKw4MG5DNQvC//85EWmFUnDlD3WHz7Hicg95D+2IjD2ZVXJy
 x3LTfKWdC8bU8am1fi+d6tVEFAe/KbUfe+stXkgmfB7pxqW5Ag0EXNX0cAEQAPIEYtPebJzT
 wHpKLu1/j4jQcke06Kmu5RNuj1pEje7kX5IKzQSs+CPH0NbSNGvrA4dNGcuDUTNHgb5Be9hF
 zVqRCEvF2j7BFbrGe9jqMBWHuWheQM8RRoa2UMwQ704mRvKr4sNPh01nKT52ASbWpBPYG3/t
 WbYaqfgtRmCxBnqdOx5mBJIBh9Q38i63DjQgdNcsTx2qS7HFuFyNef5LCf3jogcbmZGxG/b7
 yF4OwmGsVc8ufvlKo5A9Wm+tnRjLr/9Mn9vl5Xa/tQDoPxz26+aWz7j1in7UFzAarcvqzsdM
 Em6S7uT+qy5jcqyuipuenDKYF/yNOVSNnsiFyQTFqCPCpFihOnuaWqfmdeUOQHCSo8fD4aRF
 emsuxqcsq0Jp2ODq73DOTsdFxX2ESXYoFt3Oy7QmIxeEgiHBzdKU2bruIB5OVaZ4zWF+jusM
 Uh+jh+44w9DZkDNjxRAA5CxPlmBIn1OOYt1tsphrHg1cH1fDLK/pDjsJZkiH8EIjhckOtGSb
 aoUUMMJ85nVhN1EbU/A3DkWCVFEA//Vu1+BckbSbJKE7Hl6WdW19BXOZ7v3jo1q6lWwcFYth
 esJfk3ZPPJXuBokrFH8kqnEQ9W2QgrjDX3et2WwZFLOoOCItWxT0/1QO4ikcef/E7HXQf/ij
 Dxf9HG2o5hOlMIAkJq/uLNMvABEBAAGJAjwEGAEIACYWIQQL720fVjJTAhDNQh44pRV8jEPI
 EQUCXNX0cAIbDAUJEswDAAAKCRA4pRV8jEPIEWkzEACKFUnpp+wIVHpckMfBqN8BE5dUbWJc
 GyQ7wXWajLtlPdw1nNw0Wrv+ob2RCT7qQlUo6GRLcvj9Fn5tR4hBvR6D3m8aR0AGHbcC62cq
 I7LjaSDP5j/em4oVL2SMgNTrXgE2w33JMGjAx9oBzkxmKUqprhJomPwmfDHMJ0t7y39Da724
 oLPTkQDpJL1kuraM9TC5NyLe1+MyIxqM/8NujoJbWeQUgGjn9uxQAil7o/xSCjrWCP3kZDID
 vd5ZaHpdl8e1mTExQoKr4EWgaMjmD/a3hZ/j3KfTVNpM2cLfD/QwTMaC2fkK8ExMsz+rUl1H
 icmcmpptCwOSgwSpPY1Zfio6HvEJp7gmDwMgozMfwQuT9oxyFTxn1X3rn1IoYQF3P8gsziY5
 qtTxy2RrgqQFm/hr8gM78RhP54UPltIE96VywviFzDZehMvuwzW//fxysIoK97Y/KBZZOQs+
 /T+Bw80Pwk/dqQ8UmIt2ffHEgwCTbkSm711BejapWCfklxkMZDp16mkxSt2qZovboVjXnfuq
 wQ1QL4o4t1hviM7LyoflsCLnQFJh6RSBhBpKQinMJl/z0A6NYDkQi6vEGMDBWX/M2vk9Jvwa
 v0cEBfY3Z5oFgkh7BUORsu1V+Hn0fR/Lqq/Pyq+nTR26WzGDkolLsDr3IH0TiAVH5ZuPxyz6
 abzjfg==
Message-ID: <45661e97-2ed0-22e5-992e-5d562ff11488@schaufler-ca.com>
Date:   Thu, 18 Jul 2019 09:13:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190718131034.GA12581@horizon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/18/2019 6:10 AM, Simon McVittie wrote:
> On Wed, 17 Jul 2019 at 16:02:16 -0700, Casey Schaufler wrote:
>> We've never had to think about having general rules on
>> what security modules do before, because with only one
>> active each could do whatever it wanted without fear of
>> conflict. If there is already a character that none of
>> the existing modules use, how would it be wrong to
>> reserve it?
>>
>> Smack disallows the four characters '"/\ because quoting
>> is too important to ignore and the likelyhood that someone
>> would confuse labels with paths seemed great. I sniffed
>> around a little, but couldn't find the sets for SELinux or
>> AppArmor.
> It seems we've been here before, when I added LinuxSecurityLabel to
> https://dbus.freedesktop.org/doc/dbus-specification.html#bus-messages-g=
et-connection-credentials
> in D-Bus.
>
> Recapping the context for those who might have missed it: in D-Bus,
> processes communicate in a hub-and-spoke topology via a central message=

> bus process, which forwards messages between the other processes. Some
> other IPC systems would call this a broker. As a result of this
> indirection, the message bus is the only process in the overall system
> that is in a position to ask the kernel for the identity of the other
> processes (credentials(7) and related topics like LSM labels) using
> unforgeable kernel-guaranteed socket options like SO_PEERCRED, SO_PEERS=
EC
> and SO_PEERGROUPS. This means that if two processes communicate via D-B=
us
> and want to know each other's identities, they have to ask the message
> bus; so the message bus needs a representation for that information. Fo=
r
> LSM labels, that representation is LinuxSecurityLabel, which is defined=

> in terms of SO_PEERSEC.
>
> At the time that I defined LinuxSecurityLabel, nobody was willing to
> say for sure that the label was guaranteed to be ASCII or UTF-8 (which
> is part of the specification for the D-Bus STRING ('s') type), so I
> had to encode it as an arbitrary ARRAY of BYTE ('ay') rather than as
> a STRING. I was at least told that the label wouldn't contain embedded
> '\0', and that if there is a trailing '\0', I can safely canonicalize
> the string by removing it.
>
> Also, at the time that I did that, nobody was willing to say for sure
> that there was any particular correspondence between the security
> label obtained by reading /proc/self/attr/current and the security
> label obtained by getting the SO_PEERSEC socket option: in AppArmor,
> /proc/self/attr/current is something like "unconfined\n" whereas
> SO_PEERSEC is either "unconfined" or "unconfined\0" (I forget which),
> but the consensus seemed to be that there is no guarantee that the
> presence or absence of a trailing newline wouldn't be significant to
> some non-AppArmor LSM.
>
> If LSM stacking is going to lead to syntactic restrictions being impose=
d
> on security labels, please could someone add them to credentials(7)
> or some other suitable documentation so user-space developers can know
> where we stand, or tell me what the restrictions and guarantees are so
> I can propose a documentation patch?

Thank you for speaking up. It's good to hear from a concerned user-space
project.=20

Have you been following the discussions on setting a "display" value
to specify which LSM data is presented by /proc/self/attr/current and
SO_PEERSEC? Briefly, a process can write the name of the LSM it wants
to see data from to /proc/self/attr/display, and the aforementioned
interfaces will use that LSM. If no value has been set the first LSM
registered that uses any of these interfaces gets the nod.

Does this make sense to you? We have discussed what's currently being
called the "hideous" format, selinux=3D'a:b:c:d',apparmor=3D'x' which
in the past, and concluded that the compatibility issues would be too
great. It's a thorny problem, and your input would be most welcome.

>
> Thanks,
>     smcv


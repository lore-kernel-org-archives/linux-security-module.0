Return-Path: <SRS0=YDB1=EC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A55C64E69
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Oct 2020 17:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9DA521556
	for <linux-security-module@archiver.kernel.org>; Tue, 27 Oct 2020 17:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kfr9NGYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775167AbgJ0R4h (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 27 Oct 2020 13:56:37 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:45893
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S370858AbgJ0R4O (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 27 Oct 2020 13:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603821372; bh=wjy93UW/VkjJv02ZmaKT8mrqr5XoaCAAfEdjSokXy7g=; h=To:Cc:References:From:Subject:Date:In-Reply-To:From:Subject; b=kfr9NGYliW2CuzPobkAqFvjg6qBE1aGAUpt1hf4FRvG3mawbDS2jLgcIAJv20dUwYaH766ga1688R9H40VzGBSP+DDI/rjenPsJcjWzCVwXr4JIjeUj2lp5I8vmoqnw6VNJ6hXt5kbgSLhqJo6prS2CH+RRVmcRm72C70PnqL4ddy5UVCgb7IJOVWPgbSG5qe9HvNNDitWyX0dcMmPSUdIFGPqXhuXa0DNhjR0KyjeLXleqk4EoMkVH1kbqQfmuDsW/j0zVTyK4N8K0bPNPQebGgKyOqGJhvJXCjWDsM1WKe5cIzHsgqor8rIdHilpr8/TaE7d5sqhKN1nKHyVsGhg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603821372; bh=ondw8zeT5ga+pX89FB6TRh4/wv6GZrE3cg2Ro2i4SdC=; h=To:From:Subject:Date; b=aAchM/H/gFa9Ij0BCShpQ/9cL70+ncknkimTiyvKvqKH4/Kp16gVJZ0hS7v0t5jPCCopD3d7F6qf3uqTX5/wyCnuB1v7fgfwrdbVkHQ2l5fJMAyzEmEuA5IpE+2pFVTa6W5jmSV3Z2bv3vYe+9uTC5nSSio9mWCxT6fKz9iyzhfMp4NgLr+rwQOT3rPqGTlh3Dl/eOsR3zLeyaaorXp1bDqWdqGsV41ZgsWs2WlK6InQ+wg+TAXbDi4cE4kRSr4vpFLF2sLeMDJjo9MVxSuIqAKg0CPGrGrWsvNe95xX/yoCqjrBo78Ls0sYn69haMfWrpAjGBa+Kc0dMndpti8aMg==
X-YMail-OSG: Sd5Ih_4VM1nn_UnuKqCo4m9GX.FdNntgOrUV5S9bXntzNEkPZADeAD0dk.UxQoO
 Hiibo_bsB..UpeGMbmNFMF_q0AZv8nl0LgBSB80IgtD6XqIJ8IqTbfj1whcBA0iySrYNfOiJ4vWb
 ICvxC4h0VPgI4E1vV_6CTSNHqN46v3HSNShN4.hzMD3qupmR1r_XkeQjh72f0dkPCVJUoLuq4oG0
 OmsPhV0r70wo.p7zKhynlAXIwaLiwAjm2kZ3O2dck_1S5txZIBZd7BsiAv6AlP2fNmLg2YjNxjHK
 doHVgWcjOqNuwH66BfDcxi41Z7tlLbgv3pveaRema_E94akqOGWbaF4usv.pcUGooxsuvXeGTyBk
 Z20JzqFyXAwefLkbtnlIo0kJcCoj0buO8ooPjfD5yft3iBIqkKFVJFPTwKX35mf.ksxYC3hP1Mzv
 TlVZnti9k6zHb1KwZLgwcw5ILFZv2WsJC2VQJKky8_vet6RyXR5PWzv.ehqEVJKo4xAodMZhCzbs
 0HDU_qGMZ4pEU7b21RbpXp08Esyk3GoS0oUSQCJkUc_4eNkz_syfiwzcshk4XcVDeOA9yQkRL0dn
 JNzG.ax69IoRNv7qY1EC2JxS_zgOkU.BGTZ9MeimTiD8dU9h5c6pwcQO_ePPCKaNQJ6bGu3X4WBu
 SyzbNMfJGnBLld.XWvaYpu2nlAfl._Ylb6bAecz4N71DPBz3wqD7TnLq6e74D2hDI_SYC8Etquej
 mq4dpNVthx.ikk0eGwNznT0lgEC8aEA5IqwNyg2O1zoFlfOvK1Y7E85XAgypcZrxmjRw0DAxmso5
 GT.PFVCcfKph9ntPAWlDH1IhMvflIL28rzFxy0I0TvLdCExRPPW1loXtwpxUiRplf1AgkPMaixPt
 wtMwBFV039b0iFtzzQCmbsIHbRuhgdbj2hrf4eGEKG0D5m_Xz44PgyozMxR4GZZ_hxnRnQ8wcP71
 5pD8A6DY6CnNll21JYFAe.6Uy4E8ZOgBCP2c4IqZekLmePYVG3d9qfD52Nse6XMuHvkFdrxOoV4a
 tdRWqnVq5OYCAb6v3yJyLHvDcvALohKYZ9IWBYuALr92kG1.8AqYja1KI0cXw1ErgTi1WJ7wghu5
 ZD2.eQfnZnZMuPOzoT4vo6AzXFEebe9LQRbz2sZnbSwH62HzgqqxqHNKg27Gc5LVqTHH4JD5Pt7c
 GSXFEBrp7mR9wY_Ykz6fD5lLbwn64GP93u04f7P0j_lazzSCFQpZyUiPq4H_GQ.pxGN_8cVlj9PV
 .qb9sCWK8juAL5QCCPSw2OOvxqd_xd2LB9vMlkysL7av5YNdZzyHnMvDOeDKYoQjENm5pyXqGGu7
 wI0M84wPwrk6LCezHaPG5t26tMUk1eywnjHqAEzMZsy5di0EpMamjItpXEWoRPRCeOjC7VA.x40f
 8tYmad.kkPIUd0zLi3CNlMGCA4tgKoBvNlubOtDyADX9IPKkKHI5.wteZXv46Wz7oVDOI1zezMEY
 l9Crfj_jt2izoRnFVN4r6ihwMaLBS7mSYHwNZLk9CdBt.O8D4zL7RWhWBTcleyUjTyYhh.Lhlprc
 I1040FUCM78McjodZKFo5DI0o6wfU_51xBo4pbHQIoefgMio32x1HSd6zk_00G9E9rhyMTD6D53e
 a14fbFa0px7JyxSKnxrnFwu3Da8QlMQFEgDJjy8h9gvcNdsagoPL1f6DerIUP6BEIFHvWR1UqBkx
 127HnapxsdjMynAGWWNBUF630Y4q9OfhxFBBEQCfYqbVJdmrN5H6L60cYa0IgnNcKt27H1xu0ZLN
 NjiqXWiqkPdwfKDI0cXhvHml_3N..c.zwVpqjqRYijchjZykzkHeZHHZXg6DuMap05n_PU20bvuY
 BnviSx.LU4t4OXrhZdA47FmR1AHe6vffZl.6vqHEdna.CxjeIPBtoymdSfApLHHCQWne6pP7_y.G
 ZqGAnDqnO_HSp4iIKFBv42rwUGzLsDd5bbhrUVuqbipa_GMiGU5SkgLpBhWNeyu4tLmCHKrx7iro
 PMuXVMXpBoFatZxNeHPrs8hLgKXMk20vkgnK47AkUR1aI.NygdKpKaUYRl4gUiZ.L7Bv9nffPT0c
 RVGVqvsKq2bzCqxkjBGpX3fJoYeMuyihf4Uy6MNlB9fNpkeP7Os7d2U1f2Py67nJurSySKa4ox9U
 pR8hMB4fOh.ul7ceXOyHVe2nx.h6qgcChDqDrTi7yB4FDPamBeauOadgIsupdkVhld9dRUIht6b.
 6GBNTDNZ8j4rCxJsrhQdSyVPbIHmWaeITx4t8MfgchocUFjwaeTbCR2enJ6aouiJt7AwEOc9R17r
 7Q.uI7Gw7qgZHiKunSA4B6DGd1oCkHo6U2yBM9I1xBD3Dc_AuK3yhMOVLK4OxYpmcGcRJGoRCosU
 e9hpu6nPyGiYwZQX9SJOKr2SpwV8FQxR3TIqI5zhIbXESVARBAqt8p3DDAl9c2xcitoeBYH1jEje
 8vyD7BHQbNGr3hF_yzsyKP.llJo8ptlvzMqTxSIgKReVw1Dms0Ltz1EGvHfcgS4FY6tIu7hXMkCa
 R_uQ6KiACZYKth3NmsTutL7HkAEOvKsY.p0kEtO2.T6nxqd.WlKLz7n.z55DIDcg7MuQk8Q0l.4J
 63.WaD6tpNncRx0TGFUmzuYT83szs_Ft4Ezvukv7kRx50C6TY9uXtDmaaS56MNtwARUs2TIh0TkQ
 4_sWOhFASQvIZPo1E6HJFAU7nKUDBgtKFgYB00kVbtV.zpjVVvFPVpVlyj2bHCWsSWyKV8BOrGGB
 3ApA8nKnvZOLDK81eLLh_24yxZEe1PMQYXgrcYwBvg9wd4r5oXsDrnBpP22plfEACok.WHRT2P0d
 aZ3DXSB6oSO9vZc7.uN6EnES8_9_Fr7hk78D36P3iolaubd96ZzRikeM4I7UDZY4dtLcS874.dQs
 TA_bmpqeMB1bR.BhPNWoWnuDWu_7xbLyEXbYHnpFQJJMQ.7n6WKivt08pofAqt6IT6X2dX1P8PBI
 s57yjbXclGVRZHi7TBZsNuVCPgsNWuqHvLL3EY1qzkZ9d4XBKon14RmqZUQdYEGnvDR4xOrdV575
 n1RAz9SB8CFkRKoIoW.k4x0qIA8QFwrckAve3gZz7nUgNixA0Ee0jljd7l8vaIkdIy.hq2brTZpR
 ts_dVDEIdql3s8pG8EIrKVyarTysR6P4VHGemLgvC9Hpyu3KiaI9FdEt8sMW_9SGRfOYXhJXej4c
 djb6AMZmNPIrENZbBBubGKqkHCoaS4gbBkV423zqRIGbZaHqRrPzFqGcmpARQ7z2SG9SVFJQ6j3h
 aHEFPXX.bfh4Jf03jzFa7msbbhOazH_YKyazDc1IjqvYPXLvHWCk6U1pAnBuEpymrEM.qek7NKm7
 SjVJEAzPf4y27jT6N249bT6w5NwB3IjVygRMOJnGZhm6eYwrD22LwkMmv8X6TruHtYD5YjBOBPSw
 W47c4juxlAIOFOlm7fglS7JXsPmfrd_Exv_35ik7kPTIelmS0sq4pJMC0rSfkNLftoLPZlMzmAZS
 JNPqm7cY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Oct 2020 17:56:12 +0000
Received: by smtp401.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b32366ff8e77b0d1e9d281845e3c5b58;
          Tue, 27 Oct 2020 17:56:11 +0000 (UTC)
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     Aleksandr Nogikh <a.nogikh@gmail.com>, jmorris@namei.org,
        serge@hallyn.com, akinobu.mita@gmail.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>, glider@google.com,
        keescook@google.com, LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20201026125227.54520-1-a.nogikh@gmail.com>
 <20201026125227.54520-2-a.nogikh@gmail.com>
 <c768f42a-1370-5b38-4f89-357744fd9d5a@schaufler-ca.com>
 <CANp29Y5w1ZxDShGQHvJ-F0bM_P4WSrvPoDQtPNnBCG38Ee-x-A@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC PATCH v2 1/2] security: add fault injection capability
Message-ID: <c55336e4-dd4f-3a72-e22f-aaf9c305d57f@schaufler-ca.com>
Date:   Tue, 27 Oct 2020 10:56:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <CANp29Y5w1ZxDShGQHvJ-F0bM_P4WSrvPoDQtPNnBCG38Ee-x-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.16944 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/27/2020 10:29 AM, Aleksandr Nogikh wrote:
> (resending the previous message in a plain/text mode)
>
> On Mon, Oct 26, 2020 at 7:20 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
> [...]
>>> -     int RC =3D IRC;                                           \
>>> -     do {                                                    \
>>> +     int RC =3D lsm_hooks_inject_fail();                       \
>>> +     if (RC =3D=3D 0) {                                             =
             \
>> Injecting the failure here will prevent the loaded LSM hooks from
>> being called.
> In this RFC, fault injection was intentionally placed before the code t=
hat
> invokes LSM hooks. The reasoning was that it would simultaneously check=

> how the kernel code reacts to LSM denials and the effect of fault injec=
tions
> on LSM modules.
>
>>>               struct security_hook_list *P;                   \
>>> +             RC =3D IRC;                                            =
                   \
>>>                                                               \
>>>               hlist_for_each_entry(P, &security_hook_heads.FUNC, list=
) { \
>>>                       RC =3D P->hook.FUNC(__VA_ARGS__);         \
>>>                       if (RC !=3D 0)                            \
>>>                               break;                          \
>>>               }                                               \
>>> -     } while (0);                                            \
>>> +     }                                                       \
>> Injecting the failure here would allow the loaded LSM hooks to
>> be called. It shouldn't make a difference, but hooks with side-effects=

>> are always possible. I don't have an issue either way.
>>
>>>       RC;                                                     \
>>>  })
>>>
> Should we expect LSM modules to properly handle the cases when their
> hooks with side effects were not invoked (unlike the selinux crash that=

> is described in the cover letter)? From the source code it seems that a=

> failure/denial from one module prevents the execution of the subsequent=

> hooks, so this looks like a realistic scenario.

Yes. Security modules have to accept the possibility that something
ahead of them in the stack will fail. This may be a DAC check, a
capability check or another security module.

> If that is not true in general and depends on the specific active modul=
es,
> then it probably makes sense to introduce an option to control whether =
to
> inject faults at the beginning of call_int_hook() or after the hooks ha=
ve
> been invoked.

If you want to do that you could implement it as an LSM. You could place =
it
anywhere in the stack that way. Based on what I see with the BPF lsm that=
 might
be more work than it is worth.



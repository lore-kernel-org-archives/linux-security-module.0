Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569B0C433DB
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Jan 2021 01:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB1922DFB
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Jan 2021 01:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbhALB3E (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 11 Jan 2021 20:29:04 -0500
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:42941
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730604AbhALB3E (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 Jan 2021 20:29:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1610414897; bh=kwuokfKqhD75VznW687fqjpmVe7o4sq0A4/o2Ez+GyM=; h=Subject:To:References:From:Cc:Date:In-Reply-To:From:Subject; b=RbxFVklwjv9SoXbhrnCufPCBo0MU5BoGD8Cu4DBUpYtY0V7IiyhCp392EnIAToueIubgIsZzH/Ns0iEgnBemxRIdyIyoBWqruSVdS5belPhKrQW8GK3LF4igIe25EDeZWnh8ulQzQLmLFWdVv98SAoW+4lWAdAdET4/qbLI8+DOIxDbXad0/wR8OK16ykfWlfsGbj7gZoiU79sEt/2nC7L5CkqDfTSBJy/l9UMSZ7GXqKohOQ9ZAiDcpilh0/LlNTc03pzlPTDDle67QlkZR2m0b0MXCc7E+sXtuDVpk+xy1tFUO6wTg9cUwBnCH/nV1eYJvliVS//wXLfgB1sYNrA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1610414897; bh=PGYNJ+67Qd/IN+47vhmr+b6ub3oTJzmJ95DgX2TLoJl=; h=Subject:To:From:Date:From:Subject; b=je+E8ZJz9cqtNo3KJ8VCSHuY0TVTUTEZZkZT1wH+FCkGZ7LbyrJbZ1U1ZAwup4OXi55RbzIEvd2uhCbKXntiSxtI6PGr2qrBAmLIWE1Zy69C1UdKGaJTNxozKAVSVp7yklUx65fLQbp9Zp2+hBg5eEyqQlc7bpEvfm6DnmLjMS0t2wx3lggCV9OpwH5sFfkAQ2w/So9isqVFYCOPFu6irhkH2zYkwQXP6qY5heb3CbUjdzbkj1Jz1QEASTjWEtcSaja6Qc4ANFjD9dhfZHNyQE7BU3hQv4w3V4rslI0w6v8kbnyvheq0au8EoIFPb2PbdE3q96OJY4wvefyt8uysMw==
X-YMail-OSG: TL.aGukVM1meVFTJSvl82AvXoSdVTxrnynrxf.mr77ClHvKvMmy0hSctIOvrLpz
 .SH73EFjh.QRjWd0WnD1jM_wz1g61dXiGgTeOBS4a1TXueYTTG_HBBKQQIsVGk6WgtXS6bH0dZOP
 qzXjZ3_0xlIj1q6si2DlkvXYq.lMCQMjbMrYi8H_W1GIqSdMz4VpMVBWITrvAOzoXEghcDOWYDls
 04Ocho0JWRUdAWwVgsa4AKrsfL_vY9Ai2wucToVI09lRVslo_1xcQTDkgya6J6T3xfPM8Z2HEoj2
 EMVndYbsy7AkfvU34JI937tBpFPemMyyFzDZFBErzvIj5xPs0OBV3E5Og_S8wQQ8i9Htva3mk1bv
 Jnh4Mx37OrTaMuq29_9n9rSA2fQARjzBka9ZfLyjOSQisaLKnH1cT0iuO7OY3M5YrFYK4MkwgA9w
 2SmkuYokB9Kbcq49eb2NuENNUcq_Md2GMXSWHRbcDhS5nZ7yq7krjaYjW2.LRXTG9to8egDRy4CO
 7YDYMMSYaxYM9FGwXzv89ZOTMNCvXhqQrctbsOPsfRNQh8Lk8FKbMxb9eyrShwJC5G6iforvMl7Q
 y.GdyiD51e8iFR.KQBhnDX3B_MfKVB6FPIkViTup4a4NhPyr1aEuCELY.zTq2.sqaqvi9N1TpubE
 5bRcfCktW8ZYWSHhIMSmg2dK5QBzrLV49HgllWxzZFcpai50oCea8SLTrkCELQHhOwIdFMOhzoNO
 pxVSsmZaKq_.eZZadpmnwrPSQxgDLfa6FLmYM1l3GMvbnC4ZZ.H7BmjO4hmHjsfLjPsKfbs3hX8Z
 j09AJV.5AFGj74WbLjQexqkTEhUCgriBAACcIMOOCyuA7fSIOrX9D4JvU1qunHhoy4sAE7jsyLIb
 4xlHIScuJFA4HuA0MFcvDQMslFrVCpWckumPDaWMRyUl119gufmB_thsTxqMSYuv9pkkus4IzQWY
 otnjNWeaYY5xqsnDNL1J3CBbvO_rXtD1Zybqmk.2qFOHfbVVIqtWMdIZpLVjkU_s8RcVfHKUjA2l
 mxchuFbhDv.OeR0ent9hPnAsHevd4n25eC.E4nyBYWYaIwqpJpcPEYWGE0M2mPtDSQ.8lKOfPAwS
 6j6o2A78Z5.67bftx7_0kIGLALPWEIgTgX162eSewBdoJFiHJ0xK.zjFwyQSwAAdP7Ix4SplUkVP
 MBYpxWT6BRzONYe6mVbgFe._EJyFfaWC4KJfYr87Jd66FjhMt8xw9JLRY8x9mF1ISv6XNIzT61Vv
 rTJ6wa.p6588vNngAgOZxG_mxWkhzI.YFrhKMPZfDlm2MaUunVzwZ7hR0OIRmnkG5Lybl4GF9XRG
 xgm_xCljUry9qph9wOqJ2sQ31KHkcV6UezfXGOoqsxaR83q81RDOGCHEb7AJ91tqoUJLhX1YhHog
 BotrkZKPxrSciuJ4mFCAm.5KJTCJIeUVm7Cx4y_wkl2ayv4_vZppA889MML08w05dPU_.UoYJLZr
 T__gnLjqJ9IMnLbdXfY7LHBK0s_WSbbb1.8c1R.7Pwq5DJsR1l8RQOrHQVDVUJn45eM5ojZugG05
 uheDNZdY5nQWPHJNVze7qnFr8t.vGblC5eJOIJzUSJvV.yxcwDBzhMqSR6BQ7mQdXwkIMbTm3yxA
 G5UNPa5XA5WQcnX986G9Xg.pKeGch7D.KlAl4_1RlyHdKQ9v824et4ZNseMIgBSC1jWNHXIpAnFC
 fwl1lpHSRZtLhy1bzh2eECEtJsaoRCm34aMzYq4eVTKso.9Y5d9RSzhHKon6M8aX.vitDmeFwfx8
 h0IwDZJaKvZthVCXn8PNV7CgWZziPnPbX7pyUW6zABnti3YMei5wXZ6cBoUSraKwKRbbi.6.X4iT
 dBhJy5lBWCa3H5nUkokH5oo4bRCtDgxAuU.kngrfcdwEkkyEeWmi3cvhfol_c0XI9PbfbYoDKJBM
 2acZcy5yOQX2IJIdgYh3ob_YvQnmhVC.8DIOONl7MBdPFg3SsB5KbbHP5n3c8GKmLKqkyv7GnfgT
 WlK9WReeKYdakUIaSpb7Xp4f1uaVjyLBcluQxrHpBxI2eho4ARkV6NHXM.xShEm0w6ZZQc2dQd1a
 TL32LTTe6ZxWq.1plmIvipZ88McF8.wc43m3A0cNs3v6xByA_vae0xYn.vVbkXrT6Vs2uSK7oufm
 ScA3NnbYC5xVw5AY9UdIpkugOvQm6blbOuyHSkp3URALnjT_xXwDyeZldrIVIdhDZ6tfnckr9wSY
 9Qh1IOY3ox6DmH3nGn08V89wG1jkZpnz322g.6uWHZCgdU0.rCS102NaUd7RyJObNesYK_m.umGi
 jnLe.bcGeuBNNYDVcEerc9K4a4FDk82RSxhx1rII0SmLdBbFw3wx4DiBAg9YqNDG3Uc2ot0mYGl9
 XWdPMUGoG8MOwD7Uq2z0V86JH8lp_3.AUwufdrhrBxpEFxTxMZQEUUW7udLEOib.5x0l.7aWdUgE
 .8VHoW.j5195_yUm.EZJBcgKQNd9n6JY4t9_Nh5Z8attG87y8DukQoscNtbGl9Lrj8m5_Ei9AgQ-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Jan 2021 01:28:17 +0000
Received: by smtp417.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1cee7bd7477efb7410b79cf550d5c9d5;
          Tue, 12 Jan 2021 01:28:15 +0000 (UTC)
Subject: Re: Question about inode security blob
To:     Fan Wu <wufan@linux.microsoft.com>,
        linux-security-module@vger.kernel.org
References: <156f6860-73a4-f754-b460-d64de40ff626@linux.microsoft.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <f4f21823-240c-394b-2222-bb8214e4ba7f@schaufler-ca.com>
Date:   Mon, 11 Jan 2021 17:28:15 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <156f6860-73a4-f754-b460-d64de40ff626@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17501 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 1/11/2021 4:56 PM, Fan Wu wrote:
> Hi,
>
> I'm trying to learn the security blob infrastructure for my future LSM =
development.
>
> Unlike other blobs, I found inode security blob has a special pattern. =
I couldn=E2=80=99t find useful information on the web so I think this mai=
l list is the most appropriate place to ask this question.
>
> The BPF and SELinux will check whether the inode->i_security is NULL be=
fore use
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/i=
nclude/linux/bpf_lsm.h#n35
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/s=
ecurity/selinux/include/objsec.h#n164

The inode security blob should never be NULL in a situation where
any of the LSM hooks depend on it. The only ways that could possibly
happen are if an inode is allocated before the LSM infrastructure is
initialized or if the system is out of memory when an inode is allocated
and there are no entries in the cache. As the code says, "unlikely" and
probably in a system failure state already.

>
> But for smack, it doesn't do such a check
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/s=
ecurity/smack/smack.h#n347
> Is this because smack_set_mnt_opts() already does the NULL check at
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/s=
ecurity/smack/smack_lsm.c#n784 ?

Smack tries to be pedantic about having data set up properly. So is the
LSM infrastructure management of inode blobs. I have not identified a cas=
e
where you should be able to get to an LSM hook requiring the security blo=
b
if the blob is NULL. If initializing the inode fails it should be impossi=
ble
to use the inode thereafter.

>
> Also, I wonder in which situation will the inode->i_security be NULL?

The inode->i_security should never be NULL if the inode has been
initialized. Any LSM hook that finds this to be NULL has probably
identified a bug elsewhere in the system.

>
> Thanks, and I hope I could make my contributions to LSM soon.

Excellent. Please, tell us more about what you're proposing.

>
> Best,
> Fan


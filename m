Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D23EC001B0
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Aug 2023 18:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjHGS6W (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Aug 2023 14:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjHGS6U (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Aug 2023 14:58:20 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3281FC7
        for <linux-security-module@vger.kernel.org>; Mon,  7 Aug 2023 11:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1691434662; bh=E6mxZ1Qp8VP3dzS89/JOiK8+/w/1xcBgaZspT+WClI4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Nwi0bOSJ2Z55KCPY7RAGsig45W0isLMoFBCOKN40l48+CoVCwNd0Ar7px8felZz8PjHoWcJCXtxiYqLyrvj5EzG/EqqlLIdYEkam9WRR341xsV0FX0nDlvvEOjNJ16DzG02rkz6Nn2F0cAOx2qAciCdjLCmWVuki4xEJKtQUpmR/ScgKuivZIXLl3/BrYsqng2KHcvUOmcH99OrjpI13kRTTU/oEByCQQWY/ZFlYGdoDKdS7qqUk95zAPSCy/BoXcYnFmQdN4WMN79hR5nby6MPijUVmSBpE0Qdi40MWr1uYK26ucaC5DmTIXgT6G3xgnkycF58TfLL8z0JWK4V5cA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1691434662; bh=6xFKxbOD+Uv4ERdPT+i6VrE1wYjJlFTfN17Tu3puaHl=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=C7AOuFmRmblNBANyk5KdDuJZSJhgWIoYkfDrmfM7qxtV1V5Nia/bFzIwrxoWyXpG9q/w/1Bv/L/wuYf3ilABoJKT+0NtUCoBeSL9kGAXHdQz8b69wbM7gAai2eUdXW8n8L/xlr92J+E3Cv3RGxBfv9rEcHmFmPgwZCDR49jYys0spZXrq/VrLY5y1z4BoXa9e4F0PIiAT2h3SeQNpnu4ruPJSm49crw1U8NQPb45jcZkYbi835pgdAE+O+Q01WanHs28FN3xXC7BX2BaJIJzXyDbAiUu30zUTdLXG7tQpTkiLfJnVBr6Jsy5N4QfJmocCH3xAAXJcCS2KiLVyhSGmw==
X-YMail-OSG: l4SgadgVM1kKpxjhcPjmQq2D8LSJ_BNedtwDY2pRNR97ya8TgaieMpbzOcy2hF_
 2yZKv5T80.TvyosAKd_TyLLtUFHYkuI29d03VCG3nSlhhmTlgm8YRthq0jYe6jIMi0W1YMNAY0Ki
 KGC0naARbX5ki5O57tZBTMWj0QnOX3bybMcKo6fBqm7v07k8y06HwzRyiXEwLyrDNX5kKJJFI_.c
 ogo5sNyfapWLgJaxLKcvAxA.DaTpkq43YWX15QYInygKtdRrXYoMdznSDab.BdV9lCGkloCWlbYG
 tQrexsI5_1a8QAu4hP1Hjq5s232ubZmQnAl5SuHq0EGXjt1.0DASTQ.BtApKdsGWyWrsl1m9hphi
 xy507l7albH6Dq99QhwZ8P_OfLVtPZqZ1OGkfeJEnPpXa1tMsZBWAE8mHu.2SPR_PZAW7PW.UDHR
 lLXU4hOKLXG5tzLZe74fyxKGywfWsP2OPx9tVLZRyHaZTyB0Fpwn6EYN2XRKwO0696PXTrrbwMCG
 ssZp_oDxZiLfQ7scxetugIGIY5Zq1q4ppfqFxvWVi5SlIysISmeP.lksWNrrJcgqa1t5qW83j4Lm
 MINLa1ZSkVa.irp.y.c6VKd_phIDVFeIrIBWQxPxkuZ27H2Z1HVicf5niJMiKFvzjcRELdGWR6W8
 TGqUI9tmwFQM0.Uybv_4DBQ41oE32WhUB77vk6dKwMj4yQNDI.zYih0ha9cEqzRPoQtEcoOMjWAY
 NcO7SebZ0TEeo_Dh6q0u2jDUU6h.CwCo3JcMzMBtteoPw3c_OwPiV3chJVI3gxvHIPMyi_QHjILR
 5mGLd5rRIrmAnES1Hpz4OUSECtnjoKqH9bZ.DSoabFEOS7MyhBFaP.zwxTnQArnma1.hNk8RCV1p
 02MoGSmej4FbqZ1savO5qBNLcTT94w1tc5u3BgbaTwEtGB1XSgQy.R0_GaIx7p7LrspF.LgzhMtM
 qZc4Sl1JdDhtp5cKa6MwYJJ7GJjAEjRejydS9Z5jzaOpQEH4cm9EfwjMeX0aPYagpqJ7GgzZKDkw
 H_4RcmnQowiWBokkaAP8kEJwZVAXbwj60lE8HsbfjtZezH33.Afb.y60m6feaxkZ_xkCz7hpBWvX
 ORzRj.iWhU4q0EXPudXibm1lU8KuLQHGf5KQV__Ug5EWuqE52rKKzcHhfC6OTWEeIDtkpb6Sdww_
 bTUdA1FPBdXg2A0OfVk6.yaGpdp9l9HVpaf94ESBsC5V0blTeivNc9l0saadgW7.6PvWtI0A7ana
 KXcfiLSEuD73ksmqEgb6JpuSUk0DNlPzKNmcscEhAWgxEekuvEzmg5t3Kkqkbo32hzG5whCx76or
 1f7nQjbJJiC5TY.k4dGq3f.y4xlaQv2YIzrJCSbxud3T92_kcEUjj0EmXU_Ydfc_TFrzIlf0itgW
 UUDlPfMCaNGvuaJH.6mQbFsc6rFrw3r5gBesUUPbghmrGQ.YvBbEy2LZpv93DzAy9FHqKlssvN2g
 .xgRJd38unJtAsJRlEnhSsMKR2YDeVCU6iO_DYz4AV1YZj7GbI8F9AMvcc_6oXRUSc5Cb43g7XtH
 Mna_x54Ep_C2hRtxML.EhnGKZiXjcQSeJwMrZ0X1BED8b7oA4M19xgG0SXVdofrK8Mm6yO0z4Gu2
 sGgV5qXI3fi3C.LnNySjjDA1bdvu9ZfsOkdZqqmNyVfGUrv8ufG4xGdip4nyrazADOi5JSBHgzB4
 CoMlh._H6DdASjyc0zvIbAk7viMY6HjtpJRCb0DwbblztA0XBctCATBJCl7MRbQQSRpPPvrEQZdC
 _yqvpb2fIP9xZTWReU1xSW6KWdxzUA665IDqqpbulSVDuA8WOaFwY5P2SjIBsth1Hw5k2KRciZWG
 py3hNdr01haTAc9in9M9qqy4e4G.bVUBxiD0S6pKyf7m8vcqaLpwtqzb1UvV_2VMlZjjJ7bbQPlD
 OANePB5wmMxIbde8O5E5JhAAXGZcx.7It_OsIjup96brPxARe5.whOD3qmRwT8giEmpCj.Z6VQBB
 dH7tgSKCSrccXyRzHFK72fMsrccl78uq0LWm9D198dBds.Wyu2hcnTImQjj8xj5DPkRdvdyogWh2
 srlEP.LSY8UaQXJMdY5wUba.3fzSux0DkOaSQydQV1h.jjBjyNI11B2JuxX8uimKIT7V0r2TPtIs
 6KPV.Zzp5_xhHo95TClvCowLUJ3qS8fqldfRfysJx_jwqqGJwCJ2OeCWFE16CqzDgU_d5dc0EH7K
 vsnumkzDD5e3CAahCbPehaLTM508OUKTzFiDkrHfZBczSBytC3BZv4ZD4HZ0j0k.LF6sFW2wrbWW
 1pafesnhH0g--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3ad2e71a-a5b4-4f66-8131-7cf978ee2d9c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 7 Aug 2023 18:57:42 +0000
Received: by hermes--production-gq1-6b7c87dcf5-rj56s (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 519bfe3d511889664072f488090a15b7;
          Mon, 07 Aug 2023 18:57:38 +0000 (UTC)
Message-ID: <c993c896-730e-322e-5e97-7c4804d5192b@schaufler-ca.com>
Date:   Mon, 7 Aug 2023 11:57:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC 0/3] security: allow a LSM to specify NO-OP return
 code
Content-Language: en-US
To:     Paolo Abeni <pabeni@redhat.com>,
        linux-security-module@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <cover.1691082677.git.pabeni@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <cover.1691082677.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21695 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 8/3/2023 10:12 AM, Paolo Abeni wrote:
> This is another attempt to solve the current problem with eBPF LSM,
> already discussed at least in [1].
>
> The basic idea is to introduce the minimum amount of changes to let
> the core consider a no-op any LSM hooks returning the
> LSM_RET_DEFAULT [2].
>
> AFAICS that is already the case for most int hooks with LSM_RET_DEFAULT
> equal to 0 due to the current call_int_hook implementation. Even most
> int hook with non zero LSM_RET_DEFAULT are not problematic. Specifically
> the hooks [3]:
>
> fs_context_parse_param
> dentry_init_security
> inode_getsecurity
> inode_setsecurity
> inode_copy_up_xattr
> task_prctl
> security_secid_to_secctx 
>
> already have special handling for to basically ignore default return
> value from the LSMs, while:
>
> security_getprocattr
> security_setprocattr
>
> only operate on the specified LSM.
>
> The only hooks that need some love are:
>
> * hooks that have a 0 LSM_RET_DEFAULT, but with no LSM loaded returns a
>   non zero value to the security_<hook> caller:
> sb_set_mnt_opts
> inode_init_security
> inode_getsecctx
> socket_getpeersec_stream
> socket_getpeersec_dgram
>
> * hooks that have a 0 LSM_RET_DEFAULT, but internally security_<hook>
>   uses a non zero return value as a selector to perform a default
>   action:
> inode_setxattr
> inode_removexattr
>
> * hooks the somehow have to reconciliate multiple, non-zero, LSM return
>   values to take a single decision:
> vm_enough_memory
> xfrm_state_pol_flow_match
>
> This series introduces a new variant of the call_int_hook macro and
> changes the LSM_RET_DEFAULT for the mentioned hooks, to achieve the
> goal [2].
>
> The patches have been split according to the above grouping with the
> hope to simplify the reviews, but I guess could be squashed in a single
> one.
>
> A simple follow-up would be extend the new hook usage to the hooks [3]
> to reduce the code duplication.
>
> Sharing as an early RFC (with almost no testing) to try to understand if
> this path is a no go or instead is somewhat viable.

I am not an advocate of adding macros for these special cases.
The only reason the existing macros are used is that open coding
every hook with the exact same logic would have created an enormous
security.c file. Special cases shouldn't be hidden. The reason they
are special should be documented.

Should the stacking patch set ever come in there are going to be
more and more kinds of special cases. I don't see that adding code
macros for each of the peculiar behaviors is a good idea.

>
> [1] https://patchwork.kernel.org/project/netdevbpf/patch/20220609234601.2026362-1-kpsingh@kernel.org/
>
> Paolo Abeni (3):
>   security: introduce and use call_int_hook_ignore_default()
>   security: two more call_int_hook_ignore_default use-cases
>   security: more call_int_hook_ignore_default use-cases
>
>  include/linux/lsm_hook_defs.h | 16 +++----
>  security/security.c           | 83 ++++++++++++++++++-----------------
>  2 files changed, 51 insertions(+), 48 deletions(-)
>

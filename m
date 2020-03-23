Return-Path: <SRS0=YXOF=5I=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD02AC4332B
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Mar 2020 23:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9778C20719
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Mar 2020 23:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FmLIi+2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgCWXjm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:39:42 -0400
Received: from sonic307-16.consmr.mail.ne1.yahoo.com ([66.163.190.39]:37480
        "EHLO sonic307-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727063AbgCWXjm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Mar 2020 19:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1585006781; bh=MJWGaVmo+AsHi/3jj332w3mOjY/Yve8JIABkzYpaYQE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=FmLIi+2kp3ENxhgd8FKh+ifmeTEpdolfFuevHdcgLiV5+B91ZYkwY7W5vAINDd1Nxs9XWVw6u1yLqeqOx4ZgFf3vH07i6pbI+4y6TVEQC0xkt1x99KNGarnR/DRTNeRiQqytdLSUTpmoMmDQcoDuvmxyvhrn57Y7vRxk6Z7cGTxvXn1oBRJRYOnF7/770hzr6986KQOMcaRCMkdX2OrtscEuk30+pNpUa1vA1/GmOkVK8Kt7vMWbzm/Q/La74T3o0qIdmsTzv+Hulux3j4pUtrjDQNpkm5q4kYwWiNU/LJP5jPCbYX6tJQbqACXhVPxm7rngMqzJ0jLKndNrogOqvQ==
X-YMail-OSG: 7.5gGPsVM1l89x6GspRUsgS0yG8VmiO62rb9L2AJckttwMSJt79FqT6zwxgKdug
 CbnBVA0ffBK2X1UwX5JJOJZ6Cn8LsXKkGTGLksrhIIwOdGVvVtRDfkYe6n6FVty2F3Gp_kFQ0Ynm
 omYExjipeyCEkpO_ZKQvMnLTM.c9nuS6zxY_dDpdjXOiJ_MrwfSmEXuPdPdnQhJBJb6hhtnS_syn
 RPFq42TcAEAfhKjkG26BGmDQjDfBSSLiLalu3ZuKtjRQ.vAG_1KQwFWS4x1CiuShWw3rqGQzqPbA
 wdYLxMZLNCtmfAuye15xJJawdvJ5Ff4Z1VmLyHkXL7Ui_i9zAvl4yN3SA0tIMoyAOi6omXd2YOdw
 uzQWcq3RxUznmZCRjKdqh5w5PE7LLyq3MmBZm4utFvFFtxvEs07uBScHmuyNouymWL23hzndKuyh
 mur.WkrAjh2_RPWzvZ_H_IqLZc3jxkOElKDQxXQqe_5VkMKo3EXsXCw0eZQJezyh5v6v3BL2LZuf
 3vk1K4CoZkyF8.2VKS7pcOFQfQvFFG2bUYux7.phqyG6zrPl3kg4AKTldmmXfUHOFCXaTF.Krrik
 1KJBaGR7LCOCrtB5ZMRWXnE.BK6gm.9kplaKUh7mDO_sd9xUt9ClwwPzEfW4vZ2W8LwkojMDsVRl
 rQ_vMStdkmA6XfEZor.N9jufAA9VwSG83lDb3oJxKF.B7G.BgVZjLaCPNDbykO2cfPhYrxES0FS0
 lfqVnZE9y4weeL3HSEeeFOAvDG9IPrwGdfZZAaB0Ve2yP65Ls25KDx5q9SNc1wraAMWYZ3jFerkG
 ARCCa4N36nsIZzgFDES8bg4jiTHOTLuGV.SeLLFeMFzHhNWOM.LgbuqC.KcWjxkwAaDs0SwZjxEF
 cuijUMqVuLmb5uwAgC1Zg0rOoIMexfeATenA9XZ1dhkW7zOsLqq_5WS3n8XLl8aU8EDUE.K.1O62
 0Vx70DDarWwT5lUqusFp7UXEefM.hb0CYAJeOBpg6PkNzu9Awt4TGr07uCy9Ewgx2shQeo5ScDav
 _r9yLltpupukIPzaLWaAixCBV5F0UIWjLjBtS.oS5Rhhtw8ZPccmrCIiecUHsz36eHmHVeetBUfC
 BjmTYjZGImpbgWFbU1nu0TP4qiM3KRNJEZFxTs8KmUNzmMgrJTqgSeX6wxHHZUg1JBbQIIyKArWW
 _02muk5e2.odlyGhnexRwHraPx9gO_qU_dMEarlQ0LskHD0y1khHxOah3qhXFAV0ZzmcXH8_cLEx
 MXwCk3QoVmoxDSBfanKTtMYoYENw_eSk6HMoCTQPYax0w1t5mTVhHxouRXzDZ3duuRaedTTLFBr1
 QoqhvlTSDH.j2s46pZxvbVbBpQdwu4UKY5Nv.E03G4qswVkhKRS2pMu6VhZ6QReD6tr0rEFIXDgL
 JX2oMJpt91OZWbMyww82Y288-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Mon, 23 Mar 2020 23:39:41 +0000
Received: by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 57ac69c284dcd51f75714b7a846e1efd;
          Mon, 23 Mar 2020 23:39:39 +0000 (UTC)
Subject: Re: [PATCH bpf-next v5 5/7] bpf: lsm: Initialize the BPF LSM hooks
To:     Kees Cook <keescook@chromium.org>
Cc:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-6-kpsingh@chromium.org>
 <202003231237.F654B379@keescook>
 <0655d820-4c42-cf9a-23d3-82dc4fdeeceb@schaufler-ca.com>
 <202003231354.1454ED92EC@keescook>
 <a9a7e251-9813-7d37-34d1-c50db2273569@schaufler-ca.com>
 <202003231505.59A11B06E@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <4e8c7d6d-f71b-9b9e-0b8f-5bd188cbf2cc@schaufler-ca.com>
Date:   Mon, 23 Mar 2020 16:39:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <202003231505.59A11B06E@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15518 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_242)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 3/23/2020 3:12 PM, Kees Cook wrote:
> On Mon, Mar 23, 2020 at 02:58:18PM -0700, Casey Schaufler wrote:
>> That's not too terrible, I suppose. What would you be thinking for
>> the calls that do use call_int_hook()?
>>
>> 	rc =3D call_int_hook(something, something_default, goodnesses);
>>
>> or embedded in the macro:
>>
>> 	rc =3D call_int_hook(something, goodnesses);
> Oh yes, good point. The hook call already knows the name, so:
>
> #define call_int_hook(FUNC, ...) ({                        \
>         int RC =3D FUNC#_default;                            \
> ...

That makes the most sense, I think. It's getting a little heavy on
hidden magic, but we do tend to have a pretty good set of eyes watching
when a new hook is proposed. I would expect the changes to call_int_hook(=
)
and its callers should be made when default is added to LSM_HOOK, not
after.



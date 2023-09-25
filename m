Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938DECE7A8C
	for <linux-security-module@archiver.kernel.org>; Mon, 25 Sep 2023 15:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjIYPuI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 25 Sep 2023 11:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjIYPt6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 25 Sep 2023 11:49:58 -0400
Received: from sonic301-37.consmr.mail.ne1.yahoo.com (sonic301-37.consmr.mail.ne1.yahoo.com [66.163.184.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA72CDF
        for <linux-security-module@vger.kernel.org>; Mon, 25 Sep 2023 08:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695656936; bh=MrOhSvI+t/+YXuvHl9aFhZ3yD3jslvUTZqhw5s2F5mA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=VYHCI66kbMY7vbRYYC1DH0xr3udfSQ8s4cOg0fL2CmIkEttaxDhzidckzzpSLW+Ud6QEX8w5oJ1Ku4NgK8ppGE8WmTlU9AN0nex2ts3T32iABwxtTzor/nchMdPfdRTWh/5xE62apgCSLdtHQTHC4lzQpPZnnYHEa6/spmUo/r6Tx3gKo2aQufTLt8QMrHsPvtUUf5bMDQaRMONUnbVvnlldAxCdV0lbur+ECRWrxyCVS143CvA+YtsHIq8oySA2xonFsE+cXKsHD+y+NKIyQzRAcCKXOdzvfPLZXROiQ/pLFPzXv3iCSJCn9eRbTFiEZ2ZgzRoHh8lYRm51dYDBkA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695656936; bh=Fqv8WmN3Rx+OtpAwF8tBtz4uHJQ1JuHKsewrVd9LRs4=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=NEhtyOuXbkPA0SA1/ZHKM+uNU1YyqcJ6M5GtVzIb2jaOqRTwWQkScu0+rIAPT/TOzqmH/7TZTyQIlwXg9tlsuvc92TPui9GAU/VnA6VcOXbflOrP34aE+z0JHpp8zQy6nuO86rip0Qr/UrJ62AnuqVhf4hg3dWIEbUOXHashPFmMLshwQBBholGV1Mr7j2vxWuEHEyPJJ7V0KDNrKbu+ulzRek2YFOGXKxeEkQ+hhM1JZY91pWiEdkTo69xut73//6NCw/SmbdlZSPOicaQukiAjmeCWV2rXpFaVVXpR2b7ALyc570yY/uUFcO4GDJaSFmq56V//EIyx57/TMjszAA==
X-YMail-OSG: XvLL108VM1mYqWdeWEogulB1IRsUtR6JWxsTc1IOuWb8h4SRSqkcL.34fyZwrbF
 I8fUp_ZV68SFeELU1LMJ6P_DIea9KMwIjhJngazi7vnx5TLcpFO48IIdSxK_jA8sCQDBXBCKbkT1
 QUwVaBio2N_ZHbW3.K13_fDpHxWyvtfmA4I2ro83KCOMuK8ZI_zBvKQ2NSAlk6yr9QoXmC5qVbwk
 olUht1LOKzOu.Qn8iwHj_3RY_4ronKPNvkcmDQEiPP4Hjcuaw9bKVglNZFHbvjcpsogqNJTjrYcP
 1NLG4U2Am5ikL5KpeRq8o1b_kCBij6LxKV14byA8mvLT6jhJE16QtaW1Sr3SJAJTKWGEFBUG6DB7
 Yo_wfqkBbp35FiGD9ke82iKUGy3fPAX33f2ECoVHHVRUFL0ITOpMm3QfgW8GwPs2gufi761xm9Uw
 ratukRzT9pBxkMXl35m6dBKWjSd0LDfI9h5R8Bv1Zaq.AoC6Hj64QfBn.P3SX5eWQbZmvLwRUTq_
 gq1zWkuRABCzwNeqlFctvqjluYD4BISH2VMpvKo5SUoBJxblxwBRTC4AiuXyb4fhyd_06kLZd21e
 ly4Xl12TDVjUOkO3Trz8RkVmObRSc6yvyxFitVewFvgYMB.ab_g6goNW8ugt7bWfyIkLNMuHCwnA
 aHO8d9n.TlZ00nwtXiQD9UgWq1SnFWoAG1j9daw2WHBhesXgfHfKRiC8NEgCVr1ieTFQ4spGLLnv
 LvnqH7fR3IU1A00D2aTu9G6Qtc4MXFBOANaHN9GxOpeORouJDDwWE.YdJ0Cn7r3kfK7ND2EqkMrS
 ctJL4Ej9Dzmci8sFqBReZwYJ_2OJYqOf6xBtpusnr74Cv07GkU6La1czfq5GSq.8k9r9c3ATtlS9
 RnHxRjrcA_nzFDP07C.ACNUPj4oRMgWB6wighQ5QH.401QZ79k1JijfZoVbaI24eWZIR0XA5KFeA
 7eZaXdNTzeZCkZCHPeQG5wzJ5EU6E0cWStYLkJ7KGcs6eeOldJoIkct7JaeT7uCf6kXuDd1ieD_3
 hG5Uep_._lxt7v71zdkuIFNe7xK0YmU3PbWsJHNZE3mG.lxdrqL34NwgenUVQPywnR1sZgSdxW0L
 CVIfh6i5SXGv1UJ1kD_BWuuQ34fk52J6QaEYnVbQtHPvidDyEioFwIIhKX3bOAKnJCOpWC0yywtq
 jZl1zXEADQsraiXERMBSGmg3Dyd5nnA005swxZ2bGy6t7vFMXtVkOLlzFyQ5DL4TESqG26WxXMXu
 u21q0LOoW0SJTS2tXpKfjSewyIXyLFL8inGbP8tJ.xv5azp0OTKFSZQm81D2xGNCV5y0B.2xKrH6
 PpGoennHmjGhToL6OUUwaFOI3Th8cpt0Q6UvI1gkFzGHLCqBEzt0dQpUP0TQGNuNRFZX5mn_XWVI
 _GXRa0wV.pHFbK_YnCiLXiOIOncgcgR4hE3QZFGjShgBr0eK.WvhHaWhJ6Mm2nUcT1Ev2vCEKYiR
 SNNLrS8a12j9W2c_u6mGbCS1L2jiRlAGrsYfs8mi0XCCnmup20Ie0rbRtJSEtIPYJf0MXqMNv5Om
 HI7IiemZBwa4OYEzrUc3hcFD2T0h2CJAm.OBFa6WEefEuLWWiLT3NyV5HgacVyGfK_2ykSqcP2Xk
 .9n_f3Dm0ehKQtTlN21E7GoJSUKIGojh497KEOLiNDsLP6enKAji5b0gr4FFnGfoHy9DjsCCbRGe
 _OVPob8zha52AJX7diz6qD_6wuHTdfOQvkQTkzK5pbPQLvr8H6UPnwnw5CMQUiT4acwDzo_iapZ5
 uj_M7QugZ5UQJos5Enkq8cOBHSfjGAzUzeycZDf9.CWc2xKn8xgznfF3adrchIi432GzgOLeoug0
 SHTJLDzMcaisfQDl6jfVz2YYRXppnYJ3BIwK.twY.KIJLXBS34VMhUu_umjrz3vjIdlVeU6RYuyG
 HqKsJI2rzvAHIJ1YiIts0oZ5nkK3MSdjl.NRNt3sUEUdnSpI1eWGN5Nu7xOKbGRpfSZCVpFb3LTT
 T3bWS4BFyd4qbNKwNI.tZRxUiiKtd.ZuPJIU8UxfgT3NqqqGGeQ1lvDYxqcLTb7zk73SF7rFbDAi
 WFDEhGquN4Lq8onbdsgsEH8LIVZ0Y4f.Oumz18Xeqs7zCa4lWzTqDXGKkh8X8KwDXePqQIM__Xrl
 6ed_C9oPwhRL6sqbHIUk6RMu.fUEufzF0zkljSZcaNdItXuE8JwPoIlCL9x7thJJ3xbcpckFBagu
 IMAuu9E3Cz6jb_Hu0LmtjUx5WU0lVNPR5UFB8YoU0hid9httiMZpokwdjCGASygak5_fDAaIMJOG
 q69WqrWvIjg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f599b712-7155-4bdc-9761-7c8cd2088439
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Mon, 25 Sep 2023 15:48:56 +0000
Received: by hermes--production-bf1-678f64c47b-5k7bw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 82fe741eda72d826510c5ca8bacf2bdd;
          Mon, 25 Sep 2023 15:48:54 +0000 (UTC)
Message-ID: <06009947-a481-bbca-506a-20b10367b1e5@schaufler-ca.com>
Date:   Mon, 25 Sep 2023 08:48:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org,
        Kui-Feng Lee <sinquersw@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230918212459.1937798-1-kpsingh@kernel.org>
 <20230918212459.1937798-3-kpsingh@kernel.org>
 <cb67f607-3a9d-34d2-0877-a3ff957da79e@I-love.SAKURA.ne.jp>
 <CACYkzJ5GFsgc3vzJXH34hgoTc+CEf+7rcktj0QGeQ5e8LobRcw@mail.gmail.com>
 <dde20522-af01-c198-5872-b19ef378f286@I-love.SAKURA.ne.jp>
 <CACYkzJ5M0Bw9S_mkFkjR_-bRsKryXh2LKiurjMX9WW-d0Mr6bg@mail.gmail.com>
 <ed785c86-a1d8-caff-c629-f8a50549e05b@I-love.SAKURA.ne.jp>
 <CACYkzJ4TLCMFEa5h-iEVC-58cakjduw44c-ct64SgBe0_jFKuQ@mail.gmail.com>
 <6a80711e-edc4-9fab-6749-f1efa9e4231e@I-love.SAKURA.ne.jp>
Content-Language: en-US
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <6a80711e-edc4-9fab-6749-f1efa9e4231e@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/25/2023 4:03 AM, Tetsuo Handa wrote:
> On 2023/09/24 1:06, KP Singh wrote:
>>> I was not pushing LKM-based LSM because the LSM community wanted to make it possible to
>>> enable arbitrary combinations (e.g. enabling selinux and smack at the same time) before
>>> making it possible to use LKM-based LSMs.
> (...snipped...)
>>> As a reminder to tell that I still want to make LKM-based LSM officially supported again,
>>> I'm responding to changes (like this patch) that are based on "any LSM must be built into
>>> vmlinux". Please be careful not to make changes that forever make LKM-based LSMs impossible.
> You did not recognize the core chunk of this post. :-(
>
> It is Casey's commitment that the LSM infrastructure will not forbid LKM-based LSMs.

... And this code doesn't. I you want LKM based LSM support I suggest you
provide patches. If there is anything in the LSM infrastructure that you can't
work around I'll help work out how to do it. But I am not going to do it for
you, and I don't think anyone else is inclined to, either.



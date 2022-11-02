Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2D5C4332F
	for <linux-security-module@archiver.kernel.org>; Wed,  2 Nov 2022 17:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiKBR6K (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 2 Nov 2022 13:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiKBR54 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Nov 2022 13:57:56 -0400
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1D1A44D
        for <linux-security-module@vger.kernel.org>; Wed,  2 Nov 2022 10:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1667411873; bh=fP/i/C7TAqEDJKAPz2zGja8pqzMIolsQz5bFIxp2N/E=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=r2wrBE8KyDrE+rJeH2wXIGm8e/6y7qtnXfmY5bQ/OcTVxuTWOxC+2dqlygxOBeOCH1G4BIMOvypyUcM5sFcdauwVzzhqbMtByc9E7y5QSLAX/t/xARG/NnLs37ohPEpuP3SYjPZdhMJSogry4NveJkMFwOG3MlBj/U2KAIRQPS+77bHF2wXSxNp2NwBLCtPzcP59pCcRghxAelxYncDZ3YxeehvGVCb3FKK+Qas6rC47SL/g40wU2MH35V0r/e8gRNIp4Q/+qsuCcruF3pAY5vXgvtOiplXng+KXUMrj/5EgHSKGtCE9CHrLqq7jxLlffvsBJl0oZBiunSuLzkRNZA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1667411873; bh=UYaXjJDcclgb47h78mlY9SlE/T0/mXIkawXrk4NupOh=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jsKdqBvtNvVxefhmDRBtSzJO+b5almSLroEDZaU7Kuj8YXsfPaPKOcE3bd+zr6ThgKr/xqTAl/fwSj0PxPDPaEHe+9Xmc4GwXs3qv3lMT4New2wdyN/Y4xJKJ3erTgXPzRZLHGu8gxfZHdGzKn2SC35K2nAAFB/g41+SPuioLDpDUsjAoGLyX5iE6U2e7REFxAHjxZM490wlDrYEouFUo2nY5efRh7UblQOKsjUiOhyA+guqRER8Gk9tzlwQzzaf1nxeDoAC0/piJIs0aGx2cU8p46vqKOWH7lt5eqoIT1Id2aiUktBHxpryuiDoUJ9sgtodO/vF0AMuCo1i8nj5UA==
X-YMail-OSG: FG15uscVM1l3Ix06j3.KrwwcripdgA4Iy16yoFlGv4BxvUFeJlI29M34Lsp7whJ
 2Mej9tNWaNlK.Dt4MxEkM0w1pLRW1YmHOJ3tbNRm0iAKy01QEKxGqK1Y3bva5z23e.ik4.LR8ubO
 QnuhQHKJhfBaDpVRi4iR7eqV6Q8yR30Ci_lY2s7zDUpzm21WDulh69ZtDAhNUaM1k2bu2qvBXG_q
 ur_FkrzsBjeZDM3IxDukbvx4g6PgaZZGnF9IgWO7dk1FqnWPjKwwXQpIiqlZlKP5WIYhi_cWt1Vy
 bZ9aXLAqi4LdItCvqyL91gvlGN3LS_UNEOoi1AGX3Li1HSG_eClY0K._n3nS2n1N3EcCCI4LIfVl
 TRJEYXZ_jA03FP5vxD5vAkHw7_BrB8Nj405Stgeuxv6Wxoxz3V7Fz2whA63CPrJ9v5odaE1zeb1A
 AkTcFqnrzewEBeZQgD4RG88ev27WirIBPs6B9M3qyOb4OcoUncG1p75o27espMBp.GR3RffYTj9y
 GkcNeB7SzEWthYLpiMof4tTupXb.JWFIEaJDapjTenOK9uCxX_dPpUjQFgtpUfgLU4Zm6XkCPfd9
 kR6M_.f8llCtARNckggAF7MMC5XpUZ84Gu4wy767or4VArmc1E110z9X.Aq71J79MACMYS4eDS67
 qmcqly_wxGvZikdZ45m7SKbGuU0kraCFxMHFPxJLJ8TpIiNbp1s4.YrYnjF.40GWJzPGcqnmYDTP
 G.NGIghir.EcF27b9k4UZ2VSX878y435tpbpLrxgs.G73pqYRnAOgOMVE35ClOcEcr8lP07afmVj
 mSwChHe0H6dqvJJYpcNfyuO6uAXNMDPtwgIbpyDuqkxfqI_lXwa0XFGHQND0HHbe1pP8KK6mck5l
 L7uMYFkVXOy7eGHZJDnPvtnjMtXIEjTaqNTZw3q.ezUjM1jdLg7CWoe_hWbJ.ckNFpNR9ZjJRbWR
 12EVKVltwu2KksmXeQdeFO_3d72_6cx0bZwAgwOz5ySMgCLqDA4pBaQzpTFE5vpNVA4ihszRmxtE
 FZOnIS_w6S6CIXkdnDsaqT6cMGruxO.7KfI1cGRN9izU.xIulT1foXJ0vnAZk6yXN9jPl5QWalTj
 bSy5Dl658yL50RxsyFJjaX0_WOKgtTqSuDgmFJasBEssw2RKaQFUba0KMUMmmZ_Z.IZgNAneY1Iw
 .2hSwHQ1fUxlj7pyWjWKuCGOWfNOy0R1dq2NwIfRS5LvHYOFOg8Pk4p1cf2QC5ppRuUo19l1hMtC
 VY62hSc8ROgyj6s2AX0N3c_bkBxvqpfbYYNNmrrNJ6a8qkVbqPrKd0dIhrCkVEBjxrC9kkLEiv.H
 UjrczM1DShsUGf1Z5ECCt52xMGrbOJ15eBcKrrG.dZu2kkZACp1OmXB1w_2FTW39TnKtBxnHr7z3
 nztfWpUO8fwROUzxcr4oas47.4tYG9xhL0hHwO_E.JkcxP60lLJYjyex8bmpRz7qi2A8xq4dXt2n
 5VWNf1SWGORIVn.doeXSyv1Buj5yvNWok4KI8IcegMgxjGaXNJIUANWNW9cwPr7k0V8m6AFZBULA
 rCFxK8E4ab7f3NRMc7jRZ8shcR3IO5kIRCAMRdKiwNPEi0zCJngB_qBqDdG8kU60ZzYuqx_FlUx8
 YY9hqvEz5EsQAYcsFTsU_sXYZtIfr_F1VPfqYzMIYN3UCb860.bDzQ4IJbJ7PKCg1AA5_TiIO09A
 YwnuPzugjLtwyuyNAJcIghdfwIsU6Di4ao.wZVtddzGnuwSAw_K7XjwIXZISmrSGiIrIlz6U3dD5
 963EK29HEKMrseDKA31csZDcoVgpNPMCqyrA38F5cePm3CXfKbRDuTgc_txA6tsWi65LCdbB2_ci
 DmE05nzo1Ng08HOYZ7yTvVYC_0ZB32cIxJoWaKaq6gBjwVhM68DM9Milp4tOFtMk6_0UUZWaoh7f
 NcuUpqbn6ZgEKU42FXdvmz9Pev7ptdqrKtT4RDtRqIh1fG.A5n72ibBRl8kITs25PJmBpACl10et
 UMfY5nTbwOs8KJhMg3FkXLL6ZH9PwmgYxBBodciVPexE39OdUxdWABOKUefw85bYeBhM4Y6TeMHT
 s84nRY__NMU3p3rxvpBjGqmBpsfFiUbIe5m7J3eCN8f.9zBdx_vITd0kSEwcR25zNIFTLFMXaiem
 7off0wHgCcw4Y9BQiIgCP_Iihjz4S_COiE1DZ9Rk8YQVHoZI.vREd8fl.fZ17sjPpGzLYNxdMKXd
 qtrxi8eh1VOe90QZsFWKGv5z06BMtm.nNJbgiBl8zOSNFMbcl9uOqQ58k6GYQYcWoKhshs2Xwr90
 -
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Wed, 2 Nov 2022 17:57:53 +0000
Received: by hermes--production-bf1-5878955b5f-p97f6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3c9fc516a883a5f54a232a6665a44e51;
          Wed, 02 Nov 2022 17:57:51 +0000 (UTC)
Message-ID: <ef5fa206-4e7f-3c23-07d4-8591c4315d20@schaufler-ca.com>
Date:   Wed, 2 Nov 2022 10:57:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 04/10] CaitSith: Add header file.
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <kees@kernel.org>, casey@schaufler-ca.com
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20221102171025.126961-4-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20221102171025.126961-4-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20783 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/2/2022 10:10 AM, Tetsuo Handa wrote:
> The main point of this submission is to demonstrate how an LSM module
> which can be loaded using /sbin/insmod can work, and to provide
> consideration points for making changes for LSM stacking in a way that
> will not lock out LSM modules which can be loaded using /sbin/insmod .

CaitSith could readily be done as an in-tree LSM. The implementation
of loadable module infrastructure is unnecessary.


Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE65BC4361B
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Dec 2020 19:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8644B22AAE
	for <linux-security-module@archiver.kernel.org>; Tue, 15 Dec 2020 19:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731896AbgLOTD4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 15 Dec 2020 14:03:56 -0500
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:35115
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731728AbgLOTDp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Dec 2020 14:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1608058979; bh=5w+pzcZkuLjBf0hSiv6m/emlc0EMRMhYz/MnJRp8LL0=; h=From:Subject:To:Cc:Date:References:From:Subject; b=e8ld533lY0DbTa4/UkdIzH8Ll0o4RNFk6zTOYONz3jO4Ukx/nxu37vzYyffqyEjI+zo5c0kEzay8bzjBvjQnFRgZUXilvJMhQjVYvfcR9KPgVXkxfIp5lOURN7gjlSKWvSvuVuVYk/tJlJSFpAlKEI+4q6KdBbGVu7ZB57f3AYN4xh4CDcopIldSreUL5LdyVr+nJnDQGmV2vBaJYeRP+6PnOsC6tWG8Zfgu2E6iQSVdlMnfLGUrCXpfRPQzlCDn/u/YfB7yPe2GzUYrhb0f3LrXJ9bC3jiAN8eVXEpevDpC0hkMj/zp4RZcBdhH0rlsn32BtWnOhWgwF+Nks2Gk9g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1608058979; bh=tEukufIl8jnHYfOUaM7ipKMYrozf931QBH3PnEvJo0d=; h=From:Subject:To:Date:From:Subject; b=PSbjp1iuEq1+62WdASsSYRHl3xfUL6ej5BKYMA5joom8KddYfk+9tFcwK73LuqAT5qJAoNJi15W2o2fiYs0jstWLsrLl12/TwIkzN1dmzYHTDvDKXqQPh8GwA+xZg0aonf8eGQiqxqQNP9PRBoHO1Gx0olclzhjXDYrZpHBH448hyl1mAGjjO+hu+VU1FI9J8uih7WQTvJv5R5AI7OHHYuKDNVuGXOhIXqBSkEqY8JwgCV4w6oa9r5JcxoZ+Btd8pXsoeBAkQcwFvTNFiZT66ypzm8gdhsRZAGgS0mhOcZUvTxAZW0ARY9BnNkGDTwoaNpNj7yqslfcL291+wenTIg==
X-YMail-OSG: Yd1clfUVM1nsOBPliaYm3NHUCG1SqvLMPLoKLJGQx58Xt2NbLF4KpEqcNwQkAel
 xA.FpLW_Ow._xvw_eFQXqxCfqq1PbwLTFq5vbfFXszyLdcYDLcYQGIDBUpkcT2VrCrm2m4zlDnxe
 .YHwzmELX7FvoVhAE.4xZAvazyOuruMqLCBS_c6yf.5TVhiRllqiDzoGlYsfl8kxvlMWL06lLElw
 vdw87rWz13ItXH_7u0tVdDNThphZ7E9RICBTUkArpHR3juTLmJ3VLWXK28i5Pe6nKjk7cNcHBxPq
 8r4yMO6mjkgCrKAr.XoRcNA3QxyM86k333TwJAtlxMZkq2uInqNM7ugFxYXCWpRlrsy9Qzs6.MnW
 Hz_tdoLrvuvu92LjTPc2d1LcYKg_T85zY7rdgLtAOSmAMZL.8l3svVQelKQAyujPUeO0NmEnJWy3
 N_13ThbmsE_uFJUHhkFXQGIqdGO781oeRwSBr0YSW0iJB0eZQhJMXwnj1XAJxknajD33qUl3oT3v
 pfKwXWzpKPAUjhgnb2iICkF6YqVegKB6iNvFEDOAdrajN5nE8obRVV1iKLzX3h7ZayU6gQpt0zQX
 CNbE7ZZHf8p4H2b3yLOBvZRadMTvTVlMIXY9N86hN.Y0nuhs1Qpj6B7OKW6ImMZ5jAT1sZS7iANi
 ZHjtPnUJwr0qKNGk_18OXdx_D6oxmsR5iSCvgv2rEsBy9sUMs.6YECkPsqUUjhLnxL5huj8nYug3
 NXj15XwpwAcYCUnz6rbAEDCWigxjVQuz6_vhkRVkU91G1ii.HDVvtPmtcwBSPf_qN8mxnoRGJbPy
 R92dNxJuLmYISQBnbEPtnJaG.kJ2oAmSCrO.4XflPJKdYRsqvw1uesiuj9aeDOa4W2X8F3RE1d4x
 fVI.WdxArOtL5H8IcQ.XyN01ygjgc3PRgMMUA_L2lxWNFMqacHdy0Hto5lX_m5rJ2a4G9MeXIeh1
 M2BK0QWeUHhZHPmRJsHhiCPrw.BzflvY3LSx4iKxATHlRCQ4p5xrXRMmN0SQPZy8QQXa9cIHcPnS
 oHaKeC9GlOgde3KQizyuYiBxfS8ZvGLWQXgtMdLEOdYN2wrJKGfVAgUcQYKGHMf.qTOHGSSRHjHZ
 326sW_M5UceTKBF6lSrM5IsLFfnbkYwaTjax8nXCSZlaB9HNW9qUPX_Hn5LRq39aafM1BQVTSzSI
 M4tCAIBieJsCEcMM79B_l4vqXf8fC2r8fVrzCzzr8YJucSzGJ1kXMPYSRekSUuzdd6Qmhk41aw9s
 fK7_7RI85iNP9b_LwcovBSqgPPnD6AoLqGgfqKu5xlYtZsAnUao1ML6e6jTuYgxtd0qfNfqeRmyE
 3vvLQDsVI.1n6fUxzDzTGoMEfupSOxTY71lHT7HNtd.cs.MGpU4wb5q.mLt9vhsruUqHzdfdV5sJ
 byA.1nt7Fcc30tiaEcrpbBOJUe0cLyex28aoNWV8ZmKQWZbfC1QnOCMdHg4cNoZGDPp3WLRwWdGk
 sovle2JEUhmFZrMo_vYqICUU_cZVIkj1fq3UOpytBbOHgrbeO1LodtlL_CbXF6zGld.JmZY8dsvp
 856L0b8_twayzntIdRd2W6wxdRuDBi6nxtWTB8CWbygHtF0ULW37PZWDV4_rBOcNd5fio7M5_BLc
 YUDun5BXXJTd8bOJUwKZ1zqJhgWaq_zCmawheS242mk_F9.2Zdnj1xj4kXTgZDBgBpejAT9tFcCn
 Bk_R8BIJPuByBwQHhoKia7nEBE1Z258YMR69kwD2LL42MFv6Cn1wvH_uN.68u0q_wg5KCcEOI3Hg
 DVvYpmjSCchL_jFxMg1q_MsRA7VI0krHF00QOc2o1GgU4f_IGSP15XTqVcLi8_US_83wmj2T9wla
 qsi7g0o_ONHd.mKlTJbGJ9RIlk4DWjccbs6l4rpbGKZPGyH7FtICqXLB5vnt76fn63Cti_GWHTAt
 GmTq2DmSLKdmk8BXfB1D51dIWEQDLTATZsEDwFJKV5UN9cn0.Zi1_B_PxSYwbmrQskzyDpdKlwVn
 _SPPBEn8NB_IUsr2pqNXVorJC7M8_RrASDON2Qg88iIJKjdoLesqXIaVm8RD5YtXMEfBgW11o_lX
 oBzsuQZRAqaiHVJy_9PJfM5mFKuR4uU8pJ9u302hqcdDGsmJB0k35HLiWWmUIopiM3ATp_pw.Y.X
 jq4IaeXae4AklsDsfFfdjsgjeP36e2TR_AvhjaR2.lHI2vaLpfrIM5FrRgIQb7umwO4z9XHgRb3p
 ggDH0bPCw_Vlg.zcLbwurnNH0L5HndaC1A.AVCjqJbawV7d4jbqMS.TgDYIB0j9o4_WDyWCTWqd3
 1ejLpwAXaNDWLNclgdPeEFGuu64NwHx5cB5wY3J2Z0MUsSL.mqFlVWHkyKfhV5TguxTr0msUmeoa
 Cqzftfd1M8gYD4bAvaOlQP9VW9F41qfy2HW.Lt3aOlkgufMwFz5AkKFfKcrZe2dFsdS1OqubOEnL
 gjEJQ4itaJEZGaHgGagJ.IzeEcOH9lahA_Db5gFBxz1Oygf6cjzsIXQFT5bXnzlx5vo82VKWdcTW
 d3Ml9xce5C9NZ3fgoJTqA114VrQSg2BshInK_hfO4N07HpKH.rmGqIE26CM._3qwzQ.wMu20yENV
 dfRh0KjzlAIfDyy5KrrTptN5LCvbu3KcHAdkZj9T4vpqFk8Rco8pUmQHfBO0Na8kP1S1tWrs9uFu
 putLERKHMK5Sj3.hF3PWhUrbUqkS_tg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 15 Dec 2020 19:02:59 +0000
Received: by smtp408.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 4d99eb7ffc44281bb91bbb4c8dc0c244;
          Tue, 15 Dec 2020 19:02:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for v5.11
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     lkML <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Message-ID: <7bb1c722-0a4f-2799-6421-5c3741e7c106@schaufler-ca.com>
Date:   Tue, 15 Dec 2020 11:02:53 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
References: <7bb1c722-0a4f-2799-6421-5c3741e7c106.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.17278 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Linus

Here are the Smack tree changes for the v5.11 release. There are no funct=
ional
changes. There a code clean-up and some function header comment correctio=
ns.


--
The following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c920=
91:

  Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-5.11

for you to fetch changes up to 9b0072e2b2b588ad75c94f2c6e6c52c8f4bd2657:

  security/smack: remove unused varible 'rc' (2020-11-16 17:26:31 -0800)

----------------------------------------------------------------
Smack updates for Linux 5.11. One minor code clean-up and a
set of corrections in function header comments.

----------------------------------------------------------------
Alex Shi (2):
      Smack: fix kernel-doc interface on functions
      security/smack: remove unused varible 'rc'

 security/smack/smack_lsm.c | 3 +--
 security/smack/smackfs.c   | 7 ++++---
 2 files changed, 5 insertions(+), 5 deletions(-)



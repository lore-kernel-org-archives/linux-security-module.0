Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC7FC432BE
	for <linux-security-module@archiver.kernel.org>; Tue, 31 Aug 2021 18:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6696F610C9
	for <linux-security-module@archiver.kernel.org>; Tue, 31 Aug 2021 18:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbhHaSyR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 31 Aug 2021 14:54:17 -0400
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:39990
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238733AbhHaSyL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 31 Aug 2021 14:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1630435995; bh=TCQ44R1l5FTBy4S1XEpAtly0JNySReVb5ki+Z/19guw=; h=To:Cc:From:Subject:Date:References:From:Subject:Reply-To; b=Z51FRMRlRcd52Z5et07NoZQbNo8IzNHMIVH/4fbFk/hsLMFkOclOMnrKhWhliZOYTKSYNVgA9fF/dj/wzA1vaLCogpeKtcAbye7qO1l1d1rfvwT4a4l4cQF+O8/k33nX6ukYNjyx1EjVI9rJTbV3cE7K0ZXSf7JhKxjIfG78b1F+ecS3jUPpEIzi2BDCHgow7y2mKqJuGzbSB7DsDVu4EYC/Jv6t9QjaMU4pRzeiAtuFk39Q3MGxJvSfxjKSZE+rSvgIBl3HLSKHtPSyQk0t6D2gquGXhuic3mDVuj+dEaap59kIUUfB+poUTwbb5rWYA4t07f3lVsyRgsL0Uug5Tw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1630435995; bh=ZHUUKSHsKWr5GRX8VE6E6w9Q3Fjoktwtfi62sHeH0zc=; h=X-Sonic-MF:To:From:Subject:Date:From:Subject; b=fVjDuud/rtQNMChf3MoCWlEJiJtO6idBS40VLFPgz0fhl2tiVRLhh2oQl2fnmtfui8oSnQUoYA0wOfIohmdNICLKVuzdmOkV1wPKSVLWqZ7uHSLPOccFDmVs2a2AwCNbFkNMsOoXcwWS0Xp1xfVKqDnFS74J109HL6yjk6K7wqInpc0wHDWo/+ETt83wRsE0C2cI2eg5aMeIbLPAslphpJlkl68KVtE02mYvO/R60EVSgHq26n1PxBQb3kZUo9QkzaUv1dAkY5EdwUQUrSqRt3E9kQEPzoYEapJEZ+LnoHsqspWdStn4hIdicii0K44iPKVlIfGuUWx/YItYbZG2uQ==
X-YMail-OSG: 26s7PvsVM1laeIIQP649umvkg5YfLJVG.BOYO4foePD2KSFr1t7Zp_jVOdwlQVd
 LsFaVCfMNqrr62vhDVxoZjnfzinlCPP4lItRce96whm.XN5iJ.1pJJApmy.YTyd8XojRnUT0lbN3
 rPbAnWpzytJqP8kLywdTt_.CD8eXnpuNcwfI.0QJ2_f97rkApMOS4qghvb4Ys4qMIs5TLHzr9PmC
 _gUl6Wzn5AdQpEtEtGfKZ9I5uP.u6l6J48AXmxaK4mQ4OUCYDBOd8FEM.nRyXnCCcTQe3hJ.fxtH
 5S8clXUwrhuQGQrRr9UaGTw5vsb1lC6jmU5CgMTYxsQPWPzJzR1IIK98zjhXFp3rHaApz3338oyS
 XV5GawyfoRKR5Vy1pA5IkqC6sLFOCJLzjYNcyFa6Ltl9XEuDhUtjerie5xFJjKjclg7u3gsXZeb_
 QBfyh4L1FDsoV0AHuXHAbckqYxgT4kHxDVfvFxLIy7xqOO7gpHJagHNFMT5ge7oyYyaFa_VqQdTt
 bGf1hybsvdDzH2.06BaWKrSwriLl3Wf1TqWq5kATxlmH3U8igqg18E8UY9m2rEUlUgL0aezhrqfi
 zwulvFK.wZ8DTkOFab3OgutYFG_9RHNl82UJyLAbJjU_XNgZjRB5gBBC77PNdbeESC8MGFo2O7Li
 pcJfFjJ5JRFVYKCVOLKIPlSgHRzg62wFR3Rx8xSzAvgIGheRT1fLaWXxzbePc2TVvdc2Q.vbMIDd
 mosQqVtZkxWf1DWOFswsoqTSoBuAqqJ4Iss0QHtMjcVxhjS1v8qQw_Cusc3Hk10aHQGQjnY_vq_D
 TP9DvsCMs3cLZNZMk_XTFgYgJxCrRT_aLTx6GdSRBCxuKAyBxKkIFeMRtQnUuU46euL4VN89w0Eh
 yI2pUW2VRZNDeYxVGwuzAVcZjHuL0RSZFdPopXBQaKhc_.ptQHlWc5mR_d16Ga3S5XUgK6HLuOUD
 2BY8o9uV9jmkqAgLAPbmkOqw7h6WS1H6tnHe6k9O4Gws4W8Hn83y1IroE2r6J_uqO7Tmn.3nS7BB
 jRWFTeDP6Ys3ts.9f6p97g1wfPhyN4wlAYJCapFyWpz1AO6arIR.dQJzOYbSsRQpfDINqCGkbomW
 KEb93mZhyuWboGbT04mCGLhrS2irquDCzFrHb.8TEJgOPzKg1lLsDJOpgCONH6W6cQi4Jb1kZU6v
 ar9jOlXnxEprUbKVg.0YLXYjorMQeW6tiaMmTGxMlXCRsn.KO_OLDNLUYBwC6zzT24tyT3oylZIO
 RodKaHNHVz.O5XHksaN1gF75i2Vu4R5lPuNFofly2EE9xb3rwNvWifJQHMHx1vx9ke4z6Wgf_gxZ
 6jYav_ubdzx6zfuEWRiZMP1COB40W9D6wE8MMsdWZ._NI5m5g7.61Pt4RHjPotimddhEfHkILngP
 VN8m_TNpjtSX2_Fs03F5tEiJX2Td7wUKQJHF9ICTpQ6XLFJOpXBLGBMH6xzR9R2I3osQMqEyNADA
 4M5TTAissAPuV.oUthmG2kRxI4ISfIsTBIG_dMNKAYCB1QkU_g0IOz5QsVp_Ip1zgcFOv2t4Ckec
 RV4oFcfMOoKJeAK4uhlLKukSjR2_luQwkyWvT9HMTAjiSvM1.0BQh93t6ulwYPvqw_bwjlmNZG_M
 EwrOksrfNrpG5JAtoqB02y4P5J.1vN4T8AT2jJttx5r1L3sUjdndN7TfzQZ49Qg_e5wDjlQ4xywe
 r3Jo81YGhil6flv4VHzA8l0mh6Q1Jg32uvE3gLm1o6fmQjwDl_EwaUTMq.pThD7e2gpQ5tqlxUSn
 k0HWpkAh.RXRhUa50DRPV6TJKlFmb0zpyoyQ2UgK1iGX5H2OxGy4DPJYO80ST7IhYiZx2OHcrGeH
 UXGOxLMKQOaNCdLL8jiv2vZUII6WklXT8lO5q2JB9CfWIgz4DcMsAwVUnyTH1lhClmalSHlGqA4q
 S8dnzG6nL8fbv.SDFqwxpDk_db5gNzzOmSzuNA2zBc4J69AJrhPxzTtBsiHPeTq.jS897KFya9EI
 BxhLPX0dTWucsEnfiZkdXSMYTzFlNSHdz3DLog3FaShmlILgoA1TMIPkQA6b.Dhw2gvz2z5hufVy
 Nhj5G8SpHflV5FxtRRzmnbEo.wqw73AGm3_RSLtQC.lFgejKJqNN3Qz.99_zO.kwAZxE_PpB6hsb
 6YMIybjHS3GsmVQ4yRoW0Gb0uuucM.58hB_vDaw3IsLGaAQHr0QSPHmSRaexLZqFKBrHWmnyPLsU
 KnFPf080ysyHc6.4Z_iVUVglP.vCAzORHJB6r7i38iH8NjIvKgGcofPZr9YciRBAv5iGHUId_edl
 yLNouuUs4LiE-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 31 Aug 2021 18:53:15 +0000
Received: by kubenode558.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0093693c11ca727932d726add9c44c47;
          Tue, 31 Aug 2021 18:53:13 +0000 (UTC)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Austin Kim <austindh.kim@gmail.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for v5.15
Message-ID: <ff60d9aa-28b9-9c6d-f318-94dd51a95abd@schaufler-ca.com>
Date:   Tue, 31 Aug 2021 11:53:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
References: <ff60d9aa-28b9-9c6d-f318-94dd51a95abd.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.18924 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Linus,

Here is the Smack pull request for v5.15.

There is a variable used only during start-up that's now marked __initdata
and a change where the code was working by sheer luck that is now done
properly. Both have been in next for several weeks and pass the Smack
testsuite.

Thank you.

--
The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-5.15

for you to fetch changes up to bfc3cac0c76126995737f1b858d2cdb476be5b1d:

  smack: mark 'smack_enabled' global variable as __initdata (2021-07-20 10:34:59 -0700)

----------------------------------------------------------------
Changes for v5.15
	mark 'smack_enabled' global variable as __initdata
	Fix wrong semantics in smk_access_entry()

----------------------------------------------------------------
Austin Kim (1):
      smack: mark 'smack_enabled' global variable as __initdata

Tianjia Zhang (1):
      Smack: Fix wrong semantics in smk_access_entry()

 security/smack/smack.h        |  2 +-
 security/smack/smack_access.c | 17 ++++++++---------
 security/smack/smack_lsm.c    |  2 +-
 3 files changed, 10 insertions(+), 11 deletions(-)


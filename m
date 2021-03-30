Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4684C433C1
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Mar 2021 15:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78035619CE
	for <linux-security-module@archiver.kernel.org>; Tue, 30 Mar 2021 15:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhC3Pma (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:42:30 -0400
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:44456
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232421AbhC3PmR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 Mar 2021 11:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617118930; bh=oSDHq47SAtgk1fwx35vh2D9jNNKisET2ZpTrWW0uy4w=; h=To:Cc:From:Subject:Date:References:From:Subject:Reply-To; b=fnI92niXg+vVdkyFwlGFtHVkf3Db6xGEzFUMIMEB9aPkpRpZcATz8vesR60S9FBmNbYzHF/fPnD0kQ3o1uSR9ZE/IbNugF2XZ1Fj+E75mDSweAisFAPR/1grVk6MGWUFeRS5TSVhHn+qho7oHskQ6aYbixO3sFjpgF6uMJUS+H/VIxlK+xkjnisf0tE7ehsVP4xKa2LdrpcQ5geoOf4fBCCAL124hMPSywKX0HGzHSdNPOaiONaAJxmqQAuIOMSkqDEj+z8MRRlMlzBhyfdXQoxg3zLSBSXY6xGcMNZg2YrTZTrXWghkDtDIRrYI7/KO1B4cKcuNT8mM1OWIMhOAEg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617118930; bh=8/m0t9nR7MSNk5J8vhPb/aqBkdD6PNxZxIsiXz2jehf=; h=X-Sonic-MF:To:From:Subject:Date:From:Subject; b=md05Uo5pffu2EviRdYoX+aloow/5qupDv9lqJhToSzF33taVn+t/Nf0+YPTtMNFZyLgFrb1Z1kumM2A46odqo9aK2NTIxoWOcMfdYzzs13NT0jwRyofZr8C3h1tMRLSR3IIwLbGqjEtWH7bPAR+G6zJF1Neiknx28pt1e94gJUrxEDRbrhe5BETXVk7qG44v/u+6j5B8JSO0IowfKYfyY0Tra2aRTMuhVR8lQQfv3iW/N8Ooih1pu7T+60O6JmzkkCG6kfOudFM6DAJU7pZtZ7449pv2nJJreOaY8dhfxmU+chq9Y47OIXwrole/Umq/fCMak+6+oA8veSwHfh1dKw==
X-YMail-OSG: Xdp_AEgVM1mM7orcWB9azAahpKg9kpGitLOIdmhUzB4pyK8wPjYniIXaISQ7Prl
 9CdD8ETyhiB8BjRqcRAYuP_5hocUvuSFEk.NbOqAtymEkMWR3eISgtJCbxLoVkAoEn5YcvPucnXS
 lSvtq2mU5hhJigReTaazifVHmOHBCsa5aM.SjV1ho.ZMZkHt3ahCJ3JWMCV3otXEo5PzJDsQClov
 uFqXhHvhkgIBW09k0rL5myciIffKBbZVZzBhlnnLpbdbztGi8CWNb6Pl1GIZvGoazMxrJaIEUoe_
 0hA.t0GV6Lm2PyEktdgsSV1.YnWaA11djnwJJwNmbgv.zNraqsN7_785umdOg9sTbkKgT2226m6j
 bxH124tS0cImpv9QDSb_IfPkbONlU0slyLdGUTVmOFsgNGbGVhKWvTDuGkTBC4tm1J9wysJfqM1I
 Dbf7PXlbBmaTUovBeq3HUQ9VII3uAUPWnE8hqRmYvRJR0fwcuFJhyg5_peAXWPEk48_iGNNMf0Iw
 fPOFRD4VvvEzAI7b8OAhKiGrs6pBxKwhf6.B5.XSJDOt3Dm1gSQD.N6FAnCuyPjf92NVkBvsxfIG
 KWA1WnxoG_wmKbKE6uSOAtDQVnQjFUuizc_7XQVMURCaQCJ_g.4LzytqMauYQQkc77R.2NkHp.eb
 EvxSV0xLyAqAZmf0hP0a1nG5p5bosXKTLJC0RfibISyimDfKJv3AaKVlhokmWll1GbtLFrjszDUe
 AbDo9ZbUfS7JY6ARlqskJw1vos8JSysvyLnCZhWfKx9aX8K1Igwuc64RBLK0BHdMNgoBtaSJjryx
 ge4.eOJDe_x6BuLM5gcPbjQzzp8r3hbvFZVUmAJi00kIg1MENQ0gjdVdz6VZHc41k_Hdzy9xhdRT
 MTy6VNqrlzrkHOnSruiT93ViP6_gEjYp.WZFwcQa9uN0GUTYIZaR8I1zEerqom5KlbuYb_BCOZfR
 zWz8Kc8_L0s2ZEKeRpLSrxzItnmK53TJ547FNw6Vd6s9FM9FkyP1e3NP5FGiq_HRKnq9oy7X3bp6
 OZ39_bdTS0wD9VNkr3FCTbV..Lnyoy1dMTT4_4E4e2V8t9Qf2GQtqnr.I5i5YanmFFOjpfBGd8bu
 iKqwI4nj_mJTrOa9.Qlekqb04jLaHWNdXb_c1GMC0h9f1PHnGU5mwjUl41rHRxUUhlWxUbChy3ak
 hjMu2g728jvQmLuMVdGuB3RL3qRb.Sxss6u6u_ZN5QgQGctY8fa7w6Cr1ylZAheXHytMZw5jK.PU
 0kzJikTqMkE16Y352mM2OA7AWhxOTzCXNYYsTJmxGxWkOrLpXMr0xUfxf15kGomj5j6ZMOHbGsNk
 7cYvN1hWaGXsijJu.Gk9gkp9BMqvd_b5BCYjlBsoBCd_bFavuwsZSjgY1a5xfy9LlG6EQsMDXBq8
 p5ivUFQOu6E8Fa1kR3IRN7ehhMptCsrODbisvxOnSrtUP1vxgt6wiw4I7l.CkbL_CtKsXT3QnZgr
 74Cqx5YzvwSkjDhsWgOo91ZSKfeGPfkRN.EWoSTgwdnAlgHqJt1AJpYbqgI.9NqYjHHPjQpWMUxl
 PTm3pbK1Zi4BemH5iwwRgUepNJs6M12UcIjn1Zee1mL9wjoNrJh3fF1ROAibkM5GDTu4YATMXj.G
 sf3O5nU3H2d94XJefxXVY4XcmU_7_J87a69JqhFYLDwz_xKFylxEEBASvbAUupCfuDVCf8nkigTZ
 ukHJLyg_9PBP2SDZRYD8IQP0UCbAIwyDlChECZxxCcY29juc1BNMB9x0uu3h1VpvdYI83GP0BQ0o
 .8LyW7kttBghJ0qV8JJjpohI36HydmrQsGs79HGykW2Pwht7qlpZnxtV0hOajqJXdpAnao7Fuw0i
 SMeZQrG.n6Uh7ssQPBFkz4UHgMCqD_fSIODR3v7Ydzh7LWpnblnB7dY._IJOuQprucPxDnPMYHKZ
 PqOZbtpybKWHkfakRNi8wkkyne4rMNYmJ_cvAlZOmynyGIR3CuNAV2B1QrDVbBQoCWub7W9udjeF
 enYjgDcC0.95ud6KzSaIRtGC_n5G6jNSqqY9Kw0dQSb_Z9_SLRVI0Et2rb2JG2lDgY_9qbSalzRm
 OSiKBiLys1nf_a59SzEc9zBDEOFOA9Foi1pbp8QQX9Czn54M3Duf_FNDJ4M4vB0xDVPQTre732dy
 mT5zeyhGSLd1NI_Tap6SW5o5IZ2HZcxWoEwhKceA9xhmDuXVVnXcDLA7Ek0kzF.mxIPVib27JIqg
 TZQ5fJFl0mZCaAzPKjosvNCFADTl5P6KECSyhZg0P7BQPNNLvyRABb3G26N3H4HRI33XWzIgUGg7
 IqsXDYXjsqy.QxB3VCo3vaLuLsHGUsfYQrhx42WZYEsDnbPQ0rvhz9JgLVgnXxlYVdAwxplDnEES
 oQO01Yqr2SCTs7H5cc9aECVqkKqe_RqehQEMLXXiahoHwPwJFDnjNUiVXxzN.hHaNoOB4Vl_tUgZ
 UlkP6sjBiFA9pI6He9FBH8hv7YTuZaTWrT0KCFchaRhB6ulNfTCSXu6kBi3qRA1Jd1qDtVbGa3y3
 R4.YnlsP0M0f.xnamhBcnc5Fhu2W4qLwCBtFDrI7PCGmDVmGE2SeQx3J94y4dLxigUvnVm8NKgfv
 moqUs3hpAlbUEiihKSFcFMC4PzK.pPqgfH9deBYxu8G67DWiG1kBUZgofZMf0bKNbJk4G8spVU91
 J7rw_kCvxaWTt6lepJlYNHNzJwPDNBNlHbBqPfMUPIGXTSfqKKWF8KbZIsyapBzjKPKDs_QiAW6P
 oz31g94pV7wCQ
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 30 Mar 2021 15:42:10 +0000
Received: by kubenode528.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 49bec641fca7f66cff32208d4e1c0a3b;
          Tue, 30 Mar 2021 15:42:05 +0000 (UTC)
To:     liuyacan <yacanliu@163.com>,
        "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        smack-announce@lists.01.org
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Commit f211ac154577ec9ccf07c15f18a6abf0d9bdb4ab breaks Smack TCP
 connections
Message-ID: <3f8328fe-e648-9d0e-729d-eb6787f11bf9@schaufler-ca.com>
Date:   Tue, 30 Mar 2021 08:42:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
References: <3f8328fe-e648-9d0e-729d-eb6787f11bf9.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.17936 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Commit f211ac154577ec9ccf07c15f18a6abf0d9bdb4ab 'net: correct
sk_acceptq_is_full()' breaks a system with the Smack LSM.
Reverting this change results in a return to correct behavior.

The Smack testsuite can be found at:
	https://github.com/smack-team/smack-testsuite.git

The failing test is ipv4-tcp-local-peersec.sh, but it seems
that most TCP connections hang with SYN_SENT. Oddly, ssh
to 127.0.0.1 works, but other TCP connections timeout.






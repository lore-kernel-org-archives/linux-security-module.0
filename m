Return-Path: <SRS0=B0YM=BO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A82C433DF
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Aug 2020 21:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1C312086A
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Aug 2020 21:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sbys9aic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgHDVs6 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:48:58 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:41050
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727120AbgHDVs5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Aug 2020 17:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1596577735; bh=0L27Uq8ZrsYi22gP4kjh4ixcW31fg5B0yfsMY3ayTaM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=sbys9aicF+5bXJrltrn9ucCHo8U1Q+2cp8or60KpTSLSgKCO31ve5s+FMjycEEQiNiQ/8/ltBsmF5vmiqpsb7HCGNydRR5IFCaxwZmuDSUiQooix+VwgnR8KXRyRTABi0Xb+v7uSER31DM7vrJX+EPTHZmBI5eRt5sxvlm8NZl22qKccn0/PpTAedIC5JpyIk+bvKP3GorEvw6EKm+w+n+T3bPjtWJpv1vzoBTnxEixPl4MmHhG94JFMl1TrXSYkN319fQtrOfC2tUFe1k39yAmeoIkJWQCiNNncZmp8tELwBT6humAnjv49CGmdkSFY73u/M+cRXMKb8GMzOUj1VA==
X-YMail-OSG: Qgh8100VM1ngycjbd1S.nfM6w0dGp7YvvO15Nf0I9gK7HXc9qFP6rX517qEtTkk
 uoWOhvT9h5dwBbniYQxeteRwIZtJ0okru2SRsKM3NgaxFA1eOPN_sSJJaSGWdZODa5HvlBuQKuaf
 Sx14cQCspNsp9DwQJ3TvShGxKpsqQH_Eyy5ij.jGJULszl4xOB8VnAmSNlnFeksnpR2DikROwqQ4
 ycucRYImc70zc_DFBSOymVq16nVavAgAAlEW802ypXVaAgQoplNOsWAOLoc6zdxR1CLq9LKuQmIi
 CBWV8FgFN3uOba6wd0Kj3o8pcgW0.qOfNBpCzooL5KPyauEDmtw_BmJzrZiM5lA778.cNdaazp6v
 3r0_C9U1aaARjkz..rFph3UG5nx.AAZqqE8zCVZaXzBY5qYzRDIkcaaCOEwz5zfdHzW5_Kxgh5OH
 M3THxuotf1ditrVnx1mFHdG9CZbcifKWsINMdGvmnX4DidYXGRwZqe0QjDjuByfablLiemX.yDvC
 vXvw3lZIkNRCu4FyA54p3heHfgCEOqvkreMnhE_DzVeaw2twJvIcrSldBSS.Es0C3.vlzk8TU23s
 LDLFYrRsfEEltDWvs8.attysc6yGWPl_w1dSPVHlm6e5zr_6Nyb6kszkz_tGkX9XXKdcpSa_DlKz
 KHgjj7GW.x6PLIM2A4ucBGRBDCF8Py53CtawJ_s0dSDe7bBdHA8u.T4YBT5mB7YqZnl2UU7SCOHc
 rSxnIUtIJKUiY1kijL.nkKSHxyg_M_i_Er7h6HuR2OncQXqsj4n4KtgQH17pyA8lQVHfV17dRheY
 epCEngcGFAgfDEq8069vwIkUgucurDip_k8O3JuXuQTGS.fwNAkCAkBCzelc9rXQuzoAqSM0ag7e
 XoPt95.Yjb6_2xgly.HYdBU.nP2E8BHswsW2LVR89f6Ke55FGcb9hev1zu7mmQSadGsQAu4L35sx
 Q.Ogj35RiFx.I4r8IuyexAVLnwintkep0Y8Vv4bWpVplWHW9blE12lNFIWmJSAgGiwhWZauyTX48
 TWy8aoRj.jd4lZe.992jS76W8mZfUzC2gS_dovI8PVINbc4EPnRM2V3fNPqdE66n7_6VCjqzVlTM
 d9vKk6NUKo4orFMWo0lpy.BYQTjKr0PJ4bH7a0Umjex7cjAGturt.634PC7hphYRFZjTRaZTTu9H
 4nxE.FQWG40AKkedTJ_wGZowtzrQQ0oKOdWHOEJDOQ0tdcnzeqy5mmS0zo5UuIaPf90xum3YbhuZ
 KtdZMCiW45HBuMWROpCcVF.GXBgmmcLefYPouw_5T0jq1mshm50kZYgVimnA4xWmRPsT7igjygdZ
 Fz34dMtRwVeZ4ogIIDjT__i.mMo3YuoVGbVdStILSzzkh
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 4 Aug 2020 21:48:55 +0000
Received: by smtp402.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 01b7835d11afa0d3bb48b983b86ef450;
          Tue, 04 Aug 2020 21:48:52 +0000 (UTC)
Subject: [GIT PULL] Smack patches for v5.9
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <8ce85723-5656-0ee8-67a7-35597d9df0dd.ref@schaufler-ca.com>
 <8ce85723-5656-0ee8-67a7-35597d9df0dd@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <38f418d7-ec77-255b-2bf2-dd73ebfc615c@schaufler-ca.com>
Date:   Tue, 4 Aug 2020 14:48:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8ce85723-5656-0ee8-67a7-35597d9df0dd@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16436 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello Linus

I have corrected the tagging for the pull request.

Here are three minor fixes to Smack for the v5.9 release.
All were found by automated checkers and have straight forward
resolution.

--
The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-5.9

for you to fetch changes up to 42a2df3e829f3c5562090391b33714b2e2e5ad4a:

  Smack: prevent underflow in smk_set_cipso() (2020-07-27 13:35:12 -0700)

----------------------------------------------------------------
Smack fixes for 5.9

----------------------------------------------------------------
Dan Carpenter (2):
      Smack: fix another vsscanf out of bounds
      Smack: prevent underflow in smk_set_cipso()

Eric Biggers (1):
      Smack: fix use-after-free in smk_write_relabel_self()

 security/smack/smackfs.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)


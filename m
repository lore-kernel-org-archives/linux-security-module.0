Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC36C433F5
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Oct 2021 15:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2DD061074
	for <linux-security-module@archiver.kernel.org>; Tue, 12 Oct 2021 15:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbhJLP2g (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 12 Oct 2021 11:28:36 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:38899
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234330AbhJLP2f (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 Oct 2021 11:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1634052393; bh=2nz1UL+/i59bF1JQNp/CRy7h9MRCjukc4ooD4NdF7Ug=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=anxXjQu5kjdf2eyEEsiggmU5orVUdiee/rzbAn63STBz/cdULVOZmYMziSOnxamrkIjWD38wua1sFSHSMRWYwiYEuSmF8HUFn8YvZi19C5FUnoUAa2Q+Dx7WmtMkgsk3XsJBoaLaSpc+NDezNnVucSSJN6QGXfGVb0Ei3VAAXlFkf3AOehjSycKD5GUVG/Z4lhiwM6e2t+D3L4iG9IqFbMEImlFES/SgETOVReUdqJA1OgCL5FaOit9QnD/P1wl0+M3HFto0qx39qFTlc5NSEAFb2P//qQjLGwTu82QdNf7cZAz2W4/VyWD43fsregjQKoKUU+WK2cZiNPur6fbxRw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1634052393; bh=idWVnrTSL2rt0ncv8l/zkVDpfjvpK+DvPqWHrfhmrSx=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=h0d9uKS6UiMjw2Qj3KzFOt0axwviyqFdZB7aElRXwD6skn7ira79o/HqjP24NXXJntWIUrOkXq3/P101Gk7ymwh0Sh1KAgBcYVGZHgKaYIIIbf9hhOHnJZaX1LRVdFZ3IGcJIfDYRcIa3EGT9GN4nb2tiCCCuZo9QL3YjTuvAOkBQ8ao9Uu8gZyrbCEMdyhJQZSY3EDE54fldiCw50E8w7UXkplnZbm5oQTlCnY26hAVRcxhgMfLZ9Fut7o+VZ6qYvrMxzS1a971h92B46zdrUCe6kugvFFeuzUsdSUoCJHair8HKRBBOH367JDsDf9V5aFjY50y/30lCCHl6vZgKQ==
X-YMail-OSG: iVz0YiQVM1lNsYkfddRUmaJRAQaWkMA6jixHuiKUXIy4g6mdlD139zHt.s1toi1
 BN9OWFet79sKYu7FY_rbY0dmqVeN7ruSZxErHlOsAN33ZbDjVFBMqHX75SBtDNLr6hE1p.umqkNr
 90vz7.AiIZ5_jf41DvCr4k2uuHFFBHMfKUTqSz9VcaaCIcb_mZZhxNMRdhQQF6lKNE0Iyl6ga03N
 BkHtS1GoPkKas8biQ1j3wSgyrFVm1cAe0wT_RsXZJu7ML.tjfIhXBpl3D9bYdWmTUjENWBfSP7vA
 WhdYu0I7Q2lz2_c5izOBuxx9SAIFvNv19haZH7vZcyOXRlhABCirmC06uzLFqQHLDzn5EKuPLino
 cPRDXldzusZzFXV_iD5104T25xdhmaJl1.in7yYhovtMh08Z3V7crj5ti353Ebd58qyDVQbPCVUK
 1FRBQsbjFjDrjcH6wqFwcize4O1zLOmBCEvqy_9S03TW6JoS1WsiiiL79HYal3GgQ2hncJeuGU_E
 R1VsEP5FD0ZMDCtTmDWUOTdWYdTRqC9ii9ltDVwCmd9LF_UtJA.sg_umrbOfVJqWZI9ES19O0mx6
 fMqLnVmc6udhifAqct9HCL.bT0isqGxZ6JORYHA7BCZepa0dv8jJuj.IVAhuGHUavwY8OqEuMezd
 _1N08I_jBMqLXhB2p7r_L_n4RpYsOUBRHz4PtaPDbqjyWBLOLETkkxvOFE4CglbCOSC3lMc37Amq
 zaz4OfrzhnFlay2buzOd17hvLX5wquFsNuD8AF.cpXr3CUfXlggu1R01lj5g.REuasFZ0a5SIK4F
 ol3xhopJg5zrCdyp5F2pNPFWZp7u.8x1mkAcOLfil.FD_eEsNNMmtOkgWNe2PyiBDmqgdw3XxB3b
 gVGYpI5C2Zp34hh2mvgTq5x8JJ_GJT7QqYfgcNylZjA6K9fe7NFijl2UcdKDFDjLsQHGB.yj3zLF
 mkn6aKUwwwU7j4zxE.W4AkEsudPISeBcA3jqEIKBs2Z2WvEDyWnmnpcwFpPJdR2EZP7GNEVSJuoo
 jevVbd7yNEMPU_AJX01FXhAC_F6o_3k57K_YfgBsaraSiuLssas9Lx__UiQRHdTJiUXJv2aEbNRu
 e9s02.Edg42JrzkpPSPdbr.A.6CkfXXmwwn4P1ch.5BR1KpkbY90Z2T8V19qGIJA4zAvyQmIVYGr
 HdbZY2nQa9BO0XtkmPNubMIIwc6GLDmZ0L4iGDsaaPqkW5YEmSglFhSmlyzCzmb5eJ1V0dU4oHOu
 .6hWkYob14rqiw2YwsUwEAAlFQJ7suy0nCCHWwlTPz7CbpmKAwjnVEXQs7LP6zrvf4XmfQ5x3Ne_
 CvfAgFPm9Q8iDRHT4jyiP9IekIFWxlVZ1dWFv9p4re88CyNkV_znbxwn7ls7N4iMuqyMOSf7YGwf
 aPZwEbEV3OcJy.VG12nU5VVpRL9YUnfEK6u7SrT.RZj2Gxpxv1BDP8UeT09zOmGaATnQ._pyHrHw
 0Sg9HckplkGa72yhAqeD2ywesA2nBoCkD5KMBhY5yJuYjHUtVPflJOW7XueugJFv6crh7Pv88sbU
 9OP5jPwAu14Edu94RSneMVl05CE262lSgY05OnBeAx4mmsOIt7_75b20qqW_BbWUpmSNnBYwAp2R
 WNhcqC_T5eZEpO5Gr7FrKZCPk4VfzNUJnao1kLiXCtROG1.hByD4jrfv0lwCTjz.piYmJz1q04Cc
 VqEGiLMoDvEteJNVrySEOWvrwwQLuwKZhzcvKYdY1s8oIahuki39yqTpAESb8ZHwf2L_IQ.hcS5D
 kpKflobY45a_jlDpeg85Bs3hDZZUJsl40SoJcFsJd_qMjTdJHBO1Ej1FI_qNJ5GvlrMgAApoSABC
 P2DWqBRuL9fJqRtBX1hU70eReh5a1L6Kuw.YU3MYoYtALK3iLOA3joChtZ5FR50Q7DEhjg3xionD
 LCZY2hEsT1TpwlwfAuej_fRYNwBLMbYjW7D3q7J_MVJWOP5qBrfIrfqyVXRUDrgnK7LJyX132kXc
 wgb7QBJe28WYjqC_wM38dgMDwqqxx65BafqNz1_O8PU1aOazYP1iLRZGFSTylZ1lCzoY2AAGimOu
 ad_0Nwj87AwDp6mMkx9A16DKaMHGj6MSuZ5.uIwPOvmRpV2JVJFAhZ3sswZg.b8JYSPjbVHnV0Dm
 B.koXySjGDyq8IxY.ARYZifRo1rxIzubfCs41Bn35owuRp_HZrrJqRGoavwF.OK8UlBv42uOFxxt
 JCgguDxSbBx.92heCPGwPhIxOZPF392CMKJU8X2JYGZ6Px8wupweKPCUlMPGJs3QSxPk7sMEwnYH
 RJg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Oct 2021 15:26:33 +0000
Received: by kubenode534.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c75242736be9955228ad0cd21120aad6;
          Tue, 12 Oct 2021 15:26:31 +0000 (UTC)
Subject: Re: [PATCH smack] smack: remove duplicated hook function
To:     Florian Westphal <fw@strlen.de>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20211011143309.17203-1-fw@strlen.de>
 <700b26f3-a8ef-969b-dd3c-4ad849d8c4ab@schaufler-ca.com>
 <20211012144015.GD2942@breakpoint.cc>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <1f59eff5-966c-f2a0-8596-0caced591171@schaufler-ca.com>
Date:   Tue, 12 Oct 2021 08:26:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211012144015.GD2942@breakpoint.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.19116 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 10/12/2021 7:40 AM, Florian Westphal wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> Signed-off-by: Florian Westphal <fw@strlen.de>
>> Looks fine, with the one change I've noted below. If you're
>> OK with that change I can take it for smack-next.
> Sure, smack_ip_output() is fine.

Added to smack-next#next. Thank you.


Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C786D20FABC
	for <linux-security-module@vger.kernel.org>; Tue, 27 May 2025 21:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380313; cv=none; b=AbhR/gogiPu+biAO3vFDYAAKUw62q7ocX0fcRue//+YLNJRGl8ij07fGf3h69DRK/6B6/Fr8AuOLklEW0EIZCmMLc8pzkIB7Qd07KBiG4o8s3vW6qwa13FK5DCJefSm3Ryuandlek0QA0aqTOcxcnRxyGx/agooxLYOIXLFQd7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380313; c=relaxed/simple;
	bh=G+3ndt1DxOo8pbfaUqCZvbSqptA7VFCzuNnq+E1FGCQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type:
	 References; b=A1bMYQ/qrHBt33Z172jJkcjo6lVlGrbuLhG7PU6xL2z5wsjP8lZlsXBOri7LPRx9+4/vdqSQ7uk0GwW0uoIlnYOS6A+60RgRbASscHDuOUXbAeWLnGU/z/ZdGH7WlA0biarjR914uB1bTe2mu4/ChjGcMoTDaT5yOWD0VayZCFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ed3tIkfK; arc=none smtp.client-ip=66.163.190.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ed3tIkfK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1748380304; bh=kcHHNTuIruCsGWWRMvu1Wnl+DbxGdOf1gEsan2YW3DM=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=ed3tIkfKIcpFTgHXEQj1hoo48ngUr9H/JMrmCcvay4oVdZlk4NyHmZgAMJhZxZcl5p8kZAfd4q1Nn8W+DoKGlBwi2ZElbBm72n2nkHBOOBPZE8fnHoll60yxlWBfjd+cjYX2z6cuIwqyPG7vDVwSXMyshcJaCw5CUUO3rAMy+jNNnt1C+YeMcbRQyk59RJBqZyx2BZVdXlo0cXuFqW0ugTx/ihPlmbMOvdzkpyBUMdCHaPwxgCHx8i8uf9bMMZ9KqLBW64CoVkYocWT5+tFiF9QyTdbd3zClBJi7nk//oKfxUXrQowDE5E27zWkmgTNu0vO1qG7Y7VDhYfp0ZSr+sg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1748380304; bh=8Opk/rrxA9J3agqSY57PvlxSrjT9x7WDVXp21Cqgm44=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=WixOoJJ5iIy9si/N8yObjQqnfYO6yNEQO+VH9kOSmLr0TusfGdnUYbd06UlOsYOT/B3uwNP8OG+OmqFKHp3Rln9kyqsN8cFHJpO4ZQs6yUDlOlmmdZ7xGUGJgXwlFwBpELAc4xkuFHU1nD53mOTH27t77tuXeQQLIbGpnGhVKIq+vINg/5k7db0i25dycpN5tA41Y7whkWhgKcOGf9mUwLP9H+VhAldWkdQortLQBl1hbyhrPzG4s3fJ5OCb++5LGbYe3kdjG4NTS1Gliu2sw0P00Fyz1aF6pu6jN+mAfRv1LxqylmChV3YiAeb/pAx2s/JrhwVyoOaZw8JaIfxSbA==
X-YMail-OSG: OKliedEVM1lsHQQVLm2JoVyvTf7IPhTMu8VWV71jaLLwyC7L__Ah80AaMgXoT2_
 5.Ra7wEXdQw.ri8z8_uUtqYXCcDw2RAIggkk4bn5D3Zi4tk.BJWlKVZCuF1eaw59RvibpXvUuCZ3
 z8Bmkz92N.KZibrxREY4Tt0fdiW7B4Uer1_.MUWDh4raAOfSDNekCOcSucWIr3WsYf.wzCk2_8aB
 gjR9EEQuonWdbqLudsDuD_eHddAfWAjDRzdAcs7PRSopZ.FXqoDt4pQAuIfq77U3BE..EjVx.4XK
 xL8sQlQZiQb8Z_oUJ_utHo3EsK44yFDWKbOpCT0GAkY.L7SikyTab6N2iYRYBFMako8hvaEKhE8A
 tNR2g3o7AAMV2FGnbca9eE92g160EtFfAMo0Daj5l_6aKwo1wf83G2uZNBgBhPZbaMsR9kOgaLSR
 9Zg0Wdu1Hoz5S5jfrNHo31pAzAfp9NXQLi2kcKK_pDIrYjA1an.Ttmc2fJ7zahPDgLmr_9LyDJy5
 DUrYrql0LAZ9e1FK2JVrRuy8CLYcLQ5Yi27ty2_wL4U9QSGAb0zRKOK3wt2SEIk9hXaoSNxYX.3N
 p.COXwWGJ_lW0V3e8W.R6n1lsK6vdL8AYBcjd5nLObAnWmjUm7hv8pBZeROscmJhxSfkAb.Vurl9
 OnQ7wOf5tMpscOMLHGA2uaHyo6u7lQeA88LSPtdEVHAWixtTzr.frPN75sugc2UofTVXBoAoDClO
 wL9zY1QryFcx9Wm3vK1Iy8hCJHIzTJp_gTQWIZzxTTHK9gqzsGHsMC39Ff2esV30Az2JBKsuI3Og
 qLRS.RZFT.1zxFFdQZ9gZhH8otcqZGYTUo9tBzPeRSzRCQCGd0pN9HcpKowACMQEh4x9Vuaf3Pe5
 TzsKyXIBnRT6UfC0LhvpfP0SuZnwsRADQwtotssHhcWhu_IdQXFA_SF9h7mNPr8yw4vy0sLkwbhe
 dBgGAdwvgrjEshhGHBtd7j0UTG4WX0JwKjmnPgOD0oF1dpMYthxWlUfogg7BJFb3nxVRDX43sbsi
 fL41Gfm2t9rqOBFq5oHe39d9uJxZMHOItO37L8QEAFMLOME81yFXMegO7vE458OGUj7MH_zLlj4c
 42IdTx5JP7iCWxjMHTCTLoZXCtnYhfpekhYnyxrUtgsYOgFIyxFUWnd1MvHtRMTveVfHlJJ40EbP
 pRdCtWyD70nbIc.JfVcHNQ_OCGUeOmI5S3DSdNrpIZJlm3Bd7cB8Noh6_l9fgLg3gur94j_SGpuA
 A4QMyASIz3jAiuJ_01UOwO5BtaJsyCkwtucsLUhBTWscmkRLTI_uhpIZ0JZPcFxIAfFVJYJKU6CR
 ozCCIWnApy2KxbN2ToTV98RBerjVXZyITPU_SCrbMsz0lNWjzeIab7PsHtVsl4m3F7y0DtSO6cnB
 xzDM000HolZ5C_XPavAzYipvCas23BnjDynH6KwJRrWFsX4J9s.jKOr6RGKXyDg0c76U8KZmmBD9
 mNV_0cAn0_6AWKHRze1fRzd0AtPL1ZsrU5ISOcIR183ov8gh7gshDIuGsqKDHn4897VVhCNbkwQs
 atpzmhk6hd5QimQwLHHLyWJZ16FrGyGwMNr715Qil7pa3RyOMiXqJYEM.QkOCViubeg3wUx6dNbU
 jCFeKTm4ADtfMzdXZN.DVLsj8uGRY_tqYpcpmL_NXNRxbE7Krl2Sms0HcfdSs5KGh4zongP7ExV7
 aDpZD4lmN_fGUUE9njluyt2moYlOCssg6CaEG6JhEqslgp3eihRcCofmF4S8BlaPxkircMzPvXTw
 8gg_lcHDRefN1FBTpMW5qn835SMxsK6yYhUfXW1Ntjp6KMAFDNQodSLGeL0FO8ITvUpqHh.kDjzF
 xY.1BToPz21fImhE7Z_a1H42HCHl1XRUCGfGsGv_IjCBCZ.RMz9_YFUo9I.P8R6KEPcp.GmhbQw3
 9Fd3wY7DUiTqmW4tj1c32.4pRaevjKgAAANfmkce8C3QaHoHEYFsaeJ5a58ZqWeP0s6OoiMkljsj
 awU5klUCYuweSz2W98Dg1VdSpXl4UsOamtIipieZJnIxpD.f97VOYTr5I2zgExheUmU.RwTL.XeR
 1_SOG0sXchSM3qwHAMwd_uYlI9h6vW8ZU747bEtLsEGMR2Rb67CSWyYpJaK2yTbmTU06g5Sp56vH
 0VxZ_MCT73zC1omagGipd2atkpalpJUNtySpB1Ig.UtcOB4p6MpBGLhUAY8X0yflGb44f8hVSTZG
 RHHg3Ii83itmM3sz.Istokh4qKOI5VEq8DlU1VAEAaSp8ZJ4HJGFHRgyulTJ9G0GU6lqXqmGLY2v
 GnQhQ5Lj1RWJe1YpXLJtPnjxQ6A--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c3fb6c23-336d-46f7-9ea0-0a9ee77c8cf0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 May 2025 21:11:44 +0000
Received: by hermes--production-gq1-74d64bb7d7-45lk9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9c9c905a8c68c8bd6ee833fd61de08ef;
          Tue, 27 May 2025 21:11:40 +0000 (UTC)
Message-ID: <c342db55-57ec-484c-b030-ef3dab89bd3a@schaufler-ca.com>
Date: Tue, 27 May 2025 14:11:38 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LSM List <linux-security-module@vger.kernel.org>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Randy Dunlap <rdunlap@infradead.org>
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for 6.16
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <c342db55-57ec-484c-b030-ef3dab89bd3a.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.23884 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hello Linus,

Here is the Smack pull request for v6.16.

There is one trivial kernel doc patch.

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-6.16

for you to fetch changes up to 4b59f4fd0a36c31876344d7e0cfdcb0202d09cf2:

  security/smack/smackfs: small kernel-doc fixes (2025-05-19 16:28:32 -0700)

----------------------------------------------------------------
Kernel doc fix for 6.16

----------------------------------------------------------------
Randy Dunlap (1):
      security/smack/smackfs: small kernel-doc fixes

 security/smack/smackfs.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)


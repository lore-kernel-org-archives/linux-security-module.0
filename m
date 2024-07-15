Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41D3143C61
	for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2024 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721086854; cv=none; b=gZptFayhFmmxQRVMhpToCv4gWse/uqzDx4NyuoMN4cbqOeQihx+8ptAXeXXaQnj3oe4XmTLg+zhrsIrWQKxxwN6ErAV+H1dUjNA1/f+pBdBrPVfj+tzGZXWYdraX3h79ZFu8P7y95GB/F5kmJrWX3SEcz1KiW1br50CXErZAsOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721086854; c=relaxed/simple;
	bh=ZJqlczQnyFnkjnOMPY6EOJrRY+9hZErhisnAph9h7mk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type:
	 References; b=LbByfCeRnVMkxD6fkUb0wEIZ9plUeSHH6HH3S1Drpsr0c3KG0tm5LTz5KaR9aK7NeIl1xuR1D9sVv2gV71RLF6BFZ7hz+XwA/4L2GBkE5cgiEiC/7KEVsx+hDScs8m/MZ+Pt+sEl1Sw7F/n+yASElLNATs9UoAJGb1tzhLTCpn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=fcSRD0LQ; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fcSRD0LQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721086846; bh=m6fvGEXDejgdvUwq0XGyGydA5OkCYBpq6UuMurIHjTw=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=fcSRD0LQf4X69O6aUzke9cVgLnJ0HktRUZc4EENiODb6i7RduDn8fQRG3F73e1ae6lVOyWhHPAwYPNLDVpE9uNhKrRvZANhuw35nQslRJ+kycmd4yYKHmH3Vd8ml5CLrPDe6aO150xiJ5K9DtVlYtgLG5K3wgEdng09cKq1Xob5DQBtTV8EcJUDLrc7e6A2jKysOodwbKr8t5fKbX0kfL32akX51OG4j8WpQZr4qvS/pJly5i5ltVIxNkpyDeoYW/nBWKMNxvLjLLKwt58dWTt7t2rsRKo0dgj1wVqnFE8HbS+Oz8gceKnXuut9mvIf6Cj8fFF7G+ssac2RNX8edIA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721086846; bh=PpkPBZwoarN6bh7UluVx0AKklEQSY4Re5S9BPuGOAgN=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=E3vHnPbqs3LLWKJOH9fSqyK4we4NTz0514TbDVofKqS9IlsLjCfOCpgT/p6VQDX94YCZb/u9BvRsGj1Cegrdj0icU86AQizGXBo84vrE98nqhHtFtIxloHyQmblce9pw163xziCgnjtZmOzn9QFbyyzZVNqW2f+iCfOo1HBOO5v5WQVvXqEqkiXva7LivQo/fA9NGeRhvisQXDj7uOFxfJIjNcToJhKVvNqqaGG7F+/3S2H8p7Yw0j9Gav5Pl8TMlJGVizD4I0vLJDcY+O4Q+aWEsrnyRX8uApDXecN8tELA57lqeLoKRcEexgqb/qBmYk6aeuBLcaISF7voLHeJhw==
X-YMail-OSG: mxyPJDYVM1nJVmTbGtE3C_daPg8SlpQky2xlF_dHlMBN734UkW3BhN0EO04dETu
 LcuIdQeyNBq71.RcFvQ7XHwrozkQJfqxgEhrznvn4tf2gaofaE269dSoqWHWov3pA0GINaRAQGYb
 22aN0BY8j.9u_Wa06v8I_KA0FMvMv94Ta1RBOQ5JF1qLI3R3u5X1hA8z9Oyimzbkv99rDGTFdbaZ
 Xo1AQCu9BvD5OF7LkTEVCNQBng_5vNMm_nmuxPB3MPP6rr5cyOfsZHDfgHyNvJc_vJ2k5ix1.gr4
 .uJvPSzpTPCh5cjwrKVgcaqn_m.VzZVDhXrJpEettds6lZ4KQukHcP7qM1ihwGOdSVfGmUFutFYC
 c8etb5uxRDwUgmPn4u4gh9W3rry4Fqw.4nGFVliFtLy82Uyt.B9dIfSiUDzu7YEBzqyEsCz3YuEp
 t9hB.UaXhOMvtGsURb0X5Q4CQ872waWFNiP5fRcsXAhNhdgsq01a6vr1l6feD8iemfvR04l4b6vZ
 qnuW4wrjSobrNZFhry5bsd9ileg040dJmcS_oYwRGCTY69oGGJw6Wh9gPMwOwfqtYWF4P1YqmNT.
 FY4Mvbj23Nf0g.9xspplPYUB0YGn08bzQaMqyHaRQS.owM4K0mTJj0q1sUdFe4RCwq1Nwc2TwoZN
 CGKiCdfWCHVWO9EriXrk1fgGLf9sPyLKJaea8MyCcR_uyS_64VdrzYBcxNG3zumQXz_oyhl66m9C
 VbOz4TulrHGfVdS9p3qA__y.wvFiZuNzjeSPWJhtpH1fMYjse5E1nJE16NhnDBJ7Pz0ZQmxgV2GY
 tk9TY.K3UtBagOnU4owwp8Cvw7TuwD1GPlywBjK1iItml9FMYLCfTiJbe0ZuI04tntDuf2ovtsKc
 SZEbu5sxEZPRzL9nR3dcVkWFLrtdXWylSnV5fRdVN14cb7D4wdEl7zTY90alUKLS0rSfTbEUXmG0
 8uynlFYqavs5xJBIMrO4Z6_jF.kfjF3JjBYHY98zovDFdWpBU.bTqUbIqT1qi9RpiSXv.k2UdmJy
 XBjyyOc8xOmKf9q7axqdwFyn.9BSpbtRGjpsu99M4oVVypHbGrkG74VmrW61CPWu06E.krdsDz1h
 rXcm3Eyz3vFIcycrYqVzO7R1q4BKIKvq_co6RBTJgZ71iXfEeD.Orpgl7D9rX0yVgi3YLRgQP.Wr
 NlxHlGTfUgFlH6AkHycesSduqBSAVbErXLR1QuMCbl.zk7S8Ijr8RnMhmaUTnzooEJcXmEtBBo2r
 kltZmXl1kq2O46zCY9uzhf6Z_vKTg0f5sm7EYkrBaYZLfpUskvXB1FH6HdPpDerfSHpQEisdd_6D
 GQYw.dGyVoW82cIszRhCegLF1PAM5rvbSq8ZAEQMVpvtvJpd.XEKDEg5fMBYQWMq4ODGWC4ZReTK
 U5E2_ZUKgtMRE75oM8..x_ZiZqr5CJ7CfSH2_rTc5dcpaYr69xKjcIyebuw0WZytN7hjr1IdDFst
 P1bDjZRwJDPbpQXjKip3Zpe3QWu2bDlkLkdf_gOJxngftr3q9vicftogggT9Xa5iGFYsf_isdL_z
 VDi49f7g7ZLP_vrN_bJ6zsPJ0fZ.2P7B_iyUoQzJUf9axZ3QgvQw_TDnAHIhy7RhefNRNAqTOQT6
 hu0FUbMUzzk69UXy45RARzGu86.ygmD.JCn7StygoSgi9udRTCbzsBRCJxD6FWAmEYnKHPFy0YOD
 EP6R9Q5fPgfroNh_u5hR2WV1HiVOrvh0ngM7kc5vXr6s8DbK1h_NLHE5ftC8KgMPkFJQBkEpRN.N
 OMFb1pi8OmMIeMGi_GlayNMaWjEDOn0GPAr_yq3RPmWmyqY8_rnig_MlpXc._U3j42HTASde_MKR
 5wiXDCKMVWwAv5QitoQ05T2Xmms7Ik48oJH5QT0VQGMLwWVgM4kQ6SVLMxuLV_UxbfaKk5WIQ2gV
 YJXrJwXD_u1THSXIgeaBesnAsUcmOr.AnT_yLpxAfhR_1r11qCD9yq5nLPup0z9LQaMSXST_p8ZG
 JNYjbxE5xQd2SYdW.arUP3x49TZnIrTX58TaKVIclsADDrFl_WqCIV38buLe91VKwx2z2TbHx78n
 uLl7QFzDRu_KVIlbjcxaByCbDVC53oMWbhaJcosg9v.ibuBOTjBBgp3Q9XmzH019ZZ2HzFw81wuN
 S56BkFPL9lak1PqZ12Xj4sqXQODOMnXNyTNIG2RbMTQ7zwW32rkKGvDmc_joG6KI3c4WIbL6Qc63
 i6K1hQhJB99xQQe7F9HEXLdc_gKynecsjfe5c0UmjNXgdzrQ8U4qbALi9PwufBfo1hEMcksdsSqV
 9UOw3
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: cdb50ec1-fcdc-4a0e-93c3-ee133e69eda6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 15 Jul 2024 23:40:46 +0000
Received: by hermes--production-gq1-799bb7c8cf-zh7nt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d1bc5c0a4d958b9d32104fb379cfcb74;
          Mon, 15 Jul 2024 23:30:35 +0000 (UTC)
Message-ID: <c9842562-3564-4977-880f-9042ebe43e62@schaufler-ca.com>
Date: Mon, 15 Jul 2024 16:30:34 -0700
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
 Konstantin Andreev <andreev@swemel.ru>
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for 6.11
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <c9842562-3564-4977-880f-9042ebe43e62.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.22501 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hello Linus,

Here is the Smack pull request for v6.11.

There are 2 patches. Both address network labeling issues.
Both have been in the next branch and pass all tests.

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-6.10

for you to fetch changes up to e86cac0acdb1a74f608bacefe702f2034133a047:

  smack: unix sockets: fix accept()ed socket label (2024-06-19 09:25:00 -0700)

----------------------------------------------------------------
Two fixes for Smack networking by Konstantin Andreev.

----------------------------------------------------------------
Casey Schaufler (1):
      smack: tcp: ipv4, fix incorrect labeling

Konstantin Andreev (1):
      smack: unix sockets: fix accept()ed socket label

 security/smack/smack_lsm.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)


Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E72439F7D
	for <linux-security-module@vger.kernel.org>; Thu, 13 Aug 2026 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786654449; cv=none; b=gmSeaJqchkOsE9H99rAXw1yg6+1YltxymP/NOQcm3I1a94yT+ByCjOvBMrbPvsm4Gyi+0jFtt0rkFy/bPJHsSNMGXi4cQKn/athnmdW5hd8kDD5W/8qOLpoD975R1fcfqKPASoEMgCMQEa4xnwieoTvFAmN1gj+8LyyGQ6jDuA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786654449; c=relaxed/simple;
	bh=OMgGPbJCfWzsBkRrvyPKGv81/BqxiXpx6/i8a7e3IHo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type:
	 References; b=PXqEnfJbYzbPxmFUmiL/IjiD2IiPuQCmkjFO+p0iBv5mIeonUlJwdyHDDB2jrFBvuuKdNoEc7aTJKyxs2nalCzZE1BY2qaaImfFntI/3GbzK7BhfH3zso0pQEW0P33FE3xZ5+2HJfiQTXDdikOYg+9pDHkMS94aHxI0QZ2zYEF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=RyEZHDwS; arc=none smtp.client-ip=66.163.189.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RyEZHDwS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1786654446; bh=NZfZV3OotHZC7my0GONzFx82IhSBjKvDY/wKEn8mDQE=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=RyEZHDwS9hUBJyEjFvUeg6Dmkzq2b9I1aU1h0ilUYhg6FZrLesxUffv129QgIAtMXHsMFPZvTDfsGpya7XGLr33bVjbEe8BbEoaSZAc3c9I4XQKHHhf6IWJ9hkxpu7/C8eR23ECnghR2QPeIRdgdhmUWZwae2z9ElPloUwTC+m693Y+Ag6vgr2rm1Ej08vtbohZ7XYOZ4bIpyZCGh4F8mLNWYY8MKABllhWdsvhQ15F/Uf5XsN/s0LVq3TjivRreDVVRwQn+ud2n65+tM+fV/zwhLcYO/+2tyLYDy622DCBI4eh+oWPppMhVphkAwnMQrUlmeBWdOJpQRsRYJFpYrQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1786654446; bh=cZvJBLU4nZs0zVCNDFEsD12wZm2ejueSMX01f4uqV7o=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=g5fVDFOHXBwaUEfVX3dOsYFHTGu8UUXh7IvBtjW/JSePsaoR4pWUAuDn+JW77Cb3aDDcMlVxoUP2XuV35EP90g8g79moX1Sh0AjnuvJQQthcsx9cNjUPUsE0AXP7ykqezg1pIbXL/Jzr9Tpy1KnYKwKc0/H6vbszTnOszIhtn/4eBNm4Af10neGSWUgKwxhoLnhP7KrzP3trC7dvxAY96CMA68o2FZzBKvhsVvc6Viw9q5AOlsNsYp7X/Zcj1CVpN9JmKg0XoJMRAyTv9us/NHFaNiAzfJWOSYveCJJ9/mbC/W5hU7+nlHAoe+avLY9H9kuuhXQaVBgjhT63GfOYvQ==
X-YMail-OSG: CLP1QgEVM1mqnegVI6LzkD8Kx_d0tw5kFiJ.i3ihZhEPVCOv5Yx9SZ6bbqfQKCS
 36jovn18gFTgspZkEpTqPMnLk99M.irSdeSfaeiGWTxK4F9M7TXoD18pBZcmnY0d8vN.bac_PAY6
 1yDkFUXNAjOl6zkWRjr.Suh.YAWbVZubxWoRNsHfOJAHiL.XyBEvcY6Fm_F1biwhmKV2S6tSUlKu
 wQ9qqJARmZllpaOibmf.RC8u7QQfI1pP_DiAztH_HRVRxEklL2gpr1I3YRBxW.zYCMUb08FyulLd
 ocs1fnP3tH.GdmS8P5Yhh1xOIt0ua6Q1z7sp.lvBmpLwxZSgrpPcViqYzsfpEVIeNdjpg6g_Xb.S
 yuZ7CnaZxnlXptClD.i5oHAKCP4oMk4bQkaq3hZ7zZk50G3FRbIp6SWwOAm4MZXIYAMtM5wo3ChB
 P14jmMcdWuMdVqKAWH.sugV.RUH8FhN2d.H50nfJ60zNjoMJw.Srv4ikyAeIl8f0DM2RgcNzqTPr
 yz3DdA5njB6gDU5E7xZNAGcerf2Is22k3KbRidFuCh2PMSeukzNJhS6P4BEejEbT4iuH07UqT9qM
 pyVksaH35Pz6uvpQOPUhGuEWqgpYKEjixmVAAda3_ZbYd1dRMrEnzASFWBfFLTyN6ZUuZkVEAZqR
 E7vH2_lSDyFXAvnJPlUsR1PClVESpPUXXVWu3YGL.CI76Rq.WZsKECnc3ZqGig1WgWktRN6JjIwK
 Fqq5s5SwGF1UShy0FwG5cniI3ElAMUgRTJpAztDCp__CguXi3jOqvLZ7RbvsK_3b1GmQhfcU7MQY
 ouI1W.nM4DGaUlFKtzX9O6FWab48wz3KxG_d1fBQ1HzLF6Y9tVYUA1jryw5tK7_KwfVwpR5dZ5L0
 52VBu0baO.1ay5VgiyfOdW38QnP03P7AYehUpRZNmkxtKOHbQuLqxm8YgcSH1eGM2tZTsC9_u3ax
 FvOGX96TJTut_3I_99UqU2YgyzidlGTnFcjs7f_K76uuajKOax0iOCW7F1076o0ZmcBf72jglSaf
 PVyXq_pwogRcXTjzmJ9SmZxg9Z2jDIrRszU6p96Do.VFmnwhbqesaqRzqtVdGbEKqvwiQt9Z2OP6
 xq964Onfnq109GVonfSXv5WA2rbOTU33QnRDafiLktdDx4fE8U6vYDI.OkDykdGguZgfz4Tw70sZ
 DvM_HlFxKodE8j8sc8DBCsCcCa8w0V92Ocus0PQIXVIm9v9LKO22Kn33BnXd3ajBq_zGcmWlc.d4
 O.Vz_OBUwOYhwqGBO7U1TPls2Kg2_1UyKO6sAydXH3f3ttPwRvuPE4_fevHZ.tkLV.uTRXLN0lEE
 G5BOAYJLYE3q2Rkhnly_K5LcKj.8O5QLY23JjktWFEXbMExW1vabJP7l_et7JusXENp1Cfctkxhi
 KbmDknzWyGFzHZUqdpQdP15tDT9JVCuVWEB7AIMVaUYQXrZTwIQq9MXl6B32XVs6ruQPoQ_Uwcvi
 A9uTWYOA6ZgonRenoc1Fpq0A6Pz2fg2YB.XPOlxKQz3Y6nHRuCnK8NOmLh4o11cS2qkSAAn8yC1L
 0bZfEUVMFtn3DpzGtIvdAIgpAHDTlwfskItvr9MMtNN7aLjWBWXUzSJGyvSeK6FZg23Z46s4aZQa
 Iuhdy.T98rMrR4K2xV5Nhm0lfry2XALtAYp4vZf3mWvogOxtBwimgWJQlCPa0aD1h5_hm0BPWx4M
 5JhMPl3wdqAdGPoZGtOy_BO5_hZiIy85um3liRrcWbyI7_RmyKotAcWdOuWVRTV7OStWMr5YI1gQ
 ustvMRayTD1eWVOvtrhK2bCGopHvltyvlwVZu8U.ngAuY6bWTHpWxUdzDl3_yWdO0KgaabFU3o2o
 KeORb1AEyLdzyQ.FZ.zIcsvsTdvNz9fWjdtzOb9H3eTlBWYa70B6rCz9eHws9BUVyjcBQr5wHADN
 80S7bnu7LsTCD_NUeOUUVcr_rY0ZP.62TRHXGkxC6Jz_7F9NhIAukhyMm.jwnTkMCxG1IEaFFtiv
 ydkY3iNqMyNTCaABYbGfd6AZeS6nq7mthbTB2bEFNnC5btXcUduLnAboDekLckppkLw7E9kJtiQS
 dJaS4.Oq4_cp6hqu3p4ceb0aanxbRJUv6eN8SU8BMWFT7XQhy0tVM0P99dLC1cdBmKTusjjkxWYg
 Hndi_q.59kWleBIZdVPipDeXLX0X7Ae45UroAXMG48JaxjT5NSrOR_RuOLzv6HOhYKxhrAAPy4ee
 AgZiC57dnRYNqBrQKVxpEKtB_bZnQLXTlyPdX4QNn4nfli6x7_6CTVUpAMViUUvBPh.t_ai0zOmV
 btN7My_gtfoTEBP8djRSNJ1RvbLKBQ.zru19mGQNzUQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 90185998-512d-4f48-a757-4dd8af8a070e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 Aug 2026 20:54:06 +0000
Received: by hermes--production-gq1-678d9dd684-4tq4v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 03e5d0b754c7ad3e94b95cc3b7547140;
          Thu, 13 Aug 2026 20:33:25 +0000 (UTC)
Message-ID: <d74aa9aa-ce21-47a6-8a5f-2d74ae74f768@schaufler-ca.com>
Date: Thu, 13 Aug 2026 13:33:22 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Jann Horn <jannh@google.com>, Konstantin Andreev <andreev@swemel.ru>,
 Qingshuang Fu <fuqingshuang@kylinos.cn>, dmantipov@yandex.ru
Cc: LSM List <linux-security-module@vger.kernel.org>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for 7.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <d74aa9aa-ce21-47a6-8a5f-2d74ae74f768.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.26254 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hello Linus,

Here is the Smack pull request for v7.3.

Everything has been in next. There is a spelling error correction,
There is a code optimization in the smackfs file system. A pair of
credential mis-uses have been fixed. Limits have been placed on two
of the smackfs interfaces.

The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e3c:

  Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-7.3

for you to fetch changes up to fedc88e38ce979a720cd2de042578cb5df3dc8de:

  smack: fix cred UAF in smack_file_send_sigiotask() (2026-08-08 09:47:22 -0700)

----------------------------------------------------------------
Patches for v7.3

----------------------------------------------------------------
Casey Schaufler (1):
      Smack: Fix error in capability bypass

Dmitry Antipov (1):
      smack: simplify write handlers of sysfs entries

Jann Horn (1):
      smack: fix cred UAF in smack_file_send_sigiotask()

Konstantin Andreev (4):
      smack: fix incorrect task context in smack_msg_queue_msgrcv
      smack: show msgrcv() subject task in audit
      smack: deduplicate smackfs/{direct,mapped} file_operations
      smack: restrict smackfs/{direct,mapped} values to 0-255

Qingshuang Fu (1):
      security: smack: fix spelling mistake

 security/smack/smack.h        |   6 +-
 security/smack/smack_access.c |   9 ++
 security/smack/smack_lsm.c    |  71 ++++++++++----
 security/smack/smackfs.c      | 220 +++++++++++++-----------------------------
 4 files changed, 129 insertions(+), 177 deletions(-)


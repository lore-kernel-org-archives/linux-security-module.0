Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7350219F42D
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750094355; cv=none; b=uflRMWF7mtmOr2PPYzKR7k9Ib6LjklAzDmXY4cz8b12WKxK5/GtXUuImKEj8Nxo3NRdw68nFfghDLjDXYla61PgoCXf4ZbeTuPORrFCdVBtYm0diRFXKWq6bcZVy3WpgPQs7Pu0J2HS/IHspJK+MqP6TBVP23/UNj/XFpthkAt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750094355; c=relaxed/simple;
	bh=R/S7eNlj6z6nMKjuHHfUYtmROaW+6s7ToD+uBw7qJp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbytzdOU29IiwQraio050cdkJeqKQm1t0Vag9fezw5E4BThR5wmGeRMzF8QM0njggMX7xayOq0z1VYV67KsEId1Hwtyt0RDxZYhCNORRWzheFLJTzqzCD6kK0XYo1UKDocZ50q9OyW4AYXS89z1e+7JU2+711hQL8L9oYWD//7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=rMOUuf4c; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rMOUuf4c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750094352; bh=R/S7eNlj6z6nMKjuHHfUYtmROaW+6s7ToD+uBw7qJp4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=rMOUuf4cu84VUCGXTiZLWcVGPAdkSAPq1hOwdHexON78DR1D4ecx9lnVx6FXDEjGnYMfgsMSxIP8EDJfg9IqcOIutaXbR6I9XCaM7Vej7YWYZPt2eYp0EYkm49pPHh27IiIbViMmkY3M5BI+WroQLqIC+5bOXYmNun4e1+e+YthzC2P0RP+mZ6IYt1qZp64WY37Lyemo9n+PuHMgAvHElIisJdXR4q9owQTcE3Lq2CCzQwulOFLHTaAzBPjHKPSiuPFvOuu5qRa67T4OKBFP6lsImC+jgEpDAx7mOfhWJ1gZ2Yho4BvujypfcO5PQRwuJybnWXVSJZJ1KN25xihXUg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750094352; bh=v9ln3YBrfZQ9qem0Yzj4+TVjF977nKAKZ0J4eYRziKc=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=GuEXXQ0ouEYmKhMT07KgAYR6Wt1joIzUcvgqsZF7Exd+a3PDFYDoUWRu3nuqH70tgrgM6/VxvlplHgXavycPU4vGdGPBdroGXQPmk0Zkag5DQ+SzQQs0hW3U6J31Evdwk403lNlbPbTf8uMF25gm2GTdp32zSsrVoI5crcOaO0i+qTV9qu+1MwY63kynJc2zfgwZqeCmoNFKqbnjchHKnrIG+zZtK0hfNt7d0rmA8oWtRxwSd2aq0bzq/+6T9YhnOIgqbMtKK0i1vuW6aIB+43EoxNF5qq+cxdg2pq2Qk7RbY3eqbBHY+mAEa9t0t/HguRlwMOHkL8f56hvw14d8sA==
X-YMail-OSG: wKd6zloVM1kSL9dR.gRbK_M7jScuOUe9OqkhM18U5WTeQtdID1YF0SmHayc6ufc
 w23Lb3uF4JWSQ1ZJEkaksEdO96qtrjvgFM9QWaTiJ7cpR8W5.8t2OwCFcPhgRS.RU4wV.Wkhx6AZ
 MciucCy_PIcSc3WMDFhXZ4JQBNU5nGe.0fo0V4loz3wSbMVlWhP62RAnNgIRrFvJHi1VJHbwDXDG
 OX4oH81.RpFVuVT09F5WazgDAjocT2k_XvJKLAkkkwSzLR8Xp74g7r5vnx0OO6vvUtR5IxkfvJF0
 K73JEjt.QC2ZJ8LABw1FxNlcz6oTrPp9Tkgd1V3PeKi5Gg2FIzKbp5A9bUrQN89bkqAe0RkWt1Jy
 M45WEWu8RuxTIJxBNpL6xGO7SZfL87RbKGpPVYXD42jxkVfWKBtm2u6lBQKFEg4jfda95VLcU9GW
 suAu67DTbGybsaQbVqDxu7M1MugxFVqhwQ7adp2ODHAqqeAVGZBuAkSEZFuwmQHlFc.zhZnBzB.P
 nA7TrvkjksiiiKQxVvTUxr1fMhmW9Fh2Gzn5dZ.lLBBVv0WGgGfSgdqyIwO8Fz.qHPR3vChi_Y_e
 JO2BF4CC0Lff7z8vl2MNyLbKRuf2xRuANTRr9rz3gLAzvQWZA3w0W8Bpc.QuSWUohLrnd6cT85QY
 EalgDbPtPG4fi2w2WIORxUazZVBO.R18ZFOEppMCf1FtHHVet8rNtUdmwYk4A86iH1y2gpf7HxXv
 nDf7Ud5VKNTYH9v0yMMW4rZI7AjS_GEPgJIdb4alnr5SkA3zvEgu7MUAXQoICmiz6luXbZ5Pmepc
 vf0LecA0j2RzgIPruf8RyfksHnsXE7ZOChhSxZi8TaFJfzAmWJa_zyWW5hiXthJZj044xacsWNgN
 vCwr2qB3rP7xP.ZdhOnKwpHFYVRZJ.H2c6J7k7ZBnGBBLauCTkrWJnQhepSZHKx2j2H4Dkswjb.w
 1IkSfnxtPUB.r7UJjqJ0xgA8KeoJIQqUZlKBXECGPzNQuEMEDPfQAAe1pX7fNDXOb1sj7y9dmSH8
 cFBMGbq49Fot0uLflxtLqsgGU4fwNPvTOgHv2Fq7GIFpAmbDofIpyZGs5r4brqHDom2f9WqsXM.t
 mD_9r86uQOuytQmqq7AJ5C4XvlMffx_Y8cOp651A7WTYk1C4fVMVAUHTdZ6eu1GGz2gszzWE1mP_
 wWCG8Nqpk8g9OjS4aLmi0mK9XKYLVHatTCyPkunfsjK6Rp7joYCRFaO3wrcvCYJqAxO8ImOBT9mQ
 M9pHmqi.Hq8.9f70ZRpyBk7c_hNtH5hctzwtVohV.oCOVJyUe_5WMWXnyCQIQhuds6rVevOwgJZ5
 7agFPcpRtr5QZbIlKzCMEX38h6dPbVbPwGMfl5RNSpYOUePORmvWseRoYX.ZScteAJTkr_1QDHV1
 Pf4x6gap9JgM4X.pSWXYbqXOOum5I4hkhKnvp_6nL2BF.z6e1rR9UnuS0lvjFD17xlMDwWBfa7av
 jQxxUenBYa0dcK9183M8hLKR8Wv9.GtyUtCf433fZbuXRSigpJ2T48feZbN6K3lCbviKqKiTPaAf
 t_Xj.W7vKlzVcDbbrJx4CtAHVytNFyvcivfaS0Li9wGi3S6eXMKQ44ujWnbh0ZFb3fLzcrRaj5s5
 CTkqnL98QRr8q4M4E_ME7xyPpjhvqGc_e1BD91Exd3ZtanTYxXWJc.FNuwLOdSHLUqCXWokEesiP
 PS4S2Zft7KynymnHfM5le_l9DkPaMaVevsntooGc0zB7nNQM_5YATFCZ26lTOKb5cx3.eGEMF_49
 kZq0.3VIvprTlu10OskXljgPD7guC2CHAVE05scUDhIJ.RJwPGJF2Ex2jg.vr5FjVHqRdjh73OyN
 Go46JDpPPgfUVHyA54tVD_BvEcPp76ye51g0Jn8T1jWe4PlvPprWbbMedOIDNxIQT2JEdxusP64e
 ZauvTxYal1S3xwUcO6yNUfPkQxR4EpqBkERPDPqLMx9fPLFX4XDx0XRxLWfB5hrjpPGYisgp7W0R
 Cj6f6n2xehhqf4W.bwa2.ebF2nve9OS.h07ltBYjDnIxE9EC8J74.JLtKQN2ARPmTdXuBh07PMgp
 NW9zwVKIeP16xQwCANnysUyS3rohpHyXx0uQ6Xni_qeUGuw5Dv2Ekr0lAuQ4zFK5WyQTnkJhj3qG
 VzykeLmMWraG9vAhM1_OeCJduKNoNFlFCCWXxhCqs5hDfa5wLj3d7yNTVm.Xbl5_OFm_0DBxXHk3
 opuCst5SD4bP4QZgCLyjmvscEpm2LjMGPh_JUKlgm_3gspkYaOmQ4S2Fxi2nizWL0gcZdHNTv2Oy
 Y
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 63d996e4-870a-4ffb-a687-e08305e3e3c8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Jun 2025 17:19:12 +0000
Received: by hermes--production-gq1-74d64bb7d7-s6s6l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e0504c6c08f1e26149627925f357933e;
          Mon, 16 Jun 2025 16:58:56 +0000 (UTC)
Message-ID: <c512e831-796b-4a97-9ae2-5eeea7321e62@schaufler-ca.com>
Date: Mon, 16 Jun 2025 09:58:55 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] smack: fix two bugs in setting task label
To: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250315015723.1357541-1-andreev@swemel.ru>
 <0c8e9341-d044-42ca-9332-2b284a0e3e5f@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <0c8e9341-d044-42ca-9332-2b284a0e3e5f@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24021 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/15/2025 6:52 PM, Konstantin Andreev wrote:
> Konstantin Andreev, 15/03/2025 в 04:57 по Москве:
>> These two patches have distinct subjects,
>> but work on the same object,
>>    security/smack/smack_lsm.c`do_setattr()
>> and the second patch partially overwrites first,
>> so I combine them in a series.
>> ...
>
> Hi, Casey.
>
> If you have time and you could have a look, that would be great.

Looking at it today. Monday rc rituals must be tended to, of course.



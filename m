Received: from sonic314-26.consmr.mail.ne1.yahoo.com (sonic314-26.consmr.mail.ne1.yahoo.com [66.163.189.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8242391BE
	for <linux-security-module@vger.kernel.org>; Wed,  4 Dec 2024 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332611; cv=none; b=q1CTc97Lvsd9sr1tfxdzgWUDH7rAHwQ7Yn48Zcs/UZjo+kQ6ToWCKHn+Xo/oKXeCkKWyxwbsMTdvFCL5+UvZhMvxvdgs69op0tMEHOFmdv3T9TExmiKIbbcLStXwddVTyD4I9pp9OozExikevQcoFRJQeVHJisyUti0gK1vAg2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332611; c=relaxed/simple;
	bh=1M+pc0gnBkiOS0bKSh8WykprIL0kKeuWWOWOejfdfjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r53YK/bo92f76NkId5sXAMmnM/6NQOfXnaG/heoEfJ+/XjM9Iv8NAq6V3L2sIMdXIMfZI3PQDq2jvUN6VxhLjdHdf93oOPhG87ay0SsSm8pyosz4iNf1CU4V8hwlqGqwyUZecE3/GDWwKtp41u9y/D768QSpkIvpoJZFm3mzK0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=kjWQOjg0; arc=none smtp.client-ip=66.163.189.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kjWQOjg0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1733332602; bh=PvfwH6Rb3iGeOKjhjdFXumFZlZ6VJjUVLQf0cq2EA5I=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=kjWQOjg06cmJOrXVWsrg1eZAbjBjZzaCthhst/g2LU+2sTRu84SM5BahTdW6l9CB/rf7AQEHoz2Wzh1XQ23Krbssx9wAlP6ienH8olcAP2AmQGYgLfxvnXeG4gJJ91tEgFaxpsJ33BG2I8JvIvER4Y6g/U1h/JOTq5tjVU1wAvzf+5NB5WME9Y80dl5fMcYDiv+0HM+BU5zHpLAjYQSKPKriqaOWHpdczi4jNHW7PfHlYI+r2uN4ntOlREhRYV7ebs8XM6mP01cfHrSMb78B3F/HeGedI1j7+lxiCDfjwCtfyI8VziK05XxQS3IwRuoI0RBczAB20CEWDI5e1Qhk6w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1733332602; bh=5fn+Ac6P/jiLpr+lC/7GCc5wdnpvKN3a1xdTrHD/CT0=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=VvmoBhYQo4OjrpQvKxKJ6BW4hHCBX1BWuKLhZTQObmgp/HouSlN4jW6ncC7yxK/t3rh8jPDplY6CMEsfbHtqGJ/tT+6l+QfBR6iHUP8GbEkP0xSIVPh0R1qqPjMq27lZcfvDLF0ET23tiDNUSLQaTMX3N+MFS7jU4g6vrRMN8BPhUnEPfhMIlwaWK8lT+d6roRu2l/xfIXVnhRrmJPGLockbk1V+QNybQI3/Jb1GtQyNH8k7wxSu9JYWYdhIzVpbmled/mDEkxoaz33LooA9b+i7KDsxXnDMZuJ8F01XVksIXM/Dpf+l/0DFsd5hpB7+5OEA1tB+SpEYR6OLxcrmeA==
X-YMail-OSG: QKEK7ecVM1ngWDZgP8gMaGI6o4tGF5LClPY1WcxSjCVe9UKb7SSXpVa327qHHFX
 lgJRVq_gJPOjd4xRsTFn3qVHUR7DLHKJfG8v1FLYH_SKBcQWUGhE3BS1vNuHQwY8Xb2ZCN7LJGOZ
 Hb5mS6TBQOV0EOFRAYghsQNUHaYJXgYMXlp3hO2a.lpXVZDksyulZlpEOdb6uNMjWBVIRUK.cCyF
 brW_Fa_t.t19QMkpk5tNk39BNk7N9LFM3ZnIzwZSIjgW.ERituQ_9LJNxEACMsWmjMbLje_8Tl_m
 .E9J6rsc6lLjsBy3AGQrBKP8ZT6l0zx8zRG9jw8rqfuyS9kwM7JuXokRtAxN82pK0bRn2mta02Rs
 XIVHMPtyXKmDX3L2YzocGAOjNUL.6.MGF1F011bnEmZ0YMWjio4O6VIfukabsGwlb2tyTp93DavY
 8RbBb5O.bf9nX0PB3Io7GHjKGCSNkNTu.ATPowsdi7JBQZQiIhBtsdygFO0vKA6UJGM2eLYTt0ia
 QaJKq4ZbRhekeAAsSI1ykwblK5gK.CWZ_QJpNVfVLKLmuLptvDOrLaBKzW23zWNI9vQFNs.RY2W0
 7lJ3P9jyP_XpVWFj4t18NZ19iIjfPAuxmdEYmzlQePIi67ZTq1VgqGPvpxonfsLj7KzPNUphbhFQ
 HFrtyhyAgDkViSv.1ICiZcxt1SKrpUOBqpOnv.iUaLj0RzupVE.9GOjfQWeFXt_T2hlBDJTiuL1V
 twOfH4xXMKiefW_kIUY8PgeejF9UosWPhdv0hHE.6z2zbMHgYqG8uksOIS7Yu.R_aa.Dp7FctlSs
 JWaUGibRiekagzStTHRvpRsoETNUGyVN90fxCzRAUEEVdZS3GZzkPifB5DX6p.W6CgSzq2i3FT52
 P3FvPlVFrUzECxY8AHV76JIGjcFQD1DRzhVXuzVCBZ1hcmueze.UFOPsZinyCxDbyUPjN7EvK9QK
 ZxkMPhkfs6zVYtcSbzJMpIJT6VKS38DMyyW41RxliOdi87wEU1Y7onhBohKhV2y2AyveRUTIQ5qY
 8pva2gHOiTf5NrESmaNQI5Q_SK_vKTj4diB9stJgQzfEevb.lDDKq71kJZbqyVkx9lCgrN_I0M62
 5JDnH51sHopbnTxoXt86J5BxFtLOjzYxWfcqqDiiZdZarskigmRhyXVRpAD2fZnTV8JDdtbVuJc5
 sNwnF9Eh0udMvpYea53U1SZLOt_50UeKl1Rmal5EhDE6BklQwFp3AK0h_0zOWnlcLs3ZoKj.FBMu
 hWT0dfVXXPZu8e8jmf3pDr71NGx2VIEdp9y.qmZDsN1NbtCoNlsr2FRa4ORgr4mPoxtAjYcCFJZU
 JqeZiv1s8ITlFlHe7o5JTzMJKUFyZtqkEvWypP6TJXJV6BAO9rPhucZaC48mvxFR3PzLlBWKI2QC
 gU6Ha7WDC9QagQv39pn6hlFH6_wIfXFtcy8hYIGC1EMgDP6BYRNemdVF1TIZyv1e.j6C_eAkM1.x
 JMWdTHV_M8pelIbKq9toHl4PdCOzlUyIZMfeIRk9roFAvPe6Hf3LEOZWlU2rHYO9A0Hy50HTIav8
 BxmgssAwxna1COExxF6zGn3xOG7CDYXUeMVIQpvRYC9_NaZxf8NsOAxMsqKKJUYOe5IkMX6y1gDr
 fRAxff0r2t6yY85MEyvcZgUUWrUDeJuhip6R3rxmzQP9eRrxhMQVCZxCvlVaUKjd9jZOh_JOPyTw
 PstXCWPUSAWML1DfwdxcJX7rkj.izrPksq0Vcs6VzZcBisRor0PQnwzELqXBtVFU3SwYB12cBUEA
 tB2ydqpIwNNVY4LneDzFGYptrKAP9HA.7Yy68HcKm1kfd4_XWt06fF3_uNX9Xo.xiqQNJnI71sOT
 miQkYcdwbamvzIQwwD23BfXF753TBLpO03TcJkP5W2dQY2q.e7Bty0Pze0bcXC5syteDVCCvJWRE
 _9TOZQkO0VqUsexTBOtr2f1BQQg3J3zmcJIJu_r1Nvoj4vF6F4AIneoPrhXeynnlew9BGQ70aoPY
 cNZ.P3T_LH74P6SvLxM2L7meHK61RyYg5rqOww9AuWet3N3k6PimrAkrmIrJyYub001NjhHdplFe
 1FlZyxezPEc03ax7ErzYM7lgZleQtp3TJWemecEHCf2NkZgaRk_zFv6nTx2skEudC50CuGhboonv
 e00pZiti42IEvtQOecUGK9iGkrutxjx4AUmVhjuz3l3WKs3pxBckJpVAFo2zoNfpRaaD5JK7D3U1
 WGdWQVBXxNMV0MSJ6KJkUxrcHCWuw2EifQMaIed7bfNVQw3mouRPm.bJzBMAsEcf6dCudBnLUWka
 0yVTvoQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 5501f2ba-0354-49be-9ccc-e80f9ac09207
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Dec 2024 17:16:42 +0000
Received: by hermes--production-gq1-5dd4b47f46-sx6k2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f7e903d40bf9bdf6b3228502bf238ca3;
          Wed, 04 Dec 2024 17:16:40 +0000 (UTC)
Message-ID: <c8f5b77c-71d6-4cf9-9245-997ddffd72ec@schaufler-ca.com>
Date: Wed, 4 Dec 2024 09:16:38 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM: Replace secctx/len pairs with lsm_context
To: Paul Moore <paul@paul-moore.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <f16f8d81-3894-404d-baeb-febf2fba16f7.ref@schaufler-ca.com>
 <f16f8d81-3894-404d-baeb-febf2fba16f7@schaufler-ca.com>
 <CAHC9VhTfKfAeKKbe3P-ZxP-0Y01r0GF6pPvt=2FxvQzAeTGjag@mail.gmail.com>
 <6bf287dd-36a6-48e4-b847-3030fe3f7bb9@schaufler-ca.com>
 <CAHC9VhR8Pay3cePZVdvVwks36d7pfGNLUhUxSs5xPCuRcVtbRg@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhR8Pay3cePZVdvVwks36d7pfGNLUhUxSs5xPCuRcVtbRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22941 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/3/2024 3:06 PM, Paul Moore wrote:
> On Tue, Dec 3, 2024 at 5:54 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 12/3/2024 1:59 PM, Paul Moore wrote:
>>> On Tue, Dec 3, 2024 at 2:29 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> Paul, do you want a revised patch set for the lsm_context change,
>>>> or do you want to stick with what's in dev-staging?
>>> I figured I would just move dev-staging over (I've already ported them
>>> to v6.13-rc1 in my tree), but if you want to send out another patchset
>>> I guess that's fine too.  Although looking at the related patches in
>>> dev-staging right now, excluding the rust update from Alice, there is
>>> only a kdoc fix (me), a signedness fix (Dan Carpenter), and then the
>>> two fixes from you.  If you like, I can just squash your fixes into
>>> the relevant patches since there is no authorship issue, and to be
>>> frank I'm fine with squashing my kdoc fix too, which leaves us with
>>> just Dan's fix ... which I think is okay~ish to leave standalone, but
>>> if Dan's okay with squashing that I can do that too as it would be
>>> preferable.  Dan?
>>>
>>> In case anyone is wondering, yes, squashing does take a little bit of
>>> work on my end, but it borders on trivial, and it is much quicker than
>>> re-reviewing a patchset.
>> I figured that it could go either way. I won't resend. Thank you.
> No problem.  Just to be clear, do I have your okay to squash your patches?

Yes. I may have introduced some formatting (e.g. tabs in struct definitions)
that you dislike. Feel free to "correct" any you find as well.


Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBCC19047F
	for <linux-security-module@vger.kernel.org>; Sat, 30 Aug 2025 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756569760; cv=none; b=oyx4Hc2/mfs3gXy/u2s+4tuLsrAMZFLtP4C/MrBHaoMS37lh5+nXK+uIj1lEj+z1YkZXEVuf5vR7gnTl09ees4xR0H8A1Lf1U5/95LMYhHY3SavL/jETsYkRF3ZNuEqpu8KcjhSyD1TWCothHwr/l4kbFWuHRicdIFqgP15Sr9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756569760; c=relaxed/simple;
	bh=h6Kv4MLU5D0qa95VwZu+T1SQxDTE4mAm8HdMidMKxbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X42kXkzI9x2O9Hj0WBaCraq5oLiXLpq1lzKbwKufdJzmKuUF0yb+usqANaC+ySMejrloKt93XVaJ/jp+r8BmJUrZK/rY+akh7+9hu1M+GhNcvJYB3B5X9lUT6p6SChOlmsnf1DqDORjk1crtP5ztgJ2wOgeGJkgeS7Ku8trKkZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=KizHdrY+; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KizHdrY+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1756569758; bh=lf5YxXe3wERb30ft13xY8rG2yVlyo1de6EHDnd4WiOY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=KizHdrY+WjgAsI3YgRj6USglmevMEsRZTUvaAuKofBMfTKlb05TSDVetCSTohAwznpOeGoF2mMoEgj3spXdMxWk4o7FmuJKTNZjg/Aq/ucrgIX3ivEXzHHB1vMVCISU6P0VKYEPGYU6x7Pz7tr/Ggjr1rAV3CkPQMbks/vjoIEyxAIM2VzovvV/DzBboRb9efnigLJo5iQIOjEOYcb9k1gobgTYwR9RNiFIbz4s+CbTqfchOaNOdsQOzLMY5895a1ubHssiqcLSeZV4wOm47S1d+cT/lr41phDdeQrSde4MYc0l9M1sWy2cBnq1rwyorZnZd6oEAB3zUV4hb1PW7+A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1756569758; bh=3HtTM1k5nMva1zZ2d/BvAM/PsRG3koWoauuuAWzVRco=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=I1kotUuy68FrkoMO0eHdG8Ce8TfZ0nw4GyrG2ffgd9uyB6JaQthN1oNh4n8Tzw0CZBzwKB6Ml+svjPH93zAAQUU5lPmMQpBY+Bn+8tTcW6daBP4XfXn8n6/P/RHgc1ULTc2/jedJ1a09kWx9o1khFsUSXld4UaWQlgXoALIyiLF4dP/N2yIvtxXtYj/KFF92GcVqqDROQDYqQHAy41Ra0cYwp8HOWnCP7tULvbcvhIl0M3Qi6mMkW3DJvDF7fliTMoPyT4PvaFVgbf8fu2f+S5TSXR3RLpWJThPrK53ac0/s5vIdhhP+tkVSh9i19LXxt1/suvLEZsPbQ9Fd50D5vw==
X-YMail-OSG: CLALg4YVM1n2PDGmmwJ1egWq0cMLWTqw9To9a1DADbl6jVr_0FUovqe8BPJ9xjU
 mpAjFWUFUr.qWS9m.5DXvRiJ4Bt0UpkEzvaYhlYVaC5KmYcsRsPpM0gqBVM3nDi8FJHZSYcv8Oe7
 40aqrEJKI95we8u_552s4hssFjwsBCaoUIsycYWB461iO8VNHuYiZufA3Ee.fhPjqxi2W2FT4Qoo
 jPtjZkjKFGCLA4i62QRXIiv9i849sISXsbGpUYOweg4P7OJ42ql9wfSPhf4IunL8cMosoOzizViO
 Uhs8KqlwlaBSMArhtna_DzG4H7uUUho_yxzSl5Rf916dr2Gh8XvkTO2ApuQ3xWkuKZM93iXqyWdt
 GZ6FE1gzCvPiRl8Ro27P6SpHtC1XnwE.wzrIIjjSs8FO1vLrFGwCrhPphfJEP_f.qUg9K7CM.lPj
 ntOf2mOtlHqXASLJs8ND0Fo8ZRCZuwBIfRkgJaZabWyLCAVytlhVbgpWQiaxsvrDqk54PbBd1.Jv
 iYKLsmkXrcloXwyJZGbRf2JLCpLv2B5PiSQ594xv_s5wt1ofrbFz1onhgMRrYEO6BdN5d_87hkt_
 UT9vfW4sexJKVs.RE.UnZgOgBovbpvqKQ5S15RPuOtSNPeIYrpxKu4yIFiAhHMjgXogSAobitpOh
 Yek7qKUcV2Ew7ZwS0H17EyVkpOl4z_GaT0IGg3bNCzhmKc5J80WOXNyKN9gY0ZgyogZAupymnwhK
 sKErXtVpDMNDM1LOfPheiOEaqZvH.hF0MWS8Ms46R_VLrP68l.p9UeLv8ufyo9Ygyr425jRP_nhR
 FAthHv80HMHRbyjLAqUgxILHyOx5TSUxT441OjxleOpjom1fMHocyEpoqhArjPe1WqQQW7NhWVcL
 7sCqC6MsmPxLPvinQTo.q0KY543BnnA2D2vH.qCZiV_TY7jMSCyzY7b0KjumHH.SYePi0XNnQpGg
 O4pg_0hdbah2VY3EnbsKwiCuOKK4sxypoOc2TQWvePOrSTIEzxzl1ki.suMwbhDaYlSzv6hGsk1Q
 e6lqZp.L15KYZ6VjqGwK5gCT1u797lXo87UcM8rCKkyOBEBEga.yROrpgyVQmXtsAY2UrCMdExMR
 QFitELxDslhuH6j6i2Vi0qm1Xn46h3SA5UaNIoktjMDDydKrUFTxAvQjod8tqV_WPa5HSWYZdH6m
 9x5.cTvUagPT4iKcfSfKVxE9EXEQuUjFgPdFyX_f1L6mJ79Mb.8OjvyOGO39gqoYC0GM9uMZp8AP
 Ky5YZJiEzY1.pp8sklX.IOOm68zHT8OZaF1A04OkdWfQDBzOECARSEtJvSolvb3fJEcGvina12.P
 IpetMzlaU_8IMlHfo2aEsl_O1Ln.JIVkztMRSO6wFmg.I17axsxlkJKqWCb48_jXGKyNw.AN4jwl
 ZxWiDAUHOd9EqPDWQKMF9Ysm_gO3uiprlXHVUGjva3A6_Xbqns7gGpNdkvnTXTaDJlDKlEIyp1Ez
 OUamDSI7g2JWtB5NUJKr2WSONTA.VVmWw3kEml9Jrd_w7meu1YU1AA5mdWS3AdYYbqfEcT3ik1ta
 PFDdiIPqr.3YTu8RSeMy1g1oiYYkXJHFyp8_azHKUPMKt2sBvlVNsqe4M9yiCESkeLexbysBJn.R
 EK8I2FgB6UmmzyvEC63mDGVCgvxrijeFw_VC5Z1C2.8avbpLE2M1H8UaK1MQ5RhTjSk4sVfy81U1
 mmJQssAsO84F0sZZRN1Ttk4CuD9bBJ3DcKKpkL6pdVG5KwNO0QEXHYff.YgtNNRYb4S1Ynkm1QGs
 GfM5jZqlpZKrFbCHbHGfZeCZkaFl5BvbWXawHEU_YUkkSqyPF8GeGcmeSNSjv0FK2CbAoifN5wBp
 XNObpY.g.08dlRsxZlBwSJU_PZHnS4Iim_k4RsqEMpq.v3t4maC6UHyLYJ.bdQd87CylXmdPZw5x
 fY7p6lTKoAO89e8xPp0euOw9Z.NCdD8QtHJnt8AlmBMBYlBvh4BT2kF.Q6OlPdtd7JAZVC0BcgDP
 0hTacYZFk0I0Gy_YfhveWKa_9iHrRkOM9np9WCVPGeBtNidZKkptxY9D2qRs7og2zT1QRZwfsThH
 Hw15BidbIr2PlZqHR2SYnEf4VHYJ0lpmyJuIaf10Y7usPGlYj.FhBYyy7Xm4ORqZz8SOS6YIyh4O
 THSR6uOVird7FHjTwBh556olIpQ3yL2wa6A4KmApu4Mbdo7yGFfsB3WtqC7yhIJMXP7oVH.Sn6X9
 kbM7Kr31y74qsAHmxzk_nB9r.R3UHlKZULo6J.B0-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 2afd97eb-3d4c-41bf-b716-43836558ef00
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Sat, 30 Aug 2025 16:02:38 +0000
Received: by hermes--production-gq1-7bfc77444d-7l9vb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 261e6242d60e90c99a8fd30b59c0cef4;
          Sat, 30 Aug 2025 15:42:21 +0000 (UTC)
Message-ID: <43a0ff8e-f814-4305-a0f7-04c820b8f39c@schaufler-ca.com>
Date: Sat, 30 Aug 2025 08:42:18 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] Audit: Create audit_stamp structure
To: Paul Moore <paul@paul-moore.com>, eparis@redhat.com,
 linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20250816172859.6437-2-casey@schaufler-ca.com>
 <e6e9ea4bacac5553810f7963533a71ca@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <e6e9ea4bacac5553810f7963533a71ca@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24362 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/30/2025 7:14 AM, Paul Moore wrote:
> On Aug 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Replace the timestamp and serial number pair used in audit records
>> with a structure containing the two elements.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  kernel/audit.c   | 17 +++++++++--------
>>  kernel/audit.h   | 13 +++++++++----
>>  kernel/auditsc.c | 22 +++++++++-------------
>>  3 files changed, 27 insertions(+), 25 deletions(-)
> Merged into audit/dev, thanks.

Thank you.

>
> --
> paul-moore.com
>

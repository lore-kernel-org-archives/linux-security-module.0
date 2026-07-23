Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3105033F5B3
	for <linux-security-module@vger.kernel.org>; Thu, 23 Jul 2026 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828848; cv=none; b=R4L3htNDf2x47bQNBOQ4n6t+U6nm8Xa0aCIm5IcmoNxRFYWW+Dg3DSWxww33yc2ftthEojYLz3gAa7/7vwdZjUa8dE5qioqa7bymDBjOC8UykR0olHMcBNIsNFsxiGa1cH44qVeqIIEFpp2DYS/SGK+d+OERIBV+T3tZlx8Sxic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828848; c=relaxed/simple;
	bh=zna8ydIQ/LcNU+7dOAT27Bq4SCKAtcni+JqKHAeiR+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9c/2EvqlcUc0pbf2T4zhtYVJ211zX8zabIF9l1NCuBnoIWhEDRk0LC/UgwmueYTyXMsW9LjC1QRO19sH8uFuvIktgWfCgtwTBgtn+qTjTG4J7uiH/0qVvQW0Llw7n0k5je9E84UD2vu/HK44ZPNtdXM9Sski2JOg+T9dQRtfxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=JGtRk6GX; arc=none smtp.client-ip=66.163.191.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="JGtRk6GX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1784828838; bh=SPgkYgVdkYCViLp6HnJK3NcoCARpo33TKX4Bj9SO0lI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=JGtRk6GXzigOsTtY9IQGiYygwvLRMRypaHb2M4SkljU7jBsVk/Fk13LrzIx29XUdmIEXjjj1fnW1SUmyguwiKUgDpzvHTAUPJxoarQdygCHcJWBP9PEd2wbGODSA+hb63AH0YcCyY5C9/8b8sxs6BMchxKQUL56p7HyhBfB7j29QOdv135z8duFu5czWVxzs+bczD2Kzt7HFo5FnuP5Yp7E8E/ezlLPC0qsskmI71hGrnHXsYODGSnheJGxDzGGSxl0KQ3DWtP50847CWc/XdC3xKmeTkF+LjSnTufhZFptdKKh428zLBZ3o5eBSDk6DzH9ghp7+5GhydpyB+f2RrA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1784828838; bh=Gu5ouOph+4r0dtnVXFsSx6tzaCf29h3v+r3iEBEjWj4=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=sPdeGTWx9h0/j1SSY/k81Tit4HMFwAxEv/BlbfuSTiQ6H+h+2PzqRGB1nYkyPYteazf6B798AP18qTfV7Xfl4of45oGQi+YrHM99vOlc2+1z2KHPIGCd1FWaHu6/RqtaBonK2CmV7ZwYBe0rLlFNhousyo5htvGB28TFwjcTlj/uNx4Vq3TA9Gza0va9MYEi78qPYlJHWspn6K6z/ii6tKC8uU0go1MqVnZ6kDnH7Fx0lKcnJiiuUmhs2SaHCuO6KWbKjRTEGegUK406fZpV2vOY8xfjaf0ygCpAWuywU4gozfzyg5o/aPloCIMyPZGbWpNTPgb7lnTfTGgLbYQEqQ==
X-YMail-OSG: eSpTbXwVM1nF9v8_ScZ6gJct.C5NXQ291adDlRhZavG34ei3bHxt9zEpNh_FNOS
 .EaA20wwgIHC5CUl50SC9VnX1kHeHbrxOWn65.DbhXbqnVCsLIRuRatkKixTxFpLvlBBF2OwCR9C
 EldSKKTgwFqr_IOoLc4pU2DOoZ5p_Ay7Pr5Qcl..GaY5Z84sODAPqQLhvMwvrn1ogl4zx1AZWVwT
 A9wJnmzApyx4ZmhQIqoUnagEpULiC59fkKsAKae6zmDEO8MUBbeMtp3_Zk0nYfyi4FE7jWKY5TiH
 DOpj3J0UNcNAbBy9gyumecPUVVJsUG8PW0kIxaRuc1KsBcyCNtG1w5c46Q26ScKm9jEBay6YQk6w
 Q8_S1aAeshnxO3NyyrKWJ8WXepZzEpQUZal952Y6G3FqxHwKM7ngkBgbzxcp8W1qsGSN3_OT3jP.
 wftGa6lzz6CDgUquLn13JEYqu6RBGsvu6hXmrYz_MV7DVq2gem5gitdD0xI.zo_waIr_NOL.oM7q
 EM4SFT3PMnWpIoPKWlUkKcfAJgQWe4L4O_Mj3gkllM2EY3dN_3aepJqcK2OCwlryATeo3.6CpbGC
 7VX.5qNeVv3DxraZPK0Q.nZuf71nsgtAnx1qT44JgYFUv6w1wLEYIlB8ByVtNBooREL5VMdGWgKF
 Fsw5JNfrEBETP1RTlWAJsJG_pDT3Tg2EYn8bDkbeuDJ7Gf_a6yqR9qX.udKVsbxHSOF6LCZY2HGi
 rwWrc8ufIIbedtIZn7.QRZziPzycBAH7sqn28dLGjCpdqXNEGbI7uNCi3TVGGKWn7pg8gI1EaQk0
 NBugfOcsObKR37LcUyX2iydR5tEbqQPMPHQKHjd0aHkkOAJQYy22vm3Ap9rJc2aEubULg3C.xXsu
 jq5QVAfIow5xxuduQUAC_HoPx5IkhJW42GTsiYZr7zRYlCnYP5kAxLyHZ0W8alyqhBYWLoogLy48
 .8VGuDK0sP4kTZoen8cPLN7rXJdPUmscZRxo2rXLtxfXf5Ntrm5_8j7V3IPoFfvKgAEfVrWRYQZi
 faurO7dVV0Sb7380aVZcgFOZdp9mbTAQUwxSm8NfJAs7GLAULxt0NE2vIyXIR0e956iZph10I1wy
 DZQHK5AvYW.8ME0RKe.mDtXkVAA1oxnbPrShYk2xwQdcdnHXQA7I4tvudcY8Kq5wvwUkY7QNVeZM
 Kho4qLhPdiiDsDvZfV7ZWAEoE2AsV9GNLOIUy.usRi8nDl2tbfuzmno9lTgypSqA5gh_Gz2NUgc7
 FA8aW2DISx_q1V5iCEefDEB3HMpnrckx_UjM1NNOpewgy.YoyFpNCN6MNmLev1i64Sm5.V.fZLEy
 MhIguBGxMEfYezDwUgStvN37VAlxrE4RqNDILITs9ICtc3_Az.M3vRFC6ta2VJYLaWHgDHsVBBDT
 x0dpPuFhSN6E0XoOUkvnK1aZRr9TE0o98Q_t9ygYPT4W2U2Kt2ZKbdBcGcSf7yoGHAuKCvHoNzcW
 AygCnk0osarFvxfE3tfbehqHnecodwAENcvlGDvVhAVIXCcV_YSK8whqwTfXuSyAsskZxZ1YoN5Q
 FzeA91aHhDBB0IqzbojXcSTYWpXD8OXXwq0JSoT2QYYDak4MAItvKoQhurFgfMM7Wi4J1ocTKNzO
 E7v6eA1.8WclyGTPlA0Cz_f1SWP8AuzKYWIKmx4LeH2hn.U0zN8DATu5Js_Z0QVPfBLmBstrUxbY
 Z9aZ8v5bQ6DY33yqc7DMWfvapVzKXaByyiuAUsvjJNdNNFu3_GuSzcjeyWeoGVr4IF.9GV_jCi8v
 n2uQ7U6K.uOSQY_.Fo8lh6KbTPawzEJ00xtf__Qdu4t4skeIZ6GCyeoD5PGwRLagnNju0lNl3_GY
 Wd1Eor2f0yir3qKIhJxRMiKuT9AxRLp14QX82sJy2vEvsUeMMPwAy1uu8uPTXFUcFdDaptNI1DFu
 s0vx0ULPCKmBi0Q4vxaI3PlDU_zqYT2Ni5p9j.cyk0za23jmyzs64MavKliopCe_mh_2gr.VTOHh
 e5vaJSoLFZTpf1.47Ux.6Fw2HR9UzSWOu08X.4xgOdmsMP3_mjqS4M8.8EFw3yhAOBr4sQDdXXaK
 Cb1ZXLTHsBu3GRuroQSzXcHVwOLR91cmGYrHTWPbg3nA777bj3huIHCHKQpwmjflkUwyRzyl098I
 nXVMCl6oVDK14LQIhFQMB77IoZ_z9sCbgt3vCcuDYOSjHhCs.PsImNO4oG0lyMTjeCdW9sNj0ifd
 YV5EzMt9IZtKjsGSV8.1kn.7kzbursUuovXZ4fVvQfDfmladP2j3ABoFzJOeDg9lDQyV6xI5gt_.
 I1.JNqZ.wU3_EpI3lWE1O
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: cdb8bf4a-c2c9-46ea-abd7-9dc780338c61
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Thu, 23 Jul 2026 17:47:18 +0000
Received: by hermes--production-gq1-7749664df-m7mpl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 02e75194c412cff72e30910dc20b8c76;
          Thu, 23 Jul 2026 17:47:14 +0000 (UTC)
Message-ID: <d14f03a6-2c48-4f96-8682-29453945b29d@schaufler-ca.com>
Date: Thu, 23 Jul 2026 10:47:12 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] doc: LSM: update usage document for current LSM
 stacking
To: Lincoln Wallace <locnnil0@gmail.com>, paul@paul-moore.com, corbet@lwn.net
Cc: skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 penguin-kernel@I-love.SAKURA.ne.jp, rdunlap@infradead.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20260714013832.977443-1-locnnil0@gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20260714013832.977443-1-locnnil0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26180 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/13/2026 6:38 PM, Lincoln Wallace wrote:
> The LSM usage document (Documentation/admin-guide/LSM/index.rst) has
> not kept up with the LSM stacking infrastructure. It still describes
> CONFIG_DEFAULT_SECURITY, which no longer exists, and its description
> of the module ordering in /sys/kernel/security/lsm does not match
> what the framework actually does.

I've been stewing on this since it came up. We should probably
remove the somewhat complicated logic from the Kconfig files if
it's not adding value.

>
> Patch 1 updates the selection mechanism description to CONFIG_LSM and
> the "lsm=" parameter, keeping "security=" documented as the deprecated
> legacy option. This revisits an earlier attempt by Randy Dunlap [1]
> that was rejected for treating the two parameters as equivalent; the
> new text keeps them distinct.
>
> Patch 2 fixes the ordering description: lockdown precedes capability
> when CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is enabled, the integrity
> modules are always placed at the end of the list, and the remaining
> modules follow the order given by CONFIG_LSM or "lsm=".
>
> [1] https://lore.kernel.org/r/20250114225156.10458-1-rdunlap@infradead.org
>
> Lincoln Wallace (2):
>   doc: LSM: describe CONFIG_LSM and lsm= as the selection mechanism
>   doc: LSM: fix module ordering description for /sys/kernel/security/lsm
>
>  Documentation/admin-guide/LSM/index.rst | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>

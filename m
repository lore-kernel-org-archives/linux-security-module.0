Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FA43BBEF
	for <linux-security-module@vger.kernel.org>; Thu, 28 Mar 2024 16:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644295; cv=none; b=U0ggXh7QPo+cdyggO4Hs8zNSeorDDMZuQLjSbEUZibf70S8zB07jslaeSpqq45j6+aV1lnKjT1ogsvpPb4Uqq1Ah8DGI2/qyfpQVvPWyhymFIPV66AhjBwxXTjlRB/4/QGI57nZ11jNTU5SnLs26RQEs1hzGu3sG5YPNSgFlgzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644295; c=relaxed/simple;
	bh=upbDFt0G/aqujOQ/jczW7McnIK1k38wtJ65H6HaVGrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aeJuLv4Nrq1AbaKmaLna5eCRLSR5kb73TjlKx30wz8GACjiqj7tJGj4H55G7/6pHBUSVmBIFzwzkXic4BYAJYcc+Yyvpzbcu/iNG0gGOZh8f2mPWfXuhsz9d3JIvVoUPY1XygTWbaz8tndLz3X5hhmReXCKPDbPPKRHVD903m9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=a8Zkzgsy; arc=none smtp.client-ip=66.163.187.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="a8Zkzgsy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1711644292; bh=KbVXIl5WS69mtz578cqveETwQiTUCqyWWc4TShTmsdQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=a8ZkzgsyrsYHRIYheEbI5A7zheDQGYZuSX/x3LhN6SOco64hSpIrksOQ+qYFr1eYeKNih0VNjbf1zgxtADYc244OIIsSc19rvZNaA1j2OstTm0XtWK9NrrjBZudNHVGxU1/5ajVIPsb0XnTlRRSQtRrxSxA9P2lsc/BX408Ch0NLOirsUvYyTNRBJmb8/MrtbpkmlAAEIdXa8S52IWodOV5nBSFACAK8cw9wDe+Dhwem3iQrD4W6iK/62mId8dyLkZeb9vx4pVw+IUGiMh01tbC6JfKhpwvBdwiSIP4CIbZ5P4x+qDEUq0mIYTDMOAjFSGy3tILg6BUgpusvlGiFYA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1711644292; bh=QgjI7iQUB93IWgJsx4jmO0XK+Y5bN7m8+i5SAow2EYs=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=qW4vxlMgKj6LfTTw8R4Id1HAIlU6jSNERorMc6lvs81B0RIohpza3zgqXa1JoAtoLONVPIktqEbxGP3jBbQ2VWEaMi175v1ulR0zvSQSVhb+9LtkoLzYO8S1S2rCk3vZaAeGsS/25xT2aRlphMumeVmrgLCai5/9bRvkBho1HOr4X5RubGVgWLalwbALC8DTLFKiyQIR5XVaaUTpXHvS7uutElbE9yAhXokLrmdx6DLsAbKtm8V2irhyLA46guSsNa0syMQRwMBCDko2KPBIp7uuw5YeuCbAoyp78cFeB2UGlqkKg5ieDApllcJFM02Yf/Eor+TTPGNNu+nRgPqJww==
X-YMail-OSG: HEJwnG0VM1k1Cb1KM4jPGZEgw710Jj12bKJOU4.bZQ0Y4RJro1h13vbhJC9UUig
 gBZ1L1FUqkIUuazU72F02laPnyjQ81LiDSiVnBM.4eTqh7F5Sa51bgYEzWUb1TAOYEMh9LuYPA48
 shSnLAorl2jNvBE7xd8U_V8myKEK7hLtwnRjS7rfS7XlyfFV6Lu8GQMXpSIqN8mjdRONP.7YVdtW
 zsVRYUpwyQVFWXabVjM0ZcMuHZjK2u_yiQKXjpLG_DIEOKY..nwy2GZJtEsy5oq_xgR7D_LTl1kQ
 8Gg_tGgUcQRTWMz2y2WJ1NqP3vhBYlf1Aer6cGGC6taqfxZUeGI82oH2TUH4o7xWbEmVdmrPViKR
 NNARpFlGIhFQOw.QHQzZFAwTAqB5gyNzY.Ey24lPq8Dve4EY5AdUKBQl3mJybWEibqKsxZVZVDoK
 _T1FLMJXp6jXJWQmt9gy0iRGEpUXOXdp44buTg.5ZcR8K_9a8vUSoNglbLF7H7Jp5uLQFADUxrkh
 E4eMuUUAuIlsq2dyRQKqf0xUHc_HwxnoR1q6Nl3nZhkX.3V1rOxyg1M9kSKc0Oc77jCb11yvzdIB
 TXgusWkr_.3W.e1bTJPvgrFYe8sbaOTTUefFaFys4qX9E0OihBFhumUoPGbzPc76187NXoRPpOfY
 a1lcsmfkjg5xuU4XBEf.Xe4OoFqgzQdb7YdmUb4XK3ppc22KDocXHZcGfPMVGi2mxwJJ.psN8ub.
 yP.u7W9gxfcvWG1h.wIe6c01MFtO8wYGOvQgbjjIUYHF.BZHzxWXnxRAOulg6Wa33XncBL0o4Pva
 acA8a0jMFsIgzL8.7aC7X5joZRbft0wm0EuoXxenWlf0fMZiZMLiS3u1h.kpnslxcQHdbio3rB0W
 oiY64PznoxRhG89.iZ8SRyXbpHXs3PsdPj0gyBQofLt7i7aY2OuvBFNQpdObjwaH1LkCPojysgdF
 L1RsvZ0rQDobRM9_qOo8OFFEX0xde0oDEfdCK0_UmXr9rj__yhCJRfHjouk3r47WXiIEpNQ3IbZr
 Sv15gv3SBS_PZG66tRT8Kjo0vVGGY0uEfBwojAJxbhwTdnvMBWfblRsgjw.Klj5yGVx_2fMlHDOy
 WEKCbs_krZ7vpru2ezpwY6g6PT1zcdKH2VdTBRVoQ2P.EnGlPB5FDBUpeR_PNFkDdnfQDXmRx8_3
 eE.mWGgJq3Dd9GbkLa1rqFvV60_ZJcKSVCkjc6w4hkmOlEKCz0cyqvJXUuAL6DF1aFTBK77Ojx51
 gzQO95SsXJMUc_09mwoDzayi9AeA1VR7xHG6BKTVZyUjMb7JwtfqmULourLZ6XB.RtDgVJ1Z0hmC
 bStAeoPnSFlhIy6nxrJF218xYpWrV4xeSseQIjsQyBCYpMS.HzIadWzjdQmStu9VxHPl7UiIE4pd
 22v4giy232uw32xYCflzJmy0RJ.fqdFqvWMqPuChspxf.JwHy2ydjzDgbdDK1caQBGTIU6UtQ_eq
 ue0WYej9z_JSTB4DhW5ehlyZTX0_3uOGMfvaGY.bGZ6Qay0yNZc1qn7HNv1F_qsRU4fEi2MI8Oyb
 To3sqkQsBEC7jAan.kwhXRgvjQAn7HXC9f0WNBrZQXc0liHKsi2wEonGaz.hHwshgoA37gQb5QIC
 FgxNa7cRWOVjp4y5w5nMcPbugAdNd5Monh_WdbApqqYeGjW45JC4EBIRnrNy2arFSgV4wQ3RkotQ
 i8g3R8kG5FqBm.KdY5f_u_xEVMD86OfDsDYUMVGx_LMH7hTLWpuyV44.3xk07EEOhdDT2qyta5d4
 SmAvcWwkPSYZz7blRqV3yIzVGeM01cuUI.H7cAivegYDayr13Cldx1ztl8SY4NaEDrdvwk7lGme3
 2J5sisuJ7d3p7iDzw_brCA7AFzWLlGp0fx.wtFu1TNPiG5_5SVVSDDCgAlo6uNkqxeEIOQDV9MuT
 r8kJsP54oHqOqvdMszDGNSHY8jljvGaaBVN19h6Q4wt0qjqBU2ZbpkwBs.oPFWuVdVPUwhzhsr7e
 YZHFEjH18lDmqsJnh8I5VwBekPwUSwOMXq5WIfLRTq8W27AsOWM81n47lWowo0EaIQwYDW1x6AN5
 RgI2vei8l8cItjzX1WD3OpOLyKCf.Opa5klmx2VcD5SCRgsUDfPIDIyFhZHhgvQfAVRbGxm1HC9s
 Jc7McMoi32fKG60Rng4t.Tt7JUhIWjCpnKKpmZVNcEMGyXYvcAhKCV2SMM5EQ0YeMO7aiOkY9TyJ
 iPIUDjFYB5ptoqnkAb3PLiUIxJacDE8pVyiDdK0eYut.P6ARTNxmdNknI8JkzMS65CsMQjXRQpra
 E7GXcpfkGLNo-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 02c310b2-0936-4aba-9d5f-9b14cea307c6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 28 Mar 2024 16:44:52 +0000
Received: by hermes--production-gq1-5c57879fdf-7pjsc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b7e8eeb25656c4ca14a551933a7c07ea;
          Thu, 28 Mar 2024 16:34:41 +0000 (UTC)
Message-ID: <86c7477e-260f-419a-8aea-ea527a344877@schaufler-ca.com>
Date: Thu, 28 Mar 2024 09:34:39 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Do not require attributes for
 security_inode_init_security.
To: "Dr. Greg" <greg@enjellic.com>, Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, roberto.sassu@huaweicloud.com,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240324223231.6249-1-greg@enjellic.com>
 <CAHC9VhQ22ef_o_OYue93RZfff70LPuOaCuN7Czv7HiEy346Svw@mail.gmail.com>
 <20240326103047.GA19964@wind.enjellic.com>
 <CAHC9VhQvN43LL-ynV-ZZgR2L8wFfUeq2-SZb5QHh9ZMWtz4C1A@mail.gmail.com>
 <20240327091644.GA32347@wind.enjellic.com>
 <CAHC9VhSjjeBH2CE5i+PK9Zyg661k-ryDbYkoPLtEe-g52DW0Fw@mail.gmail.com>
 <20240328153800.GA17524@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240328153800.GA17524@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22205 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/28/2024 8:38 AM, Dr. Greg wrote:
> ...
>> In Linux v6.8[1] only Smack and SELinux provide implementations for
>> the security_inode_init_security() hook, and both also increment the
>> associated lsm_blob_sizes::lbs_xattr_count field.  While the
>> behavior of the hook may have changed, I see no indications of any
>> harm with respect to the standard upstream Linux kernel.  We
>> obviously want to ensure that we work to fix harmful behavior, but I
>> simply don't see that here; convince me there is a problem, send me
>> a patch as we've discussed, and I'll merge it.
> BPF provides an implementation and would be affected.

BPF has chosen to implement its LSM hooks their own way. As it is
impossible for the infrastructure developers to predict what the
behavior of those hooks may be, it is unreasonable to constrain
them based on hypothetical or rumored use cases.

The implementation of BPF precludes its use of LSM blobs that are
infrastructure managed. That ought to be obvious. BPF could include
a non-zero lbs_xattr_count just in case, and your problem would be
solved, but at a cost. 

> Bear poking trimmed ...
>
> [1] In Linux v6.9-rc1 this grows to include EVM, but EVM also provides
> both a hook implementation and a lbs_xattr_count bump.
> BPF initialization, as of 6.8 does not include an xattr request.

Just so. If BPF wants to use the aforementioned interface, it needs to
include an xattr request. Just like any other LSM.


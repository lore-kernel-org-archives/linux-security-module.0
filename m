Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BCF82C76
	for <linux-security-module@vger.kernel.org>; Thu,  1 Feb 2024 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811792; cv=none; b=stPzREm2k/Dm58RYUvlMMSXOMr1TnVMUJ8kb90y7iPxhEXiEis9Y/fhorrxFPoW1ITLjnCmqDcEoqMv5I6Fcz49tLUJtEITRqvKj0hQIkWiSVd218elVSnZC+5uupEZQOhx7xqO/zzgk7FJRQfVakHWAgy/okQecAe4eYiFeC2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811792; c=relaxed/simple;
	bh=jb3b/xR/BOuTSGOE567ei1o3opdETlfTFrpH/35q8ww=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:
	 References; b=ugsqg4IPAcWlw4JptY7qrQCJ84Bjx/J9+F+Kf/SQ4HlU7wQj+o2Yra1LCiMQrksCRiazUNmoizooSqCKVr4zpCdvVnK17wfyA2s5/DFQCSySg7PM1Ow/ZDKkozbqWrHYhQj1ZBK899JCA1S6qBa088h56vE/OhnMCmpP2B+BwkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=f7/iHJ+6; arc=none smtp.client-ip=66.163.187.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="f7/iHJ+6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1706811788; bh=jb3b/xR/BOuTSGOE567ei1o3opdETlfTFrpH/35q8ww=; h=Date:To:From:Subject:References:From:Subject:Reply-To; b=f7/iHJ+6UzSRnXeHuWNJQQBLHjdCjMjGKh+DFBev4S30/wgh1ttrd5FoaNRdyVI6egx3mALbY1H++HuIW8PKZWq7S5r96UUJvBFTbLYZlZaaxg4eJcWQ7ijM2WqUAWjhh2UdnTCXM3NiD/odxcIe7C6yU/eA4LhMF3f91Qw7mLcpOOB3GVo/xIZTLZ9I1IhkDIkNsFQn+0ki5tRgjPSKbhK67p7ezk/3tBXM4YAqmg40gJdJQ7Qew5+HT6jZ+OfaJ9jnhktnYHlj6nMJ5Rsr30/cNLCNW4E/IolKz7Ro4Eg8KZlS0W2pJ/WAw+inS/dXNLUk5bimN0iSVocUf5SC6A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1706811788; bh=B18geksL/esv/FNZT45McbilpAoeiWnxV90viMFUF/3=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=RH9B97tT2wzYOHmJ1e/QROhAkIts3vPiECKOVHQoOkxXzcMaogFmwDKFwKQGTBJIWoWETSyZoX+NI37EOvozRZ92NK1ipf7g88B5o4PcCjMPl2sXSEGdQ31GJSmrNvaXhXvq/UDw9426K9N7HetjNaVQ3BKM47Fd+LibUOumikmagf0v7shOL+zeDmDWc24Ff8fu3fHnGeTkAPt91ETU4oQGHcDMaqJxTLJ18Bk7fMcecVvH8Vx5Oc3eSMxkDKFpY0pXovFCDhhjty6nWHEkH0V918vtbzlu2WLzsDp9vU5fq4r4WgSyPL2ye7StDBj8J6MvvU9xcQKqY3UFfeFD5A==
X-YMail-OSG: KkIwvwQVM1kmq5GJLlLM11SjlE8uu3_hkxQPCxC0KTng0oE9rFmv9bDK6hnhVRM
 F4sFAkNRR3Hm55NfEhiIQXM_AlHqScuFIy.mLFDqdoj7RkZFv6V.IN.t_QqYP5rZc7p6avE_e1Oi
 g87uBc0gya5B1ahm500b21YcLkGbkz.U0WhJhNxtC60u0CvWA4atbMgX6A9pKuLRTcZ5.3AHSXnb
 J.0m0s7imyBsQczrNtJShnOAVThgXwnuOmkyuY.1TLWkV.C_DYVqXpo0.QccR_c6n7VRM2Fofhx0
 FbX4fk5_vKRPJW5avp4tCA3ZKIyHkJe.2WdrP3GG2jscrwU9crgBmT43OPdKrlR3YwLpouEb5tiy
 7oSCGl5gd45x8DpDUYvxRc0U6oz8phpxDjKBXyhfi1TqyhilCFutIvhXN0HIZjoVNQOM.VPDfElF
 m92t78Yt.1iBBznjRFPv4cwb5egOoJ155XjGELbUpSMRqm.UPxIUxjlLGgJhKDl7tspslGdfdhs1
 NCXVvsFuDZig.7prcykz6x_9IlAQ__8oscoylVKe_c4GEPrFFjuuypc3zODyqG2TerNRiEOcYPBt
 ha2LirZ_TUbIH_D2GE6xRjGsjkVobyErKE59QOCA7QYntAQ0qKmU.PJIWvSRYxRT7xXnz5w6YiEQ
 Skayl8ta4Ln7RTV.UfyPxFeKws.DR7z7UBNNPLVD5hZOcVjTLQzRN8vW2T_AcMPGKaPm52vLjhVJ
 vlt6OJehZYOzDKvKycLKI5qHko52fuAJ7E26NyXiA5OMkxQeTQZrbjiGPtRdMO9zlEQgkpOvrvKC
 brZ6c0E7djIfpDx4xgIkNnqGVPQZJuJfCcNsKpQTzbd1lR6GPxTqzkknfZcQWAKZey2CdpH8z5JT
 JAvW22EJeICICc1z1uprmUPwZ5cRfnfRqXJ5E3O5GOc4m9aduZ.wmA3scqxS1SjdQVv47buPT9hH
 sKTjcGzVhJ9ABXOYalTrZjSEO6udqG5pc4MO8XFgXLD7Cogs_T5mIupjhb6D13GUOqvr7_rk.Clh
 M2qGaxn5Nz7G6suu8EbHBQTj0ch9bcS1rooU5qOmGb7BTX28eYKwEOmetWv.ZwceSOtX16AotGs_
 vEopWtKGLQZ4eCjOKph50ZBFWrakheu1cwzbTGXlFfUxjW22UFgNLoG3yDXqWG7syLH_WbSsdIjy
 f5uGwjhnHNMBEuogPWXofzl2DQ1dtIcgQgXuPF44CNIqf19aXBl1I0TWvDS3MVVgRdR7dL18_dhT
 BYeZtPVECzgt_gXYPEES3FM9cC_9L1o81_DgushGhK09TmqJJ0lDlENQqskXPX69..WYuHzrzlLi
 zbt4G0qg2khJsGFIOOQZ.bRTKJPH659E5Oa.rw.3Pz3OMw5_d5.YOf2l3z.Q4yvwJP5AyidCwQGZ
 yGD99e1f1Tfu4F6fU.AxRG4H0.DiBbs7a27CDAdZXzs3a2EctrlQ3ZUXnQwfI.rNXy6TyT_k3kUx
 5j7A6dnRaycnWLtCFgrxGpRaXLlt5n4Hmw62A3ZUruuZ.O7Ea.5G8h0uAofld0mEgW4EtfRHMGwY
 _LYiunN9XWVWzJOlu8eXgMIPIOFatr51j9E0kesmKM8850sOuKyJzQH7gb1_pY5aDFjhqxRYoN6j
 8OAuJxg6z6y7pFqapO6glTcyVzvq8b.knLOoPPB4_I0B67w79LJViqbGzWgRkkaPFJGy5irgHuiq
 aapc4Hjr670IM8muw0onQvGwXNjSatjf7P3bBob71kw45nK1YR1qbfCSPCbzNUm_E75ls1D9g5Y9
 cQ_We8M4E3ZvLY_ur8ZBaPChsI1W9lG3Fy5SxEJdcMRN2io9NOsDhlWxKT5LmoDOpA0lFqK0pL6w
 9EKCi1qpRvsuy_SeBeKa1FIF9WEzUKwPRX.Vg4I1FkFNqLVvq_S04ulOEJG6rP99iHHI9QIJDBSm
 AB2ooeHMeY1bhjy1X.UWTZCFD6ZomQ7FK87nBPe0iwqXXeBhj6XRAly8sk5H4O_9wL1qpcws2aAP
 4Y_tcTwFFC600QG_at7JtJQaoItjB116X_h.AHoMC8veY2TH7eOaL5l3VMeskvhtS0DUjF61qB33
 MNGr3P8ScIOwXFF3ix5Mm8bPqisWFN7W.V0l0O3F70b04Bq0hIxPWiH88ZWaEj5mlvS8e6C0LlVx
 1WQusJyYALQCHGny_OvvHWYj1liHi_liuLDsBU95Ut5SP_zee2Bw4_UfmbuSY0EHcTZveKmMsktf
 zUId0sRhf3UGPM20PgdQlc247X5aVnC_M4515erwbmDOmj0ITlOtnm_sLBw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ada86e97-2968-404b-a736-610a760e1ee6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 1 Feb 2024 18:23:08 +0000
Received: by hermes--production-gq1-5c57879fdf-qprqq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 18f223efcaac59f1140d4209ca28282e;
          Thu, 01 Feb 2024 18:23:03 +0000 (UTC)
Message-ID: <b91419ab-84a0-4ef7-99e6-56423d2f9a5e@schaufler-ca.com>
Date: Thu, 1 Feb 2024 10:23:02 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: LSM List <linux-security-module@vger.kernel.org>
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Starting to work on liblsm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <b91419ab-84a0-4ef7-99e6-56423d2f9a5e.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.22046 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

tl;dr - https://github.com/cschaufler/liblsm.git

I've started to pull together a library for applications that
want to use the new LSM system calls. It's still in a very rough
state, but I wanted to get it in the public eye before I got too
far down a road I might have to abandon. One of its key components
is emulation of lsm_list_modules(), lsm_get_self_attr() and
lsm_set_self_attr() for older kernels. The code lacks much of what
you'd want "production" code to have, like documentation, function
headers and the like. That's coming real soon.

Comments and suggestions for additional interfaces are welcome.


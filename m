Received: from sonic307-8.consmr.mail.bf2.yahoo.com (sonic307-8.consmr.mail.bf2.yahoo.com [74.6.134.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDA336EA96
	for <linux-security-module@vger.kernel.org>; Tue, 17 Feb 2026 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.134.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771349974; cv=none; b=UZWn8HV4SAU4cm78VMdgtcVyoQ9yy9NQgtinfnCsG472heQKM/s07c7Yg+Pcgkcmxkazz398WF0M9oHm+w4Ql4I2l1kFfVsFii6DYolUGszTrwAWnEb4cRHP4nJj3B0VB/0KBi+gIxIK4wdoQB7PEC4E1iGFR1UiF4q/SFIzwHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771349974; c=relaxed/simple;
	bh=LXAaA6UfhsfUCQ8ySjuTNnwtOh6Kdjuq+P9PBoM2Eos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFKo1J+L/bLqG4SMn/pi0hM/eX0DILKPLscxlMGD01wH1mOrNJHIZWq2k44XoviSEn9C/Xj9RahhA8Fb6nu2Rlz64b6RClXKqEVCvHuXk53O2/S3TijCnUXBw7WRdee7OBGPJtdvfmAYEDp81Yc2xEOQatbG5yptAyN3bSBPsWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=UfUScA5e; arc=none smtp.client-ip=74.6.134.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UfUScA5e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1771349972; bh=EK9AHzFKgwkJiODkk798f35egRzjNc9C4yeF5yhWtdI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=UfUScA5elxs2p/HJHXFHHxc99wxNPqJs5ibR/+zCOWitfhBuiWVoKST2z4l/+yfUwlc/KTSGqugTl3K+Rb5YziYRKLgCtRmA37bHuBOYROUirtki4ljZ1uzbsqkjLZmlUPFAQdgFKLDtvmKEpLuB4RR15pZeTe58bUzvp834LG9cW3jImShgmmEtRh59VxTT0hU6LVnA6OGVjhMVnLwhSdVjFQAS8qZcZvLmoD+vKBAbtlAk3Sgmozv7ghlIzv4UocKIoNafBOd/YXWqQ3Wpj//mgW6nq99CnFtNzm8HjlZjC7Q3lJMDaFzYCm+L4qXM6svdCFEAGz86ReVmrBM8sA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1771349972; bh=dGYJOtW1/WpwpwF4DiJnph9PUtT12bRDZcEQ0eKtXOs=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=c9CV0ySFmHiVOg9VGt6bZiN6/v3SlCPlX9rcU+rBl8ZM1BgHbUk4Hw13swgY0j1F/vkeBkyCCNLzl8fGIb1HaGiFm5CsPsiX1fzubIgDPxw2r/bHaJq3ZX/3m23dBHq+3wHe19TpMtO3oOWNrBb8So6JaoKybB5yZ2hnl0+tGqakxcLUr82xYG/qsjn9/ydECv5/fMmqWTneShVSUiEIxAKHWXAii/yw1+7MHiqM6vlRZGbcK2dkHuKuapanmnPj+0qz6M960WbGkww+QFd6WsXjYtBMXkpgFf/ko6++/8VfP0lJdp3w5VULJyTAu7oyjVmSf8zZLeN2JDDhl+/iRQ==
X-YMail-OSG: v4Jt16MVM1msjb1OgM5OZPHixaZPDazpUHJMK0bb.iUzj1koMDII6s25ufBOVBN
 VtzXpf.BaBimH.1Nwy6gRVt1swqlaA3DBarmpKLnihPBOX9jYt_4SguUZ.llwwlUxWaSMKISN8YL
 50RiK2zXDC9sUQDU2nOJzG0emn0y4E_8lXKuv43yCJS_jusx6fz02EeyPZpckK97.oubbqO0ggoq
 lRcm7LRTcyXNFVGBkymE71cMmv2zh6dTCWKgyYTNuE7NrIYIupWZIk1i5.z1Adu.DD20EgdYYkCj
 a7eSmNyl5NlOrY_zjfVkImCmbcy2bUxpfvmVNvtopdaE7sUzniV.VS0.UnWhU4k3Aqzkl_PfVYz7
 dZhsDUbi8RbKFod82sGy5p4hx438k5oQn7WwmRGfy8y.CuJoOLKXZwbOKfeHf_kAy71KzmHzA28C
 Vur1Q8uO.4GHbQ59B6l9lROqDvV3kj1ke20ecMf5y9Qjp41YPBzTn97xE5H8NTaKzDH1Vj.AHWj.
 OzVWRHOla8ah6.I7URukdLmQdfch03SJxo9QrWCwuU1z0IgHSiq3pWAsDKUsj9zrHUK7o2utntIb
 ogb1iTVGyqvuF4NOvYRkI.xzJdkrscLbTwm5yjX_VxR4KuT1zvM75tXzNp4AHx.LWjd869ahvrXS
 4hc3DQ9lnC3WRgReTeS6g9ln3HzzaQ0HK_GWjeBDEe4P0pOZLWxUfkbRZQcs32D_KhwyZSSOJZkq
 LDEAbpbP1GnoCA9uCQoJviEdbpct0wDA6VfHHXyla3x9v0I1YJG.Kq04RltDdRbol_kEfbPDkKE6
 ffw0QTQmSltOfYgGXjrRP2fsAfJPgV06KUBFYrc2SPlIB6Swo1bNIgTo5E5B6R_uEMCFWcmo0WOD
 2na2PF30MSxjRbW0AtPtEKTgQOqEv.Ft6uswOFNS4r08uBSQ6WIkfhFHPwq2dgvJq5v0RHkVvsZ6
 _iVA7gRhJTfQp9N5l8mpU292kf_yFUN.WiIzd0ZVlDbh9ApnIlyWIr9Vi9l.oWu7WOqZGP4SM7ga
 g3.wJjMLBv8FfuRp3QJZaRmLiLVRg1SvlO_Bv.IA9yw2e4lT8Pso63F4stlskFmlKRkZw7VO2mSC
 f0kgBNnsYX3JNuDBO5TGcBoa3CXdBz72bvdhTB3I9_eYyY0W5R_Jnm5.kPzGWgshX2gYNGKCytgk
 UxG0IwbxlFmeyYLGVFA4c6tSNYmTNNiVlb5288r2QgFOaedEdFvZihrwqpeACXiE2CSMi0_XtCjH
 L5u2CA4ucxPPArZeFm7y9LxLrIUBlH4HPerNJnl0d_4VwjAv440QWrWGyQyvZsV8zYeMtGe3ztJP
 yjdh55LgODcMhDXJT9rZ2VL.IFtvhvk8KKV4IGNfUWKUO_s7OGPk6hjBgxaO7CPRsOMCxkQdrLXq
 DRZGIimPtFlC0.jb._BpvRzToR6PuOpcqK1cyNoJxktpplobZNPTTAU1a18Xqm7zp16Ko8odEHqd
 8vY3.b8N9WIWf.T_tQxJklwPvF1AVG4_Bay3FKo7VjY1ApzDe0BZaxJmz9OH86w.Pj9CeBo_Q4Yu
 lHlxeMItl2nmlBvE.JEXDPDH92HMn9bi.6nF4GmAT3LfXscENbJhmm.Mxs8cx9jIblzwV_YvyMoc
 63sntHOiCL9QXW1JdMFQfhcGRUu5c1mH2S0ifWl7CDgT6WQ8Ny2GIcpDTV3i1rA72df8M4Xe5IQw
 o3Mp5K5lYekGhFoq_ZawgV62GPWLaUkbNR8Zc43q.IaSd5O8XQKuB0158TGQOHXIeixuW1ezw_fZ
 R9n3hZgx.xtXB5IAmGepM2up6HgVvmKKqejFcydB41e6UnY_.TZ2DGC6OzhTxcCuwQs9c9RAaKRJ
 hX62HGkOekf7djsM5zkLcXXWxu5xcqbTHZ1fHOgiJGXSY9KBw7AnbdBFzK.taqLw_5nglIwU2lhh
 Td6b3nAls9_ZlgJkQDSiSQ25tlPObFzzg95YV12vk_iv6eLnqHomwjhC9O485TtMl5L5MK8E5wI_
 e_phPHjZnntKhfNkKBAqKqKtIak8OZoUHkctKWXmc_D9bRRPu8WW2z2YR0FEzyUVjj2uvfFt5kpd
 yPi9zRvMSc2aj.Eg3XLNBrWxNAC0sAH0H62bxJZrtvJEYlU.IPreerHvofEv7_bd_1w6obEST..u
 JdrfpCMdxXVyOZ2rGGqSRpexL55lVMizIL_F_BQO77POkcvJSyAYeNgcx70KW_tkt2uj7V2A8zoA
 ueTJCdgS5zCU59lWIwK2XYrdT0VVrE.dj1y1nlJRoSVL9Cfy0TKJ8x_Xdg_GuuHWNahNAlToromC
 mkRY-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4108eaf2-1edd-45bf-b6b4-7dac18693e9e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Tue, 17 Feb 2026 17:39:32 +0000
Received: by hermes--production-gq1-6dfcf9f8b-xs62w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e2fe6b038456c66677c514cbe68907e1;
          Tue, 17 Feb 2026 17:29:21 +0000 (UTC)
Message-ID: <efe72275-085b-4059-aa3e-cc902dbd9b45@schaufler-ca.com>
Date: Tue, 17 Feb 2026 09:29:19 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] security: add LSM blob and hooks for namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20260216-work-security-namespace-v1-1-075c28758e1f@kernel.org>
 <fb40e938-f6b2-45cf-b8ab-246cd6939582@schaufler-ca.com>
 <20260217-glasur-hinnimmt-ac72b3e67661@brauner>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20260217-glasur-hinnimmt-ac72b3e67661@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25198 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/17/2026 1:38 AM, Christian Brauner wrote:
> On Mon, Feb 16, 2026 at 09:34:57AM -0800, Casey Schaufler wrote:
>> On 2/16/2026 5:52 AM, Christian Brauner wrote:
>>> All namespace types now share the same ns_common infrastructure. Extend
>>> this to include a security blob so LSMs can start managing namespaces
>>> uniformly without having to add one-off hooks or security fields to
>>> every individual namespace type.
>> The implementation appears sound.
>>
>> I have to question whether having LSM controls on namespaces is reasonable.
> This is already in active use today but only in a very limited capacity.
> This generalizes it.
>
>> I suppose that you could have a system where (for example) SELinux runs
>> in permissive mode except within a specific user namespace, where it would
>> enforce policy. Do you have a use case in mind?
> We will use it in systemd services and containers to monitor and
> supervise namespaces.

While I am not among them, many people have objected strongly to making
containers an identified entity in the kernel. If these hooks were available
implementing a container scheme completely within the kernel would be
reasonably strait forward. I might consider tackling it myself.

I am also reminded of the kdbus effort of a decade ago:

	https://www.linuxfoundation.org/blog/blog/kdbus-details

Are we ready for ksystemd? UNIX systems of the 1980's suffered greatly from
an excessive enthusiasm for pushing user space functionality (e.g. STREAMS)
into the kernel. Systemd is a fine scheme, but so was inittab, in a very
different way. Adding kernel facilities to support particular application
schemes is very tempting, but often leads to dead code and interfaces that
require maintenance long after the user space scheme has moved on.


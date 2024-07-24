Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED22139588
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jul 2024 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721854598; cv=none; b=ECzrYg9Y/e0bDt5xFcXrI/Fjoo7k0ryOY9Cb1N41/9xsbe6IxrOTD7FRfpDCPoZXG5wEfXmMs4pv8qSJlmYRKJNRUmq6KiWSbL3Wyz3xbhgwvZQnc+X74tBWPJqE1Cy5AlqGcLr7aRoLYKLZOKpN8Ip+0Cw/Pg5Bnbb9fIU2c70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721854598; c=relaxed/simple;
	bh=pTW0C/srNvLSd1af1jTM4YafIWW01ysF9V0iRUeGJTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tc7sdUOtISHmcjYY+Krt+nTJ3+1nTjF+GRjb+er1O4TjBDsvuEj0PfnJb431H9Cpfzx/05Ru1Y7PMe8h3JKpLDlEtJs/5GQskAmKeEBSQuNJK3373Ma8JCev06Tt4PMBKWa2TJTLiaMkUNtO+ZPKl+hvfUZI3WRcC0jCdp08nEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=sbmZ5NeE; arc=none smtp.client-ip=66.163.187.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sbmZ5NeE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721854595; bh=uyqNlMER+A4e+8EYoXNA4LcRlMSMioRF3dT/72cqgck=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=sbmZ5NeECTHbsBoxh7XsxOWKrw1Pa18WHiN/fvvcfO1w2HwJPX5vg5yPDzFzlexluBoUz59LSyhqDdX6at0Wc3pi/yh//JdaCzoobcZzMZx6L4APixKl6a7I+QC9bazpWmT6t6yy38IxFacPFhHvUwy3e0rP+MJOxUKxfwyOSldIc49Hwvudmw67msi3vCFm8Ab/F8Z70Uw96Pnsme787lOhAc8nvCKW/g48U+UF6IVYpjzwpOQxS5vu+nuOATJlmvqOsx9PXfA2S1QpL5zyXvwVOC81eda3jSyX3yqNo6AQRz8RWBQXeNOBRETjL3g2OJkL42F+9/5I+X5tIcyUbw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721854595; bh=9kUQNmljyOaQuWHdIsnHWyNMjsXYRLvWiH/dWNwR2lM=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=oDPlu+oTKP9l9C+IotORUg7OXOELQH4h5ImUM/zb/ZrLCfc6j28h5rDSRQPot69Hj1OHGUqnMBrncL3f/tO25VJcVuwtPAIBa+7kOi9CpIV19M3gId93LwwgFErumqyCCiqxfamXysm9YQeeUAOT5zzVX8/oHFo21ecfcnPacnF/FusNmyUk4n+ers0BrTQDkmI4CCoFezJnMB65d9KgLrWyznBaIE6nCVhpOtuGuEMYLOB0kAJByxiOD9ODiuCdkBcGHEI6f/fAL8hhfdVyintpQB3vmzdtR6F77kGnOx+cpgcjBogbqrhBvdwMFZE4eQdpjn3socCrt4EaCwVnuQ==
X-YMail-OSG: 9zDWBc4VM1m_91EP.9GB7I._GbYyaOrnxhXq7Z8y_iBeIa26U4Qy1Osv0MjAJ4m
 UBX2t9GtXtwhEibAJPBgqDOdryPJSmBLytpqrnwf3nYtvHeEYpjw52vfa1BY.10p5LDBrL88aiPt
 caHAvdVIYrY1JMzSRQG5HGncaIs.Al8HhmdxnYRgiJ1UyxfNiAHxXclwwf.4sopQVVr2X6mDmeC6
 waSTmFbaNN7g1T9J9mVPGycj2hpiGkYsG_j6UfARjgWN_64DE.EMcjerMfWupsIkaK7JgF3eCaqy
 aHwgJeNyb7uk2XUHRv.d2tN3BL77ttSdPowGXLESJHi1DbHu09nig7IygHn5oiUsZd4KqT3ChPdU
 jGwyIlaplZhLhWVUb_n17wb_eDjXLQm6PrpRori2mJ_96NIL.e.0rKb_T6IhLJLkv3nDFOrDMDGv
 JnSf.6lGnxKwwRWjKXuDcArHLN11uKLs1nAqz36tk8tuSLH48s8qg.NC9ZBCHJ7SI_IZDndmbvxO
 IE9GfPT2jAX3k8zFGrE1vbBvSsgFPMTzIZWC1VtPvyGwuoGzz_HpDkMwnNod4Ud7mqiIfjcpRWKQ
 eZQ4yHGdedWsUrlP4mVWooD8IPrUPeb56VMy0UUeKw2vGskgN7Mifyjj4N9z.OOP.mON.eDkddCf
 qPH2MLCmaLcRNmXcl.blr0YgPF8HsVSxhkjI3nIdFEAX5BRUsGxOKBBWDTYWpqSIKhs9i4tADZz_
 5_yEmhlM7cGRGF0zFVj1RmZ4yFt04jcBcuF8UWu9W6CLOMUXITqxNRZMBjwDWJU.vbsynPRNpn.L
 xFRnP2KqjDUW95mKJ1EpcTADRgvtEA.udNH41P_4Hw610.ktTH.nelPWC2ZStMq_Ae.nXPgnn9nK
 RUQNGXBTEqc48rQ5nHl5iO0a2fDfAl2M3_5Ns0k0RqtnO_cMcGaIB0rm2YdsY1IjkuKeoPemuFnS
 d7Z65qZQa.lEW7IXxB3jj.Xb2GmaP1j4qw2.35DgE.3zdKGCwpUoqNikY14.SDP7nhilmRSTpDZ9
 FgkMmVf5JIagzUgG_pNDp9DTw5rSzh_DjAiFxF3MyQF51q2KWB00q9eVIesxOIt6uGKtyrmA0Um5
 13SLoISyv_Ewmql5csdSk0i1_ONnIPu7.2vV.DmB4sZB2Jj2Fu2_h9GydiQZ.ee0vMxJFEowDmMV
 RJXngI2cSTjolGZ3URXnfci5SqnL2oyhl8OfkHH.op9ALyQ3dgUer7DDaBq18Y2l9zbqvd.qoUBF
 E1cCg9fmdu.ExiCzn7RjYcNWjcXeqmsxVZ90bmTmEMArRds6cR5kbFy5syACLv3Nq8OzDdxS.I.D
 DHF2vn6HFHiDBhdrZAlTJSPSwPwgjf88JJdYZ_nN6w02quW1uEsqykW62yrq4IWBaFRczmg3ij3e
 TnqAVtQ9qkyl5cOZqQ6oXuaPkcXz_A8FX9.NnUcDMC_F2WiseVRD7g1V6dDkd7SrFaRbodWYU0uG
 DHPYpliUgFUs7Cx2jVv5kgS_0KLJ6rHCqwYGpBpeJAjX9DM8xesFzufjEdTyH4_H6W3L3ohislkz
 tOcSlVHquSf34nPYbBRpryBojgVoQeDl5e2u0hWS4XoouVHuFz3bNaPvu4KxNomfoeruZPzp7uuW
 fgmysYlhMInuOeo1BjC5WBorYgfXasU8vmD_HjhO.ZH_OsK2qf38qDOfqnEJNfz945xL.GrM51tL
 XOD3b2buJkMNGX7EJYysN8G.C54eu8_BUZUcCRX5_jHOHXqznpiVTMW0dBpnO3MrpUj5HtZXzxfb
 W9_GEn1.YLMIErFg0ON.k0L1H3gTWu_IuLbXWDjAhj9SSjYamrNPvGcOK9Tus6jkgivg5cWS1EtE
 w97SdqpYxjgN5ffG7XKjtJYl6XgnSdyTKLxvsIk93A2BZQNXtQlO_KTyKafpQypYfO0CI5OYajTi
 MO_xBdf_hCJC69FG1_HHN1nTb8jJFdR14EOgODBIaiHvqLdzAg4jIggCaC9kfaibxL81uGWIeOwO
 ZLRnf2D_gr9mh_Vb2eK4jGzfMS.NSN1Ns7PedPpzdYYsthAJ53P9XfsyPP1VtoOqHJFOim8ZvUQd
 grno60yHpe_lauJXNtXldwXBJ.vD2MXrsCIwSwOC.NbAZ8SCkUb7jEZWYtMi1tcgUvFw.9m_Qz_t
 i85AzeiiTI8VzhJBazN5ImgrdsQS0gxQjouQpElxTgcVuf_Tl0X1N.0qlxSItmZPBUX_GGpunBC7
 jHvGPidZ_fAf8WGy2T8ui0uVw0Kw3YRasS0BgjNz9AxiFPClXSIBoOzhPD2lHGBGv.JLv0ZqVHVN
 xDtDNQkGL
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 21259a2a-9a13-44af-942d-555c071eab18
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Jul 2024 20:56:35 +0000
Received: by hermes--production-gq1-799bb7c8cf-l4fvm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1e7574de8c63b9acc091ed1cca9f592b;
          Wed, 24 Jul 2024 20:36:18 +0000 (UTC)
Message-ID: <26bb0c7b-e241-4239-8933-349115f3afdb@schaufler-ca.com>
Date: Wed, 24 Jul 2024 13:36:16 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] Refactor return value of two lsm hooks
To: Xu Kuohai <xukuohai@huaweicloud.com>,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 linux-unionfs@vger.kernel.org, linux-integrity@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>, "Serge E . Hallyn" <serge@hallyn.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 James Morris <jmorris@namei.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240724020659.120353-1-xukuohai@huaweicloud.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240724020659.120353-1-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22501 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/23/2024 7:06 PM, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
>
> The BPF LSM program may cause a kernel panic if it returns an
> unexpected value, such as a positive value on the hook
> file_alloc_security.
>
> To fix it, series [1] refactored the LSM hook return values and
> added BPF return value checks.
>
> [1] used two methods to refactor hook return values:
>
> - converting positive return value to negative error code
>
> - adding additional output parameter to store odd return values
>
> Based on discussion in [1], only two hooks refactored with the
> second method may be acceptable. Since the second method requires
> extra work on BPF side to ensure that the output parameter is
> set properly, the extra work does not seem worthwhile for just
> two hooks. So this series includes only the two patches refactored
> with the first method.
>
> Changes to [1]:
> - Drop unnecessary patches
> - Rebase
> - Remove redundant comments in the inode_copy_up_xattr patch
>
> [1] https://lore.kernel.org/bpf/20240711111908.3817636-1-xukuohai@huaweicloud.com
>     https://lore.kernel.org/bpf/20240711113828.3818398-1-xukuohai@huaweicloud.com
>
> Xu Kuohai (2):
>   lsm: Refactor return value of LSM hook vm_enough_memory
>   lsm: Refactor return value of LSM hook inode_copy_up_xattr

For the series:
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

>
>  fs/overlayfs/copy_up.c            |  6 +++---
>  include/linux/lsm_hook_defs.h     |  2 +-
>  include/linux/security.h          |  2 +-
>  security/commoncap.c              | 11 +++--------
>  security/integrity/evm/evm_main.c |  2 +-
>  security/security.c               | 22 ++++++++--------------
>  security/selinux/hooks.c          | 19 ++++++-------------
>  security/smack/smack_lsm.c        |  6 +++---
>  8 files changed, 26 insertions(+), 44 deletions(-)
>

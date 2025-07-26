Received: from sonic.asd.mail.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDB521C9E3
	for <linux-security-module@vger.kernel.org>; Sat, 26 Jul 2025 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753551704; cv=none; b=lp4YuqRh0VxrIuJNOVdcEVtFHE3d8o6VaecPbS8dQH8S/SvVMDhMps5juck09mqPXO/0iY+rfRDF4qGX1UAtm0TU1KUKYwaHMaqCJOWjH4LnaroOODyh6p5JhuA8pJjKEv3P8PKIMMepYsm0Bws+kr7U9z4KYfaZM/5iLdftn9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753551704; c=relaxed/simple;
	bh=3Rm6ZUi9ZqWaBQO7uznkLuG4xdQ6j+BGtZQ0SimE4ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+Kvy9EoHkCpAGvl3pisIltIOIVSATtUls2pnAHQ/6u9v8a2vPfVBYIKDRZMqhyUgmiR9zD+PX79PpPl2O/XyHR0pnmDmJrBUihuxoGqecaYxfLs2i9AFT74Mf3uTIjdAXO3ezBNj3Iu4hrjLKlTeC76JAYxFwQbt8RnUwhPVaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=bNkc6v0F; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bNkc6v0F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753551695; bh=h11HbvDLieCOHgVd8NjsGbEJwy1Yw5M/33jQEM/DuUg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=bNkc6v0FFYjm92xbkteLA9TC7ZyW2wjr+A2UpJ76pc7VSXPXBV0OlUPTUdO3rkhcXCdvGWgjjLBDkcvQUkMdLdUAmCbxZ7QZBKEDD4kpUUU1aV2UUVR8+Ou5Dla3XWLOxW9jiQ9QCeGatZSkHSDuACKbtvrj91Pu3SjAljOUgk4EhPz7WzHFRbe39dwTXYaNWR4sNOKcbKW2dBEPZK4dibZI2JU3PgxPlaXyk72xq9xtWU97d3ND4gXmhJs5JaXj/2Zxp4yPnuRKia7TAX0lRMOxfTEuQe/ulXa3rERL8kO8Einns+uVzDP1HQOl8xlh9K8FZIUTNbv7dRFp7gfriw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753551695; bh=Opum4AKoyKPtJg5EWGOITQGTzgIpGv9lI39Uo1B6aEj=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=iGDwAUCX69F/Ic0y9BPBQTsGgKZV00sw3v3v3k7Vm3V7JYwqmbVa6EFzQkIC+glAq0iKLS2PTEuDtjq5Amse/Atd/K7u3trxIQy+LwaDYZcHlmz/FTD3JA0odmvxVtj7j8LZT+29l5ygD6cQlgynIWnUMrLm+kHLqWpqMlMGCTSiwi1vioea7Mv02kBvhHN7TfCrYf5EYm5bb4CdRb/NOpHisvvn7BYMYFdjvMjgtiq+PZEvg000eco9SMS9nF8azqNFoMCeZ1Gp3AHt3/VtGg1Nd5iiriuGaQxw0QcK7mE+q8RkVm9RsOWx9E26abT7qDEjti5ifRQbYON74f/UYQ==
X-YMail-OSG: V5aqVZUVM1lVPh1WucFPobhOIoxKTH1VLu_kSWBQYGk8e4vs2qFNVjvIsdbHERJ
 uDLDRor5FBVxG80oza2NlUqPCDCa.VK3.1Ent0eMqQNOogUq1zbRexdRYLBJNdsh13kUj1rpp5uQ
 gm0NFO5hYSPTup13oOc3Rpz2GDMTL2deYQxyCeqD3zfJmWhURjxguDRBVxM4Opnc6UfpKw2Lu.EO
 _l2bMnGWl12gE6UIwioWWj.LdVvp_AIAZMzSq8KUe1QS73DDJ7XsxZOarlVAN0xgYNrwI0ApRwfq
 fpf3wmDp0kAWUfTZlDMVNwL1KSVPnFpNmK0mPXrYkKGh9CeOO_8e0oRA5Vev_g4vFaIX.q7p2UnZ
 ZtDWiXXvzQ_nzYw2iPsmJB2K9NJYAyvD2MO.soVYygv_fVAz8Jw7SZkyHLTsvu6aCmzv_uOOWdgP
 zyinV2836HiZko9wKB00uj5sM2gs85Q_4rLBKsS96Jnj.qtk_oLbrgICPDQuKx0TOUBqfwziI0vw
 qCzUFqBS8SFhP99qY06.C17MevXKuyKl_YoT.t2yjOBari_UT8aYkqea_FHJDVUjGC9nyZczMXi_
 HLpbBmn5hQTSCKiZG0iSXHpg2yXZHDxkmRXUdgWjuHP2Af3eTYGjDiNbNXT5KwlkY5d_WeXG0Qvo
 6iMYGuXyQjHdTx0oMneW379MF1VfjoV0kmQ.VyA7w.WAectMUvlFTx_KFFAMVIAGnRdYQ8SUJzuC
 EIK1hdDHepZ2nzxngz1nVxMqLHQnCT_dGw2MtaDzySvvL_8XANOcY_YW8L96A4zwbBSTSGiAEC8u
 Xu27EASWN7jz6ZsW8QUOfUE0OgC8FlQhpaQE.E_bb913MffN3UWEEemTEKQSFL6c7mN2QR_hyxbr
 .XjWZpRsv2jk2D0RuPkVPxPi.GSli0A_95e.kuyF9KKFd3Qqy7wLnkwzWsp5jKxfSTRuLGb5vHlK
 KZyDJ73KT0Sj1aTK7TTFvSIOyfY7esU92qOJELo6RREV2ac7VM7fbA1mjxhOAC8pn.T.m1i5fX0x
 0r7pcU2KtbLzzqizdh8e.2mO6UvzNrnx4Iarr5Iocp61.Jm_oFnmuuRBFCj7y090dOHCy1X9WyqS
 Ga7e_kkEVUfS5BvVof_VxG15zl9rQ_tfwh7NGcDWjoh9DFbNMXFcUdhYVXcMGnDbQgxRzH8vgmEh
 wlU_ECiC1tUlEO815lCrze3lemjOiGJ_sSdqmGgXFthXqFU3PRsJzWENG1_hHdPIzAnNoxh.7MM0
 VRc8k.Hn3WGvb62b8N103ulKfCdr2hmIBZzuGIz0CFG0EVjNGoKsHKxfl7jCl6mQbnnzsvY9n1nE
 GZhOpU1PnpWt4WT2KYV6iQzNLyj1qvPxnNtFmwgg5GrpCFsC5Ko.Ti_0KX6AdcavF4.yIs1W0OsJ
 uSiNXBcknf9qvSTaX_dhISwjV1ElT3uAFmeGpPlqhvpBEnUZUvdutg_Bs1L5BD.qTX7mmiM0id13
 jrOOyfPCnFdHdWq1lS5haepZiAnfRCYxLNxzBgkYdyfRnfTM0x.l9c7ARvET6wIJMAyXnoReNbDe
 dFHZx5xQBsGObOUejyGAhCHXEmaYjuedxnvR9Lr9BNsXeBtn_fdGWZwxAbAO_W.H7_kDi.jgRoKH
 3upbLEEkdRYJbmex2S7vpn4BN4vSalju.opHKDTiZXpOVRJRWezZBQGCXSQH7V3DFVkSQvA_cHiH
 hTngjlbgGy0sm4PAgRmaTa2ZUhKk3S8369c6ISwqgVR91RlbVSMMh8KToohdzg2DOHtqz8xkxodF
 V1C5pIkq2eIPfensftapcmlIFrV7tCoYo3m2J5oK6zrNLJ9TQmYFfB5YcVyTPP.c7cdo8Bk6AFcO
 PEupVz02h5Y53KNT0Kys10vUwZyyu2pGqHzuAcqhZz4l58RBtDgB4rF24gFt9PnBuoCZ_vy5ug9S
 jLQ6pha71ITg1ZFpKtBakFUKqkcveyytkV_tdeiBoKunnxlQeAME_23NqCJdyTkSz1soOUFheiCa
 NRbeD9iqrDT4qHe7pEshsOma3pmQqcjpG5gxgoXRS3HYlX1m4YAkQ3iWgYAGuc1_tL1tW1mG4qau
 KfL6c1MpcjKRii56qMx9ZyScR3GpIF0YktBdBXdTiRCyYcfRw..B6YcXhSQuVzgvH2quB_UgDrse
 rXZwzbvOKvc4bMRALlIUPakeZ2HluqOoH2JplLXeCXyqMdY2sBTVsS5aTSDp6UY2AB99wfZQIA09
 VFWhYZpvUBjPU41eaIShvCPGNQdoXOZe.iW58nxeWhUTEdb0v1mg3aaoopLToN5lbn_aL8MuG8Mx
 hg9pHWi3s_Lxzng--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9a4b9640-e6c3-42a9-8ede-93f836c078d4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Sat, 26 Jul 2025 17:41:35 +0000
Received: by hermes--production-gq1-74d64bb7d7-r4nbl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 73c5e332a9fcc7c7bff98fd547659fcd;
          Sat, 26 Jul 2025 17:41:33 +0000 (UTC)
Message-ID: <f4b697c8-7851-4e46-ad33-bd0eed50af06@schaufler-ca.com>
Date: Sat, 26 Jul 2025 10:41:32 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] smack: clean up xattr handling
To: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <cover.1753356770.git.andreev@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <cover.1753356770.git.andreev@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/24/2025 6:09 AM, Konstantin Andreev wrote:
> A set of minor bug fixes and optimizations in Smack xattr handling.
> Logically independent, but with the code dependencies.

Please break this into two (or more) patch sets. The patches regarding
restrictions on getting and setting the file type specific attributes
should be presented independently of the xattr "fixes".

There appears to be a misunderstanding regarding "valid" Smack labels.
A Smack label is a text string. The intention is that a label is "valid"
if the system is exposed to it. For example,

	# echo Oatmeal > /proc/self/attr/smack/current

should introduce "Oatmeal" as a Smack label if is has never been used
before. After a reboot the system may find the label "Bacon" on a file,
and if the label isn't known it is imported. Similarly, if a CIPSO packet
includes a label that has not been seen in is added.

This policy is necessary in part because there is a valid use case for
a Smack label with no explicit access rules.

I tried out the combined set and encountered many unexpected failures.

>
> The patch set applies on top of:
> https://github.com/cschaufler/smack-next/commits/next
> commit 6ddd169d0288
>
> Konstantin Andreev (19):
>   smack: fix bug: changing Smack xattrs requires cap_sys_admin
>   smack: fix bug: changing Smack xattrs requires cap_mac_override
>   smack: fix bug: setting label-containing xattrs silently ignores input garbage
>   smack: stop polling other LSMs & VFS to getxattr() unsupported SMACK64IPIN/OUT
>   smack: restrict getxattr() SMACK64TRANSMUTE to directories
>   smack: fix bug: getxattr() returns invalid SMACK64EXEC/MMAP
>   smack: deduplicate task label validation
>   smack: smack_inode_setsecurity: prevent setting SMACK64EXEC/MMAP in other LSMs
>   smack: smack_inode_setsecurity: prevent setting SMACK64IPIN/OUT in other LSMs
>   smack: fix bug: smack_inode_setsecurity() imports alien xattrs as labels
>   smack: fix bug: smack_inode_setsecurity() false EINVAL for alien xattrs
>   smack: restrict setxattr() SMACK64IPIN/IPOUT to sockets
>   smack: restrict setxattr() SMACK64EXEC/MMAP to regular files
>   smack: return EOPNOTSUPP for setxattr() unsupported SMACK64(TRANSMUTE)
>   smack: smack_inode_setsecurity(): skip checks for SMACK64TRANSMUTE
>   smack: smack_inode_notifysecctx(): reject invalid labels
>   smack: smack_inode_post_setxattr(): find label instead of import
>   smack: smack_inode_setsecurity(): find label instead of import
>   smack: deduplicate strcmp(name, XATTR_{,NAME_}SMACK*)
>
>  Documentation/admin-guide/LSM/Smack.rst |   3 +-
>  security/smack/smack.h                  |   2 +
>  security/smack/smack_access.c           |  22 +-
>  security/smack/smack_lsm.c              | 492 +++++++++++++++---------
>  4 files changed, 324 insertions(+), 195 deletions(-)
>

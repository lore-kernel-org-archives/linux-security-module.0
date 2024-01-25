Received: from sonic312-31.consmr.mail.ne1.yahoo.com (sonic312-31.consmr.mail.ne1.yahoo.com [66.163.191.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA011369
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jan 2024 01:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706145307; cv=none; b=VO62W4mPSQCSRR1L+5s5MWjyyXN7+RyKk+hZkxwiMDkXLX0OLSMgwfacgV2UQny3nTxqbPU0SJQSk0uLXzfAPMFauhRUXGbGOYDUyEavlXH8V5eyEzORamP0owxuPyb1CUx3ksIRX3P5VcE4pqz3lzaEgPPDUTEtw01WZGbgkbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706145307; c=relaxed/simple;
	bh=wikpua9tnvQx5HZsUmTe6XmiQkP1+aTddBoA7rPVPCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=KsNd6cT2J2k9CVHXB0yBuKHWCnvxVwI0K8lkWb3r5OdCLgYPeDi7H5K7oXtJcqbV8ye00+nAttd1y6yRrZIQ4dcNPcqSRxSyhSwyAq+SAIueLiOhPJ2INpApHUgXjorVaCB070oMmzqW1/kZk/xUEZYQ9ZJ8isClih3Kplg5lSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=uR6sezdc; arc=none smtp.client-ip=66.163.191.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uR6sezdc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1706145304; bh=PtuUn5V7snXYcDLaa+iG6DbfuhXMtHzyR4Ccl4T1X3s=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=uR6sezdcdF5UjMppufeiCItGa/Xxalj0wG2HWLODCFxpZNnQr+jyurOIyXyrbzCl6/ZZHLCIZT9DFdR4vrAF1Wqn1VSbWp3JV+nM+vRW/oG3FeDZCv0kVVYcT36UqpiBB7I0yB0aOl97IBdWjFL7s5kCZCknerYRWVjfP0xd9EH5aqblDuSww5JtLp69DFyb0lnqOW6kNsgdUq/AmmMXuB9WSrjZ0kvCcQLfLkgwA0Zvlsyz1qhJMF3qtq+JeEp8dY1zuylYnwNXoEcfzvTTtX2ZPG9C/tMuaJi0CAACxHRhKWbCtagImiNn/qnVm3LuEUkU/XgiweIewiujKtR+qg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1706145304; bh=tb8OABz1D44gIrRFqyElxf3kgSC83bdW9lKpnxObElt=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Vp7SySBKm34I5pudoF9I1qk10o+1y+kGslSmRRNeVyfcVrwQ/8mkiPxyhhK2QljxSWvZnze5kCFev0ubxUH50XUVUXr2pKpI//FKimw+8BGtpWgWn+dyKeoHFNcwoNv6hXc5k11FcUjWAinEwj678ymiikEfFXfUWXIE2t4aVSubMTQU3flhfrjtcn0PWNZz1PgcfAh+2v4mawSeEoIyCQEbsQdgsdNkeq6YD1z1XEg+ER9MJo5wHjT6fVVRCR7Bj5W357X+p76vJz53hfj1wi9w46rG2h/7ppydjwvoz90/BAnH6I474IBg8kJJN6SBLJY8bbz+KwzJluBPc93Hhg==
X-YMail-OSG: ofNf.YwVM1nx10tEGYa.IpnQKyAUleOcZ6iQP98eSS_AbYs_gB3opqL1TDHvOFl
 OobvoXuupWjNY0HNO7OI62TYH.jIrqf2xbxFNJ9NgMj4P7iS6RREjbV1RyFid9nsIu476lzMFRYG
 WX12I.l7TgLwIXK2KNpc.VGMpt2WjksdJpcPbzWneGcPwB9ce4p8ROQBSCZwIfbM5l4P.n4vxCLN
 JZCjEZFbZ5X7rMmD8l1KePShxQPTiyMKbbQR4lh54in7tgkeHWp.kfGVMGHIvZRsbfiYKoQ2BpJf
 CBipQu28Dm9UlsCVvpZnGbKrQI7eR8k2_2xxF2VY4GibVqw2du7yLVdi_jjN1RfhmpKN5IjChEXS
 a0ntTw2JJZgqrZH_QUi3tWKGJ7axPeik8VTlhN0c1bdAosA03n1b1oENg_B5uO7oTYEDxybKVA3O
 YAOE8fDrws4.u2jeLAC.ug6ycZGtP4QO91AqZ9XxIVLHAx1xmCxBUdFMKIu8JFI6rF1OyzIspcR0
 a2PSJnlO1u5N.ULIzGrLMsCzXjDl4Vhiv9VtDUf1lWqil6dDiAY3JNV5ID5v47DIKQ81lvj4SHCw
 fYkUYy7G3fQEyALRh0x65lq9VEybdFQctwYoglQp3sKtUl6u75xwfW5lW9J_dzgQbU6k537oq8vI
 Xpq6KixleU_TMlyrFXQgLfiMqFLZwyvkDRkKRHELeX.rQbf24e2aX_H81BsXbn9gd9_uXrdnRPR_
 XixC8eTbAHD03cS8zSPyHF1bLE1q55OSZC2.XL9yh9mk0SVmN.ap0.73jOTQQkBBFbxeFDxkfa1a
 vMQjP1pUBvNDDpbml_XiNv6jnPW6ib69aBFHrdRcL4whJF6Xsdq4QkM_FsDj9R4R7AfB6umKlxjH
 URUCv6sF.7Zpwp4f748AFnoIViaLjGJzvdFVqQ1NnW2d0k51ym.TI70R2_ohHW4pHdP72XHyzcEr
 6VVj2y4oISAlig7C69x_56i5R6Smclpx8AmzTnwl0qoprlDjmv64pZdS2HNLg5LqKhayWRB4pYwW
 zRz0mZxhLWSvVhc65.QXTUKB9j5ascGW1TyvtLIWuQtmpQK0zMbK8n7XnEw9Eo1uFAhrWt00bE.K
 YrVjxAz1VEOkBGUdTu8Yavn7ZxS.QbjlhVfMlZZvHkyJoN0H0fsUmv6hj_tsAfrjZCDGVb8TAMo9
 93Vg0yk.M7FKBOB2Ko7aEXzY9lJWBTPvP_9NqpMUGcELoS.5cfF1CPppWQApITKaPeLsc7xRRpp2
 M3GwbSf29mLwbcV9PLSM7HN4Sj_ijYD9kNaCwHYNhLIFp4.oTE18qetxfBImxRvmX97jk8YKHJjZ
 _wcBRBxdOyMXgsEo9Hff26WY3KraXjOxKiS7AoLi7DDWfY94Zum7suyc0Nda5NYwXrSsAgKWgK_I
 ya7JSGYccLBmxO_Kd_EryYHKq2KKOgAglD7eHCchHNKrgFR38Umz0lroc4R4r9fIf0Flkd9VA4BY
 cNsqnmTdqBhvupHhCrUqqq1NRCZD_KlOJbug2N0kT1ao9SVBJF90YaQs1Y_aOoAXDfNg2e7.XNBx
 DBXGYdwzrYG6fmg6Z6N6j_LG8fdjtZz3QHsDwLJ.JhA0lQD0XItmTNPUR3YsqdhY8ghlKFzNwwOv
 Cxcr5BfWzwKUbTvrn5ExdO8fK_l0vK.Og0tNTlxDFeFiIUutLNHwoBfmR1tntz9vWCsSP_682bVv
 t9sHaFINPcAE7LT4X3aJGVumnU0_eDAobvXqnrnFBJmPFcFD8xczh43aFXuoFFRww_vfamXaB9N3
 q0QqqxKFaHYJp.7ZDO5LpgjOkdIjitV1529udF6fLssd0NIWdmmCWY0tSQ2C6bcQBpYdBHti7IA4
 i63HRLuDV4tropmH89XjsgsFDpYIv3KbdWrFy3etPGIfgUxlSmI9hJBi_t5Baq7wRUTlKhY1S5F_
 d4__QZkiqL7s37s8UBfF6aSc7BvGQ1heqL8YymbYZIgfF2pMDw6rLmLHDfF.NpJ_zvOXj8nZFyKM
 IJ_VaXJmp49aOUGpiEu_hn4CZzyGV5Q7QUjUoRl3Wm5CNGiJuEXyRJuR8FSaPWcOCrWoDKw4RiBs
 dlVBMnqa5a1XAw6N.hg9EjDH.TF2Ks1Rm3jxAvgVe707GicVkByfOSHx9RL9.WPxZ7._Pc8OXeT8
 Udw870pUdTpicXLIQe.ptw8QXwYO2OWqPWREtSdycWm.xkr3RV7DFHOtXLsplyGXTWw.De4BxNcg
 LwKDNOr0AN_.AC9O.fK9IkHQljL0u_5FoN90sE8C1KiJvTqJplqUrZ1YP85Iz_Cp2pi_hqDpTzIS
 G9jn_oI3UdA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 2910d37d-05d4-426f-8e93-5d461a1c1273
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Thu, 25 Jan 2024 01:15:04 +0000
Received: by hermes--production-gq1-78d49cd6df-c95sd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d0bee4d79f5822db3c7bd2b623d9e3d3;
          Thu, 25 Jan 2024 01:14:58 +0000 (UTC)
Message-ID: <ba29cf58-82ee-41ac-805a-82b8ae35b799@schaufler-ca.com>
Date: Wed, 24 Jan 2024 17:14:56 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: security_file_free contract/expectations
Content-Language: en-US
To: Ben Smith <ben.smith@crowdstrike.com>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>
References: <CF22CFC7-11A8-4BE5-BA61-04A55FDEA1DB@contoso.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CF22CFC7-11A8-4BE5-BA61-04A55FDEA1DB@contoso.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22046 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/24/2024 3:46 PM, Ben Smith wrote:
> Hi, I'm looking at a kernel panic and I'm trying to figure out whether the code in question is doing something that breaks the contract for the security_file_free hook. I'm specifically wondering whether it's expected/safe for code called from security_file_free to open and read from a file. In the case I'm looking at what happens is:

The only action that should take place in a _file_free() hook is to manage
resources used by the LSM. That could involve a kfree() of the module's
blob, or some other memory management operation.  Trying to access a file
from this hook is a bad idea.

>
> - Process exit
> - exit_fs() sets current->fs to NULL
> - exit_task_work() calls __fput() on files which were closed in exit_files()
> - __fput() calls security_file_free()
> - security_file_free() then reads the file that was just closed in order to gather information about it.
> - a filesystem driver (I've seen this with two out-of-tree filesystems) then accesses current->fs and panics.
>
> So I'm wondering if the expectation here is that filesystem code should NULL check current->fs before using it or that an LSM shouldn't try to read a file from security_file_free().
>
>

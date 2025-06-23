Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCE627A444
	for <linux-security-module@vger.kernel.org>; Mon, 23 Jun 2025 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750698611; cv=none; b=BERcs9785aF5XgdDIN2CtNFJKr/Ro6DmzhQwpB58SQtBJFL7A07pMGI3BRHl9//qC1dOsGqEIXaqVZ/HepIQUv5kjVtKLvQDmwATg3WYmrNSBCNTdQ7yV9GpeN+5/63rUiDDdW3rM4Hd/Dkro7idRo2ud6KbSP2ijJbWU5E0Ujo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750698611; c=relaxed/simple;
	bh=sCBYTOks1RmBhwUtoCfvqP7R/Rlt9sivQKKDFmvac8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OxQzVD3Zrg4TLJqWZ956uE4hr+ePFZ5HmKQ84QiB6kASqIpLCHC2GjBZwvg/a7xU6EnxSmLCv+ESRYuqa+GIPTUEwVCBNC/H3EfBv5jPsh7Wy/XGw4tnkaABIj1t8LMJJze0mLxUCwKaF2e1EIVGAajeBm8/L77+gSldRfGpSPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=gSo7czgU; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gSo7czgU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750698602; bh=rTC+yJuznklwmanB9t9oEkSsAKBRABNXCdw0jqRaNJw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=gSo7czgUNDOaTWBUDNAeBIUFREmDUcx/jb5nQbjYRvltWS5Qc20q6OkskYaUtFFhvdIquVSi6FZDoW/a/zDYMeEI8gKBKrbdAifHVyuWzN9ejavry/GoayzlKIa8o612VW5HkUQExk5dT6X7oReyMCpQblRO/zm7wGims23s62U62F+KNKSmLezaeM07p9wX5N7ZeiIR8bxxlvoqNQpFz4e812ILEzBFnw0vE4FSvGDnwS/JW8OqBrWq6N15LoB3mCNyf3Eh0+D5l9JTAmWxnlnnHHO3mu4KNdz6aHz529OdGrAUe4e7V6/ihMZLj2JrCf2nFfHjMQ4cDuaqzRssSg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750698602; bh=v47Uzn97MVkUCKjoeYHmmgcBzqc3VWbWQ/X3rxXxIwI=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Z+TcjZMN308hnBKo/9okckQpQgc1lJNhd78BBgSsPdeMm/FDQ11kRRGR3jbowSzKMGX8PrB+PYFRGq7amZjYM65THKIiWsj5Ma84ccag6IKizFGdVF2bLC2KjQ2XW6ctXC/O75irUUHRhdNRxFcsYJ1Cqu1SKmND60XRP/arjZkngkVBDiTRnkEJHLyrlyluGQPcfpKMPiVN5EvU3S+n9gSTa+81XVo18QuQt5YvYRi59R3FGFIc8t9WGncYWHXw7FDTM8rNfnpkKVU5iLcuoKOhtrDf6KCJ2f1iaII6BsngYFzzDUMxOpQKB+kvQcIslu4Fyby/5HgKnhZCtRe5fA==
X-YMail-OSG: Ikqi5jYVM1lAExaNvEKDH3srPcIeYpFDesH94YAZ4kZz30gm6yPCB60YH_mdlsw
 n14uWnZ3uCxPQv691Xq4Q4O8bSt9k96fb89lckvPV4F.AgIDBFG2ezKz28JK6RYhNPUqkppajtPn
 jQNKCBOcaXIIShco1olmswI.xwZxwZJ4bVLDqB.ye5NQBs1dNd2OC5ejZjFFXcq3mU.Xksx1ORfg
 4tkEU50gdUzzgKxT3um5DGTOvZmf85l85rYQaARjzH0_Wqgt26gjVletfe0WkwwjFWSPJuyCnjYe
 C9oJiY_FiSpeBaERtslBAG3oc4.eeVRp2IDqwEzpn9kRhChBnnnHVshO20sSQhkWsoxfG8BHq45U
 ngqBuSHGbU10FyDzckoCpATw.ScMtok.FagVjXWKBSv6SikFzgVgYKDW_VpBo9iDwkFRS8HP6DHx
 tO1xicKctHGGPv6Uia4kz1Sbyb1XJHHEwl8LB_ZXwGmzlFN3PeOOSAdrk5K8L4AxGNfkSLpLCslZ
 ihx4Pdm.MPO9yufRXn2fseb_0geU_h.DTCqH5wBgs0rwFWfWPcMWfuG4SHSW.lU4IzenHhJslxfg
 qEP18JULVt2wbzUDsDWrzBZHlxxYjd8_JOAGMpi8VallKRmuOH7ab6lPQ.MLzXassLcGc5Tsh6hf
 NsIhDb16Irjif2fkQZoFIsJKtpsIv2x8EFaPzdfXT4ZCxqqWoEitcjeK5jzAh9NCd2Pd84SPYvLh
 NYeXNm5sXBowCvfKX_HdrAsB9hvgAsrhceJOic6tQyTf6Hg7vlkOLrFSRIaPBV.v2onhRgHPoyB5
 l.uTGisNfbVXM9y1uKjMIbXNBk8pEyxLe62f_gP8hXoFcY4S9gByMGtxBL_.YV1DuJa70WV6PVWz
 9Sse4ndQtI7P8oBM3djzb8exDXeKlkuBznA0AErrcM.tkLjgt4N2FQIzKWh6G88xAd0nx9SAcKhf
 evXRgQdLFpO_CXYHoqGQFV.LFzlQbiarQcngF5QsMJovYWiecqYv15zVUz23i2dFBJddlQLLNSgb
 KcmcTDRVxL31g1w1EM5KfL_pS5WB.f5qCmeoafqO8qgILgV6l5ngDmX3pOvV3zvzZhAy7IGWhZMd
 1cG6TomCVe_UyGIxD2_8TfgtngxtXeoLxSZjpgBS45yP9A5XIHUfzRwH5VkuLtQoYM0rhBt9Swz0
 JdT7hAp7jDNGwxyDfGaE2IAOI5RG8.TT51ZAzrPL9vVoymthJDG9gfzpCnnR4x0dwgcdzlpJ_ipQ
 yxN7t4zCui.tuw_dmxFqtz_7clayAti_WyA77DxSVqFjS_rVS0xfvcd9CMt4lOOs9oj7HFKLLGpb
 AXBP.iW6GjIzX8EbhdVt.JWlvA8FfRqpylV9Ju3XwJ2GJX.Kep9cRquvIZiP681bT_sedXvp8imm
 6DbeYQXnrGv23AjLvR8aTLW08SnG7c2A7k1vp6IDA7MmBltypkPrn2I6aTsLB2EDHbHzswI62H1o
 fnmG4l3W.ip0k35NMbnXM1xnq6uy93_GzZlc1dR.q8i3Fn3Z86_sXCiBDeHnEZoVafjvj6eTQwmo
 k.2J5S7mnT5uLwHdcOa5YcW533VAFSZC2V9y7oRqhV1YGvOCrr7UGN0TdZ9mFWqj0t4EtQFdDpg_
 lTWwR_2Uu.nCjqR6bz4nqP1PQbG6ZpeMNRJmv6o5QiqWH.Ylx_VXLqOnqL.DYZZE8IkDT4ltfEZT
 BkX1VnVsXwe7F1og9qikaHlVLOYmFbYqCJW8uo1L2Gszx2IBSLQgSsQ0ZZk0EyrrKerYiWLwJRSx
 tv9H.giIxZHWexRUIsB.c4c5xB8VsZswnWTsCCZPnZl_64BmwYC57xexKR1O3yusVmNEvlbMMcsB
 .ETosmVl_i50oLn7XHJr71iilgq7goeg3YkYEJPGEy7JhyX8lu5LQGfxqUL8hojIZC0mPsVV0k_O
 4lkoztjgrCdOyNdlCD5pk8rObdts._kQHXU9slK8bKVbviB1krzOgOHlJmAMopUq7Sm4748qxfBJ
 TaIpOrZQIimRsLh7R9Y2RROQH5UuBteqpSjbWeMpe_OQ24_SJsEMFlmg_VwVI9HZKdz.dWLXuD3r
 oYhEEf1hTMhliFzYyA6e5yGLkBbHa6yVO0zFnGoNEX72lY6wMPHnns8SuKtwjyHBrficfNm7o7pw
 Z6aHKpcVXEsELQtBS8Hv3DclqDxWi4wUSB6FCs1O_lD_xyhRFHejZC191Yhx72PFWKhRkgKr4lr9
 9MfYFDvpawY5N4PzKLX.2fkLlhnoGBmMbV0eydFyRjYxSpXXqlu_WcJqjxS9jiqCkdBDop59sn42
 7uPyxvMSnb4NV1NNTKA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 888630d6-8131-4bf6-a540-e35b135d42a5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Mon, 23 Jun 2025 17:10:02 +0000
Received: by hermes--production-gq1-74d64bb7d7-nccgl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 39b94febc93afd593eb705f2f26f7baa;
          Mon, 23 Jun 2025 17:09:57 +0000 (UTC)
Message-ID: <e1b9e6a9-1c57-4d74-b5a2-6a321068c18c@schaufler-ca.com>
Date: Mon, 23 Jun 2025 10:09:55 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] smack: fix bugs: invalid unix socket label, invalid
 transmute attr
To: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250616010745.800386-1-andreev@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250616010745.800386-1-andreev@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24027 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/15/2025 6:07 PM, Konstantin Andreev wrote:
> Formerly, Smack inode security was initialized
> by smack_d_instantiate() for all inodes,
> except ones under /proc

I have taken this patch set into smack-next.

>
> Commit [1] imposed the sole responsibility for
> initializing inode security for newly created
> filesystem objects on smack_inode_init_security().
>
> However, smack_inode_init_security() lacks some logic
> present in smack_d_instantiate().
>
> This patch series fixes 2 particular omissions
> I faced directly:
>
> 1) special handling of unix socket files (5th patch)
> 2) S_ISDIR check for "transmute" xattr (2nd patch)
>
> I did not check for other omissions,
> but there may be ones.
>
> Patches 1,3,4 are necessary optimizations
> in smack_inode_init_security() made along the way.
>
> I structured the changes this way to make the review
> process easier.
>
> The patch set applies on top of:
> https://github.com/cschaufler/smack-next/commits/next
> commit 4b59f4fd0a36
>
> [1] 2023-11-16 roberto.sassu
> commit e63d86b8b764 ("smack: Initialize the in-memory inode in smack_inode_init_security()")
> Link: https://lore.kernel.org/linux-security-module/20231116090125.187209-5-roberto.sassu@huaweicloud.com/
>
> Konstantin Andreev (5):
>   smack: deduplicate "does access rule request transmutation"
>   smack: fix bug: SMACK64TRANSMUTE set on non-directory
>   smack: deduplicate xattr setting in smack_inode_init_security()
>   smack: always "instantiate" inode in smack_inode_init_security()
>   smack: fix bug: invalid label of unix socket file
>
>  Documentation/admin-guide/LSM/Smack.rst |   5 +
>  security/smack/smack_lsm.c              | 159 +++++++++++++++---------
>  2 files changed, 107 insertions(+), 57 deletions(-)
>

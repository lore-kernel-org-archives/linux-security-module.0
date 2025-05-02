Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFF525B691
	for <linux-security-module@vger.kernel.org>; Fri,  2 May 2025 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746201655; cv=none; b=OeR1j2C38RKPYE7AIMQp53N1N/HTEbt21xisRSifaoBi+ONrYu6kLAdU0DpBy/8O6rsw08fji9AgN/PPQkX79xnrrOFMuvOqrmz67ZD+XwPo5jJ3vuskC4CXoHXG5ciNFgOrbg+JVRY9D9YHk8ZXL/+B8WHV24WH/h5cX5DZ8hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746201655; c=relaxed/simple;
	bh=9aTUd+XkE85PCNBhyXf/46k2tEVxDrnE1MU1E3sQYgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rdSPe+YIkglcE4q8fLLRGN42C7Gn26Fc3LxL2/uJ7wLJB5vcxeqK3ZqA/oj++kKGy3KeSUBeHC73gzqkFum6Faa3QanG8I91u8S67SxK3YFbkHfZvLhS2xZHuK8O6c1cW+/PF02aWJ5EAy/SjJPy4ayHLHltwXoVYClnLG/WOwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=PSJtqjNr; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PSJtqjNr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746201647; bh=iMseOvbUafDVmbz7Z2NxQUSJNiEFWkLiEqvhg3BXCJ4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=PSJtqjNrnBZnGf6aQf3fQ+tGF/2/YdgJASIU0myVZv+p2jEnfCSgmDZiJBSCycHJvwSzZSDm8P57EOOQMHRh5erKRGaVcxClhGHTjdTOg6ujyCHLXWWbmweg+Qo0g6fr8C9qMWFu5vGngc3kss126wah6GjqSFrFvu7a8BJL+O6hoPs0ioSd5CiM9cV0/SWthDA/7iQpjosJ3rme0TD2wyZDAk1QvDj5B3oEj8J5XEfNbpia58HJsMazQIB5Eso4Bqr4IwUsJbbM3GZcmeTFvlXjSz1OpbNf0AuSEHCj2ZC7QAKD16wMTCS3W3FW/fIyijwOQgq2R55wTpicLaTnAw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746201647; bh=LmkU8YzHeEfCP44IEnx0v/Hna9eXZzM4KAxyQNMIObZ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=k1sLbQ33nCVMK6vZuwnJb+9jnheZJJdF1CzkKlR5MIFkXvqPh3yfUi9+WsY0kibiJ5bAEUZ8ZhcewrMa8TntFgzHbk+0PSj4kw4lPkBqk8lwTotaRcVdQF4Qouyfe4tpBTBehEVT9YvVHt8u9/B3reUOz0O8obb2YGAu48Ac8xTsxB/fLj39sh5SsmvW0PqaTL6PZOC2qgZZJu5qW/ZF8PmpsBDewiOA0toqPqCVju+auZKNgZbWRbYZusgGnlLKclrhHsEzb5Q0+9TPGsd5vt5LCci2LTCXm5mAaO7pNLJrbQAAp1g8K6x7CP3I/DHlXh31KtHN2/NTiF9gzU+r4Q==
X-YMail-OSG: GbsvcuMVM1nORwhGo4i4D19ac9Rpg4Nx4g0m59UpWxfqmATQHLa7TD1yc1iAHOP
 QFbZmgIfyyRML0Hp6Fr58yZ.BusDbc5HApTsZ4fQ0P6xfqr_ADgYfkj.zpq7Z3BajqqCY3j.NpxI
 FQ2Ee4PVgJgLEDx6WwguFtbywVXui0wQDCoOIEwtngvu2pqC9wvC5n.6gxlezVJa7R5pzLFzpbif
 Qiq9_dC6UYw.5Y3lCkuwGUB4sosL1qtUnEo.wqTfyhqHhBMQSsibgHO2IWLm2EXVRvVBtosBpfHq
 kmvZnorOXf7gWs0rBEg4YNMGAUvWzbFP4GiQwplwJYmhYd0rBY0DwvJY9sZROqgfzcuxBqyUb9qp
 7Mk8tQFaD_1Y.7LO7gxdZy8chFQh8KbWnEusilGQ8FwzUGAWXFJFOSfO0Nik3_mzXuNO0mpk5nqa
 .wN1tXv6IpzHCAzbsBdnBLRsjo5uwleR8Qltux55Zb4W1gFoS2U.ngQ7NH2Ek3gcUZrRX5a80avE
 bj7TSjvTfSxQzhtKYtZlw4F6bQrtLAG8UP46DRUd0eM.hmX04xWUPnHLnoYdDQon2HpA_Siuvwad
 PQuQtxE_wzJVP72Dy84l8rGY3uSLLhUNko9R7erjH3pI1.nyuB_0iPi01DcXKldJ7b87tMoaADyx
 3NJ37eFV3WIfWmZkTIrqJa6r8LOLlPqbRK6qHH6iWBHBjdLqWn5SQ.d6iFq2ONF8C5RaxcGx29_n
 PWhQeLlW9aN69YyK92NqXAsa5KCrC6m0Q3s8yxvlZj45kkBqx9KHLquuHlAPgvqTu7lKONaceZVY
 A773213a74.uRoiT02Zrnw4X0CoCOCw2fOcNTNSIn6njz.RRckHUgzrABlc5C_9xOy1DJRcWTCWs
 Kew1k8.JkjpQx4W.nKYTCnkixFCmG.FdlBgQaJosqyR.EFHpSXYEd5QMKoAqc4cAGtiVex1xvDLf
 c0t363TT3bVw6e4c49FAhQ5mk25kBivF.8xw8YGLbJCKG6XiUWN0HUrzQFevH.vTxlC_W36FaNTo
 oBE5w2tvDoGaloShbtjBqPN3aa3pHkYqVWC.VrOTaYa0oUg4E72O2k22NdONI98FczXOHkVNeI3r
 Wqbq5vpeCtd1JXu5NJukcnvhy96qjho6E9F3_N62Rr02w3vSgwOfMGUJhiVb8_CrjbD5rjmKqULz
 hOpZNnxXp9Ls2RDiQPmBC1yspF0A..cgiiXi74QHw9dzqnkDkjIGkvR3NrEx_qq4Dy3jnBauxaVs
 3Tf5BZu_qwBFdns9G2qmFAjekiw6WYIwpwgGWzdLlWFeamTLyVYZ4Gg7BoQj8GRIqzXTTS18Y9kH
 uzJmOLKMOwcn7jhLo1rS_87eakLcRocMf2KBq5QTgTy9iJGrYa3Gms6tx3Ktfkn5SeGUeTtWIag9
 1DyWVsO.Eg2_mHn.pLnxrxaMnJhR4yYI61jTu.r_tC.32tvdKN9z.19JdkL7bybXPvyF63u1n9mG
 lckbYevDCjphwniA7l7.h.xZZPncl85tnqmcTpNdbGlPW6KZCiHajyolxqKinA7BzVUv1CBBYOen
 6BGYjL80krNvJTpOOH3CmNt3Dsn22xehLJR3rZybFGTdkRGCrPEqUyQpkPzLGAy8G9SH6vXx7ERx
 vNuKF8rc0Sn3ma_HXzTX62uwpod0eTPElP05OY4joOtIyKU1ZJtY5H_LNRwl86dUIz72nRMqGoLQ
 daKbM.m7Gwa.5AQs74JAvDL_jrfYqRvrXNT5t33otELImoEvpB71MDbNQMoUBrlSTTSncdjVigki
 F1737iPpxpM8y_bMIl4MzCAoozV8QNygAHmhzenzxNQpTbpRrMnu9qcmp6MvHqFi_WsXCA2LmzAS
 yzM7riE6D2z3T0kWX8T.NGubBjeMSsPL9WlX5XttsTjY8zQIejKO4nITmuk5Qq2DAfh4LYJNotK5
 Bw7QKS32GhGqNsnBk.3Sn7h4y0V5J3OMT3MdMBw_AvKjKnETA52uiBsOqwN9gl0keTKnpIN0BrFh
 nv5vohNksBFNlHdxwiuPbhs9Dls9DGZ_hSn9hIr2a3wurMzuMiiEJmT__LD.y0bA5wDE5LlyNDYn
 Dansi.7vz6FSIaRhwlnL0Tq4e0TBGQIiJX0ux28DxzfqSkTcLjJVWKlQbYxbLo_e3yuqcfCbbwow
 LVIMysaRhtdlDFiQX.X9raLGkHotnJw_ReqXb9yAzKh6QhJsdqPRw9xlr0XTYwrWX8kZQ_9VIIYN
 v335riCAjNyb3ZApIKow2u3GVaghxRVsKwBa.brSJDT80yd5gkrtpOib9kZAJ8pV09BYRE5yqN_t
 kmUpdi95IMDAOkAFfA8tiTl_o62s-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b23c0c71-a017-4559-a311-9884badcc492
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 2 May 2025 16:00:47 +0000
Received: by hermes--production-gq1-74d64bb7d7-dp9cd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0c2894cc6a103b4c7fa33041bb79f598;
          Fri, 02 May 2025 15:50:35 +0000 (UTC)
Message-ID: <774bce75-551e-486d-9e35-16da3cb962bb@schaufler-ca.com>
Date: Fri, 2 May 2025 08:50:35 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] security/smack/smackfs: small kernel-doc fixes
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250502014421.682697-1-rdunlap@infradead.org>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250502014421.682697-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23772 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/1/2025 6:44 PM, Randy Dunlap wrote:
> Add function short descriptions to the kernel-doc where missing.
> Correct a verb and add ending periods to sentences.
>
> smackfs.c:1080: warning: missing initial short description on line:
>  * smk_net4addr_insert
> smackfs.c:1343: warning: missing initial short description on line:
>  * smk_net6addr_insert
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

I'll take this. Thank you.

> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-security-module@vger.kernel.org
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> ---
>  security/smack/smackfs.c |   12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> --- linux-next-20250501.orig/security/smack/smackfs.c
> +++ linux-next-20250501/security/smack/smackfs.c
> @@ -1077,13 +1077,12 @@ static int smk_open_net4addr(struct inod
>  }
>  
>  /**
> - * smk_net4addr_insert
> + * smk_net4addr_insert - insert a new entry into the net4addrs list
>   * @new : netlabel to insert
>   *
> - * This helper insert netlabel in the smack_net4addrs list
> + * This helper inserts netlabel in the smack_net4addrs list
>   * sorted by netmask length (longest to smallest)
> - * locked by &smk_net4addr_lock in smk_write_net4addr
> - *
> + * locked by &smk_net4addr_lock in smk_write_net4addr.
>   */
>  static void smk_net4addr_insert(struct smk_net4addr *new)
>  {
> @@ -1340,13 +1339,12 @@ static int smk_open_net6addr(struct inod
>  }
>  
>  /**
> - * smk_net6addr_insert
> + * smk_net6addr_insert - insert a new entry into the net6addrs list
>   * @new : entry to insert
>   *
>   * This inserts an entry in the smack_net6addrs list
>   * sorted by netmask length (longest to smallest)
> - * locked by &smk_net6addr_lock in smk_write_net6addr
> - *
> + * locked by &smk_net6addr_lock in smk_write_net6addr.
>   */
>  static void smk_net6addr_insert(struct smk_net6addr *new)
>  {
>

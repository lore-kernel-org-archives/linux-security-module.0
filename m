Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EB3411A0A
	for <linux-security-module@vger.kernel.org>; Mon, 31 Aug 2026 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196680; cv=none; b=RHZQXzKa5rp8nALfPLxmH2KAaNBJCDywC+UbaaiqzdWnaRKPnKMUrcPAzcHLfgHTcKYBzAmcCyk2EFQtvVuZhA+EoBvlfDQ4C61+u05I4cm9IG2/W01rvuxRm+84khuy4NzJujYJPSqDKNUdmk9T/gTBlMd5gDcZG000gtq9o0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196680; c=relaxed/simple;
	bh=FTwFSgGp7B0oMcAD4FjqadY/I7FONTHuVvMlJ2D8huw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEnLQIX/sjbx+C6ZsY1vYPY+ZjNaa4YjzPJn+T7a/SkeN/WEKj23zyaraUGynYy6r5HlhowgioOipyD4Igx5oZc4yX92Hon5bF95xdwcK21Quz1phdD8EgDgiBhb6Fj/BhD0etoKRwLuxfTnWnmMZQO2WB9oEti8hFZpL0UL86s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=arlCgvwv; arc=none smtp.client-ip=66.163.190.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="arlCgvwv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1788196672; bh=FTwFSgGp7B0oMcAD4FjqadY/I7FONTHuVvMlJ2D8huw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=arlCgvwvLm8Qb7Nbjh550SeFjIV5in6tm1BOa8NudEZoI42czzBifZzOz7DtY0CTiMtAm/qxInGtcear2DqLQACxKaji8Nr96FK7h/lLKo8bhE6aITm93wN5tzcQ7hB/edVD8ogfHgWI7tz948thXqUCKrF8/IcR7aBboecX1STYtULSqgF5l3TnXNjJGR1Eg+Vg4dTu1ZOqwEsplBN6mttB4iGUwQEKOkd+y7ibUWVXohCpGEeBF+gwdKmLWh8RUNsJ+T6BWvZaMavVv/ivaJ1KMAcVqkHjJfvqrYv0diZovORFoa78gfSyJwp8vibrvcGP4EPmsZea8WnROzuXmQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1788196672; bh=6mmQWRLcrgRtVdpHRvtmZHOvnh8HLTcZ++5pFhqLU+G=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=g6exJgxWioI0LRrCIbeMrOIa+epz3VMHYkEGntIzRHnOfoZSDHzfO63kxo7f1b8qmIaw9MmwVhxPE8j1XOuAb040kqYlrt0xEqWGaNev4gEp3Wvv+MYmdfE/Hk2xuAjZy2VLy43NC+bB940n4AHnB4I/yfBkG4hgGb5dy0WwBjp4/SqN4Hk2dregB+tocH+REMGL/OtNOs3ZRymYs/ZVOllZZgbBkly1nwJ3zD6JYTmzmxrPwJvXhYo5pdLbeVtSaonZNd2tr2oZBN6FibRunneLOfkHsmnyCJRfDtun6kEhCpkTJGFDZbhUYuQ7380er9CgN2DJ1tqkjVNDP3PgyA==
X-YMail-OSG: kPAetDYVM1mWKOgZJCvUWv2wQ60g205jl8VA8mnfSu5dDspmFK4i3NFBkBQcXBi
 CJJbTW6FzhivEvMS0FO4OHSc8GKL6yaeNOvd6yOHQSjFjYUCqAn_1CAjxHOwUbJDuvng8YlW05Mp
 gmPsBPuwjvs88l0XQxLnpGfKDKNfmKlMERSzhABFZKvkuRvAavt_OhArDFe6hzbAX5G359yWg775
 PlYLHRau2j.W1OcestXCxk8MdJuRqWGWOfmOilcB2kwoyAGDRCtjIxEhJkzzhKTt42SbXuzHTXqq
 xhA7GT_I1ENBE6el0VXFLzYD9038UwdnpBudEVL5CVYmie.ZTw9lUBhdf_AZivzxGtKp4HQHTbsr
 wRIj0LBIyILd3cnplGDbHQIdmbuYQgKcV3UaytrQi9483SfmnArPJu_q5nBlTcUkSfX_k4NVrCBn
 Ymltlxc3lV.xu9k0_UW.O1FPH9zwYc0jG0CBGr23fWdT2B6Mcbj4jnBOT2nAizxyNSp6JfUim18K
 Pa1r776AkGjumesFPbuGROrLqXufjKGsXtM0E7y5WUfhVnN7Jt8tPpnXUA.w4MhMrP40dAkAPsgu
 .8mayL4wDjzrmU6aewG_O7QGIuWW3WVNRJ3VHTVtJ08_TSk4oyXNdJHcvX8M04iA8MCbKZtFz8q6
 iL7tCooy1dPPqi94tb62fJCqM60UpA1gEUc7iMYsc6qKvRWuh4nl5Lo3yBIG7TXl2J_5POLIOUBb
 rovkj0E313x6yR8v4Oaplufp8O9L4FbBHE7OxtpJnO02Cvlzb43sqop3dtpBXC871jTbQenxHzJ_
 .k5bpSZQbavKS7D0FWkvciA1sK.zUmkKh0gjVvb90PBWZwf6ug3UdlLuYdUUrW.5dXhimNJmRZ5a
 d4SMOw6_Tj54_u_C3W62DU.wSlTyi4vz3dLBzY5vYoc8oW0QBYkBpZIDaBt6a8oDbtuNO7aUCO5p
 WOw4SQ8yF9zxc0AoXaanTcm0hjZeRGrYeso0HMrSDQ14DP38Fub59evDGO9JgKmOCLt4uXWIytUw
 MR9H7QiOdDeazZP7rpMejoD_iiQvvFNlSA_mie9mezkdZDGQxDELh_.BNUL_ONE5vxfnrZRuWFGa
 4rik09lbw0.BA9VrQrg4nFU_wm78B83bx5lHMGEYxRlmPf6Qjiad1m5FukFhsGN.aBG.3kIsXzsY
 WLtXzFQY0l9dYM9eyLfRSKSKCa9BS2rs4r3Fp6SMk8twag5SNRAf9StdSI15y5oyLdfwor9qBS79
 2bP8qczCB5ekl4rAwaCbJa4_UzsF2.9JPbNuRObsYAsEzoKxmB.AiH2DrgihUZa00SinPt4Gch7E
 TIyEK5VZjWIN4iwtuITvbyXkTXek254f1dsPQpG4J.DcYuomTwdNctzbL6mrIfagSZgZ_DCnSqvE
 lGFWGAlwk3I9xeBGS_rGCg435Dex4O7oWdbSw_Gz1kWAL14ud7P_I7J3psvqYXAoj50ALCBIqgZH
 3awUmldP.0Vjk9RT0PW7dT5NCDhtLBTz_2vjKS6OzDtbglNCs1Galol3ctMm436QLa4vTBCGHROf
 II86vlEDlaTxDqrYzPYaxuiVyUGwd8Imi3d3jibJaXNhRMMkmjeowFv6JgcdaYaL2Im7vN4nWdWP
 iaNlAdcuTaU6QJWsnOC4FmMw7R3RPdPeDwROTaj6D6YBeh53EOczR3IkL04vW2uB3SnwIv4swO.u
 8fTEvo2oqv22zxGwk7wFGaanFxjHmhw7jHHA_NFv3UEidtcnNYV7pu.mDX_F1Mly0qKM1iTtOv2F
 CnoAy_4HBKFrkanxpXIndIME6kdENfxAZxysjDRcH1rboMKDq1cSIdplCymRXFrRRm3pE5Z_ZOMe
 kk8XwotGGdSKtoeId84wDLS3l9Lra8qk.cjQwd.twKJb4_y7OGUSiFBfHI6bRUgSgtCPzr7NT.Ld
 xmkjY4SMRDo9rGF1Y.ZwEPTRQEgvkAmKguqHnG62m42Q4za8lYsXgVA2CMcimVNzM0u8LkT5IFD3
 _LjoZ5SG3.tw0QJ8H4BFLFZAg3Pd1uVKeCU82pvPzsS7aTfj1vvFxnc7HM59tUW3pz0wBsUEH2gx
 JlUDQx9lOCrVycVpp74V9bHI1wGmfmV91T_QEYQhiXYHle7iaabFeL0jM75ARySzK8DPeMQqlcjH
 1l2CuEuSV9M5ApaMqWrY_rFUEXfyWuuNtgrxDOXNa1uyoxZXAk.GH8_J_P_OAfbgsUYld2ZTHAjc
 VMQJspEN7L4BV311WpxsiJli5MUpOSPAePOaT4TIoRiQsgU7Ay6IsI6N9BsZLxTO2onRPDmE-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 786667d0-d8a6-4fa6-8e93-77cf5c761ecf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Mon, 31 Aug 2026 17:17:52 +0000
Received: by hermes--production-gq1-678d9dd684-hq55n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4f7c313e920f4db629c8c9abe1721bbb;
          Mon, 31 Aug 2026 17:17:48 +0000 (UTC)
Message-ID: <fb9ee5e1-dfc1-460a-85db-1f31f2f6ed17@schaufler-ca.com>
Date: Mon, 31 Aug 2026 10:17:43 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] lsm: Add the LSM policy object lifetime hooks
To: Justin Suess <utilityemal77@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
 paul@paul-moore.com, mic@digikod.net, viro@zeniv.linux.org.uk,
 brauner@kernel.org, kees@kernel.org
Cc: gnoack@google.com, jack@suse.cz, song@kernel.org,
 yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org,
 bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20260831145858.3869191-1-utilityemal77@gmail.com>
 <20260831145858.3869191-2-utilityemal77@gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20260831145858.3869191-2-utilityemal77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26380 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/31/2026 7:58 AM, Justin Suess wrote:
> Add struct lsm_policy_object, the identity an LSM embeds in a policy
> object it shares with BPF programs, and the three hooks managing such
> an object's lifetime:

I am not seeing the cover letter for this patch set. Are you sending
it to the LSM list? Without that I do not have sufficient context to
comment on the patches (1,2,3 and 8) that you have sent.

What I do see has me quite concerned. It's possible the cover letter
will addresses my issues. If nothing else, I assume it describes what
a "policy object" is, and what it's for.


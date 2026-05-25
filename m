Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114A81EF09B
	for <linux-security-module@vger.kernel.org>; Mon, 25 May 2026 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779726434; cv=none; b=JJEFujhsWhJTiU5pN+MDN3BBOREw4hmULUmCmA6eTMCnQozjyNZ4FywfvME77+P88fqzgmxpnwC6CiitsPZOlv1BCnesAVZGiZnOYH2L9DJr035cmtAx0pm9r0fdgiTIoRXGeTrKTvcnhXIpbAIpCYUyy7egXnYGR3Jhl8WKK68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779726434; c=relaxed/simple;
	bh=PdUJOavhmJRM+J1wFlbP0xXH4QUtlbSIwvFlB8LDfC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZ+B4AaLFK4WxK8u4aLD47CxqBtT7O3MOP/zH6ECuMCs0RlA4DSIoIIf90kPM1cgKnBICDfH99VInfZlAwfd5tmNyijoqQs5lDJc1pkY34rb5WQFiOf43lpur8xaDRnkj3IyoqqLluQiOQsGF3r8o+J5InAUJcnHWIkQF+xMIg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=LszskoCu; arc=none smtp.client-ip=66.163.187.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LszskoCu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1779726432; bh=YiMRe1V101hFNQA5Jro1sQyfqTYKyxdHuyGQs/zGI/c=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=LszskoCuYAW7W+zoIkV9Qjy6uyD6TCMPIo2TLdyuVxR9xXbg0m+nWhPwy5Q/Uu2OSe2AZ06BCDMmumFnA9iKSElh5Bh0mlOPrijd5BEYlmlqEu9tmkesQzuatgunTKwgazRS1x9R64rBwQR+acxVpkNW2ZPx4wFVN8VJsx0SrhptrRqwix3aeCy3X0Ac4ab9ucd/rxOVVXSPi2PTIkxphoHgrG9eYJYlCzjMIWNjhpv0pMpcwt+2Kt0gzq3Ny8P071AfvfENW7pf87CfdrwyzkypytJdKRLV9q7PysNfP1gexHWZBE/8NE8a3L1lpRRtOIwU4SuFupEj7gw2x7ZOEg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1779726432; bh=M588I5gNGhsNMcALEbSdpSers3chAGlp3y+ehKKN5br=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=m5f3RdC7PSPjRE+69wZVf3vxC7DXZ6dBD/GT90vsPMK55aHErod2bnK9bzhxeQUqNa+jbzUyzcgKWUqUoME5+vrtox8HLsDF2EqJWgLegQgsElbRF9sshI4uTN2cRDWlZZq5OV2wiFUNSYw+91Zdk0XRd6aymNrhfTvbsTUqCStW31Kj/k+m2dRVpHFvhh83N/H6qRL2xLWrYkURKG6Zpx8SCk/C3ZrjUq9d824DuDUQqW7oQ4qUiaFSY8uNAbdKmszhs8YAYBlgd8LUQ9S+xZcUDYPtaAmNG+DgZfNJ7+VolGRzDuaB409V9PVHKeVcM20LtA83/R8lBZG5ToY/2A==
X-YMail-OSG: MepryfIVM1nIFUDlU3Oca8Vwr33Xx19STG1ImxKkVkoyHw883GWn9sQ1VIP2RYZ
 zuS41KsTAt.BLB1BugyiJYABcfX3jkYCbVyCJxw.QodsExZQExktcSaJsba3NxVAemjnj00CSyxu
 ZtNM7FDO9hLQIkQsAKykXzS7hu9XdrFsbR1DhtIEgCTFZDuowiOP9JyuKrJZQ8scQcb4yGJbYOqz
 OfrwE3UWUrvOxQ7YYPoWyQF97UZY5ociH9dND2v5B7Y77FcSNYfLG2HgGUFd4V2Kpx.H86sX6hO3
 1h73dD1hooOQ5jxPe4Ff9unAMHuYO0.aH61I0UOKRGnvG7tEuxDKRaXNKiz4c.IVRzBofrcXAOKs
 7Opyj76dLqpBRprB87_6eg6EvwkyiD2CRs6_P_XTxZk6tCypPu3sHhej64oAb7bm4mm9QPy2ZaG.
 w7iioNvZn4dheirYVzMJ6e17HH3xmzx_VSym_lZQPffus.V2C64IJUqDuCIVAQeKD2A9Anf9lu4Y
 jivJ2M2xxz2UP94DQqXgQ8iK35GUHwAuNk4h8xFgvMx_nDvRDTn9RsN8Y6NAIX93HvMYtZDwsCIo
 CIUgpox1YC3YLFeCy0toMDPFHILg1CtxTwlMxqQQbf1hGlEC626c04xhUk4kyFkzcxTnCf4M0PJA
 4_Mmt.x8C9Z58cUuqe5bHN6xoopppO8EJK7gdBmlOXfRCEHO3DfA_CVgcLQzA6j2Z36ebOA7x8gb
 wYJbkr2wsZn8VVfwhQSsJDTAw5kkG.itm1xNTy_xmvmK7uSiWEX7CIIkB7stJuGaHUzHkKd5oE6U
 S7eYpmw3SkiSvBosDAGS4qkf9sU8uvdyAv3maTJPIdvPXRf57yQF_kWjBHgKBa0riKFhMaH_AXtm
 f2AmLYAYSBDh25EPBaztn8NZt3kZGj6tWcByyoZR5t..j3hkpP7YkBMrzf12ROX9CFPgPBhshEbU
 TX0Btri2YsKqZ4tY5dtTETxgTUyUxmP7Oog92xon3yt5dg18zxEs3uvGh7_SsAw4XwW1H5uUldzh
 ZUYWEo.7gaAQJvGf4fNrO6e6CzH7ekfuG0iTwSETCOuZY6PZiAjIkpUeLppOih5oScxq4.emSHBu
 qx9w_9SQMzn5cTz3XBYRN8TT.DeFQqRHf.VBvfahAAfh7OmAXZT2xsii6CK5Ptr34lBGnXaZsXoG
 aW5IkSGuAMNf8xg3qmy43afBCoTd02PUh98LyVehNb5vQYMfzX6TfHeXphVSFUsIWWQ9sIpP_eBl
 VZDeC1T8NZz69YfIGCPn2krYmPPLJ7vt2EJn.k5lNCT8bbMMFJXAAw_fbHYqq_k.g3LKXAgYubVC
 ASr9.t.bWTtFCuoQocTQG8F7RbWMyfyhzwOR66vhKHv7Co4kNa8D5_j5Ns1NFJrMMdBjTcSy1NMi
 1BpkfUqckg5SSgOBZK6tIOKAoKskDX5NG193i9GRHmJwWUOiDIb9wDuA044Z6qR5D.cE3aRfe0Uk
 yZD0FHUJ3J9XHBqIrxAWIDI6qriC3H628iGd4vRYQvdg6m1xmVablz9oacFyD13QDCdQC5XnLszI
 .rFmGluN7b5FXYDVgOEd1MlpCS64CmUHhcoGpADnwH3QioCl.vLUhC1sw5OlDsRYNe.bZ3EhYuvW
 .M8We_HJHKoBPxN3fnPIeEwLUYQuFOMsq9AmIQ1D1Bje28NeDWul_WOSRnrxOI0yfZ3mI3sHxZud
 lHWLxMe4roAto9Npg598L0alS86OFM_gOF0nuDCcubvQzO61QjFX3aBqx342p4kNVqpckxg4aLl2
 VptGnlVCZa6VdjEc3vbdjKWcgfGfJ.DFR_IDhc.ox3f1HTqvKJOSOax7iSqQIRooHLYwBeFA_K_I
 gcr5pjuKq.zKq7mP_Q8CW4wxk5wOS.Z8_2f4nOmBZnSDJM8HY6W0Ssdprf.5ZSBH99BMJJPPLWI.
 GeHChcE6KNDrw_3fo8f9fRUvoIPi3aejYCHs1RFf7aZ7GXoTBxNK5b7Vx8zlp6Eh7rpt_ZOMT6J1
 F69s64QxUfCoVN9Iz.NrBy1lu.NmZ7RW2_3wFkpiOarm4lc6WMZ05F0WXoXErEM2ClPhYn20Q4oZ
 D3Y5fTV1_4W_S8a7FqT9VoD3IAl5W4mzDLmxhiIjL32K.bxomNDkQNbxfMHaQupuBD1TmIBInD8t
 EFTGrN_YMlbuJbcHO46zrRal6a6YjLsTK2cutmX4zTFUGu8z5Pa8_Wnph3ov7itsYPdjKi_Rh2Vg
 0cTcVZiE0ZQmgu476UI9OfsKOxYNV7gjvwUgyRv8LMkDgCcgXJBWooLB6PbkIqv3_LpXr86E-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 61dea198-c48f-49e7-8e8c-770407ce6dd7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Mon, 25 May 2026 16:27:12 +0000
Received: by hermes--production-gq1-7bb7df5c46-m46kc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1ca323068d261e5b9c520f511b34023e;
          Mon, 25 May 2026 16:06:31 +0000 (UTC)
Message-ID: <dc8631eb-17f1-4272-b4be-07318636d968@schaufler-ca.com>
Date: Mon, 25 May 2026 09:06:29 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix various spelling mistakes
To: fffsqian@163.com, john.johansen@canonical.com
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Qingshuang Fu <fuqingshuang@kylinos.cn>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20260525021500.47667-1-fffsqian@163.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20260525021500.47667-1-fffsqian@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/24/2026 7:15 PM, fffsqian@163.com wrote:
> From: Qingshuang Fu <fuqingshuang@kylinos.cn>
>
> Fix three spelling errors found in code comments:
>
> - overriden  →  overridden
> - interated  →  interacted
> - dont      →  don't
>
> Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>

The AppArmor and Smack changes go in through different trees.
You should split this into two patches and submit them to the
appropriate maintainers.

> ---
>  security/apparmor/domain.c | 2 +-
>  security/apparmor/lsm.c    | 2 +-
>  security/smack/smackfs.c   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
> index f02bf770f638..7e097c40720a 100644
> --- a/security/apparmor/domain.c
> +++ b/security/apparmor/domain.c
> @@ -135,7 +135,7 @@ static int label_compound_match(struct aa_profile *profile,
>  	struct label_it i;
>  	struct path_cond cond = { };
>  
> -	/* find first subcomponent that is in view and going to be interated with */
> +	/* find first subcomponent that is in view and going to be interacted with */
>  	label_for_each(i, label, tp) {
>  		if (!aa_ns_visible(profile->ns, tp->ns, inview))
>  			continue;
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 3491e9f60194..51a388cfea11 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1493,7 +1493,7 @@ static int apparmor_socket_shutdown(struct socket *sock, int how)
>   *
>   * Note: can not sleep may be called with locks held
>   *
> - * dont want protocol specific in __skb_recv_datagram()
> + * don't want protocol specific in __skb_recv_datagram()
>   * to deny an incoming connection  socket_sock_rcv_skb()
>   */
>  static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index 6e62dcb36f74..2820bd3ee72e 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -115,7 +115,7 @@ struct smack_known *smack_syslog_label;
>  /*
>   * Ptrace current rule
>   * SMACK_PTRACE_DEFAULT    regular smack ptrace rules (/proc based)
> - * SMACK_PTRACE_EXACT      labels must match, but can be overriden with
> + * SMACK_PTRACE_EXACT      labels must match, but can be overridden with
>   *			   CAP_SYS_PTRACE
>   * SMACK_PTRACE_DRACONIAN  labels must match, CAP_SYS_PTRACE has no effect
>   */
>
> base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d

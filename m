Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C885747AF65
	for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2026 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628615; cv=none; b=pGpTPwFPt+gr9zm1X28jN4vDP44ioPmBraN8+R9XvuWdfqZyeJNCUoTVmx0Enzh0Ac48E86V0h06/BwOK8FbTAEUF4d4CWLOAIW7VcEl6ogVailg1wcrsk9bhTy0nZ0DL6QjH4fU6rrmhbPti76PGbGF/YN0WpE+w0UItI1JR3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628615; c=relaxed/simple;
	bh=ImIcxQ1lO7vglwNUFmFOoPLvf6mp9Zz6Hrna2keTfq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O20Ah+jXf/QJjUOGNRZdmahrx3jNHwV3Xf7ivdjJEs4WGWPi7RpdQTcWBeTaPXvejDIAlKCYMySYxLXgnrTw4peGwfbrJO7VC6BdIh54bFzyyKwbmkSfJn8/8gQn1KFYCwV0q8BIzRJII/v1rpNFarlq+HbZuuXbGQJw1BsId5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=T4Wlvfwt; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="T4Wlvfwt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1781628613; bh=RjH6q/VAmfDckDgGVvVDnZpxbzBTJaKLcX5yiUcnRkc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=T4WlvfwtUUk65W4VIdjq0TyryIvqeDvRY+IgemeMyCrFQwtYyWJhJ01VRREEyjHIfZDKfCX4tGaJrExCs+3rEf0IfVYXLE1RkCXysMMG6TbF3mVhP+94IWg878C9XRlH6VqMqMc/qhsPJBvMIy+o0Li/fT7fl1IiNfzienKsSOD9csa8hgdSIb4cZDS3dj4BlGddsEKnBq6d0DmnLQLYtHo1VtDxIdGlUsv+c5B14ala8rEf43lHRPEeYg1nKIfa2pmguoC+aNa6jnKbc4dmd6X1PIsv+pw9lM6WqXD51H9LsCvg+FrwlwcKAbaysRMDwatrfBgYmWvidPOfC2Jvng==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1781628613; bh=W2I+8GDWonOYVuWrl6owXE6eMhnVUwRDnPeq050hVBF=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jt8qVAsStYXvqZOHkRiULtZMG0/Xxsf1phdHFuEhr9ysmmRWzI0NiGsdG/bLNIwhgfrvd34sh5gfXFj0pcxnysspqqjs35C+gfQlYaj5y3Jw4O0wNDUSveiAuk1SPmxizL6Odb54oPBcRE095XgQli9MljlgECTTI5dXrA9oAgxXECMRbpuxBU05bRHvbh+xetK0bw0eV1xYeYe7eKme3qarD/l+zDOXw407w1/85R9s0u6AwkHg60fF6b7v2c7H1o1mkE5/VZPgBenX0egoQIdoTySvcZ4YOrMzk1kh2rnmC9d3AEpJHUD+lwaiV0O/Am8mWBtcuqgUI852WtfuyA==
X-YMail-OSG: qtqXdUMVM1lkF8a.8D.lDR4cvbL7q1AR2YUGmtciTaFtND62g1rZDEmvFMI68Fr
 FMYQeYElTAgBD.dbgCqWDzTxNw1LKOj8t0vN3GKeg6FiaaXaF._VIDEojnzwjHnKu2qhmxgVy2If
 L20y9GmEYoOiVl.S1RjfPV_Cl9oA2SSlN7QZNWzee6Qi0QtalXTGEXduu1ky4DPStqgZU6lLhcTw
 c9QTWW2HPSUB8fvRVlBZUdnGaqRdoxJ9kQlBMEZoU0Z6qQB.AdFJYhsLRBLM3efK4mIyO9hhvSQb
 V49l6T9YHY6UOSLtndfL_lTUKpAmAI9azgYIJrkW5L8d8iPDjTB6Jl81Fo3B5TAaJdx9IqbfQS8n
 nQZn_B_q4yTi_2i2Iivyi1mDTfPFkEIqJXt08YLaOUrkIzK2i_OiNBLwzDkClOOEzTs3U3hu3nQa
 UKsfzI1IWR4hDg6ajSQar_HdDgW3MGFzeGhVnpeNHayogFiUcdUu25FTB_szbnqa_A.zcxiFXE5d
 kR9zAel2SRLq6Kdi18WgkwabLRkPPK49cHL4gQBtXaEsHsB0MP9J_G.W1vM.ms1a8.doVPJ3Jn5e
 RBYB3uXZX2KglSuweovscAvkL541YeY21YlrDicbd2oqKJQI0h8GQh1gDpwym26yB9ru9YsQkvNz
 c5eQd0U8sxhb_pC.PsoBIIJrKRKng4Bo62h6jC9vjOpP530g0o92aXtKDN.d.rDZkACRDbl7TtAJ
 wSbakSQPK6MNAPS3201QyIG7rJ0fEKXUx9_tQj0Bb51Ifv0gL5J_0yDhgWWOikZ3yPc6a.vu5GrD
 igcF6XSvOEv4hAxKzafHUaJKr6KLRuzyVNqnNpmahGH8bo79WY2RW8ng9IXSMsnMggXc9UeU24vk
 cHgY2nS2Gint6Hvl9yNaHDbaVRy7_cpHz5mojqJ9pr87ja4NAKhRt01bZnu_d_U7W1kfdpj41STH
 hf6J5QwpaCzHuHtzotdwInc8u6pJtDIqpq9i0Uva0ZkD_9If7wgTSge0R.PMY207JP82Sur.5v_p
 nsPMq6t1vVrpEtmcCyiLLBJQA1zI3UHb9cFZGpiw7TrC9mMxnuHruOGROycQjoCTnwsHu39QOQ4P
 ds93Gsz_2Z0Kpa1tKEWNgE4KYP16xqEw9MtPxMA546ka91nBt7nNLg7mGTytVUFS9_3Q5665Z.FT
 Nzz1G8.Yh6X1qUtL4HeYZl82A.4o0vACHgImn.z1caonh_7CGlp1jRbl00OSNgedXn.UoMeFQj4J
 MlnmdkHNjUiBEhR9IZrzMUCNhpDuRKc0_pETiSfoXKHayvS5FDqWcMTCOrUPcjoGpn1EOC0ZFuhh
 f4ZbagfjkK7oB5IO47PW6SmlXn_vTbYw0uyvr0OeOF6_eLRJhfAgr2DvQPFT2K90EGDkbzNp8dQi
 gg6OaoWZSXffUn1CVgQ7X91PA7.E7owX9dejahTG4_4l6XOt0ajdPgGQHNzJe3.dFQsT2DN7c4sV
 SVn6o1tv2vZb1ayUgmEcHID16BNKut5BhuVRjPbQCOF04d9cFfbJx9.3GKQ0Qwl7eQymz_kHeVV6
 TdCVfljJK.XFU.UaA7jnZ0083TSCKOz899tMaBM.np2l_Ptrx8jn3p1u5mcoUOO83D4sYmtrnk3W
 Lnl4QEz2H1.jEW7ioS1VwIEDTqeiwVi2A1v0lmTAQfpHwFkQTaIli1vYNwgzyn8m6rFhub1HjfmK
 HGfwbOlf_ZcK6tiIiYa2AqfAzH47Ef1lKVpNyQPIq0jfDTQAYvXqqHqUJTecfCmN2.D5.dMwgUVE
 GFUySsJCspP1mnWZe_vud6jjVV2g5FjzpK_jggqoKQdQF.sIwXiA3KisP3QKHTjjKZcrHKlhNSgX
 JbfobTUEfBcenPnTirzRpN_Ia9oAy_VB1iN7Gxb1clKtG11vnm.tOgAj7s.FJGGo4GveQOoNRKnc
 vTXfMuUvdeosoJWpBMOUJXOAOnsisIkphVbLWXWKsuKWuQu_3ZNPk0UiZ33QlISJjpIn.VF9Zgbf
 CxglBEJrg9O1ewIHpeLwlceAMCJpQkee.Fgyz4XI0lHGUndnuZxcXHnV1NcZDvkonWJxhzGJIzf_
 i2TyvfC6yalubbfvQa4Gupi4ZpBxZB286dkXf_Olh4wkBjS7Gr4zZQp1ND7tnGxZ6o5.EF3KlcpW
 naldB9l53mBQxyWoYO26ik_DEpRjf9vTe7nxA5xJayIpZNjglegbZkmE5KaizVKZb5l1HuepsMRJ
 ozQGqjoZ89UjqpULv58XwneG5O9SU3F2WDI8-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 81ae825c-c7b0-4e57-91df-11909a2c5115
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Tue, 16 Jun 2026 16:50:13 +0000
Received: by hermes--production-gq1-7bb7df5c46-qhlmr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7ab7d828c5c18897186b4b93afee53e9;
          Tue, 16 Jun 2026 16:07:43 +0000 (UTC)
Message-ID: <bdf7591c-4078-4ee5-9e63-e5dc27602fb6@schaufler-ca.com>
Date: Tue, 16 Jun 2026 09:07:40 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] security: clarify task_prctl hook documentation
To: Bill Roberts <bill.roberts@arm.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20260615200325.260057-1-bill.roberts@arm.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20260615200325.260057-1-bill.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25942 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/15/2026 1:03 PM, Bill Roberts wrote:
> The task_prctl hook comment incorrectly described the hook as checking
> whether a prctl operation is allowed. In reality, the hook exists for
> LSMs to handle LSM-specific prctl operations.
>
> Update the function description and kernel-doc comment to reflect the
> actual behavior. The old wording appears to have been copied from other
> permission-check hooks despite differing semantics.
>
> Signed-off-by: Bill Roberts <bill.roberts@arm.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/security.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index 4e999f023651..96e6ef088801 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -3301,15 +3301,14 @@ int security_task_kill(struct task_struct *p, struct kernel_siginfo *info,
>  }
>  
>  /**
> - * security_task_prctl() - Check if a prctl op is allowed
> + * security_task_prctl() - Handle an LSM specific prctl call
>   * @option: operation
>   * @arg2: argument
>   * @arg3: argument
>   * @arg4: argument
>   * @arg5: argument
>   *
> - * Check permission before performing a process control operation on the
> - * current process.
> + * Handle lsm specific prctl operations.
>   *
>   * Return: Return -ENOSYS if no-one wanted to handle this op, any other value
>   *         to cause prctl() to return immediately with that value.

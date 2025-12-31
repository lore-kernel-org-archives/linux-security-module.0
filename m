Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B788B749C
	for <linux-security-module@vger.kernel.org>; Wed, 31 Dec 2025 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767214862; cv=none; b=ORxjSFjQddrXBpMDy53ioZazdV+/VQ+2REYRHVfmd1KRruuXWzsyk9KajTpXTr5Fx8Rcd2vstpTorztxEvl5yqGjFQhrbY2VrGls2g3rVLtFPeh1DpngKsTkNx86NEpofYw/ocA5dhwuVx21qMuylrisUfg9z36ObY3onmFG0u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767214862; c=relaxed/simple;
	bh=VoHtzDBwJduP7qDWcy4jAhICW/igvyXUQg5Z4j1tqRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyhdFCwgBuxuH4znP/eDcyMsIL4fqhvSJb48V/BFfDPh8N2nWzuaXV23cwOv5j2HY9osE86o3NRWqtYM60ROsJtrj+w48nmBL5DE+JUxvNhamVwrQc2lVvoAHqA5T1QNKJqR550o+6h3883hG6tlRw9KyPeigRF0Ud1zGwneqyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=CdA1IIau; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CdA1IIau"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767214859; bh=jVP2lkZEqGw7tucgJsOjREvhHylkG+G5Et09lT6LToI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=CdA1IIauWdMKv5yiUOndaP1pi57gxFjZeWHJeM6drJNcxHTPCh0cJpTAL99NqtAritq76XzAJNkL+dJ8q2jWSMrCyt+JxehM6I1nBTZ94LY3+7oNnE5pIofTx1jYnh5UKxipQY6LTdwNEskmmXFzCv9V2Ds79oGVW4cZ8ETESIipnaiJ4I3ySFbuk64/KfGw3PlYku1kiH8p7XnykMdNAes1MI+pFk09BshgMR3vVBBgloAdWSof+Tzo0XQVEMQ5Xm19SLMyWR7S5sblCSuZAy5Tt+NY3zhZAM46jb41m5sei8BrnM7OmY0vhK0ytCFgj/idSTSCVgLCvDvv+fickA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767214859; bh=CbsQjKOX0j8IdyzWplh3PUgn7Lh5S862Okh75A6ccVx=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=TfvJ5/bFWxN8+ReaklJgdlPVcqk35kuXDH0Q5XLjsVV8CcA5crxsBaFDFJmkFWcQUhBEUris0s4q7cotO9vVHCfdPHTO2jZqaY8xSxT4RbQ+cjq0vQJC0NShvNepwfGwH0Y3SzST3/Ex3hdF8rWN9aNvhZM8CaxrKH2bazlIjQvIw1XcIZ0zXNkCNa0Dwa0piV9sqSFWgC5uB+0MK0CW2/XJPo0sezR2EpTYkMaExI6HoOaCeRJ1Pj7dtUdc1YeJPCURwM04DkCfFEC73f1DN4F8HpK+Xn7eObrsB2Y1ud2PBfr0FyrueJpLKWC73P/x1FK7p3oML344yInx997+VQ==
X-YMail-OSG: CA7r7s4VM1l6wd6BUzRtPkcTANDgl5r7No3hARqhOdzNonc6ghUbZ7zoGndBVz.
 kVoOszjtIGHPdGcAYZqeJib8AXV5Fm14nnzAiB3SpIrg.ZVzNCYA2sqHpV3Cm4S94fJ.vpu3k2Ap
 nGlarmHbJymLcpMpLTMcV.J.t_1R0LR7w7SicEqqpXwf3NDIdHWDRRPjmUvk1n4eORYl_735nKw2
 39U8YWYGGkMc9R_6cxwDbZ7nmrGRZd58KpqHglkiBQ.b14payHsinCvCkqGqhiCpGl.dSsEYQ0ri
 ReUKxzSStXVHEh5X22JvmsNee7jwM8_FIogno.JDsMmkfl.3nhbo25.T2EPZRWpAC6NCcCEd5IJh
 hLaY1EpnhA.LellHO9C6u0nrUVY5PDy4Ujdcfmtr3MlrQsgMnNIzJsGjAt1_UxVeMv50Mzo0efIo
 MGl99eSsdc5S.HK.C6qSbIxXC4zs2yA58pwZh9KrbwsJitCF28g.jRNLNqrYdpxQQ7LzhNx..2Or
 KEcq2Yw4B23P0I80irG3sVSwatKJ_LuWINzVw8fzJ.3il8Mec1Ti17lFLENSVQWNY_0mlM7ZwPOc
 OJaOF6QrWISOVTZMKwxoxPh7vJArLJBIJITiYcjzigU3hf1REAp3_Q8Vi25GnSrVt7Gh5Ots3SFd
 5WeLRPLGEzmTnEcUHcmlK601vQeT0x_59dJoY3.GLtO9Sz3gW_y3BsjZLvhbRX0PkupSTg12.PKS
 8BXnmjp45JqgMKQK_ZHIMGVuCikTZKISMThd68UtPvWcLXFUgyWBAYzvdQkoJTA7V4_tAYMjrtCs
 Id.uf8mVb12X3RJ1tO4KCbF.t6J7zZeCMPg0hew14bNj4AftvHmrqhbKN31xaSTV70EQlwHpQlir
 c6AfmdzELqx5ie.V_.5pkCrpofJM5ZNExJf.xWiy7ykxxQPSPH3VtUygAJ3AGwhT5nIWRCPGdZje
 P4FMqpxLSYUmeSAH0tRbnFvZj1P9SeAqrNObfOW_Z9Jb5JQBwOOuRZDQ.LPXhSrjqDdbm0GHiVDP
 UxGmKZnbSNa0V2OwIKTWmY.ya2880GflH8DGAHpeil85Xw2eYwab8m5Ype2blRZv22JNeZJzW0T6
 WjyVhDwoFULz1E5f.DyxwnvXj.BIIA5WO_H4SMoucc3pakyBaYaGJUN2D4wDukZz_Fhms_4PC6ra
 NlWcRLe56t3E_w.INJRLv5hBZZCtjHI13oh7PPuO2ArzR_5LSRMXZBWGuxWJyls1EKBrkvTOk2VD
 jrKZ_MKjll55x6lG8Cg78N5mjpHM_7qSjBEQ7TRueW9fbFTraBFcZFzIt3M_dCDCj20j7YPcYdnP
 60GJ3eQ4.1nIdYgtL95qr9V1NzVx0utLwpRaeniGYEClb1qkjn8LCo6OYMrqVkENLPInL0zDl7OY
 Er44Am8BuxARFTfv5O4kzL91wJ_Db9DQORUukIfq6naWWIohWDsDWWM2qd1zOfSFftT2qOdShi_D
 oG3jBGkQYbCFV1e5Mhj2dqj2r244pi6kXFlcYrbhHv7djnM7UgMs7wqaiMV3an1L9kj1hM4nJSa1
 3AwwVaizsbyiObHiaoUbOszrDXA_dUiK9BXTIgmGNJ8Cvmjpb9peBmJxYdk96JBUOaoCsxSKCK3E
 G3XGTX_PvPbezCp2Hpe4KDMpVXfEzhuTF5NAQ3wROlSLFpFAfKTvtkidT.p9sTjJxIq_LvLZiTFr
 q6Y5L5e1p73.nnOBifOH7FHwnM3BmF4xiaSrpYuGakyRUI7OU2Y5T4ZwR2cnAFhXjH.Q5_R1hT9q
 pISY6DohKyInlneCU7BkJPiU6U_8O.SovH.59fdiry.bcoWVxmEUc4oHK9ObCrOjK_XeaVXE9LKW
 x0fJjfDbQCpIieAq_LfPXDhPgtKYNKl5VYA8M6XsDAp5W64gLE0RnglYER_hGPBUNnoPsomN8Xs5
 .f3nIkVsEfu5GygB98EEwAsU3qWzrluWwhXFmaDX4WLXkA7FCtF0iuLAHzezsje778xFB7pMLSAj
 2FDRVVn90Vv6FrUrwLKBW5t3syB4Kmcg5ogZpHgztLpAvUfgY3CTzm577AGrCnCXVaEiMkkfVS2H
 zRrxXGBhBHcbkk425qmqPJtB1cnHnNXFKKF3BvBN5H_H54Amx7FjoD4xuHxOzM7t6uWBWGhuEH2F
 3AqNB1DsPlyVPFzlJpnNKfpwWXl15dm4hQm7u0Mvi.KzA_Xj.ejxQYFl28K2aZwBNi3TKRqFLjhA
 zpUvT8ww0FuleU7KVVaoAAuqvQbQ5drA0vY3usyw8VAwyE51H2UadoASGmVZeIQ97dxv3iWwvrOL
 B_JXYQ9slig--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9cab8524-44f8-47d8-a25c-8a08ccaecc61
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 31 Dec 2025 21:00:59 +0000
Received: by hermes--production-gq1-54bf57fc64-fqp47 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3c4ff4710636b88319d1a825f37fbdbf;
          Wed, 31 Dec 2025 20:50:51 +0000 (UTC)
Message-ID: <47b6baae-7ae8-4419-bbc8-b20b81f64d8c@schaufler-ca.com>
Date: Wed, 31 Dec 2025 12:50:49 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] security: smack: fix indentation in smack_access.c
To: Taimoor Zaeem <taimoorzaeem@gmail.com>, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20251009112055.142440-1-taimoorzaeem@gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20251009112055.142440-1-taimoorzaeem@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24866 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/9/2025 4:20 AM, Taimoor Zaeem wrote:
> Replace spaces in code indent with tab character.
>
> Signed-off-by: Taimoor Zaeem <taimoorzaeem@gmail.com>

Added to smack-next for 6.20. Thank you.

> ---
>  security/smack/smack_access.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
> index 2e4a0cb22782..3cc0e00ca1ae 100644
> --- a/security/smack/smack_access.c
> +++ b/security/smack/smack_access.c
> @@ -392,7 +392,7 @@ void smack_log(char *subject_label, char *object_label, int request,
>  }
>  #else /* #ifdef CONFIG_AUDIT */
>  void smack_log(char *subject_label, char *object_label, int request,
> -               int result, struct smk_audit_info *ad)
> +	int result, struct smk_audit_info *ad)
>  {
>  }
>  #endif

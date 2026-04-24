Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1984A2BD587
	for <linux-security-module@vger.kernel.org>; Fri, 24 Apr 2026 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777046842; cv=none; b=Aw9KpOWha9T4sLDukhe0tP6eJI47nHfi5UoU958gHYtBKTUqP6OpULNFH9luMtmu3ksY2MVN/ZfvAL+/YDk7KYAiZBjPOPnRCGydgMod4xU4E6E/7fzf6X9Ja8RWP/BF8zO+OmINPdLKiJ9gMSu/HvUPUkG9yfsjAz2nk9kilfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777046842; c=relaxed/simple;
	bh=lqyUDD7ztKlfNJgYcsY/h6LyhwGnYYhak6HU3rIEeqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zq26tHlimv1vA8J/nTIGdjjNFczCCjWmwL8iK2WNKrmtW1ZflFcBr7tYyxukRRz82i05/0Hc3qxBz3uOfRdnm2xRQacB8K5DEMFiwNgsPypIjZ9gZpB5VuxOqnESdA+HbZLuxeRnqD2ZYd6BLRvG8U2yo0a54fZM3I3x3I/PtPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=CCw0TJ3n; arc=none smtp.client-ip=66.163.184.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CCw0TJ3n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1777046840; bh=7dSD6msxq0MtTnFW9/Zr2XwD+k3DdYey7Hcuan8qcVE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=CCw0TJ3nkchhChiSCcNm60JocGpvhoLwiy5X96ASDgTMXBY0OoGHEzUIzfTHbfsaYz2vP2OhtC5ZgyncWdVLeaPYYlwTIq1k90+wQofGHS8QO0a5MB231kR/Sam4mqMHEuHpDS+9Cw525pSgjQ1y6tPlf/1rvZ5xKsbNWHWzKE4OSP2eEe6Sm0iSPZQYoDmmLNy6aCfFrfhTT2E6x90foj9dis2wnAZczDsMMkKmJ3e9D52LyxKrjxFBL22KeTNKzgd8vHtr9QeB05NIHgWTw7e/t1g6H6ylC7fz5SjKtkkJO1P1S4jgQ/VM4DGnEELSZN3DXWrSKWE9tunDjF9GIg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1777046840; bh=RQERf5kjPQA3IXyv3kPrv5hqlNrL2OpW0NPxFl9V2jz=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jn3Pcontz1RNGYxcslouR8BU2JSXQvOrrtCishh1Cztv9ZDY62eaEF+3/ZpTTOYAMjEVownRwAEYid3XPJgZMKuqBM6xwToLq1Mg+FQ1dRhwYq7FweX8ocDc5NHaMJhP5hf1vaXsPGS9HT9cbqQTdu8VZtkiz0X1+47r8fZozwW2TV9mKXdJO8jzdKqYqnUcbuSUKSPapmg4K6j5d2xhwFFV1cwWKG73S+4UBVM1ENUXfq4Iqc2sqLd6TV2pSfhc+wqeruPYsvoni2U95Ik8DlwbRrvRN6QAU6+IwRgkJu2U58N2VT5MugRN1SS4TttXqjhwfwzoY8g/OZdYGjpnCQ==
X-YMail-OSG: XrwMWEMVM1mDXwj6n5NY4wlp.zMbK_Dedonk03sU8PEEknaROj0jkGsU.OYalRm
 T_bAJCi7aYKaviHWTLimRsYko4UwZKuw3T2kxTajkdhloxB1uu54sidk7kpk2QMEdXg848MLGc3k
 EER.S2OaGEIrtlU4I7Qeyz9tUG7_7J2S8rl.U6U3KK.7C9OuHQ3assBSQ6n4IGznQUuA28eRvgTl
 amzCqu9xwVUkp9pRdYvYKcbz2zSzt4eDi6iQYkHzrEU16vAxICZmLmomLT7LLjb0HZCBMhuK.6J.
 fS8xv40nW.GTQTTfEVGcr_yyOCOCCQbpIBmfpMPMiFiMwqYSD55Fdes6ikneHbB05rlFFqzfTQ9d
 LWaOpKltrnwl6IrKpoQkU2tGUh5AmJWqzVS76amFK1HokS8FEDPnLoW8r2JxmUVpQ2glSTCFkRrw
 FYi1_fVKVvTcZPXUxjQWqO7lBb6nLt.y5mmha63rUcfg_KLloZmn3a6U4U1lUX40HZd1AkQXRUpe
 0Xc3j.LdbLs_rrsbf3iAu_rgHokfTr9iwc_zm6J_LouCwTwDIxLWFBkMIuMMIRrv7ldzCpiR8KSJ
 C4FrcJ0HIrTCIpJMT_9wyeDl.yT.sqfuSwx8xJaV6nZv.oT5uRuVl.CQkwVYSgX568nHx29k5oFg
 QmoevN1HquTK5ySUdT7PMFhGbV7Q9pjBgchBiqM10Em51Kdfgvt3s9LoQQYquWSzs_cAwxZtsGsk
 l63gc7JNzAVCOParlCvYqwLVFG0DbSjFpROo23F0.P3ZDlWPqNnKq4ku_JgaKxNYrYfDtfyE.rKv
 THGpD3RFMd0q33M6u2Aay8DcEWS7KAPyYQhbGXRad80XfmsdNXZUGOhohK9gawX9i7sN_wYdHOvh
 hfyJZI4yCQF2kW_kjrZhSY5K1x5cLNmE5OHTgrG8aDvx.IyFX_iU_TSgI8xwGG4uL.oajpmlAHuu
 PSJvhA3Xf7pxqKhnAWvQZYCrwISCQHv9MbNSfWl_KxN5cL3qN6lzeo4I6aZKMy1xyBIhEx7IlwSb
 hY74o5IashH4_oWMdgYLa14PV7vxKb0iBMjB6ayFc7rnmBj7akJSpAiulDeLbT.Rceosya28mIuO
 rsoSsf5maX_pRPZgdoRkFOYkJt2bP0cjt3tMzxdccK0IIARC8zI_6Ww.YEVKTmUWmZ6g9heRr0RQ
 2PiK7iBhkjLX3hRgn73mX3u1qobntidlsHqKg__pGzOtS_vm1YcbcNEli6dOJEykm2aKd9LkPhGX
 p7v03tXsQ22J7GFrowMqDgzlmiamXqr7AXLwa6uGaVPq9ZeRXPDsNGXawRPEcSJTKr_wI5srVh.S
 KAvV9zAh_aNnzBoXlAKpk4iqB701s6ZaFIKT2gniTxA4rYAIdfkPwn4eGqconPNLahRGv6usSuhC
 2p7BX_EGz5V8C6KJ4KdxIpg9DrExMqC4c2V5amOKVLgS9oOl9iDyPOKOhgcT78H1FQFhhrxl36fO
 a68Mf5kdPaPRuJMjgwJ1BFQut5XX.7dPfJNqIoQF9.ZRm88clR43Csvx6JDwKqZBvD4R9Ai.iSWM
 suDrWYloBjdLmiabp5UCbSt0fSApgQdf3xPBYVw05QWXjRF0CsqxCV3tMSghDRn16GgFl6FKejj.
 fHlC.dRHWJv0IIpWrLnvRa8bRR4wRRxVXrr9oYgQzHikrcTdQG2RV1bd.KDiW1D1bM9TreJPGqA4
 dGeEnBsi0Sj4yJyl8s1l2GR6IEUZDqcRaM9U4jMQYOcHy7p4mpBwEgl7mZoVnisT5tEVlHkeCQ6t
 SquUbVqiquN61sfQ7KdzPxV.Y56ZNR7WThZnlI1u_bq_CRJqs2Xo9Mb8MbcB7TxlY2vnqikYoxLH
 qB0i8LZpXDmZG45qkmp4yRHRK_5gdo5BCzJCeu_ggIZzcgsN7DfOCIbcvPHwmNao2y4WviwfgSWe
 N2mZE_rOZ.RWQarUwlXU8SUwbHm1Tn2jYCYaqKqXgedkaN0nPaOHnCoVMqQWC_IUB17E7b.Ol.zQ
 Jai0SI7fVwx_YtnIjPh7oWYuXynSYmkq.IgexenIRouZNeswRwkqaID3ajalJPHoDc6Mb6aa6C3H
 KDWm4f2TJeIHeE4W6bIsQwqUEGoP7M12q6lQxJ_fgqJW3Ea1bFqfoeEKB08KKhLpAi3CflUX2KjY
 .8t39Y7KSVrTGfSfHZYfbwiPK4pFCsXbX.HQ0jFACtzH7JhB24RuOfKub4R3cTXllZOqWnMbkJV5
 3GwJfsUmxGO1rdBr7HDFmxGYCVp3354DVvKtN3lepVbINCXpZKoTNevqIvErMlnfg8wig5ZuP6Q-
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 06473df4-40eb-45cf-8c6b-a8f65af37946
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Apr 2026 16:07:20 +0000
Received: by hermes--production-gq1-7bb7df5c46-m4r75 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1936fd73ca784ac34a7d0b313199a5ba;
          Fri, 24 Apr 2026 15:24:46 +0000 (UTC)
Message-ID: <fadac326-d6cc-4d28-8ebe-b4ed3a06ddd0@schaufler-ca.com>
Date: Fri, 24 Apr 2026 08:24:44 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] LSM: add a flags field to the LSM hook
 definitions
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, selinux@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20260225192143.14448-2-casey@schaufler-ca.com>
 <c25833f447e6c00868b352cfea50d2b2@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <c25833f447e6c00868b352cfea50d2b2@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25559 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/23/2026 6:19 PM, Paul Moore wrote:
> On Feb 25, 2026 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Add a field for flags to the definition of LSM hooks.  This allows
>> for hooks to be identified at system initialization for special
>> processing.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/bpf_lsm.h       |   2 +-
>>  include/linux/lsm_hook_defs.h | 614 ++++++++++++++++++----------------
>>  include/linux/lsm_hooks.h     |   4 +-
>>  kernel/bpf/bpf_lsm.c          |  10 +-
>>  security/bpf/hooks.c          |   2 +-
>>  security/security.c           |   6 +-
>>  6 files changed, 331 insertions(+), 307 deletions(-)
>>
>> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
>> index 643809cc78c3..d71ba8c87e79 100644
>> --- a/include/linux/bpf_lsm.h
>> +++ b/include/linux/bpf_lsm.h
>> @@ -14,7 +14,7 @@
>>  
>>  #ifdef CONFIG_BPF_LSM
>>  
>> -#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
>> +#define LSM_HOOK(RET, DEFAULT, FLAGS, NAME, ...) \
>>  	RET bpf_lsm_##NAME(__VA_ARGS__);
>>  #include <linux/lsm_hook_defs.h>
>>  #undef LSM_HOOK
>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>> index 8c42b4bde09c..acda3a02da97 100644
>> --- a/include/linux/lsm_hook_defs.h
>> +++ b/include/linux/lsm_hook_defs.h
>> @@ -18,451 +18,475 @@
>>   * The macro LSM_HOOK is used to define the data structures required by
>>   * the LSM framework using the pattern:
>>   *
>> - *	LSM_HOOK(<return_type>, <default_value>, <hook_name>, args...)
>> + *	LSM_HOOK(<return_type>, <default_value>, <flags>, <single>,
>> + *		 <hook_name>, args...)
>>   *
>>   * struct security_hook_heads {
>> - *   #define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
>> + *   #define LSM_HOOK(RET, DEFAULT, FLAGS, NAME, ...) struct hlist_head NAME;
>>   *   #include <linux/lsm_hook_defs.h>
>>   *   #undef LSM_HOOK
>>   * };
>>   */
>> -LSM_HOOK(int, 0, binder_set_context_mgr, const struct cred *mgr)
>> -LSM_HOOK(int, 0, binder_transaction, const struct cred *from,
>> +LSM_HOOK(int, 0, 0, binder_set_context_mgr, const struct cred *mgr)
>> +LSM_HOOK(int, 0, 0, binder_transaction, const struct cred *from,
>>  	 const struct cred *to)
> I think adding a flag field to the LSM_HOOK() macro/definitions is a good
> and useful addition, but I'd prefer if we created a LSM_FLAG_NONE #define
> and used it here just so we could avoid the back-to-back 0's and do a bit
> of self-documentation.

I had LSM_FLAG_NONE initially, but removed it when I saw the amount of code
churn it introduced. I'm happy to put it back.


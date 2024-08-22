Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF322AD00
	for <linux-security-module@vger.kernel.org>; Thu, 22 Aug 2024 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724361199; cv=none; b=Voo366lZyY0D+y8aL28GW2XZbe2vPNXmw1EQ/V3kd+aWbdW3gBGUfIv1OOelaMA/WXukhEUtVj7XD1PbtkmQfgI/6n6R/VAP7fe8dygIcgkLJCtVp5vqfarjvN215K3NNbveuanx3lHoR/XmpBqAJn2h6SQU2BAAkVZb2NizGF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724361199; c=relaxed/simple;
	bh=VVH1QrIy1uE91YAhu53plArfDsUU6iUuK27CcmF8P3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=oZEXXRa+NK2W3XHQckWRYyylujiHY70Oqw8fc8zdMVNdKou9BG7MKec9P8089PtWz2ssDla586YB55BJ7fbRqzqfUf5XW+kyZOWD2jb9phBWDljfT+C9jwebo1zwzUfV5I4IumxlCE/KVFFvPUbfn8ccBCMgQbOPxlfis0yPMdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=am3NBqVO; arc=none smtp.client-ip=66.163.189.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="am3NBqVO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724361196; bh=qzdyWvoN4h7ir3vjK8yOsOtv30O4tZsk5SfOzU0/DcM=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=am3NBqVOPWux4Wvvu4vrcYyaCBZozvFmndXRC0p91+3oJPbzwLZSgoXGYbYZm++RAAPL+50I+MuBuQZHMwURlnwpVH+d9W7k2KW0I7AHX+Ir92mnRwo1vv21kunGLlX5vaUdh6/cEgLByMGp1YEm8GIXvHph5a8FlCPPmiPi8KDbJ/Kt2dy/oEiG5TYtnskYKJ+5cX2Wj0e1UhcqNoB8GuTGk2LISfVcKq7vTj3aQ2+ObL7ywhXhSJOG8lVBvBEkQcIbiAL0FVs+mBCWjWQ1TJuhN5qP4UBKUC0kCPtM3oeDLtynq92Fw+vpc7w6Jj4FTFTdq+WT52xIraOF8EtW0g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724361196; bh=bE+uy/0yJc6QJo6RMLuZgihwSarY3c4pE8bDetCSAzm=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ak1JjXbDv9lBSA/hSGWlX9w0b2RPcfI2YsOgaT0j+SliF/n+dJmR3q4ud1uqJq6zu8Rgi89Oc4d49ZcUJVArPZZtRY2g79KYiHkVPPPWexeGB/iqbg7zv0sAZqDaZpWQlEGvgjFCXMU/c9ApPOzXFbOksOHKyDpAnTLABCd0TE7puL3XZJq+uvRWs81AQTpVRIjJEuD5PLZLc23G4vO8+ujsjN445ehEOpHieB9cfvLBclQi/pbe0IB5lsLTGrHTyvbOp8kY8ojfgzJS1wGuGKV8hUcM9+icxN5jqjGpNEBQzr/bfxjL91ngtRMeZIpIsvjFsB7/RM4ByMy75XWI0Q==
X-YMail-OSG: MPdRytkVM1kd5rl.1ws_i0MTps2UzmXzD5FpdEG95YuGi9Y2QWlD7.DWhFkTGbu
 b84btcLDAQtH7jSm5qJ189eHXVHHK7sDZ6HI4GqjcKugqI9jLV3HcFpkm4PfmJQTrlrltaiP_EXs
 IaiYBNIoT0hoYIxoSQ1nzRqvjDjHJ0RrNu9cDb4LVuWS__8DC2HSJbML6WkhYq_X8tTT9BIyVIDm
 .m0Kp854it6Yes97ieITko8TWasni1u8OM9HXBG9V0fB.qt5z441lk2gs6dKRmQJGTiuBwFnUc7o
 jjOgsXsgvUfY5barXUX6m6RYI4QFJGhE_50v4eVfnNA0nIn9I7MoDNQ0nPR1ZbNXEwfDCER3XNBZ
 Z1o4se4F9xGzGlZJ1lx3nQ0iOi40Or69VQfCMYmBTG.0s6awQEGvjBhRr7CjRkf3jYwzavAH6uSi
 XO41wfwvruSrK4JV3WKNsTGGmteDJp0g3NVifULbC02kuc_8c_72LQyZ5EIzv7q6LHHxb7LQ3vBn
 2cBFGVY41sWwRe.zwRy2gR_yfmI9aYqRYCRe_Ra8ru_5tZCm29mNngEaMas6mHbAnVY44i29wUsa
 sENWsCoTq57wV.fOWrTTeUSLBdfruCi3n6lg0Sa3LNRvsnt7fnU1wC0n8lvsFERzGVaJ3eHfTh0.
 hZT4HC7GHPG7ZnEAjKsdRFAwonxCsujK1uF4T7I5W3vbC_3kYfJxhmYK1SCf.ScSCI3G6h2CwX6h
 InWYTPHRU1yta9knKHDxRBvPlklyELisNx2ztgQv7U6HpQGzaMrWUhIDTpI9NiL4ZNT_r8D_IdKR
 bwhE34NaCzUx7GdAEoSRcLRz30HrvyXq0.JwAvumoZbi1kbszNtJTwqm0VB1pp3aprcvioNO3xkV
 cGhTkErIoZVkgg2McD0ka7Ldil_YkEHSym42jwIaHuJQKU0XiC8eIBkWyDliWfFSNRK_lDePBH4N
 YnM5IroQEnSmrav8TINakI1hIWsk3yVZwwN.W8bD72W_ZibU_G0M1iBHKL6fLimer44f3EvLy.dh
 NKNEeF042RtDaA5eGbePSUxmGxpEHfiNArZNY7m8bz9_JVJGNfklE3mBlnm_gQYtAQhjqKe9a8YH
 wrXUqrX4D8mAhHF42QTzeaWfXDajrSQqkeJGzRkKR4R6a75e3MpNPTXzwWiwSkjhIZjFvt4jaz9c
 w6s7k_FNVoFmCP87ZaAgYM5UPUETQZRmPylwIm0J9rKQqy7QOqlRTG8IEVQ_kZS1tKQOjLdtQcd.
 I1R4Ph80pNhiQLgWM7X3R2P7JAnTkGTaCILdaTeFR1gclaXfufqnnLp.dvS1V2UVCpMux0VoGv66
 Y8aVw_kTDy_kHmrsXIQJlLUke5yhy_y6UhtpvsJRy8vvpu3kQJvGgb8453QILv8AWTqvfV9y2SaL
 Fq._2VB_C2ohMfsrKSiDep1tro4BgHJL4KjcaSmp11wDNi2ATtsK1o6hYhrKi7o_2NV99biLgdXM
 9uKQtqMb5j3iKIxOFrgG_m36GmRS6kayjPOqPlN10yO9onoOyLIJMrDy9yAqLndf5BxU8.DjinSk
 7HR.QGoRQrFeGDXpYn6n6UwfIgDnNVf7qVKS52QuJXSWY8M7Yc2A.KCD0J3sPyMCPJi7Vq5ZUBYH
 1REt8DcyJVWl30281bzMAoRcHC7ulibgfAxmRcrDbVijhawGndt81qKRyharhiRokfXg2QWr74fx
 Yce.GM9pFjWL66tu8dE_3B96hm4PbNmcjZ.Som3MbyjXsxPdL31jLfCd1qvKbNkFHbx_kl.xd4FR
 olIUlLOOAsywBzwG.NU.woo0.WM2oPZ5M.4Wj2iWWXz.lgJ4YlEnFIHZ4pdNeQGd0eDwhD.gr.eA
 pyopP89xc.WklCi4HSdtljCeU5yc6ZtvsppOyiuxVtoe8tf0oioa4Uv2.i5BXseuCylU32x_M9_Z
 FSjCS49hU9Wenye5Oy8w1yoJpCZMh8wwgcKf.iTunyVUDNJNygLqmTCcaiwTEcmhjO.DSj42hTYY
 J_WeSN.iSbn2zYJ8Gpw3Ef5ASoPZdfazxLJ72lU9l1cxvL.JoWRmCak8JHLo9TMhATaTXm9vaJtV
 gNsOCSZ5o3o45JCq5wnQsZ05SKaEstI9.L9HApX5tWmI5y53CjstXshAjAclIILGeP3yo1Gj_Men
 qZ6sR_7XdxwR3aFQnzCDGu5PeVkkvn9M15UenjNdgaWuiHliqrGKQ3VFKZ2ziaCHUNQ8W3eh2JUK
 TXt0QgvsBMgFr.UArGBBs35Bm2AsZYJLxUxeivLEI_JJvaL7G8y5e1mEioaHq5gJMXhzDN.rIePB
 LKRVB3PpwfYxvD7O3zDKCxL6kgQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 42b73cdb-47ab-4973-8cd7-4a0490d0cb7d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 Aug 2024 21:13:16 +0000
Received: by hermes--production-gq1-5d95dc458-b574z (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 965997a897c4bf0674c6cdac05093446;
          Thu, 22 Aug 2024 20:42:52 +0000 (UTC)
Message-ID: <7bb43c87-095c-4478-bb7d-38ab55edd8a7@schaufler-ca.com>
Date: Thu, 22 Aug 2024 13:42:50 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] security: smack: Fix indentation in smack_netfilter.c
To: GiSeong Ji <jiggyjiggy0323@gmail.com>,
 linux-security-module@vger.kernel.org
References: <20240822091806.89425-1-jiggyjiggy0323@gmail.com>
 <7680815b-1f40-47fa-a0b9-ef8f7fdcc457@schaufler-ca.com>
Content-Language: en-US
Cc: Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <7680815b-1f40-47fa-a0b9-ef8f7fdcc457@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22544 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/22/2024 8:34 AM, Casey Schaufler wrote:
> On 8/22/2024 2:18 AM, GiSeong Ji wrote:
>> Aligned parameters in the function declaration of smack_ip_output
>> to adhere to the Linux kernel coding style guidelines.
>>
>> The parameters of the smack_ip_output function were previously misaligned,
>> with the second and third parameters not aligned under the first parameter.
>> This change corrects the indentation, improving code readability and
>> maintaining consistency with the rest of the codebase.
>>
>> Signed-off-by: GiSeong Ji <jiggyjiggy0323@gmail.com>
> Thanks. I'll take this in the Smack tree.

Your patch was whitespace damaged. The tabs in your change were
replaced by spaces. I fixed that, and have applied the change to
smack-next. 

>
>> ---
>>  security/smack/smack_netfilter.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
>> index b945c1d3a743..ce06cd268d81 100644
>> --- a/security/smack/smack_netfilter.c
>> +++ b/security/smack/smack_netfilter.c
>> @@ -19,8 +19,8 @@
>>  #include "smack.h"
>>  
>>  static unsigned int smack_ip_output(void *priv,
>> -					struct sk_buff *skb,
>> -					const struct nf_hook_state *state)
>> +                                    struct sk_buff *skb,
>> +                                    const struct nf_hook_state *state)
>>  {
>>  	struct sock *sk = skb_to_full_sk(skb);
>>  	struct socket_smack *ssp;

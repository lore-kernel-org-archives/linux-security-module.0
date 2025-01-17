Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E41D126BEE
	for <linux-security-module@vger.kernel.org>; Fri, 17 Jan 2025 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737138652; cv=none; b=YNBNjX9PZHjjKtl6SyvM5ICbhUFZS5ZHKQ5Afp2UeqhE+3n0nFIca09VNXVm1z70csJLaJxvONWs2OKcO+98teZvAufDFdoWL9VvwswXYCCZYFU4jXLdv0MsEkzea4ZS9IVDpsH1wpzb+0gGeWF7da+J5/OGPW907HBdXD959KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737138652; c=relaxed/simple;
	bh=BViXMiaAHI3FS9EUFuWFm8CA7Xya5pO3DAGNlsp+yeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOBk2ufw3rPDUCGUTvEPaJIcQbRJQDbaOfJICU3Qh8vaFRvKOq6bv+vgQZPv5ds2jU3xK+HF/jKJ1RghdjAF+h5N/V0Ju8joNzKGmWw8g7iuTz8cCFzhPlnxLjw3H7OiW5FtgWEoVvp535eQKayLE6bMEbLV6xmgfjtev7jssSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=G25QeMIh; arc=none smtp.client-ip=66.163.185.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="G25QeMIh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737138648; bh=iwmlG3DPkVReQ+JGE3IKAZNLTnIXA6O5zfXqMOLP5bA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=G25QeMIhdMiWP+ShebQap0EeZNhhnegH3/Wae6FD0H6NgGiXtj5EkJ0W7aRTidz4Z4JldTSNyptb5+P2hU1ojnj2cgNEqJZ/huukyh6OyQ67EAFESyma2Q2P+clruPprwMBsgmcmE5mftlR24WU/8ucawl7pqbsLL1mU6lE2H/E2vnvoj9hNF15KLoxoJKtkhyr1pQO7wELr77OqjAhWQ8NIrbiY+CAUw+5THTzy/Uou6mUpIpeGLhFaC3/NwlhHmwcq0jy/Id+sQ34tGR52kTM1jZu+Spo42r64sbaEibFeGLaVJQxklrCV20m8uSHwh8wQAlbzRFFaOgoaSmt2Rg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737138648; bh=C8RzoX+ICb5sJwLLEzl1qFHHstYBvBMwy3lAMijut4i=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=taqR73d9rp3mxaoIzUQ8TTiOULI7go5HX4iRJWn2uUxoPa+CuP8DkavuKmZbFXLNguotpDVvSzFA9ZzNFozkf7BL8zZRsF8bYenOtx/m4gDjl7HRxtKFby1oNCJSME3iVsjfyX/5jk4a+y0gjbwBEuFM8Jq7LKwO4gbSg30MHHbQXP7ZNnEJnbUDQT4kZ+5HyXea77Cl0rpMncddLaj7CJ67tibaiLkRUavL+O7hq0PvWHIH5yjO6TxFIam9tkbtAnfatU8a4ujS6p5qD7/x/e/04WCWc8+eIKmikihcEY3Vkguh/DVKeuQb3FIiymi69xE5CDnUIN0zatfPpkiF7g==
X-YMail-OSG: 3Tq6Ql4VM1mDsn4GbxONdAiLIN5t1rgKbmHkNjLLzgaKgCO0avZ8ngjLgv.UB5i
 bPrJeJycyHpCY7DlJvZ6Z493naglMKzl1SmwF4pRO8ckPn891ti9z6V5IQz6PZHCAIgeEUhl4sDm
 zW9W3MQpLntXNCFLJ0NYX3rRBv3b4OxJlqOyHbNznLbMd7RERhVUc43ZGpKNelnEvcaw8GQjhAuq
 lrOmUZ7y2IhZaqV8U1FYBIxVczSurF9huMmbJgOVSpaUZLgAvd14_4g6rS0gIG2ZWKLRWDxmYM_8
 8KtAkoLtaHdT8GcpI3SmTmhibbFmq9EQqR2Z0ZhvlwVPOEizfeQsMa6mPki9v9Ps.C_ioe34r5ob
 lAILASjZV1.di5jTtSjHK7wXbsYHSDgT3c9oj49LlcmHUAzj9FkXBbbK4n7knozpZEbFhPKJJ.C_
 xSbExJFlAUN9lhzsyjthM3fQYdQVupT1alawo732fxAGEz.ZaAsywm6VYAOZU80U2z4O1_nTxf2R
 jbWwUsOYhlikiJ3vV_m80Bc5n1NhNrjUA7v_6xjPop5rzmHTietybgCC9aaNShG9U5_azuVRGQef
 gLRVu9TxFCbjWvBNb2fmoWuQtypQdM5HdW88gBHQCC_1zfcWRuU36j3aqxuc0gVhXmAcN8xh.L_x
 xaKHSr73LKwQNP880w3kK0bhsbGVJOduSU0MJO1xeTK5ebG1z3Y2q1jA0eHlziP1C1x1i5CF4x9K
 dafXqWEenJRZ66YiZz1NQWcUiEcObT5dBShbp2UYmQ6kfOLND1PxJ_9ZIShMr8.OHUnrbsrVM4oc
 j7X9Wovh_MKGnCObPDc3GTh.d9RX6CiCLPSJ30BB5kgI94rBTRrGpoVyqurUY6I8mMFY0H7IrKX7
 pUQyNfaWFM.23kcyZ0xkZk1aUyLT2MZ5JSwNqs62FvRpEiUMFQ3kHhAtWye.You35tUMyheQPdf8
 8PxPEDSAP6.CKPf5OsMYg9L0_0Xch0zyxk3EF1KFcP91PB1HZcJLNHTnKCVntm8F8E3v67p9eTMw
 .cuQlA_4M0mI.f3pWg3i.LEqNsCAqVgu7Mkacaag1odSCk_s3n1lMjCCVOaody.60EbTDQIQ5tyv
 u3K6MQABAEwvhxYY2n.LM9jMiPQDhITjJ9MA7wm4W58jx64puBPVXXGG7UY2Sfk8cLu079igtq6k
 v41c_F9KMe0QuaWnVlQRF7o.8tyeE30ocVt5Kf97Dvs9UJfsCq2aFGGXFi.wT.05tM0nb.3OK.p.
 CGyDxnEI5O1cuYdju31F83W7_aFKzMXWEVCrJHINrXWpcsMjfTiwJ5xRmdlIykwGg77GcZHznBd_
 abL8eExMmtCUB0HAJIZ.GpAwP80_wLYt6cGqnZD78ZvG_xNiXJqq.Qibib8DV8ATKMRQfde0pcuG
 wZasnoOzdWFn1YOBmF_CaKDNIMBREfyuhoOgbUhBMTSkGNWvoNN5Y5tClhIW.RcJ3JKyJN8FJYeg
 snWzCQMQnSFcOEagwtcHsBixQ8w6SMM8yXY4t7v8eBEWt42kprtQxB2t9C9Oc2CIy5v6TsgYrbsU
 RKj8UK2x0vTkXP_PmurWpGm7skWOJtcJijKsETTOaU6AQ802l4aaZikX3sdyQqP_0Tqx6DBcO_ch
 KyNuPDtmvvlbPn72ki427Gtg9SZ5UOj8uGg7Enx02WuD7cZxhOo6ML7zO_fTtZViHS69IilvdOoh
 8e4azd_6gl8.TL8rO87LGWt4cbsoxvK4dd9Bdue0bfCTm5_2VK7626b3RX6ehwlviJ1sQN8Cq3oG
 YskLx6IrdMxG1HC4bd9fLz9jpF43KOQcTGtTYyfsflJjaQRvmDcbY6evhlTjRscYIdhtqRQSYItu
 QTwZrmRQO6K3GuSJCtVd5XROn0AvXj0T5WF0eW1RyAWV88EWOi0MNuq0LdoFR8ZY3kfqFn.tLgd7
 .D70koajljlDD97dBpjAqieQQVEzCIHOERqAm9S_KPuHLd3qO2bBYFQj4eJIreg.O8ukZ2gjZxOg
 lQRolixxm.whZfqebJJipAy5XmONFrEFwD3AZRkWYLkFchmVwQGCwrc866SIYNoFOjKy2oHQn8gl
 YmRhlxnxUdx4k.d38MUGqDiMUoDNxbagjRPuHSQWqafWty0bOIcLz747O4A2203QmwSjMyZRB1ua
 KoEucqhqn3seM.QlX.oZVXgt3yUZlVeatZVE.8eyNtkx4ALjO6jHJNagB_yKjs_IdMixMWktBd2S
 NecV7ZwEZYXSCk6mbicGDXzVRMnOCjJBZE0qX8aiIiaGuajtc.Y9oIZtg8xDKv.nkZjU0NA3j3J7
 ZGV2czlAydaTj9w--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: af1c2efd-4810-4a9b-8957-5108a6c238f6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 17 Jan 2025 18:30:48 +0000
Received: by hermes--production-gq1-5dd4b47f46-qfm2r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3098a66bb1cf9a24af6cfad36d887427;
          Fri, 17 Jan 2025 18:10:32 +0000 (UTC)
Message-ID: <1630b5cd-c1ef-4afd-9767-7ebf3c0cc7ae@schaufler-ca.com>
Date: Fri, 17 Jan 2025 10:10:30 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/14] Add TSEM specific documentation.
To: "Dr. Greg" <greg@enjellic.com>, Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 jmorris@namei.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20240826103728.3378-3-greg@enjellic.com>
 <8642afa96650e02f50709aa3361b62c4@paul-moore.com>
 <20250117044731.GA31221@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250117044731.GA31221@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/16/2025 8:47 PM, Dr. Greg wrote:
> On Mon, Jan 13, 2025 at 08:29:47PM -0500, Paul Moore wrote:
>
...

>> Please define the CELL acronym here as I believe it is the first use of
>> "CELL" in this document.
> FWIW, CELL isn't an acronym, it is a metaphor.
>
> TSEM was conceptually inspired by and derived from the Turing Abstract
> Machine Model (TAMM), as applied to the problem of modeling the
> security state of an execution domain.
>
> As everyone reading this knows, a TAMM, in practice, consists of a
> head traversing an infinite paper tape divided into cells that direct
> the next state of the machine.
>
> In TSEM, the model consists of a Context Of Execution (COE) with
> security definining characteristics, traversing a finite set of
> measurement points of infinite length, with defining characteristics
> at each point.
>
> We refer to a measurement point and its characteristics as a CELL in
> deference to the inspiration for all of this.
>
> We will add this explanation to the documentation.

Communication within a community as culturally diverse as the Linux
kernel developers* requires that you do not assume that "everyone reading
this" knows much of anything beyond how to type "make". Let's face it,
there are kernel developers today who would look at the Turing test and
say "is that even a thing?" There are others who don't have an education
that includes mid-twentieth century technological history.

[* Yes, an awful lot of Linux kernel developers are western males. ] 

...

> We believe there is a technical solution to this problem as well but
> our work on that front, at this point, is too technically immature to
> go into.

Didn't Pierre de Fermat say something like that about some theorem
or another? 

...

... Sorry, all I have time for today.


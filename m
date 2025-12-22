Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4962405E1
	for <linux-security-module@vger.kernel.org>; Mon, 22 Dec 2025 23:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766446371; cv=none; b=YMk1diDBJL2b12/0L2wgVXrJ8/mjy1wEpDUW7tHFJW0nVHCBgHhPIBgWLxzvu1OLqZc6pkF+Qun/fObW7QTDOB+RkIIq8TqzAMTgbOyjuw9qAxqxekybhFVc8+rm5YfPM8v+gG0m/QK8Ae15JK1YMME1hgcXmw3kWHzHv5DeiQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766446371; c=relaxed/simple;
	bh=+nlWl2A4SbyQ1s7jL6sDvoa0mwVXQesTdioQZyDaOt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDZuJbQUavnVJMioj27XogrJg0NojR7tb33codsOB59f3Past5+Va/TVbCO3zncldis6AHNrrbpqUKkwUTbtmbgozY073Gwq8i+id0ItJ05wPQodyDxUmXTwR3RxgtVPP46+Ut1Ade23m8EENHjHgT4yG9uVEFroMbcBuljJWhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=uTmIreNW; arc=none smtp.client-ip=66.163.184.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uTmIreNW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1766446367; bh=+nlWl2A4SbyQ1s7jL6sDvoa0mwVXQesTdioQZyDaOt8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=uTmIreNWFkTX9zccFAxdct7DDsVgrFFrjcxveL38yVnt2yFGpRkJc9Nlp1/weN1wq6PUrnsXtEPtnY03BFZ7eFMUyw6eQxUe35WBSJ0lgKkhj5FAJ//ZxmAUv+6SydwfdPopFPUkaRGEAOH684irbOhaCWKhjnVYSO8fuU+G77uRQrkCWBIoQqCAvt6qOjmoVC8dUOXWhNN5y/73tD4NP6YhEFrQL7k4Tt1akq/2/P0IxmqOtqxjzyIvn9204TZ5w51HMitpKEBsDVPm+a8w4pWJxAtTsN3SzbUoNLcTdab0G/ksbiitoWbKC32eCtSztu+oI+/1UCZ0SlEO1v0omw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1766446367; bh=P0G9o3QAvOC5L+HqIn/v0nbDeqDz3hGvFIjTanMN6y6=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=J9pLG7gaBefr2ApmEsJuddUQ2eQaAxOMUo6XOt1YoVh+WWDCC7YMyl7GWSNjgy/nO7xS3MRHEkulQAB9pInNHPbtKw0SARpxNh0Y7mb7MxNLED2/LqAxLG251mv+gG9nuet6iQhAwjGUvWMyqimqOpuq2JzOBhZCOxh4W6rk6xEQ/196+vvuV25V56wF2ClJWOymmNXTBnXhN4YoeK2r3wzg04ZYoPPwI83oADQjW/BKaVaDJks0h/SkzbV3UwSAiAzQyKZsSAAB7Djpi6jbNmqQ6wiectikZBXX0/x0oifYX7FPYVTgmU+5Ka0MrDA9MDZr3pEXhk2aiXbhkJkBfw==
X-YMail-OSG: .G7lCWcVM1n753tPaOUArHKtT8wHZAmVFQeH4V6dGUcoKEoeWVNi5jiS5AQpcQp
 w6JXCAThvYVDOTLepGvPXIrkym5UK03RsPYgK.pXr8rANc6WKGBxbKQ6vwttRZS4DIyd.WtyAwm7
 iF2.x_A1sKyeykg850pm3w3DDQE.iqlgrHb1wLbVKrii7Ghq272D0INGiXfaBSY_53AY8j9gvK8v
 faA.SAhWn.bCb0PyqamZbK3Zppc3hcCEXJEcNlvIIk1aA_CRCk4LqgBUDfRVGXV5taD.KBpMO7u4
 .EdwLVCGxBjtJW3W23M.h2Cs0Q8N5u8MBHNL2Dx9U0cnX8RAJ_V_bLzPZq.7L9G4lzOISNZkUs5Y
 veBDv3zf0j80pdvhEYAFHmmK8ay3dXSPnT1X9MrPSdtKwQgQ0ljXIodsrUyblLVCS5_f9wA_an.q
 9hW3vHSPW6yKNy8UAY2MhJOxZAaBf8lsBfxllOisQcRC.jZeUofVma1cyLArCIzS8unty_W.GBPP
 lNGdajBS4AGXUtJl8KK4TMfl_vgnDBkCET0DgfKHGIHLDi16xrdCkON4PxrNHbCfjvuoPWYuEJkB
 hcpAD6O.gCesz0XJuJHPidi0K91Jj.MLAfdvzkH1eaegvQ35vVN9ZREC1sDYBcwaNDDLygTWSfgB
 3vKG0bTg8u1Eb_W.rtmBf23xrkoNMKIw_cLpSKboiMRDoape_u8kBtshL4pe5vnasCt4L8EGBo9F
 X1AAMoZ4Aevk8AbD9dRCeueyNqyVXXrFJ2U.udURLT8TxoMVxLnXhQvNQYkcDqhmPToURaWs_D9K
 Luqxd1OOnFkt7rJ2WXKoFaUv2Xpt06y5y_OHhInpZinwwbt42RlA4WByLsG0hjn_LZ4RA1Wh5sIC
 .qCN3OttZeedz1BgBYmBufnXivWXP2Ka7u2kjXs_YYM6kcSP12EzrhaQWrHmxoB3CvjifAvk3SQK
 F1BonjbkSV11lVjw8a3En.tzEZDIIVKos6rMd78_uZgmfbOUoW70MXcKoDQODLYcl3tKxXQiUZkq
 kBNS2L52EflodoXDf00AuwEkJLZxjCRXPjDxEkj5gtd8yjem_lhy5bUvTyxUqWRbMbCR_zlWEIGn
 Cpi6tb2bzEw8QNGKhDcANs.UVUq98Dn87ojxMLPYUz3KMlNhxCMYFGRvtCGp_z4ZEdQVZzvmpsLL
 xa.iGWhGJIBT4KgVubYutBMP3MuJk39EuiMjeG8wHLVz.632VLTru46o_UipMTuhhRXfMlmZmwJV
 a6KpnkwTgX8FxKi4PJKzcXstgqaUnd5RnfG6c7o7DnpaCF0THDXyhiHn8WdEeUB0jUrViGsw6taI
 epkeusVqf2R102VeFTu6novq_WMh0httaNO0ny4eo52ki7rEqs7XOGHofBSS3TdTiMQTevKP3oXO
 jBpmAWuf5uNJBE3Xrf.A0qJEhTzLpZnaVcituCnbZcFmMqVKfMZSE_xE3g_O1pR5YskqbfOsfJN3
 06BhlezECeZUiSogweSx3ZoZr5UjJ9YMAx4GgEQUAp_VQI42CvXb.3p5YDBW9labchYHbqa0rimu
 zbQol6rlPxEqzTbtmK7lPgFXDiSqMo.fYKF3CA5p34yiskMeRIPxV2NHPaGuiqLGpo8Ycdz3DGaN
 jkM2LLIwK54yC0oVH2g43SAJkXnYF_OE9pV74yJdfZS6i3OKHu289UB5.XWKCGMXI7qeQNMdTq3o
 .7JEVSqsZsyVvWQGm05U7zDoZg8zDaTA59n9D1mjWCfXSNcZkrl_5h_fGB6R7_XasdHMVVvDUvbo
 HL4MX_vj8DbdjBWhZV8w72ffE4Ik6de2_EV_BNS3ogl73kvYHoDAoumWu3sJ02TrSMcPOh70AyHM
 pm2VEs7_Fp7uEmSIYvYMemP.vDunz9bKPPBoOhJQ7Ae3i52TtZQOyj_nU4FdxHmaTtmu3ukRJC7m
 eF4vtD9iImv4BgZvGBsB.yVRx5d8nOQaPVifDiSDiZN5h1QoGuhkInLqo8wwch3Tvb.n27B3fGAH
 BC7dllgJzrJ9ftwcAaAQlotrt1Rj4c_vKwWMMF8d.6.eHGtpgL5tKgoYOdYzrt9c_3s6eyBy5eRt
 03JBYnIRwlD8hYQUI2KUJkP2Wi2pTbg2KAJENbaZoYelZW9LMmCW6mmnZmjioYfuwJQ8sNmLHLvi
 LAbZXJK.xMsP7A7EagUW2R_oe3d2.YE4CZ2J4QXvXnZT0qMyMjoA4KNCEwQCwhid0oiY66XqxZvS
 cL17z3AwaCvIq3.2zIqUCB.up.7ZNtIZi5QZNMGgdwiaTwtAp89IyMpKyiUy3Jz424yTzpp1Y2.n
 dWJQ6ePC.U7kt
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 727b78ea-877e-42f1-ba80-3e3c1cab7107
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Dec 2025 23:32:47 +0000
Received: by hermes--production-gq1-54bf57fc64-ftpn2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9493b02f00dfd715bb6118239bc53bcb;
          Mon, 22 Dec 2025 23:32:42 +0000 (UTC)
Message-ID: <b62b5a98-12d5-4a21-ad8f-4260c8ba4373@schaufler-ca.com>
Date: Mon, 22 Dec 2025 15:32:39 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cred: Remove unused set_security_override_from_ctx()
To: David Howells <dhowells@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Serge Hallyn <serge@hallyn.com>, max.kellermann@ionos.com,
 LSM List <linux-security-module@vger.kernel.org>
References: <15895666-464c-4349-9fb2-f24e10aac8c7@schaufler-ca.com>
 <15895666-464c-4349-9fb2-f24e10aac8c7.ref@schaufler-ca.com>
 <1075251.1766441984@warthog.procyon.org.uk>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <1075251.1766441984@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24866 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/22/2025 2:19 PM, David Howells wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>> The function set_security_override_from_ctx() has no in-tree callers
>> since 6.14. Remove it.
> It's also declared in include/linux/cred.h
>
> David

Yup. I realized that just after I hit send. V2 coming.


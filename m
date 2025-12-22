Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D704F278165
	for <linux-security-module@vger.kernel.org>; Mon, 22 Dec 2025 21:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766437318; cv=none; b=tlCoHLz11i5+Z5R6Wd2KgAr/lGYDcTSFu1AYUzG3z50URpYgXU4d05uZtjKqApwEN8YzmhggqjwUJhhVQpkOw7anVywt39LF93c+Dw8wq7szED7mgZSlPRlAJoqw3XIIhovdOJGgScjcuRD9es5GAnYdirazUcR1lhEItf+5fNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766437318; c=relaxed/simple;
	bh=TL9mbg6ropHYFI59qkau0E+6Xwx866LtDw+V9SO/gdk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bEeahWx3sI2+4ChmyznrUCl622OcWsNo1/PRnU1IUKAdWQtZw444VV7j6RQUCWWCLOi2qtOOYKJUhgTLHOvQkRz/NUJcu+UPEqJuW2HMwc/hPz0rCaYISNHANL6qJ5XRaWgQLj6r8CV7TnN/zaMU/D8oHGlG19oUV3SALU0N5uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=DbyAB+eh; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DbyAB+eh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1766437316; bh=TL9mbg6ropHYFI59qkau0E+6Xwx866LtDw+V9SO/gdk=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=DbyAB+ehPrVhEod1k0sH2pPGuwYQuo8DUo7MrHDb6L6l9ZRnphmmhkyp+J+cEzGpdUGbCgUIl5jKF3n4dW8s3Pc8bGAfD+ICfAVXkyMaI8k0RAF/PE5PteH1qEkE4m78UZ3XvqqdpD8EoqAiUF1QOnYXvUOKBUzLSQ1iblp1ELO/BMekYxM6TyjRx4mhyJbVcB387t6MhcpOOOgAia8Ym81qcYRqllwJC17oN/WipeLFoM11mkReqA1rce/EgjU7nEx/EEozYVntGZQV+JMhzPPtGdwQHE+dW1J/EYv62AfDOIrUXRMcUU0fWDB2W4oLFxGRJCVIsAjKv3cUG1bsBg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1766437316; bh=IKFkobboXSQSDdDrJCHRejkoRCtSR+KCSPSkd3jO/0M=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=JfLGa4VDGF66eBWle6jqgLjeo46o4EdEbWgwKRzgTtxQgQWVLSbhHA5V30u4p9vQznr7AeMXOBznsuQ3ePQdUBXAN1NKP5pMQlCRH8BCrb+72bQGSToo9sVJPoeAfJTZx2+5Y4fKnZiygy7SlKu9+IxWDWDB97GaMlvvFlHBN+OsOqrkC+yJygRyrWbRy5oMWJJySwLn6XWqDeaC5IXSU6DA17YafPdrazxgWMxtALQHiCNuPK9qM8LT9bBQtWUj+ndU0jdA0jmyF3+2m4h9ZT9+tU6Oqxl3mSrEjz/MQfKMvAHnQqsCOEKYIM/fxZo4QSLEMXwvxHG5f4c0KuGJqQ==
X-YMail-OSG: vtmETBIVM1m2ur1.5K9S7gdIe8TcDEyLzyn8pCLdwdW9f_rSbtscx4wfXDY1UM9
 2OIIYT0ZrPq1jgFO5Z_GYBqLL26_0a_f3b9cUs_SyIPLYh4brhRzJcSBnomGPOv0mh9u.LQHG0y7
 vWDGWklFz_ArH6aAWt3V9MfrkRD7FEpLAKfPlI2ZII5JhOxZihOiGzYWtcEoswXi9UMUE8SMTu0H
 e7C_8qGI1rPQEJW6X5FTFwwLIs5SpFBd3LByA4SCdD4UxQDVVw9vry6KDji_gLhNtZJQK4Bv6RrR
 mKlmWen8mcoDCyV0qqiQ0qk.tNdCiJ3dH3Pu4tDi6aBxHksaTaQv_HKZvOUpxgqnEqdjHplV5zr.
 be5ru1r9G97araBAKdkkIGYTYmVLeOcFZwKIS.Izb0jYZX.R6E8av4qvGWishr.fnM.y3pBWvsvm
 QZpC.T9SLMbwQ6dJL4UzPSwoUAZlAvpCxeuUi2bJ7SK4Xwhg.ovp4gfKCUNZqRzIPwkPvKsjRymT
 BW1swfhWAezCu4IqJ9Si62qIzNUpWZ9O2mZCbb1TltCNzLXnNhwIVIRZvX46pPqmByedE1Fq7t5H
 8uunu0JzoFC6fBb5zf4bhuD4bHdTSHnqMBivrY.j8og1gDdwg1sxEhBXiZD8rGCUgz5GGTcoeR5U
 7Hkiu3j5KHrjbOmwH.xOaPAORBKNiwcm2X3YLvuki4PxiqnxxuTzfa.d9qQd15cy.ad3nk0T1vkW
 qe48Ratwj38N9GEOi7w4k5m3iWF5iWVfaVv9pfM9JLDdFxUTJF1lCyS4O3.uUJ1ivxYoAhr1NvzD
 d_ilaCMbYanpQ4Ot5hJX8f.zKHyRoWW.wI8S_aFcR3MbUBzYtrJSt8YO65sCtlXKkpUE24haiTRe
 _qGilSMo8TyolCpOnjmjWEbPSXsCiL7Qly7FYw37tiMHmMH4nbfqja118xhsyzBTfvL7MaHMNOfv
 YjIAdlGTA2ZKEiefqCXW2u5sy2TEbu._5sghdTgbWmuxyE2eKGSiS5A9eHxFECA49RKWCV3sHiUo
 dUu9cYIGa77.QLtZt8iLSAB3BCJDf24gk20rRfErSdTEeMg0_XGTeDapJrkfbcYIg0_92.a8tww4
 VlL5Jxy9Mcg6knrKyJlpGOrWaDm32cBMIPiKnPalFO89i0eVYS0jtNzgETTXwYUIQTUSonbGnLiO
 s51lmrby9qHji4WoIFm0xay0hvyBusMxNEFIoMoyswMS3YARpKVhGQYYw_wo2rriljr5PvmXWKr4
 lMh3ZGveooxe9e9Z2.hJ6BTN2fmREM9L9Fu_b8UNMMynFc88dQR.dR.SC20osvF5bvq8olcjp60y
 PAluf5XzzGwxzBU4G.iLhGyYiW6xIOBWtW9bpPjIRpRT4BjbC46u1FmJM2X0eCVQvlTggBAIOuw2
 A20KZ0rDsEauC2UMfFVn7Mz_2qsMLSPIdlaLHxqmLsMSHU9GrQEfevsJPBOsW2M4nXovuvgbzz.U
 ZmDfEi_Q57etc3omT1KtzHE_IT6HBpZA0FaI.GWUO3MqH4GZ4..9QEWL80UBsFdW.hd2UwzXPFjE
 MJY24r6gqjp5ltaizPV2ZIS7oem6_O1TUhTS9iRFbXBPAlS8DCMFwb4fCABJODOdb8lhPCl6Ii4M
 VPnXTKSFtZFLLG46KH16RhYgtrAkurpA2.Y_tYHckgo488WgX6AWMx2xsIN6qr1HOC2ipFEu1cCH
 f3m01zJ1d4uEh7tjSpvGrBI7VEnuIvgfgTh2IhX_wiHbGadP.Rv9fFaXjmGpRdIBaqHd3ybLl1eL
 HFYg8GAS7TTxYqjdJnOxjl0Z_B3rFKAoZ9MGHNdRghztB0RnP_at7B1y3009ExzbkSGRWPazN1uU
 uvKkrRpDIi5kcZhx1VD0v3mww0NJ3gbE2x09UA45u_tGHLIvxH4xJLa6uoVbTb9UNuha0Qb5IlDj
 zAnTIvoGtoair8F.p42SjBDuwUvPqTdxgHIf96GPlyMQ5FEQSbPwOCdkjqRMBxHsmbfIafNhfRn4
 UzxfKeMhu9zfhTfjz6au8QpMzgHj0RYnZ6quR_LuD.DwIZc.9vcDzTkAuAXcyhh3j_eyjp0uI3Kq
 DrEnf9rSzg3YlvwkG3SEYF.mMQfh6yKmSk5j.JSlgqF9rQ7iLgQLi5XMK1uReB5CfzAisCZ6qJ_g
 EnK1AqwJ4tEkd4lvt4SEQaTjrKsnYONQVsrGlPunlO.ChZYaf79Ykvati2mF.FXS4vYyCBCjESC2
 VIqnHLwNPMioMRoMmN7.wJcqm5Rt8LqkXEXU2xgsZdj8rKH4pu7f6K2dlBlWHssYIwri2c8WGIcT
 Dpmdgk5IdWQucLZgBow--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b4706daa-b812-4422-bc60-b6b13952f91b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Dec 2025 21:01:56 +0000
Received: by hermes--production-gq1-54bf57fc64-zwq7b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7f93d536bde2a23dbcbe760c907f19be;
          Mon, 22 Dec 2025 21:01:51 +0000 (UTC)
Message-ID: <6c29c8ad-6aa8-4f50-98c8-81b363666ae8@schaufler-ca.com>
Date: Mon, 22 Dec 2025 13:01:48 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH] Cred: Remove unused set_security_override_from_ctx()
To: Paul Moore <paul@paul-moore.com>, David Howells <dhowells@redhat.com>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Serge Hallyn <serge@hallyn.com>
Cc: max.kellermann@ionos.com, LSM List
 <linux-security-module@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <15895666-464c-4349-9fb2-f24e10aac8c7.ref@schaufler-ca.com>
Content-Language: en-US
In-Reply-To: <15895666-464c-4349-9fb2-f24e10aac8c7.ref@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24866 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

The function set_security_override_from_ctx() has no in-tree callers
since 6.14. Remove it.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
kernel/cred.c | 23 -----------------------
1 file changed, 23 deletions(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index a6f686b30da1..12a7b1ce5131 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -620,29 +620,6 @@ int set_security_override(struct cred *new, u32 secid)
}
EXPORT_SYMBOL(set_security_override);
-/**
- * set_security_override_from_ctx - Set the security ID in a set of
credentials
- * @new: The credentials to alter
- * @secctx: The LSM security context to generate the security ID from.
- *
- * Set the LSM security ID in a set of credentials so that the subjective
- * security is overridden when an alternative set of credentials is
used. The
- * security ID is specified in string form as a security context to be
- * interpreted by the LSM.
- */
-int set_security_override_from_ctx(struct cred *new, const char *secctx)
-{
- u32 secid;
- int ret;
-
- ret = security_secctx_to_secid(secctx, strlen(secctx), &secid);
- if (ret < 0)
- return ret;
-
- return set_security_override(new, secid);
-}
-EXPORT_SYMBOL(set_security_override_from_ctx);
-
/**
* set_create_files_as - Set the LSM file create context in a set of
credentials
* @new: The credentials to alter



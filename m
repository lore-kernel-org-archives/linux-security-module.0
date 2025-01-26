Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E96F9476
	for <linux-security-module@vger.kernel.org>; Sun, 26 Jan 2025 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737913850; cv=none; b=ZYaFL3+U+YCcTUQV/eKRHwhLpSx7evCTvCJBE9lNi3qUds0TnvDVkIpBcUH0rRYl67/PEEWmEX3BWTa2PtYq3UGIIctSXkuUETCWDADlF2VFAjL/dizMk+2K5ptqCBqd4fP3Fa9nM43Q71xeqQ6JD1e9v9JWYTFdqWBn7AFihqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737913850; c=relaxed/simple;
	bh=GZMFbTeOoHA8xb1Y9meuNga2E1QKnY37oMJPuFhARp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usYQy8dT6jsowN3zpH/v96wv4fj8gSn54Tpfco5HvgNcE1o4V115ZHcYy/8B7mM0K/T4rGvT3xfh1ecU5tdb5NLr8L6G+PZVgfA+eiJuNQIbBAJd/dJ5+t9bI6EkhiGvgY3lOQ2g0+Di9htSAO2StsgrNx53Qu9cAo/dJri8Ur8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=bezNYAV2; arc=none smtp.client-ip=66.163.191.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bezNYAV2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737913841; bh=eInL92Y0BvY6Kfaz++XXd5Qjo9rnYHZS5cbviD7NpV4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=bezNYAV2F7PSktr/KPUbzY+3FYhK6A+As/uQHzDh494twArQZWpnhnXb8UXSCIk/GsCdzi4zFgJ8A5lWOIwnSMtqgIPdAlTKdvLDxwinK6o3RXeeY6KYnJRgtHjdC8mFCpxbJ6uMm6A9D+KUXlQFGtifaEgxBlZFBx9es0cQJCi5C6s4EQq7F0pdaTuDn8cEGmixRG2eT2/GsnCWKqa9SIaqWcT58EQZCJ4/u+bkzEgJm9dO4yQ1ZNbzBwOark02KJxwVGlowOOp6TuFkYbfKXEFDm4E/6CtxuC+AJYIcC+OcPptriBvCFvqMMmwPre4MaUu0l3e/AI7XQYdbVCVZw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737913841; bh=ytxbJabBAKQVw7DK39IZq9WWCkpk267RZYnPAr58nC1=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=d7bpYlwEiVWlJRKeehn4oRcaichn9WxLAi9dK0wBr8zbtC4GWo3Zh1dmXUPDeYmmH9xys61iDwTcTnysGsBXBl+RLGxHdPzlWOBPj/H/pL0PWI16SMQxyta+Mc1yryHu7TjvZHKD8/8ZDAB3kRTpe09W7s1/6i00wkSM7OE9ndh2ACT/e4yVwyy0fNlTu9Azsjg5HxTcwWpRENfYY6T55/AJt9PvmE0TyIxkpHNfn/rdZjerU+Q/2JSocb9n592VxpABymnvZ3eW/Q5JLXVlQf0PwXa3T56c3bkiTUW1zz4BKL3Sv2o45RQepUXTQR0OHY4vpN+Flq33/SJp0fdVqA==
X-YMail-OSG: kp6ZOt4VM1nLUSImpL73zxTyVXEtBUGdGttawEvteD5fkWq9jbfG_1ddv1zsKwN
 VdUXb2W43A97arhcJdjEhgyCLewSGsHEl2OF8Pg3IemDrbrOt7sQLglnLEDZyyVWkG3IfHl8n9AM
 a_p4_JYL8VQC12NFAH_FRTpihvZgyPI4mOgZ9xDX2kB593Ttb75nY0Gq0xVT37NbSLmAdAzGfgL2
 BP992G6Z.OHsydcoCxyQtdmDoExzWO1ybNsUwivDLCLGfguMpMXAihKSJNPlgvN.6iZYX2Z6V5SV
 pYy4tcOpeowVtYxMUCMSJqtGn6ViRg73HsiPjCmmvJeHJZqdy8lDg8swxGM.YYa.GEGb2BYuTo4t
 8e3fxoNhD_HYFrnzYuY5PiUhLRRQ7mRLbulO1eF_GufSi0JWywKGn0CGXVEcAZJGwj6RUPx455fk
 MxoD3WJVuPqdr_We3_EVnQDnQIjVws.rTZt8pgvo_s8QtAQucov6CuL8D8SNl31xCGdpsR41gYLh
 C8A9ZZF.Y5kAjVcm3Yj0Bm1F4FlzUuEbOC9UqCiN6nQ.lcFmHUq3e4DIpiaGr4xCoYF4kPBYdsCI
 KenGMI52_GBVLhtN00gUZUI_xx1OwYSseNnWerTR6jsSSp9ZWoi7vyRV.Ap7S_sYjHZHb9BA0cT4
 WA8C9l6nUx2cLyiS_LLz6ShL5B.hYwVBU_s2NPk8gQ6SupJNi2..TGo3WN0M6ttRvbpFKYY.P6F9
 awLrhz4Lg9ABbpEoGfW88Hj74aRegJ7x5msFUX0KRpyEVMgJG5kb8e3_jKBqB9USM5TZmVZQz0_U
 c_sM9Z6R47jvNqeXKIWycPMVaIiKQLyIml6o5h8rsZKaWMcgpyA0QZdGLvSGqYcpz.INznp_zhRs
 THNHkjSVxc058rdlLAu6TWDkmunVkq3.Xi2XpvAaHH0RJdVtfhdUsUW5Jqy_WLMW_5g66S8XSbtd
 nkvQmXV7uKSOmusMG9EtTmS48P7cIvoBGaGhNIjGPRiXFxk9G6s_p2_RqaTJx_19D7GZKR.UbQDc
 5OYSbBlKyUOJPqA9FE5O5vIu4VWg4y6jjANWbBx_1wr3Pblo9osfRNef3_62XUcBOvbslAM.cjka
 BZTmlbP5BQvCzeAtW4QC6jnAb0ou3jfTB0eTgSFmzic.n8cjGHtQUXaKVBpXAFp_pdKwefkwT8JU
 3OxidABrPI1md_Gvp4Zui5KoUMLFS6FfSrIIDDVrTGgtShqWzFwW_pGIZ_TIFtYMEe9Nl8RLcKlC
 BOClkjIo5AvzGVfrz4yixvXefLyi4aGjIkAHsUFubgXfveCLp73Q3j5VJChckKHc_GmUXziNZoeE
 x0vslAFKMIjcaxJdf.XMXKBiiP50CccwqgY2yF.ejQTpfc4LAdB9sSRKxgs3.tVSmqxxT9f3VlUa
 ejFTH3_Jh4Rfp39uLZf0HoMlhJjPMkuULdMWwe6XBhs_UlEhwc4qkWKnvs2AVL1ZXExONCCx7JUP
 Y3af_aOtean2kXkiZoiMX0wOQmwHSlAZREMTub1zZyt0qiwhn.gthd5tSm30RwO6ri5AjlOvz67a
 dIL9PFhOpVgOMob1kg9pRJ.T.vaDfxdzgmEFFthnOgRPZPX_72BNRZNrwq4VfJLSs2jRgp9bvjLN
 3In2KPQI9YHSokrXTvMsLNob6ya4LOseHpch98LCjGn13bPMxfO0qemuH.JS6zjqcy1p67kl7s1t
 91rn3PN20VVfn_zzfjdaGIquPWAYdgmFLRHNeuivHE2l6VFWqDGr8viygC9o4G7tTsiVRpokCVTU
 hJbPmObKQimk1c_L1VuOWWHkrmdCS8egcGI_EflBluLydNtR7E9fp5NkgZC9CBQ61JpomIV0XtLG
 1.5MFVpNfnz7I8FzqohM3pDPEfBcTO7udqv78JJgzOhfzniWcSsU1ArnOq5QyyeXCcyQhsxU2haK
 6gbjFJ6hkPu3va2AC3S1gjl3aRc0mkeXFTASssoKioCT._fhTAsDkPSokkQutXbrAlfG.FY962nw
 ViKpQqKhLzJTOmIMd5JA6L3oOMY0EWYrG3TN.c1WLffyaIaRc4yMh_ewMgVTLwOChtj09dPX9PnD
 R9pv7z._wqzvO_Ywsfa2Wfc4wl2P3xZAoF4TyHKvf8n2x0svzUIHVxDp1tS9F51KFPr0sJOSXuKM
 KstWEEdKY2bK1iRXn4hsSxLWUstLRQ3_KoXGG0jbbkftIBN4IOO5x48mePUIsgEJlWD3Vba9a.fa
 DoDJGbv84dhNGpEO0CnPvHx_ooA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e13b2798-032f-49de-8a6d-f33b4bd0e1c2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Sun, 26 Jan 2025 17:50:41 +0000
Received: by hermes--production-gq1-5dd4b47f46-dvwsq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1642d13a577dbf5cec573d6d6d6204dc;
          Sun, 26 Jan 2025 17:40:30 +0000 (UTC)
Message-ID: <c65ad1a3-64f7-4101-ac26-d72fbbbf85ee@schaufler-ca.com>
Date: Sun, 26 Jan 2025 09:40:28 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smack: dont compile ipv6 code unless ipv6 is configured
To: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250117163645.3069927-1-andreev@swemel.ru>
 <40046ce8-1117-47a7-80a3-650f7adb1ecc@schaufler-ca.com>
 <72077b25-4f5f-4a64-ae35-ee2fe72f49c7@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <72077b25-4f5f-4a64-ae35-ee2fe72f49c7@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/26/2025 6:15 AM, Konstantin Andreev wrote:
> Casey Schaufler, 21 Jan 2025:
>> On 1/17/2025 8:36 AM, Konstantin Andreev wrote:
>>> I want to be sure that ipv6-specific code
>>> is not compiled in kernel binaries
>>> if ipv6 is not configured.
>>
>> The IPv6 Smack support really ought to be replaced with an
>> implementation of CALIPSO, now that it is available. The
>> conditional compilations that already exist have drawn no
>> small amount of well founded criticism. I will most likely
>> take this patch, but if you want to be extremely helpful
>> you could have a shot at CALIPSO for Smack.
>
> Actually, I am sharing the changes
> I have made to SMACK along the way,
> during development of other feature.

Thank you for the work you're doing. I'm curious about your "other feature".

>
> IPv6 in Smack is in my waiting list,
> but not in a focus right now.

I appreciate any work you're putting into Smack.

> -- 
> Regards, Konstantin Andreev
>

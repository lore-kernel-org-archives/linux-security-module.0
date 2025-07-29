Received: from sonic.asd.mail.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C741714C588
	for <linux-security-module@vger.kernel.org>; Tue, 29 Jul 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800233; cv=none; b=X55BxiMPxG0WZVcU8Gt9w2p1Igd72myZhuN7nrZXzYOvBd+wbXzZwXqGkKgJiqGU8sm1PxMPZQlqR+IWU5jcENQNKxATS/I/yo8IMnIoib0Xtl2dY+51EEbLMowOg41sjnoEM8Cda8VHYvTLQLGJQKr1qN/Nrxm0SBCBFqq8UcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800233; c=relaxed/simple;
	bh=iTo3KXrECATeW+Q/tMWgpI1FyGPKBHEfmLF2GIQul9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G9r4Yi7n8CplSEB/Wmoc/4afWrJTJskTENM0ogrMmCXSvpnYsaxm4CT55v/5glvBAkw8+h8WMjifXBODvLpVCDpiAXZJSWO+Gnc207oLbTmT/h8TQ7M4KkEkLsA47fxt3FSDAHe1WykTGwPCacoeqbG8Ks1kMRdh0ZBpZbMnXpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=XBwJIDh+; arc=none smtp.client-ip=66.163.187.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XBwJIDh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753800224; bh=R+2Hb5QQsnwPYs+LSLMuPwc9rRMNcwquBS+dy2JrL00=; h=Date:Subject:To:References:From:In-Reply-To:From:Subject:Reply-To; b=XBwJIDh+zu3iBZRIC7p9/e9NXjaA8wR/YHG8d9P3KC02bLdRoYkL3vDPEKU0+cZzjr2DZ6zwMX61wurb/AClLH9lByhZKwDXd7NTTSvcjA+GhNe+A88pyVqteFJCA9DefHYqNA6N4Hxugg9gkzarLQT5FLlOnPLy4vw+bu3UEenewIJqbCebhoTCDLUqv1WP6MZTfy7pEpthL76fw+yuceOyoSk1PuNngEjrM5Lzs2x72pbeDHpz0dogav/UzhDpgdC5Mvi2UrkXovKKnyt+6i7p59UgRfTM6EJkSiYTR1MHZ/HqblEA5N9riOlYsSWUPeL1PIlRWYKCin6dKk4T/A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753800224; bh=/Mc7dM4J4NbYVSN/DiTkw6Ajc3J6/OvU8taCh7sYFAY=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=YVnpf9Rl5CPwX88ETN1sZN3PciH0tNBBQTEx5brwkMEu+4t0vJYEgoZaJw998y63f7NqV0pL88YRFLOzpUUsB1+j9gtXIlWflFTIqZbW9nOTF4XSKyd/Vs7qYI81/J0g9L2tyNzP12G4n0Owv1FpDBE+4OXNDpDWh+RDh0giD/3Cd1ZzmXycc4KVi8kY1XmI5xm5P/LzHSYd+dKsFu+RFzJmtkiEtw63EIVrRLKlHmsC4Lj5Swcq9N2JkcTOGlc+sHkhrld0SaX7+sdaHQQhLm9S/PkYo+0J1zMyHAwArWNl1rW7aLEFh42MaUY9WCAy7TivmJmBLDL79rLQlh3j/Q==
X-YMail-OSG: _7M..HIVM1nRoUZrg0GnVWy32sCZw5_XMxIcMq4qqeUHXS0a1IgzWvQo_6xdcQk
 hjiAuLB57cYrQsq15o9YAK5DjKQdqVvn8Dq2rEioqDc4OuhdESQpjTGjusycvPjFuneJBBc3FsPG
 ah87q_RlWjtUYAeXg0203wc9r87T0NQK6nA30IBosfRE1DzbVdzJv1.McXtdWnR56YiiR78NGsS8
 kh5.JQ7EHTo_UYYqDBeM5J_t_elncnxuXo7ygb5IPPDohUl7SR_6ZTEFmgezHciPaQqTX.6QtwWd
 nvpLD9mAcFe4SpXJ5cPWhWLzpsVUHZLjNW8l1mInewBvz9qd8qG1r_PkgN4qUvAupo125lw9IPuj
 shf1BDk3MzOqe_9DBRI.7m46RsponjbRzMcaZjRDuDP1cyVNMgG9xs0SjHV30ISJLKCYzb0y1jRQ
 gEs71JhHloMg_lpIMuOX65GWEF_w1k0iki06_ugrZMG3jq9XIhvecjpa39YZpNA5OdNahGuqOvE4
 myzrncIouiJs4xLsPDXRf._IOZ72F1JVzRxePLuiL7qdgyx5NzzaiCCJ4cXJSsUGr45.Xdi9eEcq
 0nK0mng6B5Xy45cW2jp3AafY_ZqV1tHTBHay2Fe58X96yEzOa8bfWkUfOLYpDjjLk1FGthF.fEHJ
 zYPfAhVj9OavrcIxWSW4OPuwQ3Zazk4uK.RXNxqCkFM0ar_IOmeTGbawIpKWx_IAlFAMBCFCaWNs
 0InnJzhJWp12WD3Il4XSGeiDrww1p5nQ9TIqNpBnTCP61jS253ZDCYLLRF3dQKcpZppGkT5FRT6v
 GyIZL8Atg57qo1RwqWIfI4aDJ.XG46b76ewjttuMQsjrtx_XksDWWTYmdEF4d4hljIEsjeiCi0gw
 wL8Exe7O..oNztUPAI33vdYssUYShcqDHi_6ZDxCHBuFTmgl_sLwRXgzsbBCWhYQKhcFIFlyz3VU
 e6iafCy8mSfmQXQ8ejMvzXfNESyQAg7fUc3XIP_Hnhgv2PsG3FSa9wn3D.L2H25NPOComsGlmtjg
 V4yQNw_bFaXERMytcWcGcmhXCQjvxM6EuAY5VTfNvdrl_N3Z1YdPCjcJuCwwWOKDu9U7JbDQfCsu
 61kDjPrRVcgBISt_d26L0Ea8ffePBipBq2nGBLhWDhV92uk9OFUIHYNm2bI9115JKc6cwudm5qGy
 v9REZ5HDuZ4Knv_vuRwCyphuA6wWb0bvUcBunR.m_CR3MPphS9H0kj._cVHK0c8LDSDRqg_0b1bp
 4Vi6k0pDHXAg3XgsqteGaWrt8ljnorr6H9x8dGS4YHPNw8T8TZmMbT3hQBffVGN0vldsJKKMupcQ
 aCjXdXSd9wSaodsVrYizvdDpjPqrN8mvqZc.1Eu_WhmQu5P9UkFFneVjF54PfWIT2gCsUcQqtGig
 IJAK3ckeTSMyzThVDpBmb4xSc3ZzZz.uhmyhSsX1SP45pEos4NOcNTv.pAmcCb5.9bqd_rnXILHt
 HCum_vLx5M2AWRpUf8AD.0E1ZDqf5gzVHcxjuF2cMX2kEltjekEWpPfzrHkpMsgeeiDEDpe6nf0S
 K4GZn5AB1e4Dsbcb1XkAvVq88Kh9bXsNN7kvJ8fvDGXQ9bi4zQ8JV2aqUjbGcqOrdxGy7X6hbJgJ
 zoad4v_5WZIfVxOMVboYib2SzoEo.yffz5USPbc6VWMfcsTKhYQA.Fj0Blsb0kSbk66dgfmXEjUt
 GnO8OGCMUYC6k.3eEX1dbyX6nn6hbdsrfvdOos5DhT.XGitZE5JLVjMB2.5vYhXplVYgW9T8y4Sp
 vjQWOCcKd26B34hedAjG5wY1cQo6YLqHqOL6oMuQ5skxAiZo8AJWhnu_BB.p1IJy5QhvWms97Hvr
 7l377UyMCnAHBwQJJPmVlTNeOk6Dr3EEoDnWYEwzbIiYLQXSRBjYDMbTswZ5dU1A7ntSOCxpdYIk
 LGoH3dKJKsqdU7rle.2R8M50o0sWMpysCbSJmC08VdmB3UZtSxKdqVGWtbVoYg9kyS.iBVZFWcil
 W_lxe8wRlOU5P5pb7Ej8cYpmG3U5eWKRPf0AgHZJ8qkKBYChkK3UWW4oyo5tw6ceA_S0s2P4Szcf
 A1cQgEbIA8wxGP3Is3Du9WOwAczWAdEoql3tYg.y4z2nWzb4hyc9FojhsHkRTW6O3d.9I.qOxfu1
 klxRXiFmOr6poOF1qaXMqEOG2y4yDnLOv5tH7NQWzCRJ9PYtnqx4j7oDQv757qyG18vIhiasRaPJ
 r63TkRPulsaJNOvXXMXBdMRGDoTDo6x7Jc_OVfeQ-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 7f4dfe97-1ef5-4ac3-950b-5115209fa6b4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 29 Jul 2025 14:43:44 +0000
Received: by hermes--production-gq1-74d64bb7d7-tqd77 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ba259b99096dcdb2c98c654fbdf1947a;
          Tue, 29 Jul 2025 14:43:41 +0000 (UTC)
Message-ID: <e81ba8e7-8938-4b76-ae7b-bfee6021aeac@schaufler-ca.com>
Date: Tue, 29 Jul 2025 07:43:39 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: simplify security_inode_copy_up_xattr()
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20250729090933.94942-1-tianjia.zhang@linux.alibaba.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250729090933.94942-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/29/2025 2:09 AM, Tianjia Zhang wrote:
> The implementation of function security_inode_copy_up_xattr can be
> simplified to directly call call_int_hook().
>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  security/security.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index 596d41818577..a5c2e5a8009f 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2774,13 +2774,7 @@ EXPORT_SYMBOL(security_inode_copy_up);
>   */
>  int security_inode_copy_up_xattr(struct dentry *src, const char *name)
>  {
> -	int rc;
> -
> -	rc = call_int_hook(inode_copy_up_xattr, src, name);
> -	if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
> -		return rc;
> -
> -	return LSM_RET_DEFAULT(inode_copy_up_xattr);
> +	return call_int_hook(inode_copy_up_xattr, src, name);

Both the existing code and the proposed change are incorrect.
If two LSMs supply the hook, and the first does not recognize
the attribute, the second, which might recognize the attribute,
will not be called. As SELinux and EVM both supply this hook
there may be a real problem here.

>  }
>  EXPORT_SYMBOL(security_inode_copy_up_xattr);
>  

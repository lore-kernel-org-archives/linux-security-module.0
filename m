Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA33B3C4565
	for <linux-security-module@vger.kernel.org>; Tue, 26 May 2026 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779833618; cv=none; b=bwPt/3i9bNXqBf+NO/NGBN8ZdC9GlpEZ1bIHcts1j2DngoCF6DN/dlvkFESG8accMhvgLP82X22O4uk131sGwrH/MjuyZSNweVf4uXoH5ZcbF2Pvj6byWYJIT5L3Qk5zwbtSbt01MWrrQLgCDmdOWp9JiJT/HhkZ3e9o1cy/efQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779833618; c=relaxed/simple;
	bh=IloGCfeach8B1WDMJz/cLVwJ093bp4iY+GKkflH2yfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/IlKEDswFMQGK2NZxEK/gqTsDv2cYoWKCJERyAlPOAuIOANak/3BDcgf8+a0ljezORqtcFF1NQq8MLBMNns16wbR6/knqCAaRsoUDv/UcH0HsqzmyU3WBsL5BmZkPSBW/9Ta9dA6H9e9Cms6GkS+6jwuh8Tl3aHxsWSRM5UfVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=BztkhTX/; arc=none smtp.client-ip=66.163.186.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BztkhTX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1779833615; bh=1iMWKtSBx65sr6SoovBvz9zeQmxFFziakSt+YPKOaP8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=BztkhTX/ttBRcQA+X8tMM9vQXJ7StqfSfqSY8jH9ZSQ5ArCTtUkps0Xrzp7o7nhwK1HG9A0N75ZVhjLj3dKa/XDkPy3qAn9DQjjyEQ1lvEIAmpcd8JMQ4w7t2dV+qiPRzlEs3rD4uomTNtrszQyRUSJZF4jrJgR3d4R5OEk8N5WBP6MjJ6p8kQKRBsZjbEq2Rejr45Ql/Z9X0kQEo20zOWW8+XpAPIyOLJqEI/USwdOfvRQQxgI1w6Y9eRrf1aGrotIkBXD1HyR1U5pnMl911zvX65yodnyfn1gvf7T1uFFZdldlMccqf9CFIz1mxykNYWZQObmZRmug+w6EDdq7dQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1779833615; bh=PGXbVzRYkTXBvC8OlPbznIQYr9tDRABDHDV4PqBRrbd=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=TjuIHXNDl2HM6HshuibTdYK+usTxmmc1hULNN6swePagVd9JF07ukD3iQ6I9/4z8asugjZduVGf7yoVCzT9vTnIp0XCcwENJX4qc2NU+Dn+gyJOixgWqIKHkBfufvHavkW2AWTD7CPkbMxfppbFFEnWmXzjQ8HlBYAwWmsHAb6407p2yH7o18nSxOexv77ocoR7Zg0hMZdYvTmmLZHbWGHpbqVS0SIf8GfcwY8Rndm7oY7PdTwayJ3duH1U0L9oYWS8fM8TPNK9Y1WlIoRSniq5L1yp1w4pfoEHmQXS1U+Ib6EyPpqyMWMJfizVDO/KJ9l4CBC34pz7EgtpR19RXUw==
X-YMail-OSG: 1eX0uowVM1nwf0yvaKjr.7tJzJGnqdXptcjpO42OcaeGKbR7buSJd3SNmRyn.mw
 6CdTxTNv9CC5z.eErm4dJqLb58j9fIs7t3.Eke6zged1m4Xwwl_zT9P6UGVXLlHSKCCzjAIltCH_
 T.PnSV1sqW.abEq5JcsosF8zrkLokLnDesCVva4DYyxeFFJRdr82VQnUDYguf6.wxX_LN2ZzTWIz
 bcx9CpgvJX289SyKR5BBFvLqSC5.Rodqimmg9X9FxA4rWFPFup3SK0Px_8C99WYb_VPkQY0HLUWq
 JCo9reyJhRmJSa25gUyqkOIQ6wbLc6c2QGbgV0SA70SS8JiVczsZnlUcGsxNwvI9n.uLv.jY5r.x
 6JFKZe1e6goVcd5zJTT3XTpoT2xTefpwsDaT_irlDrte_HZKqApildXnO4UOl.EIUmYVR3kBYcjt
 ZJn6L1twGlt8WP_7RPvXBMYXGVL7Q4BRrmNUrUWcT1MnQmVKXuLrSNIgb3snOdBxDRvW6sxv3Jo1
 Mig5K6Ppr4dLolQ8z4inqGiSBJR67aN0qcMAWR6hUR88MtXgx_anyeWugTFve62_N3Q.j4H8FYId
 sg2nt0OH46P.GAatE38icxiclYQFU4sAGpt_Y7SnF7VLdL6T_ds0CIZmr6BIS.eG4x5TXUy7a5ww
 sgdl0EFuSn900FAk7Hu9pyREuXIa9D0QEZKdYWnLPIvNuAgCoRbI6FcYxEGylTKaaEx5zPbwnrcr
 25jVKFv.tkz0jTgtCD0kR7cXN7w4s_i3qV3G9DHBhc7LwHdsWw46f9A7waYL3j4ZliC3iWNL_PIN
 0YNLhV1xs4Da1NgPPu1JiZb.xX0ZxxweRaFazCRgC8z5CO06vZQu6_a8aIPuzqUdLlRdUZLH3T2K
 N4IysE5qTySkxxlOSzdhEOFj9gsDLUNSil2PnxiUbK0eZPJSNAvQyMPqKKzi50mmmHOvzX_fKoLv
 OCh1n8Rjq1TFwtrKI1SamQlXxTSOSdVczKdBimqIbjnEL3VlJfDAxdxXWjx28QzOZn9pnYOnTPEv
 nqW.NhRlLPd92UPERRMWDg0X9pCew2WZn6hL6UjNd9E75e6_l845sNs00stUl8ny0pv2.pGRelqO
 Z78LNULOD0WAmPBcawpuHziJf8QQJx0XD0k2Gz5ULh5b.rxeA3kofGKv3Ks8mjX9Z4IS.LSF57BJ
 .Kafm0ngQRtDKBEC.sdjGunCk6cerG4gpiKvmLCh8LOb.w6.XDu.2R6l3KGzFGLuSAKuKoBlo0Pm
 6u.bSEdYElpl_m4z8Xi5dEAK0Hb5S5y7AUk.MLrKGl0wNgX8xwcb0NWJZajxgJEWtiXYsY7EJr99
 f1THBh3sUYs1jaTt.rUNN12CqjoRlPNwde1k97z_uN6_8UM7dX2ihedT2mhmzSsVpNhA1jEG0aBP
 2XD5.a9V4Daf2VyE7tCK08OJ25vBZti0FPpsUc7mPzIT0IaYi0dYP852Ho2S0KXIMWn5ieBEgKy6
 W6bDmSHUHkmDvm7Pg_4uBzOhIOXocq04yi4x3cf2_Y9FZKasl2hJg028uIM3eV0NcXdtHm8OI3PQ
 8sJ7yGErU_wRCzSJNFAIBFb_Wa_8dfhsM87z2cqLRlZ9Vl_TcR5stmBVEe8bLTcYVVBbkNsCh.nT
 OGr9CTGPmYgHfEtv_dRbXCjFBPTLN9GerqYoUXEw2eTNXxGpXRkmilyLhIzJZ.g0gp4wLHoKI0jj
 jual5_YsxOIuTqW8TU1rsVKPKjBTeNGpQOvK0MkuJ.govM8fTadY9EMUOPqEeDRtnckzl0zf0p.8
 oz7Z1OWYaqhCEVmsahwOm7AmcjYUo8Wel0CDk8Ux6pWeINVoB0qNs.cfKT8dflFnvxVk_ziF4sL0
 EEPJRkxu1_gehLVjxD3irv0EQTFD3Gi6SzHdipgEoRiJlx5NBaRNZExuxVev0is07_y4p7W.okbR
 lD1Y29n9JyyibyYja1nELtUIYzf.i7jVnEnqZWvgQWVzEgy0TZFFsq3DAzz_gZKahOlDueZxLK9f
 lAAZ3sdW_k6Eu1NePXxGtJ86BtvEkxVWncaM4gaHg_reFHMb_P.lRR4n28bMZk8eHhZENBy97tw8
 yAWOZ_B35ytslROGA4qdRtFD6pk.lHosKtRcMTTY9COWR6Fg.je9fczBxvrwEsemNu3Vu.BW96ji
 dHMyM1YD6z8VGLO0y1zzoes1XFNfYj8UY_W_9vpUiC3PvK7vikWGwO_jIEZ474y4o39xdjN9Yibg
 bMIsyCv6ZC_4sV3MsaUOdXGkT55fLJwH1.o6s6xRoMfTuO0WpA9t4V84ZDCsCY72z038yDA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 34057ad5-5c8e-43b5-a4fe-070b4da8715f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Tue, 26 May 2026 22:13:35 +0000
Received: by hermes--production-gq1-7bb7df5c46-g87s2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fd6d342a07456e03a179e9850b20e41e;
          Tue, 26 May 2026 21:52:55 +0000 (UTC)
Message-ID: <7c530346-1c0f-4818-85c3-4c3262d36a49@schaufler-ca.com>
Date: Tue, 26 May 2026 14:52:53 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] security: smack: fix spelling mistake
To: fffsqian@163.com, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Qingshuang Fu <fuqingshuang@kylinos.cn>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20260526013834.399816-1-fffsqian@163.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20260526013834.399816-1-fffsqian@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/25/2026 6:38 PM, fffsqian@163.com wrote:
> From: Qingshuang Fu <fuqingshuang@kylinos.cn>
>
> Fix misspelling: overriden → overridden
>
> Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>

Thank you. I will be taking this in the Smack tree.

>
> Changes since v1:
> - Split original single patch into two standalone patches,
>   separate AppArmor and Smack changes for different maintainer trees.
> ---
>  security/smack/smackfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
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

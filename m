Received: from sonic307-16.consmr.mail.ne1.yahoo.com (sonic307-16.consmr.mail.ne1.yahoo.com [66.163.190.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1111D5173
	for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 23:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741822386; cv=none; b=qLbxWWpA35k0wXdOcdM+4OXsLr/FCkr1dguMHQRS6NKW9PYMQ68sgA+EgqRrPeztDZv8IvPY+evtZTqGrGOvUhab/ZECRo2aOieVkei+6RzkUukT3t1+ihfoUj+MSZh7V9eQvIln0vN65ky+HJuiNBZcwl9MZca9m9DtpvSUbcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741822386; c=relaxed/simple;
	bh=vT6PAURo4MNN0PEl7mxHirVrCIwv91xowfPOi+urB3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8cRaCcPHIi8NiH81L/b75x7o+qk1jBxP+PlABwPoEY8gV4S7cvy/XPRxCsVZyVdARpwZIHtxVakIdTEPyn19fxqbdd0uPvTyKgkjZrcC+Kszqu9sLa3KHY7k7uxKikLEr/8pFNGuLut9eKmXMFgOT65kWvYT9k5vAi29sZO9yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=MB2c+fpz; arc=none smtp.client-ip=66.163.190.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MB2c+fpz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741822383; bh=GksvniJbV2RDtt/B/FzhP1sVZRmoi2tuT6NLJdfZJFE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=MB2c+fpzRu94tPvrqbuzkPUN5nnAgxcm3Lwbfv49D4bCL8G5zHO/tv45eHgM9hHznvGVzHQvTYNNQDiuOGk4mMNB8DYCksxz10WjMG4mztq341qWDEkxstWMJNW7qitLmwo1dtCIMlVfNHfh6Kq8Tl+YlYQMKVEjwKlCapa2gH1D6g9c3N4O9qi1KOr+FEQcHa/r2GHXqFLoqco2OrBskLc5XElZbPE3QAnXkIg0sml3GYM2JrMGRZOE7HZJiHVdDJohNOYw6iEqphqZUJMKW/NtMuu8OAkY+1pA1f7bUOkEkcaSWTFjw5jXrN/zSFFIw/1tl7KZUSV5eqKjUewE9A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741822383; bh=Xk/LwEfnl1UYfWOkcO6Oa7Orog5y/sfHDPGVyZQd1xB=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=VBulqZTpH+wOrywT3vjnDVZuZxUOtCIEBj3I7j2ibh3ph1G1XEQs8iDQz94rzlB6NeiTkm27y97laGGq4fUV2E6egeczbDo0XUbBdCrgUByQ95m9noTiXWfXTDIRx3oCJ7mCLHV4I58VTRyEbFcWIBP6j18ASPsMTizjoRBOyfZi427GjCK5I9/qwBlMbmgTxsJy7LkdHbYSEuzToXlSNkSRNux0LqAJYaL9QFT/i8Bd03ExOZyy4FqrHtb6NJJ3Xei71blDYi53813AOwcYdYFUR9yn6TgSNwf/6owe3mLsuuTNuyGYUTLkKkBMUDG8NPIQsdL90+wg9zZq4+yNLg==
X-YMail-OSG: CblqW54VM1mlJoZ1Vh_N7qHqJXDbZX4uGEHXP1NHJeEbB4MozVPfLB92ulLKVaz
 mIh26SA02syEWkisYf_rAu.UGSdmizh9PqVHTSqJZ5n5b.uWLFaxtjTv1EmJHiIqUfAIixCm1Y1U
 4LBp2MprB.UmA3ykYS.Fnkv6qAN_asM9FI60U8i0I2jeI2ceY4ldVMFo3mQFpwAoa3sl7wvxvJWX
 B41lf6w4xqGPLI6jf5KO.MktqaxW5wCHr323_nCNDIK80oYdiXq2rIXa9YGrtWg46VjNsYdjIguy
 kV85u0PcaTR2SVfBiiMEbvWHrvMDMrmmsFHSDKqVYnQs12RZnPUn0V7hvY6hgHKx2WD9xw1Gynb4
 wewbA30H7DCS15wzS3BIMaBmRAE0AX6WWmqsEA3Sbu8xyqj88qdBbIHn_i31b9lSq9qaOwtUcYnV
 GIslh4Mvabafz6Egik7YpiFdlXKdv4DhxtPSJE5wTqORlpRXM4NSqNebnp5QF.Tmyx95IqJxhepg
 Q10nm9b21_3zMMXdysiu3foRYCPoanoaPHfEhfcHauIVqpczR.WCcnYX4_Ybvw8d5qY8afipeuYU
 ECq_BmnQCmIS3u7te.7LvNOsxMSNrZ3FjDKf2GZTH_XG_jq7bPExa4tC0iMWApXRwUxHBpp3aE9e
 BZ4YEZiFh1WcpAPLjIjHRsFU9VvMz9JOuRDTj1sdo_qLALScOOMDeSr3gr1CLXHqo8diJbQ4p5xX
 vOy7sWjLIJ2QcL7pTs7B_G6jt_vLb_Fnnzh9U_QjP2V__uzhPfPsmkfDteF2mnhJPhG35TaDArgU
 _bvRCrHIY1iFeVjXa.WxKngFNV5whESnWOpTAaJ8D2xiIU91MHH5oIc.wjaSXRHtAuTcbG_J9kcM
 AA6jp8KiQ8l11PoYyh6Cyzae9mH6vMODdRaqAJ9W.IlYyeeqQPYTyT5ORcxg0_ZqvdfolJMBjDJB
 BJsvYfvWEtY.z4pcPGfhg32wiZ92WoShH1CRuGMraQ21M6fR01DSVTTnlpmqAHsZxUdw4hgTLjbG
 tDeES_ijWOMIpi6.55cWQ.pP1LbOLBnWInQ27fZVypXJ2OWVXTU7ku09mD0kKJeIRSqUdW.IrR2a
 odyV_GMwBoTXtaSm3D.7JWTviROUQwsovdIvJ_2TR1sbsR6Ei3uAVCsFfwwzPdNj52hAOwBXdJ2j
 IjmG.tsoOh17XMJCF4Dcg5LBlzFI9.VJT08AQ0csf0z22Fj9TeUWdAt2TpHcOoa9WdADbEbMuCW3
 AukpgJLGpRBY_eAARMVdjRUFYK8UOTdB6NvebCSWCEQ0NR1cZxacue64Dhf5RoXZ3YIiO9XCsPHO
 H0oWDI9CqHjf5gzE5sElKEps9wZW_fX12ouiK4f.4MfMBgSqr11R2fgdEkQSvnqAudSSmxkFYYgU
 67n_uQY5NHui2cnblL_Tj6I.K_zjrclJ03v5abj92m8w1DjFD6ak2b5ovrTUAuZZ7Ta2.ME7sK.Y
 b5eCiLtaPnhxOrCzGf8lY5x9Nnq2icnVWbAvGeXSyWdMYK1z4K6o3d1eSw147sbAjot_ejG42oEN
 8rQzvrsXWGrdD6R9Mil.jof5EPzwP.cWceS8EPinRzMQAaQCk0LknjFtUZjffWrAV87MJpeN2yP_
 v2A7YbHQH.NQgHMcSjGy3iWmRemiZrqBZpLoyHVs2trWFRcdmkQNiprbF3HRqjlMf3lo6mOFVSPt
 bLuBCXGG6g0QOyGI7pyIxYzHgCnRqELF8ZeRI.t.3lb.2BXDa8zLKxCCZVNYcDXwGMPLzZ7c0hkx
 fCAe_ZkXralxcDehrf5lUbbXa9zkfH_a5w21MJMdgLiBSWNr3znVhM3GrjOC.WVa.HELylfUXvYB
 9AyqZ4.G.jxGQNBHq2lnhClOgK9_KOYbcJ5C7fA51vUHzzHvaWtbDO.a.RsfdtJyE6ySbvIO02W.
 VIONzjVQ6rQRHgRkGKMbUNncJBK3e9vkuT9o05LBh11DY8aGupVBxf.6w8hhjwqUuHBJv0gjU9xz
 P04sluQIUpezYH3PWBj3biyCSbzTYyXJcmBGeTS1yl1bImyNQQy2KSWBSAgvYFDr1_YJm1ys3RIv
 C0.GCqHvJW0pOfNWWfGPp25oer3S.N_mmXXJRhvPgQq_18zMOVeaYhbboujD3jfrqkJQzXdbGCv1
 Guzi3LIISknIt5_h6eIF5r5iAw7xnnv3uySgEtu_.ijM29O2KT03RsNAp397Sp6.2IaJ82iYVzVg
 TzjME8302.mLWNOzdzcve5RnKghz6EGnwcHp4YNwhhDNJA9LeWQOPT90Nbm.g1xYC99ipjnuArJC
 WDF1VToI-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c231de60-f6ae-47b3-b766-6c39b1353092
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Mar 2025 23:33:03 +0000
Received: by hermes--production-gq1-7d5f4447dd-n5sg2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fae0248b384e80f26af981590c55b4fe;
          Wed, 12 Mar 2025 23:12:44 +0000 (UTC)
Message-ID: <fdf0e86a-5ba3-4d28-8c63-b2019af009f1@schaufler-ca.com>
Date: Wed, 12 Mar 2025 16:12:42 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/6] smack: explicitly skip mediation of O_PATH file
 descriptors
To: Ryan Lee <ryan.lee@canonical.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250312212148.274205-1-ryan.lee@canonical.com>
 <20250312212148.274205-6-ryan.lee@canonical.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250312212148.274205-6-ryan.lee@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23435 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/12/2025 2:21 PM, Ryan Lee wrote:
> Now that O_PATH fds are being passed to the file_open hook,
> unconditionally skip mediation of them to preserve existing behavior.
>
> Signed-off-by: Ryan Lee <ryan.lee@canonical.com>
> ---
>  security/smack/smack_lsm.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 2f65eb392bc0..c05e223bfb33 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -2062,6 +2062,10 @@ static int smack_file_open(struct file *file)
>  	struct smk_audit_info ad;
>  	int rc;
>  
> +	/* Preserve the behavior of O_PATH fd creation not being mediated */

In Smack the single line comment is discouraged. Please use

+	/*
+	 * Preserve the behavior of O_PATH fd creation not being mediated
+	 */

> +	if (file->f_flags & O_PATH)
> +		return 0;
> +
>  	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PATH);
>  	smk_ad_setfield_u_fs_path(&ad, file->f_path);
>  	rc = smk_tskacc(tsp, smk_of_inode(inode), MAY_READ, &ad);

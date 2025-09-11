Received: from sonic313-14.consmr.mail.ne1.yahoo.com (sonic313-14.consmr.mail.ne1.yahoo.com [66.163.185.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4764C2206A9
	for <linux-security-module@vger.kernel.org>; Thu, 11 Sep 2025 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602869; cv=none; b=uRFec3V7887W31BP7uiOF88mh4FrtmyqjTQoIj7GVe+Yyef86gof0+BlX73vZgiU4H0NrcyORPty9UObZJRZ7UA7gjjh1jL1f9atIOouAJeLelb9zqKiEkTOJfLWLRetvi4golJFH5be5Mo/91b4LVclq3R6jrBZBbVuytaT7w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602869; c=relaxed/simple;
	bh=QZEsoQGOsjlnmtFhMbREm0kY3s6DmitEWkyCWliE/20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/UmFqN9QMs6kqehSD4xmCQODzXdu2XGjrNhQlm12eyCwtzn7dILlAzb47btO4JcCFZ0MMsF5m6plpeRPWHimV5X5MGx99smB1dMPZ9XtyjUWeAxN2yutQcMWhOFMD+wUPpaVFlKkLprs1beYym5mMRpaoPEXBjphobLTXleMZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=lCrz45r+; arc=none smtp.client-ip=66.163.185.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lCrz45r+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757602866; bh=fi1iR/ffwue1j7XSq0mm/oJJFZ+PjkggwgXdeE39wKY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=lCrz45r+2+ud+IiRVNphqWKTzmx+UxO2zC7CdjKWvHNvxul9TJyIhWZ5kyiuNFwxwYsPVpL/6pJBZzIysOXiJTBtU+AyuJs/XnENLjnwne2YcNRD0Y75wfMiv1a41/2IX4/HsEhPH7dVYipqWTWD7T8bPbw/xrWp9wKRKSD5psRqv9SI6ADqkozFlCN5XLIGYZW+17NHhRDYZ1QqsdSR518vYh15Z9UrlJqAqO2rpkr1Rb3+0czwINZs2tegR9VO9t6n07OsJyU0uRbvZWNIm8kjQamE45PTHdkpC3/DUlCqr+dn1NQsWn30S06XwLQR5ODfFM1DP7f6DST4Jbi1FQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757602866; bh=YVcaFXV6F5wQE9fdh3yZTlxWtuz12Fp+YJqDNPL+O25=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=b8CQcc25RbTeCV2tYX5MYv7sFdxW+lAIIrE2uHzs61x8U6p6lrdGRyPZngop0a+10lzcwiOsanc/uukBtgqg4r81nMpBWB5UQ90s6gUKkFCf6dup+TtrcHKiB7DHMISLbdmE+Inq1BsChYjIA1bSAqT20Ms9OVqzRauJNF5e4cY0HBg0Vmzu4tcZ6VU8LBTQvxL/UjWNQLTuJLaayRFzljpomdYjFz53T7bNCPpMOxt99eA7UBQAdr3wRfY5sP5YOwyFD8BPjExSSeiB2X5uIXD1Xph9VfS9/zfktc3wwHR/lQNXh1wlCN73s8mL5y2wZA80/yKEjVBGTBzZktxuMg==
X-YMail-OSG: uvtzMIEVM1mYKua3wHcR8tNlnmqyKJFs0xAlwhlkbxnQ2oYzqkkgRAcHgM850SX
 zQpyOPPue.XUntpfl.MB2RzusguquWYun06BkvmVk1_8p64fM0CZAb2SVqrlrWVXzQyph_bSggPA
 9QBj1HC8JaZI6wCVKo.eqbMp1K_.dLM..q2lMgG_fwfzQi9f1WZEY7uf0M6XZkJAejMbOu27KQH7
 beRiv2np6XhxM6ibrXTQgohhcQWJE_8nDB3g.eAW3j873ZmcgT92D8alW.Ng65Bh6EPQBhZAMaHR
 J6jhg5lpMtX0lTxjX41pTfy7bnqgAmRn0HFy48tvCBTiFAIhRmiqtmoG.h5Qo83JD9hsU8Joxo2_
 d_lbOGCLlUSxwZDmhm7HR7lhdn2eBGua35P7vqnwxpmtxcna0QXS6yyBIQOxxSHnCs6yZ0jL2Bk4
 XiADytd65UkTdJeovs6mFCZZPE1Xrj5ltZSfwqQ0ZgVZbgemNc9WEyKBSSWYVXuFJDtJ69FTklCQ
 XQ.xUP_q60hzH8vCx5dcAwV.FkXCCjUOz38Q3SJBuxrnPGHej09.vKMr8xA4aPCg1nAu..LXeVra
 R0rQp1hzze8D3HYaS122tsGvE.wAsi0KjDE6BcYL.mBYy_uWIGBZ7tEqSceyjT_28Tvgel54pMCy
 AkIWIdLrszvhatx9HIDekmuLK0HV3XG.P1KP_6VHHtILDvu3ENateTyAG0TGKsEddaO7SKqwxJZ4
 5YIhCJuT3XULTZ0XCg5tJR7AcXSxvTWJilZoMhZKpdSv2ibt4trQqUkNjIP4ui2UDn7_RiA4Gjuv
 GZcjKxVSVedG0Upw7LccWcmDIDJOrwsUaSeiD2Mb.A2W1.6XnnMxq8y6YwtNhK5de1NvSpvdIUcD
 n_KIGqq7.fWuL47w0Wb6mzqGt4zbRUpytHwfIKbrZ7ImTj4n2J4wgpy3Ep6vuimwrZ2ZAP8OeOXG
 AQPMntS2R6wR7slA0nV5gaFEibQz9K80wpTTDJ6Z7XSHI67YorL34FgbVT3Kd5KP1JDMkQpntPsF
 yoCTF03Ffh1Dd6AfTK_f2wwmNCkOE.d4HzFVP_Qe00j8GQATNkYLw.A2bd2z1IPEuH_1v_XyyTB7
 AGlKj8OFkJMv8B3AvW7096DK8pvEr45bJ5JCyGJ7CS8QJ4Bux7PLmJx64fUJYB.72LqzlOz0fcK6
 wixI03KqayIsVLov30AGikjkUcKTx3q4Z8dzI85.yPDfIihKOPfMNMEHghLZ7LT6VpUOopY9rDog
 1c7zkSs_cOlBomeWrHQYJJKfu8y5UfQCURLYHNYBt.nuWlakevkbNmG.nKYD04T7e_olLXhtcs8A
 wGgdunC8MOdjDuSjYhxmKZZsKTHZMN4igRlZ4gF9EDt2Og.ZERD7qtSSybovyPBBMfIsd5zJd41_
 ao7LRM3B8tGpHBYPtPPP7S1jwU17GmDDgzo3FXHCg4BMOEh3G3iAcKCcOpCLylD7KN4nRumGoM.q
 p84uP5ycmyhR.M66CkR9iUZTewmq2Iw36PfhkNgKqny6I6cRbBXq9ppM9OZTiCvX4.Wb4bFvEx53
 xkyjmuX0Gdh4sSsP78CdK9aP_5F0FhMV3Iz5wxbFy9qv7xsAvX3oFTDSLanbRal4r54tG06lBHrZ
 QbemUqJ6rmPKstzTqnPOdQpP5bIQLXMwiixVeO8ahyLDleDSTHcCqszlZvqDb4Wa.H6W.XrpgOJF
 sUS.EBXohEfXNIBdrALPiXCgKrQFgg_pVs5aHRFG7KYvme.JSRlxcs5.4b64wUkhfXj6Nzo.C8SZ
 WOtLgaCIzS86wwq4HXBqDgxB1UFU0_7.zzsxmsZuQ4PpHbiCUokvGFcyZ6ucXzAVYxcZQ7Nq4T3Z
 uAw2X.ODwYPgwRjEbuxc50QFIfR2B6qfox_wR5Q6LLi6ps4UquZjcK4fru0j0BxzlJhYBQK5T2aZ
 EKTnFR9VC5_shi7F4EOsDoMiswMUa8dJ2GKTiGs_821XAM43KS5wcbQUws7fCbni4ac6BHQDPels
 GN0XnqS7cfL.OucrEe5E4hw8yz3KWpXYsRSF.GAOpzhw.opMGTEdFXQWCO0IfeZ2ZB8qOz6cZJZO
 Jx9W6I24_ryZ4JEr8rs0a0nbz5JoL4GZ8JC43Y4xuCWrcTcPepyR1hQxUNQywKzBw1OiERMMJC2H
 .6CYhrXMkG68jB136X7ET2dKH6HX4.9BoCTetw3v8URKTn1Canq90vGIa4k2K37yfqjxhQ_er6aw
 SGzIOuIflOj4y8KJEfo4OBUZJKvBJNGvNL1cr322KxfGBFAHkgCjckseX7BNIyy_BMMjhJPnNcVw
 fBa7iUz1W_NmVPCH5ZMY-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3563e2cd-f754-4dcf-a41d-578910d893ab
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 11 Sep 2025 15:01:06 +0000
Received: by hermes--production-gq1-7bfc77444d-5m7lw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5829aeeacd8ee07d1aad2898c78498f3;
          Thu, 11 Sep 2025 14:30:43 +0000 (UTC)
Message-ID: <66295710-bb13-45e9-a87f-98b8aa6aa86a@schaufler-ca.com>
Date: Thu, 11 Sep 2025 07:30:41 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] security_dentry_init_security(): constify qstr
 argument
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
 neil@brown.name, linux-security-module@vger.kernel.org, dhowells@redhat.com,
 linkinjeon@kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20250911050149.GW31600@ZenIV>
 <20250911050534.3116491-1-viro@zeniv.linux.org.uk>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250911050534.3116491-1-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24425 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/10/2025 10:05 PM, Al Viro wrote:
> Nothing outside of fs/dcache.c has any business modifying
> dentry names; passing &dentry->d_name as an argument should
> have that argument declared as a const pointer.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

For the Smack bit:

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/lsm_hook_defs.h | 2 +-
>  include/linux/security.h      | 4 ++--
>  security/security.c           | 2 +-
>  security/selinux/hooks.c      | 2 +-
>  security/smack/smack_lsm.c    | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index fd11fffdd3c3..aa4d6ec9c98b 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -85,7 +85,7 @@ LSM_HOOK(int, -EOPNOTSUPP, dentry_init_security, struct dentry *dentry,
>  	 int mode, const struct qstr *name, const char **xattr_name,
>  	 struct lsm_context *cp)
>  LSM_HOOK(int, 0, dentry_create_files_as, struct dentry *dentry, int mode,
> -	 struct qstr *name, const struct cred *old, struct cred *new)
> +	 const struct qstr *name, const struct cred *old, struct cred *new)
>  
>  #ifdef CONFIG_SECURITY_PATH
>  LSM_HOOK(int, 0, path_unlink, const struct path *dir, struct dentry *dentry)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 521bcb5b9717..3f694d3ebd70 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -391,7 +391,7 @@ int security_dentry_init_security(struct dentry *dentry, int mode,
>  				  const char **xattr_name,
>  				  struct lsm_context *lsmcxt);
>  int security_dentry_create_files_as(struct dentry *dentry, int mode,
> -					struct qstr *name,
> +					const struct qstr *name,
>  					const struct cred *old,
>  					struct cred *new);
>  int security_path_notify(const struct path *path, u64 mask,
> @@ -871,7 +871,7 @@ static inline int security_dentry_init_security(struct dentry *dentry,
>  }
>  
>  static inline int security_dentry_create_files_as(struct dentry *dentry,
> -						  int mode, struct qstr *name,
> +						  int mode, const struct qstr *name,
>  						  const struct cred *old,
>  						  struct cred *new)
>  {
> diff --git a/security/security.c b/security/security.c
> index ad163f06bf7a..db2d75be87cc 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1775,7 +1775,7 @@ EXPORT_SYMBOL(security_dentry_init_security);
>   * Return: Returns 0 on success, error on failure.
>   */
>  int security_dentry_create_files_as(struct dentry *dentry, int mode,
> -				    struct qstr *name,
> +				    const struct qstr *name,
>  				    const struct cred *old, struct cred *new)
>  {
>  	return call_int_hook(dentry_create_files_as, dentry, mode,
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c95a5874bf7d..58ce49954206 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2901,7 +2901,7 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
>  }
>  
>  static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
> -					  struct qstr *name,
> +					  const struct qstr *name,
>  					  const struct cred *old,
>  					  struct cred *new)
>  {
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index fc340a6f0dde..5caa372ffbf3 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4908,7 +4908,7 @@ static int smack_inode_copy_up_xattr(struct dentry *src, const char *name)
>  }
>  
>  static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
> -					struct qstr *name,
> +					const struct qstr *name,
>  					const struct cred *old,
>  					struct cred *new)
>  {

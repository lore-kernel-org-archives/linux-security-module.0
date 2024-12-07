Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D3A3FF1
	for <linux-security-module@vger.kernel.org>; Sat,  7 Dec 2024 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733595492; cv=none; b=hYpPp82rqdY09FDXWrHYYg6ZZhsUenIhP0G72v1g+eYzf9L+ATwf31Pgk4iiOIVsdbYs5YyvBNxLNA8eGl5BlM8lmTAnwgC+xyZ90EoDsjgNfjRLW4qM+Y2yneOJaIJtCuvl9ViZTkkTu/dXVT5Y5SXekQlQeDZA4ZNDAQihRvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733595492; c=relaxed/simple;
	bh=snbAjhgxaWiABrSRaultHPvRtVHf0+/ZBYnxqhk0Beg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mFmrrb8aIfwRnHB+w7t5jpWWC3pr3Thi3ye7VoW7XApLSyo7u5fIzLB+mMeoAysVk+fWgb8KaZZVUXcpVdowLSnfYOHg55vVBRUpAE4p11aJ3enB7VY5RQ5JbItCT58a0e4QXdjT6Wrk8wHY8AMli7nymKCH5P1YH1C03jZA6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=hEqhgFgL; arc=none smtp.client-ip=66.163.190.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hEqhgFgL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1733595489; bh=lYT8ZYPac4TXGPGKZFrFnH+tpMl7kC2we33bV5cLXnU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=hEqhgFgLMl7JiaBoTuvYoA/+HbhURHqYAcqmNDAtVbuO6Th2JxC6b7rQ4Fx3J0cLvmZRzos9EloszWZkqxnSgKiFqwUVhDd7u83oikz+9kxmpK4ktu7JEDVt4PcuZOxDFfyvyD0fEqhUNA5PBGi1+1gixSzfNCIJeIMay53ipb4V3obFAG8c8ll8uXsCn1K2rdZw9S8VMxx5F8YtaXht0sXOmo/6y1EvTjixlgRc5GaKRX3VFv8a7xsKBNhq94vthZgIUNJ3uQ31TlZbAptzR2+wZdfUI3bIQ7hnS+E3XC1q/eympRnwi7eRcCFn8BwxbCJcAgh/J/6RukKnkO7owA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1733595489; bh=xfgDy00Z2esM88ReixNKJKHctP3zLeHr5pPHrqJ29K3=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=lgUy7H0s/oAh8uHjitQ6UyhqLsqXIVq4iukhHTQlo3uSsltZlFsbV9Z3qfDYtfFM2xsgpbIJxKcnhng8aMPXHWLQWTMVXD1WliyLKo3LLdVmKrcJFhzMf8J6EDT8xxUIJRpRufd36WIbm6NmeE95u+CXSAZe9nMy+wWRdlxgBeu4v5RK5kwTp6mhA1fyRexgvrqrZAUfwIbRGtyZ1dkajqJgqnrcySabx8zOcvHLD3e43aU07XFR5Tn0LOPjClqVRfQHba/820FjB+U0sir83dFY6rp4iy02UAt/DjnlUg9d5ggIatGyfQ1P90+0Qh9groF0t/PuYwelZEyQ3oWpOg==
X-YMail-OSG: BuGkjrsVM1nbIj0p0CWtudOCeQqh74mpiblKahIWiSIt8qBOKB3lQQfmfzU6jcg
 OfZm6ltBumuxK0L4VrLLmqrXNbecXxrDttXT.Cdy4_yr8ThkResuhuSoKl2a4V.w3mL1RzUAo3ib
 pVcQoDmGiDGN70Mv47Npp2K_JDQQoVp9RkrHizv7cxQF7Mxt1vlhj7Ty8koVmva9y4GD.sBdS2Av
 uCotiROb2BHhv0uU5jIobsPATWGkm8ggd_Rf4dBaXHfXQ8_VX4RqUWS7ZmbhkAC1gbycnEjXN5x8
 .VlrY47k2t6L5CdrmrnFBgE._P4_Rzzx_GW0rgqyqk4_rADk7boY8WkLlnGPXPPClQGKjMZynmqB
 477XlX4xrAmn5AZ.Kl93NiD5VYBbi6DxZRbVdrhBTHCWKchOUSPunJSrnCVNviJqXLlqyLK7SPhx
 G52Qij1i6wSmC0EhCpiDiBOYxq.pPw7Cwjk_gL3IDwCzlhvrzkSy668ZZjJLuARYOR52.TWc2AFO
 jQeLgRcEmsZAGEJ5y_JTK3bS5fB4pjyid4e2eEBdwM2jkiZCuYvnRV9yrNedZL_CIbPjEhGH1642
 4WIuxC1SWDaCYjmTlQKFnrWmVkmRX2YYBDTEIuECHKWeG7GqvtIPdUgYPXKuP7sZ5g8prMHsjCYF
 RD8gf5PKn45W9l5fEcyG0WzKTOqJLy2ItXQVyLJdM2nICLuk8t1zSfaqmzM7Fc9ABnQIUaQh_zyY
 jizOO5SfohAHJUcM3S_8hH7iKeODN5yIkJq0.oncVOC1O5kPlBnJjUPYzlDSMVkSzehDByyIqU26
 uFj6hVBOfJXlAJP3VORnCTnI.L2pf365.leYe2zS5BkX6ihEl6dMucDMM8E3oFgaikHwXQTXFE99
 esYjBRgGu55k9BSDJFPTxOItcaom7yOu1l2nKTWWS.egWqOs5WPrKWmrS9HgLISFtGCJJ2x7ZYVF
 J5mQ3EZk_XoO1RH148YY.Lbzmn924VNhktpKdGBQCuZETP6uzS6QdT68m5zNwhoWODXbjZIYN.Oz
 KL57xepP8btLzLqtvxDEzW90saWMWnxLcuazRnjJbDaXkcFuNOIP93qKtUkD26iVnHkyhQESzEAd
 4UCmfwy6wlNr_cjqPgCM3cQi0kXERANqp.43HhmX8ZeJWHk6xaHE0Mc7z7SgXFpWJiVbmRq4UulI
 ZaTBKbef33FxL_2BrVKDYG1BHBimNHhpQxyDzYVL30cnTC7cHiGzdTLhb1yx46q2449U3l9trODi
 xuiEIVt3jgP37kxbSriRAZphzhHhFLjZDK.__IbwTYuM2j7BM3APuzfcU_x5d2pbcxfNmp7fW5di
 N5ePzp8.G2mOBA8XJ5d84Pk477kdygJBvKd8V0tDTqjqvoSh5QL_c3fU34ShFer1gWkA6pjvEoUt
 vt8G5_ZkRVn8bQlwIzNms6LrhQIOmydjdVkj2g6Q1p7p.r.m40f3PLPx_vKyOqf15Fq1mqcP4nwf
 J.KBPAsgMjakAY6DQSiYEY7F4DQnAsTRkV9iD7wyDmUSiUzht55HPwqr35kng5sBsOfI72S.rr6m
 aqCCiJumMYzuNqDUeZzCxLwOUG4rHS7zZroQ286ucJfLx887TD2lc8ibWVavPIBdqVbvnqY8P2ey
 NG8Zpqnej3yIOvbUPHk5tQK_s5OlNhvhRMwQXCh_vwvNWGu2SvG7jzfE1RiAjggwMaC8.9E6.kCk
 n8qhmSR9mmecFKcd8e0EtVKMtywXPzuI4.54nspsvqzQc1dezAC2jjBS4XzMqarkiaObBn07gaCg
 jvtlfak2YqouSA29NsQzTexmSihOWQZ_TQEH4UK7cbv1OWiJ7osO_VUH_JDRI1U7W.TJtPUZJAAh
 NDWAxfMu2VPTx0xFdo2mHdDRoCwpV5dPMdBCob.mNo_oa38pHmbcyW6cuvERHpZ0QEuzAq_UCDx8
 _5lcx0NpZwXoWZvZJqhTyPjx2.5djyrwDvTzHj8lNIQVrB_cJeBAWRiK7mU3qFz.mTdCysGNe2Up
 R6W.0NYUjOT3ULo6I1eoT061RszxMnX6OmiDLCUqX6joiEOhb8paJOn8iTHFIc.Inur_WWjE8bj1
 CpSHLuFhJFC0Xp9XGIuOpY5ixYFm5tQuildTUAsxC_V_HckAdjD032CLnAeAAQ9NbfAH0yraFKuh
 xjeuDI1xiN8dftgVr2lvquE96.uRfaSm70uowbX6nAGkZP_v2AjHUARlFVspnBIUyBHscYD_T8YA
 JBAIYDdKpukKlOqfZDbodcvzgW30E7dbhBg0DvILdfBQ_1dcr18qTsFzYceuGHXJsJRyCdfolWeK
 uCaBbm2Vj3xE-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: e1a39e94-4589-4aa1-9b2e-b04e5703ddb8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Sat, 7 Dec 2024 18:18:09 +0000
Received: by hermes--production-gq1-5dd4b47f46-n48bg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4bc89aae52e6cd56a5ae7443130c423c;
          Sat, 07 Dec 2024 18:18:07 +0000 (UTC)
Message-ID: <f16d8349-8b98-4a92-af3f-7e0638300aa6@schaufler-ca.com>
Date: Sat, 7 Dec 2024 10:18:04 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smack: deduplicate access to string conversion
To: Konstantin Andreev <andreev@swemel.ru>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240913144727.1839137-1-andreev@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240913144727.1839137-1-andreev@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23040 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/13/2024 7:46 AM, Konstantin Andreev wrote:
> Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
> ---

Applied to smack-next for v6.14. Thank you.

> Currently, access bitfield is converted to string in 3 different places.
> This patch consolidates conversion in one place.
> The patch is against `next' branch at https://github.com/cschaufler/smack-next
> The patch does not hurt `Smack kernel test suite' https://github.com/smack-team/smack-testsuite.git
>
>  security/smack/smack.h        |  1 +
>  security/smack/smack_access.c | 10 ++++++++--
>  security/smack/smack_lsm.c    | 18 +-----------------
>  security/smack/smackfs.c      | 26 +++++---------------------
>  4 files changed, 15 insertions(+), 40 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 041688e5a77a..9e17e813fd1f 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -280,6 +280,7 @@ int smk_access(struct smack_known *, struct smack_known *,
>  int smk_tskacc(struct task_smack *, struct smack_known *,
>  	       u32, struct smk_audit_info *);
>  int smk_curacc(struct smack_known *, u32, struct smk_audit_info *);
> +int smack_str_from_perm(char *string, int access);
>  struct smack_known *smack_from_secid(const u32);
>  char *smk_parse_smack(const char *string, int len);
>  int smk_netlbl_mls(int, char *, struct netlbl_lsm_secattr *, int);
> diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
> index 585e5e35710b..3727379623e2 100644
> --- a/security/smack/smack_access.c
> +++ b/security/smack/smack_access.c
> @@ -275,7 +275,6 @@ int smk_curacc(struct smack_known *obj_known,
>  	return smk_tskacc(tsp, obj_known, mode, a);
>  }
>  
> -#ifdef CONFIG_AUDIT
>  /**
>   * smack_str_from_perm : helper to transalate an int to a
>   * readable string
> @@ -283,7 +282,7 @@ int smk_curacc(struct smack_known *obj_known,
>   * @access : the int
>   *
>   */
> -static inline void smack_str_from_perm(char *string, int access)
> +int smack_str_from_perm(char *string, int access)
>  {
>  	int i = 0;
>  
> @@ -299,8 +298,15 @@ static inline void smack_str_from_perm(char *string, int access)
>  		string[i++] = 't';
>  	if (access & MAY_LOCK)
>  		string[i++] = 'l';
> +	if (access & MAY_BRINGUP)
> +		string[i++] = 'b';
> +	if (i == 0)
> +		string[i++] = '-';
>  	string[i] = '\0';
> +	return i;
>  }
> +
> +#ifdef CONFIG_AUDIT
>  /**
>   * smack_log_callback - SMACK specific information
>   * will be called by generic audit code
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 4164699cd4f6..e0c2a2c6add3 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -107,23 +107,7 @@ static char *smk_bu_mess[] = {
>  
>  static void smk_bu_mode(int mode, char *s)
>  {
> -	int i = 0;
> -
> -	if (mode & MAY_READ)
> -		s[i++] = 'r';
> -	if (mode & MAY_WRITE)
> -		s[i++] = 'w';
> -	if (mode & MAY_EXEC)
> -		s[i++] = 'x';
> -	if (mode & MAY_APPEND)
> -		s[i++] = 'a';
> -	if (mode & MAY_TRANSMUTE)
> -		s[i++] = 't';
> -	if (mode & MAY_LOCK)
> -		s[i++] = 'l';
> -	if (i == 0)
> -		s[i++] = '-';
> -	s[i] = '\0';
> +	smack_str_from_perm(s, mode);
>  }
>  #endif
>  
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index 5dd1e164f9b1..cd5327253d1c 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -564,6 +564,7 @@ static void smk_seq_stop(struct seq_file *s, void *v)
>  
>  static void smk_rule_show(struct seq_file *s, struct smack_rule *srp, int max)
>  {
> +	char acc[SMK_NUM_ACCESS_TYPE + 1];
>  	/*
>  	 * Don't show any rules with label names too long for
>  	 * interface file (/smack/load or /smack/load2)
> @@ -577,28 +578,11 @@ static void smk_rule_show(struct seq_file *s, struct smack_rule *srp, int max)
>  	if (srp->smk_access == 0)
>  		return;
>  
> -	seq_printf(s, "%s %s",
> +	smack_str_from_perm(acc, srp->smk_access);
> +	seq_printf(s, "%s %s %s\n",
>  		   srp->smk_subject->smk_known,
> -		   srp->smk_object->smk_known);
> -
> -	seq_putc(s, ' ');
> -
> -	if (srp->smk_access & MAY_READ)
> -		seq_putc(s, 'r');
> -	if (srp->smk_access & MAY_WRITE)
> -		seq_putc(s, 'w');
> -	if (srp->smk_access & MAY_EXEC)
> -		seq_putc(s, 'x');
> -	if (srp->smk_access & MAY_APPEND)
> -		seq_putc(s, 'a');
> -	if (srp->smk_access & MAY_TRANSMUTE)
> -		seq_putc(s, 't');
> -	if (srp->smk_access & MAY_LOCK)
> -		seq_putc(s, 'l');
> -	if (srp->smk_access & MAY_BRINGUP)
> -		seq_putc(s, 'b');
> -
> -	seq_putc(s, '\n');
> +		   srp->smk_object->smk_known,
> +		   acc);
>  }
>  
>  /*

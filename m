Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526A812E48;
	Tue, 10 Sep 2024 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725950263; cv=none; b=fgjkfXZoHCgQK3nLm1M2vTof4MUBoRN2Zm4227Zmf/poQFlTQDV78Eh4XBGWNVsVA17e9+Bw3HV/mKz6o9E3joKI+PJV5K+gljT/fKStB2WNpwkk3leh4GmxUDCc4ZdUnA9Ziu8FJu7TVYCHG5oCy/FE0NuwPg8s9cJyzPlKe6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725950263; c=relaxed/simple;
	bh=V8vhyzk0VAxgS8tMe1VUgAkArvhCgBO2hTXJkAu40uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2Ncc0LY64feqF6IaARjJ4b9Vs8JsR1zpL+a8XgtaYApF6h4WIbuLAOpJ1MHp6aossEfZudyWsrH8vI388cPVU0tEDZ0L+of9HTD6fUCITwLwPT68smQucRB66cp77PkeuwwKF6lKUo66xW3OKv+2IusGurTa+WNvhBokeqbjnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Ne0iLmss; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Ne0iLmss"
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C7A7B3F815;
	Tue, 10 Sep 2024 06:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725950258;
	bh=hNaxVTeDmA7r/tUtlAxxAlz13RsZqnnlsevQEA/+jrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Ne0iLmssw8tHYcRfHTw+KZOSv0UCJLhTGFIyPPBM7+zAh90e86RDkXKjJYKs9hlWO
	 dt0NhoSbCnRIyztTIRFzyqpSKgv7882JptMGWiMjcggTBV2gKWn2jKxbdsNC7zT1sS
	 66nu2JoSZOCWzFk/j9A5cT3FvmkgMoNWbRnMK+y4ReCaX0iUunmAQJe+v9QVnSOWnH
	 iEZoWDGxvTNT4HPlkgaeLyKprGrtshLTLKG/YkwjFCEfDcTXTVDLTwzGMWUKY8G1A8
	 cw3m0akx1LM42Cg5wRmQCEEwapevdUx8IaMJ+D7WeFjuDuzu4bV98VGLOKQhJ6AY39
	 8atd3p0qjvcSw==
Message-ID: <41b11740-65aa-4015-86d1-c98f8354846e@canonical.com>
Date: Mon, 9 Sep 2024 23:37:34 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: domain: clean up duplicated parts of
 handle_onexec()
To: Leesoo Ahn <lsahn@ooseel.net>
Cc: Leesoo Ahn <lsahn@wewakecorp.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240709030751.3825748-1-lsahn@wewakecorp.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20240709030751.3825748-1-lsahn@wewakecorp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/24 20:07, Leesoo Ahn wrote:
> Regression test of AppArmor finished without any failures.
> 
> PASSED: aa_exec access attach_disconnected at_secure introspect capabilities
> changeprofile onexec changehat changehat_fork changehat_misc chdir clone
> coredump deleted e2e environ exec exec_qual fchdir fd_inheritance fork i18n
> link link_subset mkdir mmap mount mult_mount named_pipe namespaces net_raw
> open openat pipe pivot_root posix_ipc ptrace pwrite query_label regex rename
> readdir rw socketpair swap sd_flags setattr symlink syscall sysv_ipc tcp
> unix_fd_server unix_socket_pathname unix_socket_abstract unix_socket_unnamed
> unix_socket_autobind unlink userns xattrs xattrs_profile longpath nfs
> exec_stack aa_policy_cache nnp stackonexec stackprofile
> FAILED:
> make: Leaving directory '/apparmor/tests/regression/apparmor'
> 
> Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>

Acked-by: John Johansen <john.johansen@canonical.com>

this was pulled into my tree, sorry for missing the reply earlier

> ---
>   security/apparmor/domain.c | 37 +++++++++++--------------------------
>   1 file changed, 11 insertions(+), 26 deletions(-)
> 
> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
> index 571158ec6188..b73e01b512c2 100644
> --- a/security/apparmor/domain.c
> +++ b/security/apparmor/domain.c
> @@ -822,33 +822,18 @@ static struct aa_label *handle_onexec(const struct cred *subj_cred,
>   	AA_BUG(!bprm);
>   	AA_BUG(!buffer);
>   
> -	if (!stack) {
> -		error = fn_for_each_in_ns(label, profile,
> -				profile_onexec(subj_cred, profile, onexec, stack,
> -					       bprm, buffer, cond, unsafe));
> -		if (error)
> -			return ERR_PTR(error);
> -		new = fn_label_build_in_ns(label, profile, GFP_KERNEL,
> -				aa_get_newest_label(onexec),
> -				profile_transition(subj_cred, profile, bprm,
> -						   buffer,
> -						   cond, unsafe));
> -
> -	} else {
> -		/* TODO: determine how much we want to loosen this */
> -		error = fn_for_each_in_ns(label, profile,
> -				profile_onexec(subj_cred, profile, onexec, stack, bprm,
> -					       buffer, cond, unsafe));
> -		if (error)
> -			return ERR_PTR(error);
> -		new = fn_label_build_in_ns(label, profile, GFP_KERNEL,
> -				aa_label_merge(&profile->label, onexec,
> -					       GFP_KERNEL),
> -				profile_transition(subj_cred, profile, bprm,
> -						   buffer,
> -						   cond, unsafe));
> -	}
> +	/* TODO: determine how much we want to loosen this */
> +	error = fn_for_each_in_ns(label, profile,
> +			profile_onexec(subj_cred, profile, onexec, stack,
> +				       bprm, buffer, cond, unsafe));
> +	if (error)
> +		return ERR_PTR(error);
>   
> +	new = fn_label_build_in_ns(label, profile, GFP_KERNEL,
> +			stack ? aa_label_merge(&profile->label, onexec, GFP_KERNEL)
> +			      : aa_get_newest_label(onexec),
> +			profile_transition(subj_cred, profile, bprm,
> +					   buffer, cond, unsafe));
>   	if (new)
>   		return new;
>   


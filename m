Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F970382
	for <linux-security-module@vger.kernel.org>; Fri, 20 Sep 2024 02:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726798291; cv=none; b=R644NqoYGRo1gjT3b7J5sP70cVwKdHRi9u6Ywue+dUVM7kHscPykPZd80VWycntX7b74J0ZL2qJ5XNBEVVBwFtqn1IXs8F2JjkfGq64FtLAq6nQiCBKGymwhB+sSqmesSHpVPwWtKNCUamkMQiednExTVwKTqjUJ6/GS98agpyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726798291; c=relaxed/simple;
	bh=/yyO4nmrphHKf69gszmDz2gtWOFduw9r4nGfR87m56k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFkK9Z3CYdJ9d0ozbehxefJb2wnddCOPlyj9shQ7TM5+SQXvtUDdFwQvBFMpsQXRmhEuO3zybwA4Ye0yO9KAspFWoYVSyDWeN5S2ZW353lhVQc7lfJ5+C/cs0h4ICav2IqzdiUD75ncrw0m88EyB9HndLcre2EGpHzgoIj0scTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 119ACC1C; Thu, 19 Sep 2024 21:02:17 -0500 (CDT)
Date: Thu, 19 Sep 2024 21:02:17 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: luca.boccassi@gmail.com
Cc: linux-security-module@vger.kernel.org, wufan@linux.microsoft.com,
	paul@paul-moore.com
Subject: Re: [PATCH v2] ipe: allow secondary and platform keyrings to
 install/update policies
Message-ID: <20240920020217.GA528455@mail.hallyn.com>
References: <20240913234840.1318655-1-luca.boccassi@gmail.com>
 <20240915091119.1916049-1-luca.boccassi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915091119.1916049-1-luca.boccassi@gmail.com>

On Sun, Sep 15, 2024 at 11:11:19AM +0200, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <bluca@debian.org>
> 
> The current policy management makes it impossible to use IPE
> in a general purpose distribution. In such cases the users are not
> building the kernel, the distribution is, and access to the private
> key included in the trusted keyring is, for obvious reason, not
> available.
> This means that users have no way to enable IPE, since there will
> be no built-in generic policy, and no access to the key to sign
> updates validated by the trusted keyring.
> 
> Just as we do for dm-verity, kernel modules and more, allow the
> secondary and platform keyrings to also validate policies. This
> allows users enrolling their own keys in UEFI db or MOK to also
> sign policies, and enroll them. This makes it sensible to enable
> IPE in general purpose distributions, as it becomes usable by
> any user wishing to do so. Keys in these keyrings can already
> load kernels and kernel modules, so there is no security
> downgrade.
> 
> Add a kconfig each, like dm-verity does, but default to enabled if
> the dependencies are available.
> 
> Signed-off-by: Luca Boccassi <bluca@debian.org>
> ---
> v2: add Kconfig entries following the dm-verity model
>     update documentation
> 
>  Documentation/admin-guide/LSM/ipe.rst |  5 ++++-
>  security/ipe/Kconfig                  | 19 +++++++++++++++++++
>  security/ipe/policy.c                 | 14 +++++++++++++-
>  3 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
> index f38e641df0e9..47323494d119 100644
> --- a/Documentation/admin-guide/LSM/ipe.rst
> +++ b/Documentation/admin-guide/LSM/ipe.rst
> @@ -223,7 +223,10 @@ are signed through the PKCS#7 message format to enforce some level of
>  authorization of the policies (prohibiting an attacker from gaining
>  unconstrained root, and deploying an "allow all" policy). These
>  policies must be signed by a certificate that chains to the
> -``SYSTEM_TRUSTED_KEYRING``. With openssl, the policy can be signed by::
> +``SYSTEM_TRUSTED_KEYRING``, or to the secondary and/or platform keyrings if
> +``CONFIG_IPE_POLICY_SIG_SECONDARY_KEYRING`` and/or
> +``CONFIG_IPE_POLICY_SIG_PLATFORM_KEYRING`` are enabled, respectively.
> +With openssl, the policy can be signed by::
>  
>     openssl smime -sign \
>        -in "$MY_POLICY" \
> diff --git a/security/ipe/Kconfig b/security/ipe/Kconfig
> index 3ab582606ed2..ee6beca5494a 100644
> --- a/security/ipe/Kconfig
> +++ b/security/ipe/Kconfig
> @@ -31,6 +31,25 @@ config IPE_BOOT_POLICY
>  
>  	  If unsure, leave blank.
>  
> +config IPE_POLICY_SIG_SECONDARY_KEYRING
> +        bool "IPE policy update verification with secondary keyring"
> +        default y
> +        depends on SECONDARY_TRUSTED_KEYRING
> +        help
> +          Also allow the secondary trusted keyring to verify IPE policy
> +		  updates.
> +
> +          If unsure, answer Y.
> +
> +config IPE_POLICY_SIG_PLATFORM_KEYRING
> +        bool "IPE policy update verification with platform keyring"
> +        default y
> +        depends on INTEGRITY_PLATFORM_KEYRING
> +        help
> +          Also allow the platform keyring to verify IPE policy updates.
> +
> +          If unsure, answer Y.
> +
>  menu "IPE Trust Providers"
>  
>  config IPE_PROP_DM_VERITY
> diff --git a/security/ipe/policy.c b/security/ipe/policy.c
> index d8e7db857a2e..bf5aa97911e1 100644
> --- a/security/ipe/policy.c
> +++ b/security/ipe/policy.c
> @@ -169,9 +169,21 @@ struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
>  			goto err;
>  		}
>  
> -		rc = verify_pkcs7_signature(NULL, 0, new->pkcs7, pkcs7len, NULL,
> +		rc = verify_pkcs7_signature(NULL, 0, new->pkcs7, pkcs7len,
> +#ifdef CONFIG_IPE_POLICY_SIG_SECONDARY_KEYRING
> +					    VERIFY_USE_SECONDARY_KEYRING,
> +#else
> +					    NULL,
> +#endif
>  					    VERIFYING_UNSPECIFIED_SIGNATURE,
>  					    set_pkcs7_data, new);
> +#ifdef CONFIG_IPE_POLICY_SIG_PLATFORM_KEYRING
> +		if (rc == -ENOKEY)

If the secondary key *is* there, but returns -EKEYREJECTED,
do you want to fall back to trying the platform keyring, or not?


> +			rc = verify_pkcs7_signature(NULL, 0, new->pkcs7, pkcs7len,
> +						    VERIFY_USE_PLATFORM_KEYRING,
> +						    VERIFYING_UNSPECIFIED_SIGNATURE,
> +						    set_pkcs7_data, new);
> +#endif
>  		if (rc)
>  			goto err;
>  	} else {
> -- 
> 2.39.5
> 

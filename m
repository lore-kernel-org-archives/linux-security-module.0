Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6A813A3F7;
	Fri, 24 Jan 2025 23:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737759886; cv=none; b=AqMfn0fN0Retzs3YgKM20LUhc7xr1cC7xzHmKeOcDSehLOsB+87AEnYjsZrg5BxABXHw7DjudauSqdBZdD4MslmRKIiQNY6YM50w2wdYgatSNELMaXgCuYEYaM6Zx4IfJPExZCkHpvCVAIivwiIZ/XkgtD17Jvp+A7eolJolgS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737759886; c=relaxed/simple;
	bh=mUWUhS0OQk0MhF9WiTWRHL3p5kRtoo0r4ieg4/Ernd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVWW750NgBPg4st3nQ19VXYZeugGOxAAMzkWE+5VYB+DO/RQ81cTGD43UzdRfDs8wkTzVfxxE6MMD/hECGttC4Udks58MoHFJPLNTWQ2+zG7a2tgOyEVodbJ02rUa3fPY6EoA6ZHzw2UGCSe/KsGsN0cr3hgDjL/V9sSMTeZOyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nCoDFixK; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nCoDFixK"
Received: from [192.168.192.85] (unknown [50.39.104.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8FC043F1C5;
	Fri, 24 Jan 2025 23:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1737759878;
	bh=ri9gpr6Hf1j6jpCRGdI5Ztg3/KkJ6+VDBlyO6a9Bh/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=nCoDFixKMMtpibsfPMSNdiHT/qxAeMXqdqoQ0OmNqs9Hce1ncZZAt0SZ1GMkwMrrQ
	 /BbVserpYrvJ39rt8K7pbQC8ITKl0PtPzyciOWlfkniXJPzq3xrI2QekU0j0V2d7RB
	 LEexYXwcoUc90eFz/Q9pUbpJ5mFZ+5/8lX4wgWJaOMuSr6bBwEEd8k0LZSp3S9qjbz
	 iZchlBKeZp2gxZLcsoIsPArkbOl7jV8UKhP2eRaTwFiRbzyLXd9Z/YlrDtowp0652B
	 uZWXHwrlirEqjQWWwjBYVQx2nKfiZM2Sc4pVwQgNkGEz2bEVu68tUfJ7uzNEf51PgO
	 S3ovTfqo6sKVw==
Message-ID: <00e63eb5-e8b4-43af-b1bb-764f3c5230ca@canonical.com>
Date: Fri, 24 Jan 2025 15:04:34 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: fix typos and spelling errors
To: Tanya Agarwal <tanyaagarwal25699@gmail.com>, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, anupnewsmail@gmail.com,
 Mimi Zohar <zohar@linux.ibm.com>
References: <20250123192058.2558-1-tanyaagarwal25699@gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250123192058.2558-1-tanyaagarwal25699@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/25 11:21, Tanya Agarwal wrote:
> From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> 
> Fix typos and spelling errors in apparmor module comments that were
> identified using the codespell tool.
> No functional changes - documentation only.
> 
> Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Acked-by: John Johansen <john.johansen@canonical.com>

I have pulled this into my tree

> ---
> This patch set is split into individual patches for each LSM
> to facilitate easier review by respective maintainers.
> 
> Original discussion:
> https://lore.kernel.org/all/20250112072925.1774-1-tanyaagarwal25699@gmail.com
> 
>   security/apparmor/apparmorfs.c | 6 +++---
>   security/apparmor/domain.c     | 4 ++--
>   security/apparmor/label.c      | 2 +-
>   security/apparmor/lsm.c        | 2 +-
>   security/apparmor/policy.c     | 4 ++--
>   5 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index 2c0185ebc900..0c2f248d31bf 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -43,7 +43,7 @@
>    * The interface is split into two main components based on their function
>    * a securityfs component:
>    *   used for static files that are always available, and which allows
> - *   userspace to specificy the location of the security filesystem.
> + *   userspace to specify the location of the security filesystem.
>    *
>    *   fns and data are prefixed with
>    *      aa_sfs_
> @@ -204,7 +204,7 @@ static struct file_system_type aafs_ops = {
>   /**
>    * __aafs_setup_d_inode - basic inode setup for apparmorfs
>    * @dir: parent directory for the dentry
> - * @dentry: dentry we are seting the inode up for
> + * @dentry: dentry we are setting the inode up for
>    * @mode: permissions the file should have
>    * @data: data to store on inode.i_private, available in open()
>    * @link: if symlink, symlink target string
> @@ -2244,7 +2244,7 @@ static void *p_next(struct seq_file *f, void *p, loff_t *pos)
>   /**
>    * p_stop - stop depth first traversal
>    * @f: seq_file we are filling
> - * @p: the last profile writen
> + * @p: the last profile written
>    *
>    * Release all locking done by p_start/p_next on namespace tree
>    */
> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
> index 5939bd9a9b9b..d959931eac28 100644
> --- a/security/apparmor/domain.c
> +++ b/security/apparmor/domain.c
> @@ -755,7 +755,7 @@ static int profile_onexec(const struct cred *subj_cred,
>   		/* change_profile on exec already granted */
>   		/*
>   		 * NOTE: Domain transitions from unconfined are allowed
> -		 * even when no_new_privs is set because this aways results
> +		 * even when no_new_privs is set because this always results
>   		 * in a further reduction of permissions.
>   		 */
>   		return 0;
> @@ -926,7 +926,7 @@ int apparmor_bprm_creds_for_exec(struct linux_binprm *bprm)
>   	 *
>   	 * NOTE: Domain transitions from unconfined and to stacked
>   	 * subsets are allowed even when no_new_privs is set because this
> -	 * aways results in a further reduction of permissions.
> +	 * always results in a further reduction of permissions.
>   	 */
>   	if ((bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS) &&
>   	    !unconfined(label) &&
> diff --git a/security/apparmor/label.c b/security/apparmor/label.c
> index 91483ecacc16..8bcff51becb8 100644
> --- a/security/apparmor/label.c
> +++ b/security/apparmor/label.c
> @@ -1456,7 +1456,7 @@ bool aa_update_label_name(struct aa_ns *ns, struct aa_label *label, gfp_t gfp)
>   
>   /*
>    * cached label name is present and visible
> - * @label->hname only exists if label is namespace hierachical
> + * @label->hname only exists if label is namespace hierarchical
>    */
>   static inline bool use_label_hname(struct aa_ns *ns, struct aa_label *label,
>   				   int flags)
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 1edc12862a7d..04bf5d2f6e00 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -2006,7 +2006,7 @@ static int __init alloc_buffers(void)
>   	 * two should be enough, with more CPUs it is possible that more
>   	 * buffers will be used simultaneously. The preallocated pool may grow.
>   	 * This preallocation has also the side-effect that AppArmor will be
> -	 * disabled early at boot if aa_g_path_max is extremly high.
> +	 * disabled early at boot if aa_g_path_max is extremely high.
>   	 */
>   	if (num_online_cpus() > 1)
>   		num = 4 + RESERVE_COUNT;
> diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
> index d0244fab0653..5cec3efc4794 100644
> --- a/security/apparmor/policy.c
> +++ b/security/apparmor/policy.c
> @@ -463,7 +463,7 @@ static struct aa_policy *__lookup_parent(struct aa_ns *ns,
>   }
>   
>   /**
> - * __create_missing_ancestors - create place holders for missing ancestores
> + * __create_missing_ancestors - create place holders for missing ancestors
>    * @ns: namespace to lookup profile in (NOT NULL)
>    * @hname: hierarchical profile name to find parent of (NOT NULL)
>    * @gfp: type of allocation.
> @@ -1068,7 +1068,7 @@ ssize_t aa_replace_profiles(struct aa_ns *policy_ns, struct aa_label *label,
>   		goto out;
>   
>   	/* ensure that profiles are all for the same ns
> -	 * TODO: update locking to remove this constaint. All profiles in
> +	 * TODO: update locking to remove this constraint. All profiles in
>   	 *       the load set must succeed as a set or the load will
>   	 *       fail. Sort ent list and take ns locks in hierarchy order
>   	 */


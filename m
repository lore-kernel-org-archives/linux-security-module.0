Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F9F221540
	for <linux-security-module@vger.kernel.org>; Fri,  6 Mar 2026 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772782531; cv=none; b=p14dXHtySUUkLTZIM7Ak+a0HgguQKfc3AQuyOeJ8nT4nsEg1olA4PPzxCp2qZvV3bSdTbWRvbNFxjM7d8jWp71qW6p7OhKryUWQpnnfpEq12ZcxsyOzjbg3JWIQukYaOlekgUfvEgGs7g1+83XaGSVoK6/qhUK1MEJRBbiiZLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772782531; c=relaxed/simple;
	bh=sztkPVnHNDT4E05gcPJ9H9WGznVMghLQnHawhBqKel4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGfu9M/ybZ6ZOg6mhLA415GcUviA23j+wungexrBLRiijXAyogsEErU5pa3HOsduQx4AiS3vXh60lezuGu60kE9qoC8e/UV189k7gW5oEtl6lVsLhCmNLCTMtbpnYxmIKShdL1SQQ6LPNqDp9OF5iKyMa4wHA/nr2J/yzSov43c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgpIgYV3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgpIgYV3"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48379a42f76so77257545e9.0
        for <linux-security-module@vger.kernel.org>; Thu, 05 Mar 2026 23:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772782528; x=1773387328; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cCDSzPMlv4fpJAeXBxBDv0mnT/OYHNbkIWf9gB98IDs=;
        b=KgpIgYV3q8DlAjJ+59qxhnK7ssRALz0OwdSID4Ifuuz+1LTn+1ty3icKJuyLGtfpfv
         RP2iV7J4DHVA33fQ6WlruU9G5iMXZou3V2Wday3qTvqhjCiNXtKdJSdHqVWoxqSb2JwH
         49y7VWTlCdYV2Zpc84NXQGaKEKv7JNNHQqVatPJtISl8ts2Ehin+ajHIwIs4Ng7a1tPf
         g/S2edca0u5JZxZl+ZE+gj6IiwBq1TqPww8/ceVSvrFT7kfT9jMyk2GalC1W8HnzhKNx
         hZUeMxV4p03W4bw0T7Eb9dp7y5ZhGK1H6mxsYeipKXXyIl7cAApZpmhjtXR2OKsNtfm+
         3ipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772782528; x=1773387328;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCDSzPMlv4fpJAeXBxBDv0mnT/OYHNbkIWf9gB98IDs=;
        b=GSn9/1WYG/nZsqitMzSXbLGLG8YAeumAiy3l7zxV2Tn4b/Va+E0Ed79v0epWGKDUHM
         IuvwE48Ihphx+/EJHrcyj2UtILN78LfcPegOb1p/ovBPrNHuWa27jRyLL4Yy+84YrDRh
         EeUhHkEgdbkMGn/FzRjc9qHeqH3/yigNvGFUxa/gGOn0a2Qdmr9diUPy/mWeyEkqemK6
         DKkCS5vuS79PigelcH0bpGqrQq+Fx/ohZSsZBO5KLfSSE1RrBppgOO6jvkr1+ZWG8Qoz
         N6y+eh/xjkWLZyiejphArFHAQvOfQuFGlMLEWnyG5+iFazdDgy/jO8PXHuFoRtgknXKE
         gFkw==
X-Forwarded-Encrypted: i=1; AJvYcCVN8iOb3NhJ3RArv7wuzxjgN6vBZTiIFTfgehHd3ev+EV9k1Nx00mn2P5d2kqXT18gOLYYtiJ+3YiQIBH/FL/m7DQ3diKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlChfGLXtCVLL5jYCVcgo1QVYiI6gmNaQoG6mzPAnAfHOrkpuF
	A66FrRY1ns9tvtg4Ixi5uFTRckzGg1T81CwaxL6CCPr99s5bnMTIFiz2
X-Gm-Gg: ATEYQzzDNTZvhLATVJ/eMfEwfJdVPzewBUgc9wQ/OXWUYhHomwqy6NxEzGLVkBNdLn0
	P9UDJONLoPnfiGucZ1vICxLjzehxVAEKUQG6TSvY2X1Qgv2nfSkJsJfnwPf/UYGv9i5LIlLCKRB
	hUkOvgjaNY9E2GvNaA74vmEcgPlo8IKlVs325F1p8PTX5Bykd0KphO1wrcr7XqpllqRktcCPTml
	CP2NzZcVTvcQENWerZbEvX76P3PLsS2gIT4FXEtdMu4qqBz2AEUSDuu4As1HPXFRczuC19rS0bD
	/HyymQW055qB9EP5YewlLQoVDz/gM8etJO8aR0yzT9pGUKyBm6WTK8O0HSF3aeDSnd1LG/3gbjS
	8un2z2bQyqVoxjJmargQ8sZC3pZWRTvCprcKmoyQcIG24CGyPokiI95rvu730khxx95uUzH5TJq
	B0sP75YNmEDpVywDsf4N5vjtTbtw0xp33U6EQKUhQJtFUTx6/n
X-Received: by 2002:a05:600c:3acf:b0:480:1c10:5633 with SMTP id 5b1f17b1804b1-48526979e65mr14948625e9.26.1772782527507;
        Thu, 05 Mar 2026 23:35:27 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fb33815sm186001555e9.12.2026.03.05.23.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 23:35:27 -0800 (PST)
Date: Fri, 6 Mar 2026 08:35:25 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 2/4] landlock: Add missing kernel-doc "Return:"
 sections
Message-ID: <20260306.c97707a248c0@gnoack.org>
References: <20260304193134.250495-1-mic@digikod.net>
 <20260304193134.250495-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260304193134.250495-2-mic@digikod.net>

On Wed, Mar 04, 2026 at 08:31:25PM +0100, Mickaël Salaün wrote:
> The kernel-doc -Wreturn check warns about functions with documentation
> comments that lack a "Return:" section.  Add "Return:" documentation to
> all functions missing it so that kernel-doc -Wreturn passes cleanly.
> 
> Convert existing function descriptions into a formal "Return:" section.
> Also fix the inaccurate return documentation for
> landlock_merge_ruleset() which claimed to return @parent directly, and
> document the previously missing ERR_PTR() error return path.  Document
> the ABI version and errata return paths for landlock_create_ruleset()
> which were previously only implied by the prose.
> 
> Cc: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/landlock/domain.c   |  2 ++
>  security/landlock/fs.c       |  2 +-
>  security/landlock/ruleset.c  |  8 +++++---
>  security/landlock/syscalls.c | 17 +++++++++++------
>  security/landlock/task.c     |  9 +++++----
>  5 files changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/security/landlock/domain.c b/security/landlock/domain.c
> index 79cb3bbdf4c5..343a1aabaac6 100644
> --- a/security/landlock/domain.c
> +++ b/security/landlock/domain.c
> @@ -115,6 +115,8 @@ static struct landlock_details *get_current_details(void)
>   * restriction.  The subjective credentials must not be in an overridden state.
>   *
>   * @hierarchy->parent and @hierarchy->usage should already be set.
> + *
> + * Return: 0 on success, -errno on failure.
>   */
>  int landlock_init_hierarchy_log(struct landlock_hierarchy *const hierarchy)
>  {
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index e764470f588c..cfe69075bf4e 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1568,7 +1568,7 @@ static int hook_path_truncate(const struct path *const path)
>   *
>   * @file: File being opened.
>   *
> - * Returns the access rights that are required for opening the given file,
> + * Return: The access rights that are required for opening the given file,
>   * depending on the file type and open mode.
>   */
>  static access_mask_t
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index a61ced492f41..de8386af2f30 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -202,6 +202,8 @@ static void build_check_ruleset(void)
>   * When merging a ruleset in a domain, or copying a domain, @layers will be
>   * added to @ruleset as new constraints, similarly to a boolean AND between
>   * access rights.
> + *
> + * Return: 0 on success, -errno on failure.
>   */
>  static int insert_rule(struct landlock_ruleset *const ruleset,
>  		       const struct landlock_id id,
> @@ -531,8 +533,8 @@ void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
>   * The current task is requesting to be restricted.  The subjective credentials
>   * must not be in an overridden state. cf. landlock_init_hierarchy_log().
>   *
> - * Returns the intersection of @parent and @ruleset, or returns @parent if
> - * @ruleset is empty, or returns a duplicate of @ruleset if @parent is empty.
> + * Return: A new domain merging @parent and @ruleset on success, or ERR_PTR()
> + * on failure.  If @parent is NULL, the new domain duplicates @ruleset.
>   */
>  struct landlock_ruleset *
>  landlock_merge_ruleset(struct landlock_ruleset *const parent,
> @@ -623,7 +625,7 @@ landlock_find_rule(const struct landlock_ruleset *const ruleset,
>   * @rule: A rule that grants a set of access rights for each layer
>   * @masks: A matrix of unfulfilled access rights for each layer
>   *
> - * Returns true if the request is allowed (i.e. the access rights granted all
> + * Return: True if the request is allowed (i.e. the access rights granted all
>   * remaining unfulfilled access rights and masks has no leftover set bits).
>   */
>  bool landlock_unmask_layers(const struct landlock_rule *const rule,
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 0d66a68677b7..3b33839b80c7 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -60,6 +60,8 @@ static bool is_initialized(void)
>   * @ksize_min: Minimal required size to be copied.
>   * @src: User space pointer or NULL.
>   * @usize: (Alleged) size of the data pointed to by @src.
> + *
> + * Return: 0 on success, -errno on failure.
>   */
>  static __always_inline int
>  copy_min_struct_from_user(void *const dst, const size_t ksize,
> @@ -178,16 +180,19 @@ const int landlock_abi_version = 8;
>   *         - %LANDLOCK_CREATE_RULESET_VERSION
>   *         - %LANDLOCK_CREATE_RULESET_ERRATA
>   *
> - * This system call enables to create a new Landlock ruleset, and returns the
> - * related file descriptor on success.
> + * This system call enables to create a new Landlock ruleset.
>   *
>   * If %LANDLOCK_CREATE_RULESET_VERSION or %LANDLOCK_CREATE_RULESET_ERRATA is
>   * set, then @attr must be NULL and @size must be 0.
>   *
> - * Possible returned errors are:
> + * Return: The ruleset file descriptor on success, the Landlock ABI version if
> + * %LANDLOCK_CREATE_RULESET_VERSION is set, the errata value if
> + * %LANDLOCK_CREATE_RULESET_ERRATA is set, or -errno on failure.  Possible
> + * returned errors are:
>   *
>   * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
> - * - %EINVAL: unknown @flags, or unknown access, or unknown scope, or too small @size;
> + * - %EINVAL: unknown @flags, or unknown access, or unknown scope, or too small
> + *   @size;
>   * - %E2BIG: @attr or @size inconsistencies;
>   * - %EFAULT: @attr or @size inconsistencies;
>   * - %ENOMSG: empty &landlock_ruleset_attr.handled_access_fs.
> @@ -398,7 +403,7 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
>   * This system call enables to define a new rule and add it to an existing
>   * ruleset.
>   *
> - * Possible returned errors are:
> + * Return: 0 on success, or -errno on failure.  Possible returned errors are:
>   *
>   * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
>   * - %EAFNOSUPPORT: @rule_type is %LANDLOCK_RULE_NET_PORT but TCP/IP is not
> @@ -464,7 +469,7 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
>   * namespace or is running with no_new_privs.  This avoids scenarios where
>   * unprivileged tasks can affect the behavior of privileged children.
>   *
> - * Possible returned errors are:
> + * Return: 0 on success, or -errno on failure.  Possible returned errors are:
>   *
>   * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
>   * - %EINVAL: @flags contains an unknown bit.
> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index 833bc0cfe5c9..bf7c3db7ce46 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c
> @@ -37,6 +37,9 @@
>   *
>   * Checks if the @parent domain is less or equal to (i.e. an ancestor, which
>   * means a subset of) the @child domain.
> + *
> + * Return: True if @parent is an ancestor of or equal to @child, false
> + * otherwise.
>   */
>  static bool domain_scope_le(const struct landlock_ruleset *const parent,
>  			    const struct landlock_ruleset *const child)
> @@ -79,8 +82,7 @@ static int domain_ptrace(const struct landlock_ruleset *const parent,
>   * If the current task has Landlock rules, then the child must have at least
>   * the same rules.  Else denied.
>   *
> - * Determines whether a process may access another, returning 0 if permission
> - * granted, -errno if denied.
> + * Return: 0 if permission is granted, -errno if denied.

Good simplification! (the removed text is already mentioned in the
short summary next to the function name).

>   */
>  static int hook_ptrace_access_check(struct task_struct *const child,
>  				    const unsigned int mode)
> @@ -129,8 +131,7 @@ static int hook_ptrace_access_check(struct task_struct *const child,
>   * If the parent has Landlock rules, then the current task must have the same
>   * or more rules.  Else denied.
>   *
> - * Determines whether the nominated task is permitted to trace the current
> - * process, returning 0 if permission is granted, -errno if denied.
> + * Return: 0 if permission is granted, -errno if denied.

Ditto.

>   */
>  static int hook_ptrace_traceme(struct task_struct *const parent)
>  {
> -- 
> 2.53.0
> 

Looks good, thanks!

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

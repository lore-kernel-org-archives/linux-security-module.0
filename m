Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96B6B676;
	Sat, 17 May 2025 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747471922; cv=none; b=TIBc/bDPvrln36pURPmVup9yeNUcLGNeUOlupuKCmAb9S3/re1YaHf3XGKu9S8pKBok/U08rjEt95Dhj202AbDOOb0m/9Qi50w4j4TIuYkR/48zPnn2uPAfUz1qbZLvcsJHWDeRqD1gzvcfVklg8+N5iKBNDeqRPnthpMfjkhHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747471922; c=relaxed/simple;
	bh=uisxt740Y61JWYGBXeFHyzPfobIwQCvSX/bROKXZBVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJT3U88ALZ8fF3xymiS7HcHBTiEbkpsXzk6n1tn/+crioqa6xlElpCZqkuRIVb5lzw1ClLy3G2y0p/5RLfdOV1NEY87yrfZUBHqyEfbAuK6ejRRex6y/j0qXXqmuQpfoKoQnKOR7uB0hdUdaE92QBVw9OiBqrpchwBkr4hJnAvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=lKKYZokp; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="lKKYZokp"
Received: from [172.20.3.254] (unknown [213.157.19.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CFE513FA89;
	Sat, 17 May 2025 08:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1747471916;
	bh=LwsxKnzgLwgB3MddlDAZtddVxaV1Ne+qf0U+6mAN19g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=lKKYZokp6+3Q8dUnfS7Zalqu8zH/t2g4HBGMeD1Diu0VI7koArKeM6+P5Uf0nYn6E
	 +K5mUMu2UQUiLfbDT7UwgrHqPJObjynhYzCwfcguo7bUWTjzCG3Of+S88hqFBlraI9
	 Gfdpati3ax/8GFbhF/FO73PdvxqPrs9OraHAxlFkKXMBrF9CrMxzgYm8dsSi1zXOdH
	 eyabtIojsEp+kpAKh5/sE+krTquiH5JDES6xvtlNa4/A1dn4L5iAGO5YgB+SAZdbbv
	 OafoJbHQeSKkqRxzIg4/oTlwD8PxwyKFrg4MLEAFrvXTl+cQ8INul2hAGsJFuKMuxk
	 +eXiJgtTrExJw==
Message-ID: <b105b0bb-9dcc-4611-ace5-5bf58375c7af@canonical.com>
Date: Sat, 17 May 2025 01:51:54 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] apparmor: fix some kernel-doc issues in header files
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Ryan Lee <ryan.lee@canonical.com>, John Johansen <john@apparmor.net>,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>
References: <20250503044919.2251962-1-rdunlap@infradead.org>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250503044919.2251962-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/25 21:49, Randy Dunlap wrote:
> Fix kernel-doc warnings in apparmor header files as reported by
> scripts/kernel-doc:
> 
> cred.h:128: warning: expecting prototype for end_label_crit_section(). Prototype was for end_current_label_crit_section() instead
> file.h:108: warning: expecting prototype for aa_map_file_perms(). Prototype was for aa_map_file_to_perms() instead
> 
> lib.h:159: warning: Function parameter or struct member 'hname' not described in 'basename'
> lib.h:159: warning: Excess function parameter 'name' description in 'basename'
> 
> match.h:21: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * The format used for transition tables is based on the GNU flex table
> 
> perms.h:109: warning: Function parameter or struct member 'accum' not described in 'aa_perms_accum_raw'
> perms.h:109: warning: Function parameter or struct member 'addend' not described in 'aa_perms_accum_raw'
> perms.h:136: warning: Function parameter or struct member 'accum' not described in 'aa_perms_accum'
> perms.h:136: warning: Function parameter or struct member 'addend' not described in 'aa_perms_accum'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Ryan Lee <ryan.lee@canonical.com>
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: John Johansen <john@apparmor.net>
> Cc: apparmor@lists.ubuntu.com
> Cc: linux-security-module@vger.kernel.org
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> ---
> v2: add better commit message (Ryan)

Acked-by: John Johansen <john.johansen@canonical.com>

> 
>   security/apparmor/include/cred.h  |    2 +-
>   security/apparmor/include/file.h  |    2 +-
>   security/apparmor/include/lib.h   |    2 +-
>   security/apparmor/include/match.h |    2 +-
>   security/apparmor/include/perms.h |    8 ++++----
>   5 files changed, 8 insertions(+), 8 deletions(-)
> 
> --- linux-next-20250501.orig/security/apparmor/include/cred.h
> +++ linux-next-20250501/security/apparmor/include/cred.h
> @@ -117,7 +117,7 @@ static inline struct aa_label *aa_get_cu
>   #define __end_current_label_crit_section(X) end_current_label_crit_section(X)
>   
>   /**
> - * end_label_crit_section - put a reference found with begin_current_label..
> + * end_current_label_crit_section - put a reference found with begin_current_label..
>    * @label: label reference to put
>    *
>    * Should only be used with a reference obtained with
> --- linux-next-20250501.orig/security/apparmor/include/file.h
> +++ linux-next-20250501/security/apparmor/include/file.h
> @@ -104,7 +104,7 @@ void aa_inherit_files(const struct cred
>   
>   
>   /**
> - * aa_map_file_perms - map file flags to AppArmor permissions
> + * aa_map_file_to_perms - map file flags to AppArmor permissions
>    * @file: open file to map flags to AppArmor permissions
>    *
>    * Returns: apparmor permission set for the file
> --- linux-next-20250501.orig/security/apparmor/include/lib.h
> +++ linux-next-20250501/security/apparmor/include/lib.h
> @@ -170,7 +170,7 @@ struct aa_policy {
>   
>   /**
>    * basename - find the last component of an hname
> - * @name: hname to find the base profile name component of  (NOT NULL)
> + * @hname: hname to find the base profile name component of  (NOT NULL)
>    *
>    * Returns: the tail (base profile name) name component of an hname
>    */
> --- linux-next-20250501.orig/security/apparmor/include/match.h
> +++ linux-next-20250501/security/apparmor/include/match.h
> @@ -17,7 +17,7 @@
>   #define DFA_START			1
>   
>   
> -/**
> +/*
>    * The format used for transition tables is based on the GNU flex table
>    * file format (--tables-file option; see Table File Format in the flex
>    * info pages and the flex sources for documentation). The magic number
> --- linux-next-20250501.orig/security/apparmor/include/perms.h
> +++ linux-next-20250501/security/apparmor/include/perms.h
> @@ -101,8 +101,8 @@ extern struct aa_perms allperms;
>   
>   /**
>    * aa_perms_accum_raw - accumulate perms with out masking off overlapping perms
> - * @accum - perms struct to accumulate into
> - * @addend - perms struct to add to @accum
> + * @accum: perms struct to accumulate into
> + * @addend: perms struct to add to @accum
>    */
>   static inline void aa_perms_accum_raw(struct aa_perms *accum,
>   				      struct aa_perms *addend)
> @@ -128,8 +128,8 @@ static inline void aa_perms_accum_raw(st
>   
>   /**
>    * aa_perms_accum - accumulate perms, masking off overlapping perms
> - * @accum - perms struct to accumulate into
> - * @addend - perms struct to add to @accum
> + * @accum: perms struct to accumulate into
> + * @addend: perms struct to add to @accum
>    */
>   static inline void aa_perms_accum(struct aa_perms *accum,
>   				  struct aa_perms *addend)


Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C9125CC76
	for <linux-security-module@vger.kernel.org>; Fri,  2 May 2025 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202101; cv=none; b=se2CPgPFupIdSQg33Ou6I7cKVTSJ9PlEx+isQz6Wju0NkTfEMOammJHzk1AuNb8HFEhaYeZA9NNynBZTsT41bn3c9W5aHeMUjcmk31e1h2NzGRpKClBtWstbqbPq485pWsQ8sMdJMiBuEPUV6TAoU4aNaMVa3dE/UeaJS5sGM0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202101; c=relaxed/simple;
	bh=EWGiktsus5+/o19nyZqxpCKSl+7liaK/rjrKxK1GacA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9rmsSmj1yGbENv7O4g31aEaAuOPWpHDbNOQmh/01e9X9HfUgegAQXE0qnD/a5zq00zlTzkpIhaB0GEfzaPEtdr3uF8g5t52vMzJo2Tj3xJwWW1ULmORpV3au8JBtkyfNG6jlkFryC755EIrQXcjXaNp1md2bNPNkv8PDxFUjAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Htfg8dlY; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Htfg8dlY"
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5AF313FB81
	for <linux-security-module@vger.kernel.org>; Fri,  2 May 2025 16:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1746202089;
	bh=3CisZnV7pjBTrd6barH3Ffmi1vw4zOqiBAICZChs/hU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Htfg8dlYfXjHLF5GwOlrzQbw21B0YWI9TUM02aNcd55ReS9L8Wqz2AoqELEf5XlrM
	 cWg31GeWU8hrVjGblnoTnXIygsMDi4+4dMa96qC8OKFQ2ReM8WlMA1toIt8tkvd9z1
	 458tm7IKbx7SFu5VMaDUZTSrzeO49xX5/KnkkR4CAuv0on3uEvLaGJ5JrhtYu8GPG2
	 MhJDEgXc9hqHa9V/PvTMVmsC3Gg0yZQ7S81TVXYv0LvoOlvlDgdV6n774XpkwQ/8sF
	 IBbSHOwn6nvg+zd9BSFUy7QNFl+8OChCPDeeUdu501hXTtnA0H9sy4B5ZX7/9Iv6CB
	 8F2o/aNVFVhuA==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac2aa3513ccso155238466b.0
        for <linux-security-module@vger.kernel.org>; Fri, 02 May 2025 09:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746202089; x=1746806889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CisZnV7pjBTrd6barH3Ffmi1vw4zOqiBAICZChs/hU=;
        b=TSsiY9Jk9V7/pg1MhVI+Ir2ACTkbCtLOOFVwj8DMeWDdpQUIaiWjFPYKox+7fk93OY
         UmRWSalhkbyd9FATlj6fPi0EtJ/JiVPMb4mDGqbcjLH+sM6tHxfqRMJtyS5+kUZ2VVLb
         yS1tD+E8qiwVe6xXlqZihuQLZ81J3THhcOK8deN1E9EhtJBkrkuuZIAcxGWC4I6qDNfv
         F0Q6hpenXKCx6xa1/1GDWY/CADb+df6j7NZUOhkIxk6Vfs18q/NjGWZ+wtzq/f9uOjQZ
         CCNaFYnQba3B22CGdAmoMZEkZ2+DJeF6RJrkNyBCwKaOaALEnKoZxoBcRC3gHJKoVTFs
         nsew==
X-Forwarded-Encrypted: i=1; AJvYcCVQbdpO0X44WBEYL3rzSSf61/b/yRIL/8yJF5vQganO4NUMpcjLDxwIWK6JvU5hqZ2CB3E4Z61EOtWfpL1cAD3kz1tIA5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOlKFa4i03NpP3J13gNGJOiK7Gu7pOOVKE87qo0NcV4IES8hE4
	sono0XpU0wId+6ubV2UNQ6S8avDk6BNu/suPSeURyjqQBWanFesv+xXj+JyS3Yft03p2nbsX6Fp
	n6vaeOaLlRNlmw01OeLojFxeuEMCiAha6Ws5SBMqw9fXBPG/10UMrzhrdl4R+W+GG9JkQdL6qfZ
	qt2ViC4aVoWljC+16f6JDZX68wGN1w0zOsjQrL09paFi3Y0kHVeVDUBiAnE/2s7tyV
X-Gm-Gg: ASbGnctt1J85vNb9A+VN71v2gxQp3apt0Jbm1RZAxy1jOQ/t4yMtAei4ZjWWgmVDsN0
	Epjps5t/TwvqW9OooW1hVuQ1rJZABeG0VRZ3tu1oP8EN3NE7QooBVvVqkYcktyOrhJeKY
X-Received: by 2002:a17:907:6e93:b0:ab7:cfe7:116f with SMTP id a640c23a62f3a-ad17af50ba6mr318241066b.46.1746202088759;
        Fri, 02 May 2025 09:08:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr9plp3S4dQ544LaoyFbcAWDmz+kpgB70DWFpnKwx/6/nfuEShDUm7vfsqSJ3aI2C6UpRBZ8JzEemIwm+iSxA=
X-Received: by 2002:a17:907:6e93:b0:ab7:cfe7:116f with SMTP id
 a640c23a62f3a-ad17af50ba6mr318236366b.46.1746202088361; Fri, 02 May 2025
 09:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502014412.682674-1-rdunlap@infradead.org>
In-Reply-To: <20250502014412.682674-1-rdunlap@infradead.org>
From: Ryan Lee <ryan.lee@canonical.com>
Date: Fri, 2 May 2025 09:07:56 -0700
X-Gm-Features: ATxdqUH1VSosWBuE6vF-uqoJMXP5CM2bLoq1d2PsBwhsXzhf70B3sJUNYIK_FnA
Message-ID: <CAKCV-6vV1o6KmPjD3k-LWo-VYEEaZ8QS_tdM=GezT9XH2M=Hng@mail.gmail.com>
Subject: Re: [PATCH] apparmor: fix some kernel-doc issues in header files
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	John Johansen <john@apparmor.net>, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 6:44=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
>

The commit message should also have an introduction like that says
something like "This commit fixes apparmor documentation comment
issues found by [name of the tool you used]:"

> cred.h:128: warning: expecting prototype for end_label_crit_section(). Pr=
ototype was for end_current_label_crit_section() instead
> file.h:108: warning: expecting prototype for aa_map_file_perms(). Prototy=
pe was for aa_map_file_to_perms() instead
>
> lib.h:159: warning: Function parameter or struct member 'hname' not descr=
ibed in 'basename'
> lib.h:159: warning: Excess function parameter 'name' description in 'base=
name'
>
> match.h:21: warning: This comment starts with '/**', but isn't a kernel-d=
oc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * The format used for transition tables is based on the GNU flex table
>  * The format used for transition tables is based on the GNU flex table
>
> perms.h:109: warning: Function parameter or struct member 'accum' not des=
cribed in 'aa_perms_accum_raw'
> perms.h:109: warning: Function parameter or struct member 'addend' not de=
scribed in 'aa_perms_accum_raw'
> perms.h:136: warning: Function parameter or struct member 'accum' not des=
cribed in 'aa_perms_accum'
> perms.h:136: warning: Function parameter or struct member 'addend' not de=
scribed in 'aa_perms_accum'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: John Johansen <john@apparmor.net>
> Cc: apparmor@lists.ubuntu.com
> Cc: linux-security-module@vger.kernel.org
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> ---
>  security/apparmor/include/cred.h  |    2 +-
>  security/apparmor/include/file.h  |    2 +-
>  security/apparmor/include/lib.h   |    2 +-
>  security/apparmor/include/match.h |    2 +-
>  security/apparmor/include/perms.h |    8 ++++----
>  5 files changed, 8 insertions(+), 8 deletions(-)
>
> --- linux-next-20250501.orig/security/apparmor/include/cred.h
> +++ linux-next-20250501/security/apparmor/include/cred.h
> @@ -117,7 +117,7 @@ static inline struct aa_label *aa_get_cu
>  #define __end_current_label_crit_section(X) end_current_label_crit_secti=
on(X)
>
>  /**
> - * end_label_crit_section - put a reference found with begin_current_lab=
el..
> + * end_current_label_crit_section - put a reference found with begin_cur=
rent_label..
>   * @label: label reference to put
>   *
>   * Should only be used with a reference obtained with
> --- linux-next-20250501.orig/security/apparmor/include/file.h
> +++ linux-next-20250501/security/apparmor/include/file.h
> @@ -104,7 +104,7 @@ void aa_inherit_files(const struct cred
>
>
>  /**
> - * aa_map_file_perms - map file flags to AppArmor permissions
> + * aa_map_file_to_perms - map file flags to AppArmor permissions
>   * @file: open file to map flags to AppArmor permissions
>   *
>   * Returns: apparmor permission set for the file
> --- linux-next-20250501.orig/security/apparmor/include/lib.h
> +++ linux-next-20250501/security/apparmor/include/lib.h
> @@ -170,7 +170,7 @@ struct aa_policy {
>
>  /**
>   * basename - find the last component of an hname
> - * @name: hname to find the base profile name component of  (NOT NULL)
> + * @hname: hname to find the base profile name component of  (NOT NULL)
>   *
>   * Returns: the tail (base profile name) name component of an hname
>   */
> --- linux-next-20250501.orig/security/apparmor/include/match.h
> +++ linux-next-20250501/security/apparmor/include/match.h
> @@ -17,7 +17,7 @@
>  #define DFA_START                      1
>
>
> -/**
> +/*
>   * The format used for transition tables is based on the GNU flex table
>   * file format (--tables-file option; see Table File Format in the flex
>   * info pages and the flex sources for documentation). The magic number
> --- linux-next-20250501.orig/security/apparmor/include/perms.h
> +++ linux-next-20250501/security/apparmor/include/perms.h
> @@ -101,8 +101,8 @@ extern struct aa_perms allperms;
>
>  /**
>   * aa_perms_accum_raw - accumulate perms with out masking off overlappin=
g perms
> - * @accum - perms struct to accumulate into
> - * @addend - perms struct to add to @accum
> + * @accum: perms struct to accumulate into
> + * @addend: perms struct to add to @accum
>   */
>  static inline void aa_perms_accum_raw(struct aa_perms *accum,
>                                       struct aa_perms *addend)
> @@ -128,8 +128,8 @@ static inline void aa_perms_accum_raw(st
>
>  /**
>   * aa_perms_accum - accumulate perms, masking off overlapping perms
> - * @accum - perms struct to accumulate into
> - * @addend - perms struct to add to @accum
> + * @accum: perms struct to accumulate into
> + * @addend: perms struct to add to @accum
>   */
>  static inline void aa_perms_accum(struct aa_perms *accum,
>                                   struct aa_perms *addend)
>

With the commit message addition that I mentioned above:

Reviewed-by: Ryan Lee <ryan.lee@canonical.com>

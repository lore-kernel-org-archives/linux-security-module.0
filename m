Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85662F616B
	for <linux-security-module@vger.kernel.org>; Fri,  8 May 2026 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255193; cv=none; b=SzaFTjxtXNG+BI9w5JpD/VxXgJJYFRV8xO7769ryx0f4/ABy3GUYt56s/hFjJPZZ3/yZeXQvD7G2CfbruYlM0B3uEqR6Lm6rENSaAMQu6Y6WZo3HTgrCTAQXzubHiPiTJ1uyxxJHZfYRTdRDF4MDxBz/xMAEDT5v++A941X6Rc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255193; c=relaxed/simple;
	bh=EEJOon7tfD06EhaJJ3xYd6UPI2cRdKrQxDwFIwqo6+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=la14IQmlGVljubDuSNd1fHOFzenf2QrCQCnJDgYXcuTOT681lh/glS5QgWSI5pjhbd/x9Mq3mfCz7JCA9fkMwkmaPPiwDpoF8fHh0UdtBtDTBuZ8GV4PjSz9H/HN5gcpX+1Dol7o0FjxTsH2sTjcHwAF5Z7WUOjkYCY3W0phie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DCkuzeIC; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DCkuzeIC"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso1271526f8f.0
        for <linux-security-module@vger.kernel.org>; Fri, 08 May 2026 08:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778255189; x=1778859989; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LyAmqkwrKoX89qW4LxibMJznEU6mGsZp2ITyzfd5tRU=;
        b=DCkuzeICSfJib9zbpZZt97EX2CrtsGsxTv3RF8yBghXhTdMjCo16sDP/5GdkRhQeJR
         W0/XHMik5zX1WziTxt2nvwWusjf/PyX9V48T6emKeKj6GycoloFAru1VJaloR779MKVc
         lNHuQWSMeskQ7Be0ZAcpkxOlEouO4uqvdxnkoxc72vYC8e+cjfL9/AbDXuAJWq8zVdkD
         EEIc32VIMPjkZzoQmhi9HCKyQwGMKdgJxtGaMQwmS5KBAaSVGNi346seJkiI09sCHtZG
         I5+O7T1akbeUnXb787SGNH4XyOQNoP2KTd6Xm4QCo5q44AVcNmF2KFSImsmEzQ20A6LM
         vPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778255189; x=1778859989;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LyAmqkwrKoX89qW4LxibMJznEU6mGsZp2ITyzfd5tRU=;
        b=XZ5Ksr/+kZ9sz46EBeGR4L2A7v55m+j6AfOUmoN4ucdwfnkpler07R1/1g0YFB5CBg
         25285UJosXUPWe4Hibum+mTXoo+9n/2fWicusiPnVGwVThjJ5buFBfEsGHTROCZSpEXc
         VIQP1mfD3jPuXJM/8L/fDxxdwTaOiogHos2hC6JkVSlEzI86svyoY5QGYsRQe0KewF/D
         mbORlw/3sYdts5t48CVQBpouVItE/DY0cJPl0FsudXdu8QW5mq/79PTYGpqn1njHvpuF
         uJkfcQVNJyWTQTFgCXnZs7ZnoA6zp9k7eaXCk/D8tgfwCFH7Z72vRMsgI8ovcADzi6JZ
         gcPg==
X-Forwarded-Encrypted: i=1; AFNElJ9cuJmtl4fys1JE2fpzbds3C1OHUb8FkSVyIpCGUm/vyVkhL5ArpjfvtwSNTnHABb4FmLjm4b0vFAU65O6fwLamJdtgyUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4HKlrjvR5JBP8oy5uvoVawa859eT2v43Hh8mpxy9iIB9Lp5Hm
	xlh5y70zhtoDwCHHy3KWMjPLmOek1ydM4c+zSu8eoEnPSZ9U2XBETABQNb7jSlNSMg==
X-Gm-Gg: Acq92OHnYYjnRv45Uswzg51l91TZ1/Fsd4zub6qGZlsQMVY/MDZaa+xYSDCpWHSQ5CB
	Rt2URkj3tZPJZuhC/VGCEqi5+eb6Veun7SFhaBqd+la95EzAtqpXYibYbwvJK7ueUTr+yGkAooz
	U5jq7sao4JUmmH80ohBXS/wBeRcUxU9iHAco2jcgcgXGUzEXFF7LRocf+DwvQ0EqAjBwQSJCaad
	Q0MDrkDDZPIgo8a8gKgOFSX2VzFLuTj/nfHhX5OiGhHlozIYoe7Vvcr9wJ+LFm70KSuMRu8Yk6i
	cnrjg/rVxSl9JJYCiwPryBNU084UQTFb9Y0oaUoZdagtkLSInj8M1ESYDq8/zVnx0ska9qOtzcb
	U5s46mg6Sn53qx1qj9SEdIrQOu4W+XmatmMX8POLswzIEXBg3bhZB8/h8wdCMTWRwbszWDuHXQB
	Bbk0MsstCxAw7pHjCHc0npAk74cY/gFD2f2go+HiVjws7kd8pIJc3X4EazMVlku0xx
X-Received: by 2002:a5d:5c89:0:b0:455:51ee:7afb with SMTP id ffacd0b85a97d-45551ee7b88mr993186f8f.2.1778255187085;
        Fri, 08 May 2026 08:46:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:d8c3:543d:1961:f820])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6cd75sm5225603f8f.16.2026.05.08.08.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:46:26 -0700 (PDT)
Date: Fri, 8 May 2026 17:46:21 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Shervin Oloumi <enlightened@google.com>,
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 05/11] landlock: Enforce namespace entry
 restrictions
Message-ID: <af4FTeMtMzb5SRCH@google.com>
References: <20260312100444.2609563-1-mic@digikod.net>
 <20260312100444.2609563-6-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260312100444.2609563-6-mic@digikod.net>

On Thu, Mar 12, 2026 at 11:04:38AM +0100, Mickaël Salaün wrote:
> Add Landlock enforcement for namespace entry via the LSM namespace_alloc
> and namespace_install hooks.  This lets a sandboxed process restrict
> which namespace types it can acquire, using
> LANDLOCK_PERM_NAMESPACE_ENTER and per-type rules.
> 
> Introduce the handled_perm field in struct landlock_ruleset_attr for
> permission categories that control broad operations enforced at single
> kernel chokepoints, achieving complete deny-by-default coverage.  Each
> LANDLOCK_PERM_* flag names a gateway operation (use, enter) whose
> control transitively covers downstream operations.  Rule values
> reference constants from other kernel subsystems (CLONE_NEW* for
> namespaces); unknown values are silently accepted because the allow-list
> denies them by default.  See the "Ruleset restriction models" section in
> the kernel documentation for the full design rationale.
> 
> Add two namespace hooks:
> 
> - hook_namespace_alloc() fires during unshare(CLONE_NEW*) and
>   clone(CLONE_NEW*) via __ns_common_init(), and checks the namespace
>   type against the domain's allowed set.
> 
> - hook_namespace_install() fires during setns() via validate_ns(),
>   performing the same type-based check.  Both hooks set namespace_type
>   in the audit data; hook_namespace_install() also sets inum for the
>   target namespace.
> 
> Both hooks perform a pure bitmask check: if the namespace's CLONE_NEW*
> type is not in the layer's allowed set, the operation is denied.  No
> domain ancestry bypass, no namespace creator tracking, just a flat
> per-layer allowed-types bitmask.
> 
> Add the perm_rules bitfield to struct layer_rights (introduced by a
> preceding commit) to store per-layer namespace type bitmasks.  The 8-bit
> NS field maps to the 8 known namespace types via
> landlock_ns_type_to_bit(), keeping the storage compact.
> 
> LANDLOCK_RULE_NAMESPACE uses struct landlock_namespace_attr with an
> allowed_perm field (matching the pattern of allowed_access in existing
> rule types) and a namespace_types bitmask of CLONE_NEW* flags.  Unknown
> namespace type bits are silently accepted for forward compatibility;
> they have no effect since the allow-list denies by default.
> 
> User namespace creation does not require capabilities, so Landlock can
> restrict it directly.  Non-user namespace types require CAP_SYS_ADMIN
> before the Landlock check is reached; when both
> LANDLOCK_PERM_NAMESPACE_ENTER and LANDLOCK_PERM_CAPABILITY_USE are
> handled, both must allow the operation.
> 
> Five KUnit tests verify the landlock_ns_type_to_bit() and
> landlock_ns_types_to_bits() conversion helpers.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  include/uapi/linux/landlock.h                |  58 +++++-
>  security/landlock/Makefile                   |   1 +
>  security/landlock/access.h                   |  42 ++++-
>  security/landlock/audit.c                    |   4 +
>  security/landlock/audit.h                    |   1 +
>  security/landlock/cred.h                     |  42 +++++
>  security/landlock/limits.h                   |   7 +
>  security/landlock/ns.c                       | 188 +++++++++++++++++++
>  security/landlock/ns.h                       |  74 ++++++++
>  security/landlock/ruleset.c                  |  11 +-
>  security/landlock/ruleset.h                  |  25 ++-
>  security/landlock/setup.c                    |   2 +
>  security/landlock/syscalls.c                 |  70 ++++++-
>  tools/testing/selftests/landlock/base_test.c |   2 +-
>  14 files changed, 509 insertions(+), 18 deletions(-)
>  create mode 100644 security/landlock/ns.c
>  create mode 100644 security/landlock/ns.h
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index f88fa1f68b77..b76e656241df 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -51,6 +51,14 @@ struct landlock_ruleset_attr {
>  	 * resources (e.g. IPCs).
>  	 */
>  	__u64 scoped;
> +	/**
> +	 * @handled_perm: Bitmask of permissions (cf. `Permission flags`_)
> +	 * that this ruleset handles.  Each permission controls a broad
> +	 * operation enforced at a kernel chokepoint: all instances of
> +	 * that operation are denied unless explicitly allowed by a rule.
> +	 * See Documentation/security/landlock.rst for the rationale.
> +	 */
> +	__u64 handled_perm;
>  };
>  
>  /**
> @@ -153,6 +161,11 @@ enum landlock_rule_type {
>  	 * landlock_net_port_attr .
>  	 */
>  	LANDLOCK_RULE_NET_PORT,
> +	/**
> +	 * @LANDLOCK_RULE_NAMESPACE: Type of a &struct
> +	 * landlock_namespace_attr .
> +	 */
> +	LANDLOCK_RULE_NAMESPACE,
>  };
>  
>  /**
> @@ -206,6 +219,24 @@ struct landlock_net_port_attr {
>  	__u64 port;
>  };
>  
> +/**
> + * struct landlock_namespace_attr - Namespace type definition
> + *
> + * Argument of sys_landlock_add_rule() with %LANDLOCK_RULE_NAMESPACE.
> + */
> +struct landlock_namespace_attr {
> +	/**
> +	 * @allowed_perm: Must be set to %LANDLOCK_PERM_NAMESPACE_ENTER.
> +	 */
> +	__u64 allowed_perm;
> +	/**
> +	 * @namespace_types: Bitmask of namespace types (``CLONE_NEW*`` flags)
> +	 * that should be allowed to be entered under this rule.  Unknown bits
> +	 * are silently ignored for forward compatibility.
> +	 */
> +	__u64 namespace_types;
> +};
> +
>  /**
>   * DOC: fs_access
>   *
> @@ -379,6 +410,31 @@ struct landlock_net_port_attr {
>  /* clang-format off */
>  #define LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET		(1ULL << 0)
>  #define LANDLOCK_SCOPE_SIGNAL		                (1ULL << 1)
> -/* clang-format on*/
> +/* clang-format on */
> +
> +/**
> + * DOC: perm
> + *
> + * Permission flags
> + * ~~~~~~~~~~~~~~~~
> + *
> + * These flags restrict broad operations enforced at kernel chokepoints.
> + * Each flag names a gateway operation whose control transitively covers
> + * an open-ended set of downstream operations.  Handled permissions that
> + * are not explicitly allowed by a rule are denied by default.  Rule
> + * values reference constants from other kernel subsystems; unknown values
> + * are silently accepted for forward compatibility since the allow-list
> + * denies them by default.
> + * See Documentation/security/landlock.rst for design details.

It needs an empty line before the "See Documentation/..." for that to be
its own paragraph.

As discussed on the documentation patch, there are a few mentions of
"chokepoints" and "gateways" here and elsehwhere in this commit and commit
message, which should be updated along if that phrasing changes in the
documentation.

(I suggested something like "critical enforcement points" there, and
added a suggestion which delineated the permission flags more in terms
of (a) not being about individual kernel objects and (b) doing
deny-by-default for an open-ended list of operations whose full list is
defined in a more core part of the kernel.)

> + *
> + * - %LANDLOCK_PERM_NAMESPACE_ENTER: Restrict entering (creating or joining
> + *   via :manpage:`setns(2)`) specific namespace types.  A process in a
> + *   Landlock domain that handles this permission is denied from entering
> + *   namespace types that are not explicitly allowed by a
> + *   %LANDLOCK_RULE_NAMESPACE rule.
> + */
> +/* clang-format off */
> +#define LANDLOCK_PERM_NAMESPACE_ENTER			(1ULL << 0)
> +/* clang-format on */
>  
>  #endif /* _UAPI_LINUX_LANDLOCK_H */
> diff --git a/security/landlock/Makefile b/security/landlock/Makefile
> index ffa7646d99f3..734aed4ac1bf 100644
> --- a/security/landlock/Makefile
> +++ b/security/landlock/Makefile
> @@ -8,6 +8,7 @@ landlock-y := \
>  	cred.o \
>  	task.o \
>  	fs.o \
> +	ns.o \
>  	tsync.o
>  
>  landlock-$(CONFIG_INET) += net.o
> diff --git a/security/landlock/access.h b/security/landlock/access.h
> index b3e147771a0e..9c67987a77ae 100644
> --- a/security/landlock/access.h
> +++ b/security/landlock/access.h
> @@ -42,6 +42,8 @@ static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
>  static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_NET);
>  /* Makes sure all scoped rights can be stored. */
>  static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_SCOPE);
> +/* Makes sure all permission types can be stored. */
> +static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_PERM);
>  /* Makes sure for_each_set_bit() and for_each_clear_bit() calls are OK. */
>  static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
>  
> @@ -50,6 +52,7 @@ struct access_masks {
>  	access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
>  	access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
>  	access_mask_t scope : LANDLOCK_NUM_SCOPE;
> +	access_mask_t perm : LANDLOCK_NUM_PERM;
>  };
>  
>  union access_masks_all {
> @@ -61,14 +64,47 @@ union access_masks_all {
>  static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
>  	      sizeof(typeof_member(union access_masks_all, all)));
>  
> +/**
> + * struct perm_rules - Per-layer allowed bitmasks for permission types
> + *
> + * Compact bitfield struct holding the allowed bitmasks for permission
> + * types that use flat (non-tree) per-layer storage.  All fields share
> + * a single 64-bit storage unit.
> + */
> +struct perm_rules {
> +	/**
> +	 * @ns: Allowed namespace types.  Each bit corresponds to a
> +	 * sequential index assigned by the ``_LANDLOCK_NS_*`` enum
> +	 * (derived from ``FOR_EACH_NS_TYPE``).  Bits are converted from
> +	 * ``CLONE_NEW*`` flags at rule-add time via
> +	 * ``landlock_ns_types_to_bits()`` and at enforcement time via
> +	 * ``landlock_ns_type_to_bit()``.
> +	 */
> +	u64 ns : LANDLOCK_NUM_PERM_NS;
> +};
> +
> +static_assert(sizeof(struct perm_rules) == sizeof(u64));
> +
>  /**
>   * struct layer_rights - Per-layer access configuration
>   *
> - * Wraps the handled-access bitfields together with any additional per-layer
> - * data (e.g. allowed bitmasks added by future patches).  This is the element
> - * type of the &struct landlock_ruleset.layers FAM.
> + * Wraps the handled-access bitfields together with per-layer allowed
> + * bitmasks.  This is the element type of the &struct
> + * landlock_ruleset.layers FAM.
> + *
> + * Unlike filesystem and network access rights, which are tracked per-object
> + * in red-black trees, namespace types use a flat bitmask because their
> + * keyspace is small and bounded (~8 namespace types).  A single rule adds
> + * to the allowed set via bitwise OR; at enforcement time each layer is
> + * checked directly (no tree lookup needed).
>   */
>  struct layer_rights {
> +	/**
> +	 * @allowed: Per-layer allowed bitmasks for permission types.
> +	 * Placed before @handled to avoid an internal padding hole
> +	 * (8-byte perm_rules followed by 4-byte access_masks).
> +	 */
> +	struct perm_rules allowed;
>  	/**
>  	 * @handled: Bitmask of access rights handled (i.e. restricted) by
>  	 * this layer.
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index 60ff217ab95b..46a635893914 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -78,6 +78,10 @@ get_blocker(const enum landlock_request_type type,
>  	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
>  		WARN_ON_ONCE(access_bit != -1);
>  		return "scope.signal";
> +
> +	case LANDLOCK_REQUEST_NAMESPACE:
> +		WARN_ON_ONCE(access_bit != -1);
> +		return "perm.namespace_enter";
>  	}
>  
>  	WARN_ON_ONCE(1);
> diff --git a/security/landlock/audit.h b/security/landlock/audit.h
> index 56778331b58c..e9e52fb628f5 100644
> --- a/security/landlock/audit.h
> +++ b/security/landlock/audit.h
> @@ -21,6 +21,7 @@ enum landlock_request_type {
>  	LANDLOCK_REQUEST_NET_ACCESS,
>  	LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
>  	LANDLOCK_REQUEST_SCOPE_SIGNAL,
> +	LANDLOCK_REQUEST_NAMESPACE,
>  };
>  
>  /*
> diff --git a/security/landlock/cred.h b/security/landlock/cred.h
> index 3e2a7e88710e..68067ff53ead 100644
> --- a/security/landlock/cred.h
> +++ b/security/landlock/cred.h
> @@ -153,6 +153,48 @@ landlock_get_applicable_subject(const struct cred *const cred,
>  	return NULL;
>  }
>  
> +/**
> + * landlock_perm_is_denied - Check if a permission bitmask request is denied
> + *
> + * @domain: The enforced domain.
> + * @perm_bit: The LANDLOCK_PERM_* flag to check.
> + * @request_value: Compact bitmask to look for (e.g. result of
> + *                 ``landlock_ns_type_to_bit(CLONE_NEWNET)``).
> + *
> + * Iterate from the youngest layer to the oldest.  For each layer that
> + * handles @perm_bit, check whether @request_value is present in the
> + * layer's allowed bitmask.  Return on the first (youngest) denying
> + * layer.
> + *
> + * Return: The youngest denying layer + 1, or 0 if allowed.
> + */
> +static inline size_t
> +landlock_perm_is_denied(const struct landlock_ruleset *const domain,
> +			const access_mask_t perm_bit, const u64 request_value)
> +{
> +	ssize_t layer;
> +
> +	for (layer = domain->num_layers - 1; layer >= 0; layer--) {
> +		u64 allowed;
> +
> +		if (!(domain->layers[layer].handled.perm & perm_bit))
> +			continue;
> +
> +		switch (perm_bit) {
> +		case LANDLOCK_PERM_NAMESPACE_ENTER:
> +			allowed = domain->layers[layer].allowed.ns;
> +			break;
> +		default:
> +			WARN_ON_ONCE(1);
> +			return layer + 1;
> +		}
> +
> +		if (!(allowed & request_value))
> +			return layer + 1;
> +	}
> +	return 0;
> +}
> +
>  __init void landlock_add_cred_hooks(void);
>  
>  #endif /* _SECURITY_LANDLOCK_CRED_H */
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index eb584f47288d..e361b653fcf5 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -12,6 +12,7 @@
>  
>  #include <linux/bitops.h>
>  #include <linux/limits.h>
> +#include <linux/ns/ns_common_types.h>
>  #include <uapi/linux/landlock.h>
>  
>  /* clang-format off */
> @@ -31,6 +32,12 @@
>  #define LANDLOCK_MASK_SCOPE		((LANDLOCK_LAST_SCOPE << 1) - 1)
>  #define LANDLOCK_NUM_SCOPE		__const_hweight64(LANDLOCK_MASK_SCOPE)
>  
> +#define LANDLOCK_LAST_PERM		LANDLOCK_PERM_NAMESPACE_ENTER
> +#define LANDLOCK_MASK_PERM		((LANDLOCK_LAST_PERM << 1) - 1)
> +#define LANDLOCK_NUM_PERM		__const_hweight64(LANDLOCK_MASK_PERM)
> +
> +#define LANDLOCK_NUM_PERM_NS		__const_hweight64((u64)(CLONE_NS_ALL))
> +
>  #define LANDLOCK_LAST_RESTRICT_SELF	LANDLOCK_RESTRICT_SELF_TSYNC
>  #define LANDLOCK_MASK_RESTRICT_SELF	((LANDLOCK_LAST_RESTRICT_SELF << 1) - 1)
>  
> diff --git a/security/landlock/ns.c b/security/landlock/ns.c
> new file mode 100644
> index 000000000000..fd9e00a295d2
> --- /dev/null
> +++ b/security/landlock/ns.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Landlock - Namespace hooks
> + *
> + * Copyright © 2026 Cloudflare
> + */
> +
> +#include <linux/lsm_audit.h>
> +#include <linux/lsm_hooks.h>
> +#include <linux/ns/ns_common_types.h>
> +#include <linux/ns_common.h>
> +#include <linux/nsproxy.h>
> +#include <uapi/linux/landlock.h>
> +
> +#include "audit.h"
> +#include "cred.h"
> +#include "limits.h"
> +#include "ns.h"
> +#include "ruleset.h"
> +#include "setup.h"
> +
> +/* Ensures the audit inum field can hold ns_common.inum without truncation. */
> +static_assert(sizeof(((struct common_audit_data *)NULL)->u.ns.inum) >=
> +	      sizeof(((struct ns_common *)NULL)->inum));
> +
> +static const struct access_masks ns_perm = {
> +	.perm = LANDLOCK_PERM_NAMESPACE_ENTER,
> +};
> +
> +/**
> + * hook_namespace_alloc - Check namespace entry permission for creation
> + *
> + * @ns: The namespace being initialized.
> + *
> + * Checks if the current domain allows entering (creating) this namespace
> + * type.  Fires during unshare(2) and clone(2) via __ns_common_init() in
> + * kernel/nscommon.c.
> + *
> + * Return: 0 if allowed, -EPERM if namespace creation is denied.
> + */
> +static int hook_namespace_alloc(struct ns_common *const ns)
> +{
> +	const struct landlock_cred_security *subject;
> +	size_t denied_layer;
> +
> +	WARN_ON_ONCE(!(CLONE_NS_ALL & ns->ns_type));
> +
> +	subject =
> +		landlock_get_applicable_subject(current_cred(), ns_perm, NULL);
> +	if (!subject)
> +		return 0;
> +
> +	denied_layer = landlock_perm_is_denied(
> +		subject->domain, LANDLOCK_PERM_NAMESPACE_ENTER,
> +		landlock_ns_type_to_bit(ns->ns_type));
> +	if (!denied_layer)
> +		return 0;
> +
> +	landlock_log_denial(subject, &(struct landlock_request){
> +					     .type = LANDLOCK_REQUEST_NAMESPACE,
> +					     .audit.type = LSM_AUDIT_DATA_NS,
> +					     .audit.u.ns.ns_type = ns->ns_type,
> +					     .layer_plus_one = denied_layer,
> +				     });
> +	return -EPERM;
> +}
> +
> +/**
> + * hook_namespace_install - Check namespace entry permission
> + *
> + * @nsset: The namespace set being modified.
> + * @ns: The namespace being entered.
> + *
> + * Checks if the current domain restricts entering this namespace type.
> + * Fires during setns(2) via validate_ns() in kernel/nsproxy.c.
> + * Uses the same type-based check as hook_namespace_alloc(): the
> + * restriction is on which namespace types the process can enter,
> + * regardless of who created the namespace.
> + *
> + * Return: 0 if entry is allowed, -EPERM if denied.
> + */
> +static int hook_namespace_install(const struct nsset *nsset,
> +				  struct ns_common *ns)
> +{
> +	const struct landlock_cred_security *subject;
> +	size_t denied_layer;
> +
> +	WARN_ON_ONCE(!(CLONE_NS_ALL & ns->ns_type));
> +
> +	subject =
> +		landlock_get_applicable_subject(current_cred(), ns_perm, NULL);
> +	if (!subject)
> +		return 0;
> +
> +	denied_layer = landlock_perm_is_denied(
> +		subject->domain, LANDLOCK_PERM_NAMESPACE_ENTER,
> +		landlock_ns_type_to_bit(ns->ns_type));
> +	if (!denied_layer)
> +		return 0;
> +
> +	landlock_log_denial(subject, &(struct landlock_request){
> +					     .type = LANDLOCK_REQUEST_NAMESPACE,
> +					     .audit.type = LSM_AUDIT_DATA_NS,
> +					     .audit.u.ns.ns_type = ns->ns_type,
> +					     .audit.u.ns.inum = ns->inum,
> +					     .layer_plus_one = denied_layer,
> +				     });
> +	return -EPERM;
> +}
> +
> +static struct security_hook_list landlock_hooks[] __ro_after_init = {
> +	LSM_HOOK_INIT(namespace_alloc, hook_namespace_alloc),
> +	LSM_HOOK_INIT(namespace_install, hook_namespace_install),
> +};
> +
> +__init void landlock_add_ns_hooks(void)
> +{
> +	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
> +			   &landlock_lsmid);
> +}
> +
> +#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
> +
> +#include <kunit/test.h>
> +
> +/* clang-format off */
> +#define _TEST_NS_BIT(struct_name, flag) \
> +	do { \
> +		const u64 bit = landlock_ns_type_to_bit(flag); \
> +		KUNIT_EXPECT_NE(test, 0ULL, bit); \
> +		KUNIT_EXPECT_EQ(test, 0ULL, seen &bit); \
> +		seen |= bit; \
> +	} while (0);
> +/* clang-format on */
> +
> +static void test_ns_type_to_bit(struct kunit *const test)
> +{
> +	u64 seen = 0;
> +
> +	FOR_EACH_NS_TYPE(_TEST_NS_BIT)
> +
> +	KUNIT_EXPECT_EQ(test, GENMASK_ULL(LANDLOCK_NUM_PERM_NS - 1, 0), seen);
> +}
> +
> +static void test_ns_type_to_bit_unknown(struct kunit *const test)
> +{
> +	KUNIT_EXPECT_EQ(test, 0ULL, landlock_ns_type_to_bit(CLONE_THREAD));
> +}
> +
> +static void test_ns_types_to_bits_all(struct kunit *const test)
> +{
> +	KUNIT_EXPECT_EQ(test, GENMASK_ULL(LANDLOCK_NUM_PERM_NS - 1, 0),
> +			landlock_ns_types_to_bits(CLONE_NS_ALL));
> +}
> +
> +/* clang-format off */
> +#define _TEST_NS_SINGLE(struct_name, flag) \
> +	KUNIT_EXPECT_EQ(test, landlock_ns_type_to_bit(flag), \
> +			landlock_ns_types_to_bits(flag));
> +/* clang-format on */
> +
> +static void test_ns_types_to_bits_single(struct kunit *const test)
> +{
> +	FOR_EACH_NS_TYPE(_TEST_NS_SINGLE)
> +}
> +
> +static void test_ns_types_to_bits_zero(struct kunit *const test)
> +{
> +	KUNIT_EXPECT_EQ(test, 0ULL, landlock_ns_types_to_bits(0));
> +}
> +
> +static struct kunit_case test_cases[] = {
> +	KUNIT_CASE(test_ns_type_to_bit),
> +	KUNIT_CASE(test_ns_type_to_bit_unknown),
> +	KUNIT_CASE(test_ns_types_to_bits_all),
> +	KUNIT_CASE(test_ns_types_to_bits_single),
> +	KUNIT_CASE(test_ns_types_to_bits_zero),
> +	{}
> +};
> +
> +static struct kunit_suite test_suite = {
> +	.name = "landlock_ns",
> +	.test_cases = test_cases,
> +};
> +
> +kunit_test_suite(test_suite);
> +
> +#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
> diff --git a/security/landlock/ns.h b/security/landlock/ns.h
> new file mode 100644
> index 000000000000..c731ecc08f8c
> --- /dev/null
> +++ b/security/landlock/ns.h
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Landlock - Namespace hooks
> + *
> + * Copyright © 2026 Cloudflare
> + */
> +
> +#ifndef _SECURITY_LANDLOCK_NS_H
> +#define _SECURITY_LANDLOCK_NS_H
> +
> +#include <linux/bitops.h>
> +#include <linux/bug.h>
> +#include <linux/compiler_attributes.h>
> +#include <linux/ns/ns_common_types.h>
> +#include <linux/types.h>
> +
> +#include "limits.h"
> +
> +/* _LANDLOCK_NS_CLONE_NEWCGROUP, */
> +#define _LANDLOCK_NS_ENUM(struct_name, flag) _LANDLOCK_NS_##flag,
> +
> +/* _LANDLOCK_NS_CLONE_NEWCGROUP = 0, */
> +enum {
> +	FOR_EACH_NS_TYPE(_LANDLOCK_NS_ENUM) _LANDLOCK_NUM_NS_TYPES,
> +};
> +
> +static_assert(_LANDLOCK_NUM_NS_TYPES == LANDLOCK_NUM_PERM_NS);
> +
> +/*
> + * case CLONE_NEWCGROUP:
> + *         return BIT_ULL(_LANDLOCK_NS_CLONE_NEWCGROUP);
> + */
> +/* clang-format off */
> +#define _LANDLOCK_NS_CASE(struct_name, flag) \
> +	case flag: \
> +		return BIT_ULL(_LANDLOCK_NS_##flag);
> +/* clang-format on */
> +
> +static inline __attribute_const__ u64
> +landlock_ns_type_to_bit(const unsigned long ns_type)
> +{
> +	switch (ns_type) {
> +		FOR_EACH_NS_TYPE(_LANDLOCK_NS_CASE)
> +	default:
> +		WARN_ON_ONCE(1);
> +		return 0;
> +	}
> +}
> +
> +/*
> + * if (ns_types & CLONE_NEWCGROUP)
> + *         bits |= BIT_ULL(_LANDLOCK_NS_CLONE_NEWCGROUP);
> + */
> +/* clang-format off */
> +#define _LANDLOCK_NS_CONVERT(struct_name, flag) \
> +	do { \
> +		if (ns_types & (flag)) \
> +			bits |= BIT_ULL(_LANDLOCK_NS_##flag); \
> +	} while (0);
> +/* clang-format on */
> +
> +static inline __attribute_const__ u64
> +landlock_ns_types_to_bits(const u64 ns_types)
> +{
> +	u64 bits = 0;
> +
> +	WARN_ON_ONCE(ns_types & ~CLONE_NS_ALL);
> +	FOR_EACH_NS_TYPE(_LANDLOCK_NS_CONVERT)
> +	return bits;
> +}
> +
> +__init void landlock_add_ns_hooks(void);
> +
> +#endif /* _SECURITY_LANDLOCK_NS_H */
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index a7f8be37ec31..7321e2f19b03 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -53,15 +53,14 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
>  	return new_ruleset;
>  }
>  
> -struct landlock_ruleset *
> -landlock_create_ruleset(const access_mask_t fs_access_mask,
> -			const access_mask_t net_access_mask,
> -			const access_mask_t scope_mask)
> +struct landlock_ruleset *landlock_create_ruleset(
> +	const access_mask_t fs_access_mask, const access_mask_t net_access_mask,
> +	const access_mask_t scope_mask, const access_mask_t perm_mask)
>  {
>  	struct landlock_ruleset *new_ruleset;
>  
>  	/* Informs about useless ruleset. */
> -	if (!fs_access_mask && !net_access_mask && !scope_mask)
> +	if (!fs_access_mask && !net_access_mask && !scope_mask && !perm_mask)
>  		return ERR_PTR(-ENOMSG);
>  	new_ruleset = create_ruleset(1);
>  	if (IS_ERR(new_ruleset))
> @@ -72,6 +71,8 @@ landlock_create_ruleset(const access_mask_t fs_access_mask,
>  		landlock_add_net_access_mask(new_ruleset, net_access_mask, 0);
>  	if (scope_mask)
>  		landlock_add_scope_mask(new_ruleset, scope_mask, 0);
> +	if (perm_mask)
> +		landlock_add_perm_mask(new_ruleset, perm_mask, 0);
>  	return new_ruleset;
>  }
>  
> diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> index 900c47eb0216..747261391c00 100644
> --- a/security/landlock/ruleset.h
> +++ b/security/landlock/ruleset.h
> @@ -190,10 +190,9 @@ struct landlock_ruleset {
>  	};
>  };
>  
> -struct landlock_ruleset *
> -landlock_create_ruleset(const access_mask_t access_mask_fs,
> -			const access_mask_t access_mask_net,
> -			const access_mask_t scope_mask);
> +struct landlock_ruleset *landlock_create_ruleset(
> +	const access_mask_t access_mask_fs, const access_mask_t access_mask_net,
> +	const access_mask_t scope_mask, const access_mask_t perm_mask);
>  
>  void landlock_put_ruleset(struct landlock_ruleset *const ruleset);
>  void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
> @@ -303,6 +302,24 @@ landlock_get_scope_mask(const struct landlock_ruleset *const ruleset,
>  	return ruleset->layers[layer_level].handled.scope;
>  }
>  
> +static inline void
> +landlock_add_perm_mask(struct landlock_ruleset *const ruleset,
> +		       const access_mask_t perm_mask, const u16 layer_level)
> +{
> +	access_mask_t mask = perm_mask & LANDLOCK_MASK_PERM;
> +
> +	/* Should already be checked in sys_landlock_create_ruleset(). */
> +	WARN_ON_ONCE(perm_mask != mask);
> +	ruleset->layers[layer_level].handled.perm |= mask;
> +}
> +
> +static inline access_mask_t
> +landlock_get_perm_mask(const struct landlock_ruleset *const ruleset,
> +		       const u16 layer_level)
> +{
> +	return ruleset->layers[layer_level].handled.perm;
> +}
> +
>  bool landlock_unmask_layers(const struct landlock_rule *const rule,
>  			    struct layer_access_masks *masks);
>  
> diff --git a/security/landlock/setup.c b/security/landlock/setup.c
> index 47dac1736f10..a7ed776b41b4 100644
> --- a/security/landlock/setup.c
> +++ b/security/landlock/setup.c
> @@ -17,6 +17,7 @@
>  #include "fs.h"
>  #include "id.h"
>  #include "net.h"
> +#include "ns.h"
>  #include "setup.h"
>  #include "task.h"
>  
> @@ -68,6 +69,7 @@ static int __init landlock_init(void)
>  	landlock_add_task_hooks();
>  	landlock_add_fs_hooks();
>  	landlock_add_net_hooks();
> +	landlock_add_ns_hooks();
>  	landlock_init_id();
>  	landlock_initialized = true;
>  	pr_info("Up and running.\n");
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 2aa7b50d875f..152d952e98f6 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -20,6 +20,7 @@
>  #include <linux/fs.h>
>  #include <linux/limits.h>
>  #include <linux/mount.h>
> +#include <linux/ns/ns_common_types.h>
>  #include <linux/path.h>
>  #include <linux/sched.h>
>  #include <linux/security.h>
> @@ -34,6 +35,7 @@
>  #include "fs.h"
>  #include "limits.h"
>  #include "net.h"
> +#include "ns.h"
>  #include "ruleset.h"
>  #include "setup.h"
>  #include "tsync.h"
> @@ -95,7 +97,9 @@ static void build_check_abi(void)
>  	struct landlock_ruleset_attr ruleset_attr;
>  	struct landlock_path_beneath_attr path_beneath_attr;
>  	struct landlock_net_port_attr net_port_attr;
> +	struct landlock_namespace_attr namespace_attr;
>  	size_t ruleset_size, path_beneath_size, net_port_size;
> +	size_t namespace_size;
>  
>  	/*
>  	 * For each user space ABI structures, first checks that there is no
> @@ -105,8 +109,9 @@ static void build_check_abi(void)
>  	ruleset_size = sizeof(ruleset_attr.handled_access_fs);
>  	ruleset_size += sizeof(ruleset_attr.handled_access_net);
>  	ruleset_size += sizeof(ruleset_attr.scoped);
> +	ruleset_size += sizeof(ruleset_attr.handled_perm);
>  	BUILD_BUG_ON(sizeof(ruleset_attr) != ruleset_size);
> -	BUILD_BUG_ON(sizeof(ruleset_attr) != 24);
> +	BUILD_BUG_ON(sizeof(ruleset_attr) != 32);
>  
>  	path_beneath_size = sizeof(path_beneath_attr.allowed_access);
>  	path_beneath_size += sizeof(path_beneath_attr.parent_fd);
> @@ -117,6 +122,11 @@ static void build_check_abi(void)
>  	net_port_size += sizeof(net_port_attr.port);
>  	BUILD_BUG_ON(sizeof(net_port_attr) != net_port_size);
>  	BUILD_BUG_ON(sizeof(net_port_attr) != 16);
> +
> +	namespace_size = sizeof(namespace_attr.allowed_perm);
> +	namespace_size += sizeof(namespace_attr.namespace_types);
> +	BUILD_BUG_ON(sizeof(namespace_attr) != namespace_size);
> +	BUILD_BUG_ON(sizeof(namespace_attr) != 16);
>  }
>  
>  /* Ruleset handling */
> @@ -166,7 +176,7 @@ static const struct file_operations ruleset_fops = {
>   * If the change involves a fix that requires userspace awareness, also update
>   * the errata documentation in Documentation/userspace-api/landlock.rst .
>   */
> -const int landlock_abi_version = 8;
> +const int landlock_abi_version = 9;
>  
>  /**
>   * sys_landlock_create_ruleset - Create a new ruleset
> @@ -249,10 +259,16 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
>  	if ((ruleset_attr.scoped | LANDLOCK_MASK_SCOPE) != LANDLOCK_MASK_SCOPE)
>  		return -EINVAL;
>  
> +	/* Checks permission content (and 32-bits cast). */
> +	if ((ruleset_attr.handled_perm | LANDLOCK_MASK_PERM) !=
> +	    LANDLOCK_MASK_PERM)
> +		return -EINVAL;
> +
>  	/* Checks arguments and transforms to kernel struct. */
>  	ruleset = landlock_create_ruleset(ruleset_attr.handled_access_fs,
>  					  ruleset_attr.handled_access_net,
> -					  ruleset_attr.scoped);
> +					  ruleset_attr.scoped,
> +					  ruleset_attr.handled_perm);
>  	if (IS_ERR(ruleset))
>  		return PTR_ERR(ruleset);
>  
> @@ -390,13 +406,57 @@ static int add_rule_net_port(struct landlock_ruleset *ruleset,
>  					net_port_attr.allowed_access);
>  }
>  
> +static int add_rule_namespace(struct landlock_ruleset *const ruleset,
> +			      const void __user *const rule_attr)
> +{
> +	struct landlock_namespace_attr ns_attr;
> +	int res;
> +	access_mask_t mask;
> +
> +	/* Copies raw user space buffer. */
> +	res = copy_from_user(&ns_attr, rule_attr, sizeof(ns_attr));
> +	if (res)
> +		return -EFAULT;
> +
> +	/* Informs about useless rule: empty allowed_perm. */
> +	if (!ns_attr.allowed_perm)
> +		return -ENOMSG;
> +
> +	/* The allowed_perm must match LANDLOCK_PERM_NAMESPACE_ENTER. */
> +	if (ns_attr.allowed_perm != LANDLOCK_PERM_NAMESPACE_ENTER)
> +		return -EINVAL;
> +
> +	/* Checks that allowed_perm matches the @ruleset constraints. */
> +	mask = landlock_get_perm_mask(ruleset, 0);
> +	if (!(mask & LANDLOCK_PERM_NAMESPACE_ENTER))
> +		return -EINVAL;
> +
> +	/* Informs about useless rule: empty namespace_types. */
> +	if (!ns_attr.namespace_types)
> +		return -ENOMSG;
> +
> +	/*
> +	 * Stores only the namespace types this kernel knows about.
> +	 * Unknown bits are silently accepted for forward compatibility:
> +	 * user space compiled against newer headers can pass new
> +	 * CLONE_NEW* flags without getting EINVAL on older kernels.
> +	 * Unknown bits have no effect because no hook checks them.
> +	 */
> +	mutex_lock(&ruleset->lock);
> +	ruleset->layers[0].allowed.ns |= landlock_ns_types_to_bits(
> +		ns_attr.namespace_types & CLONE_NS_ALL);
> +	mutex_unlock(&ruleset->lock);
> +	return 0;
> +}
> +
>  /**
>   * sys_landlock_add_rule - Add a new rule to a ruleset
>   *
>   * @ruleset_fd: File descriptor tied to the ruleset that should be extended
>   *		with the new rule.
>   * @rule_type: Identify the structure type pointed to by @rule_attr:
> - *             %LANDLOCK_RULE_PATH_BENEATH or %LANDLOCK_RULE_NET_PORT.
> + *             %LANDLOCK_RULE_PATH_BENEATH, %LANDLOCK_RULE_NET_PORT, or
> + *             %LANDLOCK_RULE_NAMESPACE.
>   * @rule_attr: Pointer to a rule (matching the @rule_type).
>   * @flags: Must be 0.
>   *
> @@ -446,6 +506,8 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
>  		return add_rule_path_beneath(ruleset, rule_attr);
>  	case LANDLOCK_RULE_NET_PORT:
>  		return add_rule_net_port(ruleset, rule_attr);
> +	case LANDLOCK_RULE_NAMESPACE:
> +		return add_rule_namespace(ruleset, rule_attr);
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index 0fea236ef4bd..30d37234086c 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -76,7 +76,7 @@ TEST(abi_version)
>  	const struct landlock_ruleset_attr ruleset_attr = {
>  		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
>  	};
> -	ASSERT_EQ(8, landlock_create_ruleset(NULL, 0,
> +	ASSERT_EQ(9, landlock_create_ruleset(NULL, 0,
>  					     LANDLOCK_CREATE_RULESET_VERSION));
>  
>  	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
> -- 
> 2.53.0
> 

Documentation remarks above are minor, please feel free to tag as reviewed.
I could not find any issues in the code.

Reviewed-by: Günther Noack <gnoack@google.com>

—Günther

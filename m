Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E8A23E35F;
	Sun,  9 Aug 2026 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786291294; cv=none; b=RJ85GjS0bFTma5IsAEA2AQkr/KW9UXca1KoD12/oEdehBMa3rI1o1aYXgUrbX6xmAGWQ8X8tmKse0Mwpe26AQvXN4TvROMKoR5z9kkG01aKGLZv6TwZQh2uNsZfs7MtiQyvTlG47hCPmWTL/3URQ2aT9lrPmJFjjRrTZojjIl+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786291294; c=relaxed/simple;
	bh=V2ZLATU6OMYm4kKb5m3F4F0djawlb23zO7cZBC235ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBP4nQmBnG5N3W+bYosOYNUCUBspgUs7p+d5O1Ca+KGTMX6QH+f39qZHlE9IlDvpuCJmMwPSyMdfdTuworNqDNea7N9iE5o8YOSGCV7I6X4HLgN3z0t1LNJyvuQAoCydc5tsUDSCw48SO0LTbaBLz7umPWDaQvx7RKblGzdMK4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=LqZbcXmv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gZtyK/VR; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="LqZbcXmv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gZtyK/VR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 07E4FEC0081;
	Sun,  9 Aug 2026 12:01:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 09 Aug 2026 12:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786291292;
	 x=1786377692; bh=UUOu5oiNKvrMuaqtBdhykLRb9MgHpIgeON4nzXEd0Zk=; b=
	LqZbcXmv3a3mDPOiC6vZ/JdnMG6H0ASp0Xaiza03/Ozu5usKaA0gSbK+AsshuDqh
	CVo5RJC+7u7wHxhmCDKQN9HZObUsqsCgTX+jCSDpa1ouczOlqWNnRCnj55qBSpnd
	lJiQS0rr1JFD9zPI4XCYoxjT8hr6b0mh8cFlneCOK4sPFCdcESexUgUdsmG6Y0nB
	fIP9eImTbRtt0RUf9LtczuRyw2nqmGJW1hJodtEQJQQoCAwHbKhVzoCpiURW7C5v
	Af7deNMpvooqYveB0uTHYpuJKKkoeORHQ/PHlD3ahrSMAAXhZ0ci3GJB5f8x3Aav
	daWrSKMvZpjBHTf26HY52Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786291292; x=
	1786377692; bh=UUOu5oiNKvrMuaqtBdhykLRb9MgHpIgeON4nzXEd0Zk=; b=g
	ZtyK/VRrzaToOIm/JvW4KxXZSskJjUFFOA46wFfX8F9Wx6oCrq2I9n/pwwuU+sUG
	UhwnWNKtdwUV6F/YEcF62JUqLVR4tf4LRkDqqTaGZrJo6w9ktFCHiuSy1EAOWr4e
	MD1IE0S6C8xzCoKu44nETr26EtMjUFIfgog0BxZ5ovU4+q2WKOs8zRi59c8oRGnB
	Up95298g5fYLyzCg495WAG1ZXc8odEd5hUMil2zBkquS7C8lz8ELayuCYWMEr3fo
	RSN54yUlLixrM1891fokAVX9dwYvMnTS+0dFdt0FQEXbkKHqUi+ihsyKqWkYoOjj
	IfpTbNALYbhDMgnMf9PwA==
X-ME-Sender: <xms:WqR4ajezSxw67c_NvD969GyVvz4vTxVh3oLnNKyC6e4liYpIkPVhvw>
    <xme:WqR4akb28cc8nWnICyCXk6uDsAnyzp2NjribLxpKtQNi7VWDVh3QdxVTnoOSxrNHM
    F6A_aCDnZe9eSP7Uo_MxDFULTBFtpxj7pcSB_wI11lCSJ3r3lXTAH_6>
X-ME-Received: <xmr:WqR4agU-CX6tU205zUIQOlGH64H_lkiJ4aOd57As5wAMC9dPHP_gXlaP4OaTbcSTWwYhZ5tXAcwlMNrP5w>
X-ME-Proxy-Cause: dmFkZTGFKym0mHFhte0kEv3lr+V2vFiY8MtMWP7QK9luEB3ghaxj/Jo6mlNaSrWQAJJKxT
    ScBUawq81M8MZYroSikVNGHmWag6KfdKkl302UDm2ec7ukwDlPlHvY1G6Z0+bqDXMnzUcw
    zDp//uQvGCPe8D+Eo1WCNFPbbkdDHoxMYB9kgR8EjfpUBSx0x23OtDr7R1PSanVB8LG5o/
    t4ulDf2TVjwZ3M0uaedMQpstoySuK11wArM+hc2cReZv3x6HADn1IIG0reeLEb1u0mMyLc
    9g4usVbsNv/xduECqgvL8ULiXCHEwAxxLaQIgucktvDjijzFLNSQlxUPnRmiYyBTW8S4HA
    CoPweE9z2KBb3ei0j3rYvznS7MXZ0A9PcK5G3QC8noTfj4E1zQnFeRJ9XgxLU79tmRQHNQ
    S6PMXZGR52tBPaKJ3PTHfQffCdhHVwQmGIXlp6FEyQlsKobycUzUfmFXUMDqBJM7d5WAH5
    ZDMPIqgEy9BVQ2lN3IRS9dKKiGfcDfX/C0nYek3vRgMxTLl75GQxMeGyZSe0RcqrGYYpQa
    11+vIOEium4dRybitjRjuO4NY6wwnpDMNqyqB9s1M9lvVnu5B8LWCET8XkZ5st7Vnhj13h
    lqIv73qbW+W1fA2NAkJEmYTwUlvISn21xRB6Slc5eLa9tc3umtafMH1CXjKQ
X-ME-Proxy: <xmx:WqR4avTr8FhT7E6Vp9MP5o5OJBU2Rses9EcPvjzJoeCvXzlZE0v3hQ>
    <xmx:WqR4atF4Ax1p-vG8B6UW2rVDbNi_89XRNquu7iRTbtQRc7SEABjwtw>
    <xmx:WqR4amfZp9EHsag-DfH8nhRHJ5dYClrzMNjkne4H3Gi4Yp3-MDxesQ>
    <xmx:WqR4asLZAhhsbVyAYn29eoUo6ygnbpf-JXcGvw7Cbvu1cKy8Ip1H6g>
    <xmx:XKR4aiAUMSc-vhy98oYTfMq6QAJFVypK9IEha7cvgyh1BtLm9MImI98P>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Aug 2026 12:01:28 -0400 (EDT)
Message-ID: <2785c970-8df3-4b74-b428-526c65d8c652@maowtm.org>
Date: Sun, 9 Aug 2026 17:01:28 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/12] landlock: Enforce namespace use restrictions
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, Paul Moore <paul@paul-moore.com>,
 "Serge E . Hallyn" <serge@hallyn.com>,
 Daniel Durning <danieldurning.work@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Justin Suess <utilityemal77@gmail.com>,
 Lennart Poettering <lennart@poettering.net>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Shervin Oloumi <enlightened@google.com>, kernel-team@cloudflare.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20260726161400.3010511-1-mic@digikod.net>
 <20260726161400.3010511-8-mic@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260726161400.3010511-8-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/26/26 17:13, Mickaël Salaün wrote:
> Add Landlock enforcement for namespace use via the LSM namespace_init
> and namespace_install hooks.  This lets a sandboxed process restrict
> which namespace types it can acquire, using LANDLOCK_PERM_NAMESPACE_USE
> and per-type rules.
> 
> Introduce the handled_perm field in struct landlock_ruleset_attr for
> per-category permissions: each permission gates all uses of a
> kernel-defined category (CLONE_NEW* for namespace types, CAP_* for
> capabilities) and provides complete deny-by-default coverage of category
> members.  Rule values reference constants from other kernel subsystems
> (CLONE_NEW* for namespaces); unknown values are silently accepted
> because the allow-list denies them by default.  See the "Ruleset
> restriction models" section in the kernel documentation for the full
> design rationale.
> 
> The new permissions extend the UAPI, so this bumps the Landlock ABI
> version to 11.
> 
> Both hooks share check_ns_type(): if the namespace's CLONE_NEW* type is
> not in the layer's allowed set, the operation is denied.  No domain
> ancestry bypass, no namespace creator tracking, just a flat per-layer
> allowed-types bitmask.
> 
> - hook_namespace_init() fires during unshare(CLONE_NEW*) and
>   clone(CLONE_NEW*) via __ns_common_init().
> 
> - hook_namespace_install() fires during setns() via validate_ns().
> 
> Both record namespace_type and ns_id in the audit data; ns_id is zero at
> namespace creation.
> 
> struct perm_masks is __packed __aligned(sizeof(u64)) because on m68k GCC
> packs bitfields at byte granularity, so without it a u64 bitfield struct
> can be smaller than sizeof(u64).

(The reason for forcing u64 is not obvious just from this patch alone, but
it makes sense after adding 40 capability bits in the patch following)

> 
> The rule's perm selector must be LANDLOCK_PERM_NAMESPACE_USE and
> reserves room for future per-rule-type sub-permissions.
> allowed_namespace_types lists the allowed CLONE_NEW* flags; unknown bits
> are accepted for forward compatibility and have no effect since the
> allow-list denies by default.
> 
> The rule also carries a quiet_namespace_types bitmask that silences the
> audit records of specific denied members without granting them.  A
> sandbox that knowingly runs a caller probing a namespace type or
> capability it will never be granted (e.g. an old runtime kept for
> compatibility) would otherwise flood the audit log and drown the
> surprising denials that matter.  Quiet is per-member rather than a
> coarse per-category ruleset bit so a sandbox can silence one member
> (CLONE_NEWNET) while still auditing another (CLONE_NEWUTS).  Making
> quiet the complement of the allowed set would be broad, could not audit
> a member that is neither allowed nor explicitly quieted, and would
> auto-hide members added by future kernels.  For the same reason a
> sandbox should quiet only specific members known to be requested but
> expected to be denied, never a blanket set, which follows the running
> kernel's known members and hides surprising or future denials.  A bit
> set in both allowed_namespace_types and quiet_namespace_types has no
> effect, since an allowed member is never denied and its layer can never
> become the youngest denying layer for that member.

I agree this uAPI makes more sense, having a quiet_perm is a bit wasteful
given that the quiet configuration for perms can be determined solely via
the struct landlock_namespace_attr.

> 
> The merged filesystem and network quiet feature marks unbounded rb-tree
> objects (paths, ports) quiet through the LANDLOCK_ADD_RULE_QUIET flag
> and the ruleset quiet_access_* masks.  Capabilities and namespace types
> are instead a small, bounded, kernel-defined member set, so their quiet
> list is a per-rule bitmask sibling to the allowed bitmask, and the
> shared flag is rejected for these rule types.  A single add_rule call
> can allow some members and quiet others independently, and a quiet-only
> rule (empty allowed set) is valid.  Only the youngest denying layer's
> quiet mask decides, so a parent cannot silence a denial made by a deeper
> layer.
> 
> [...]
> @@ -268,6 +281,40 @@ struct landlock_net_port_attr {
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
> +	 * @perm: Must be set to %LANDLOCK_PERM_NAMESPACE_USE.
> +	 */
> +	__u64 perm;
> +	/**
> +	 * @allowed_namespace_types: Bitmask of namespace types (``CLONE_NEW*``
> +	 * flags) to allow under this rule.  Unknown bits are silently ignored
> +	 * for forward compatibility.
> +	 */
> +	__u64 allowed_namespace_types;
> +	/**
> +	 * @quiet_namespace_types: Bitmask of namespace types (``CLONE_NEW*``
> +	 * flags) whose denial by this layer should not be logged, even if
> +	 * logging would normally take place per landlock_restrict_self() flags.
> +	 * Only denials attributed to this layer are suppressed (see `permission
> +	 * flags`_).  Bits also set in @allowed_namespace_types have no effect,
> +	 * since an allowed type is never denied.  Unknown bits are silently
> +	 * ignored.
> +	 *
> +	 * At least one of @allowed_namespace_types or @quiet_namespace_types
> +	 * must be non-zero, otherwise the call returns ``-ENOMSG``.  The

Worth noting here that if a layer does not want to allow nor quiet any
bits it should just not do the landlock_add_rule.

> +	 * non-zero check runs on the raw input before unknown-bit masking, so a
> +	 * rule that sets only bits unknown to the running kernel succeeds but
> +	 * has no runtime effect.
> +	 */
> +	__u64 quiet_namespace_types;
> +};
> +
>  /**
>   * DOC: fs_access
>   *
> [...]
> diff --git a/security/landlock/domain.h b/security/landlock/domain.h
> index 56cceed5f50c..c2b72795b0d6 100644
> --- a/security/landlock/domain.h
> +++ b/security/landlock/domain.h
> @@ -116,6 +116,12 @@ struct landlock_hierarchy {
>  	 * logged) if the related object is marked as quiet.
>  	 */
>  	struct access_masks quiet_access;

I'm not sure if this is worth adjusting or mentioning in a comment but
basically quiet_access.perm is unused.

> +	/**
> +	 * @quiet_perm: Per-member quiet bitmasks for permission types
> +	 * (capabilities and namespace types).  A member denied by this layer is
> +	 * not logged when its bit is set here.
> +	 */
> +	struct perm_masks quiet_perm;
>  #endif /* CONFIG_AUDIT */
>  };
>  
> [...]

Reviewed-by: Tingmao Wang <m@maowtm.org>

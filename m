Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB2C2BDC0E
	for <linux-security-module@vger.kernel.org>; Sun, 14 Dec 2025 22:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765752824; cv=none; b=Ef7z//nFFeKHaijrwbbNKJrAEhWskX7hWvrzn8IoP7Ju3TbVEmkSvesLLts3QxudT95xUsqlUwcxln8ddMY2HrSJEorGKA5wpcbkgaBG0pWbmQ7/nnk1BcvDUMhgD+H3xl00XYwBQVNHKV0tDjZMuocl5mfNvMHcz3YjyJ8asNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765752824; c=relaxed/simple;
	bh=o36GwUK3KHqUFQeieDaKGhvn/HhOXehWyZj1pKTvcbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmciZCNAXXbJpH1TCAH4VVmPWBX2CAMZlRKajFSpbdFPgCrqxDynn+9eoJI7lcIPvSBQBMKREsBOm2wbW3+By0AfqkGoxN3JInGiwfWI9FhbMkkBrr6sch/fV2I67RJ6PSqWipv+3wgByfav+JnuiV28GlPlQ1OhUk1UbuydJx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Gnp56A7H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u9W4H7hP; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Gnp56A7H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u9W4H7hP"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 951A07A0074;
	Sun, 14 Dec 2025 17:53:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 14 Dec 2025 17:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765752820;
	 x=1765839220; bh=Vnz9yfJers5xrUKFjyXYznbWDrhz3LSl5L+nQjLKX/E=; b=
	Gnp56A7H5dNtOrsAWhxWvSuNm3FTZcUvRWgZwa0yOBa/JaGLxxc46PmVUs5RUuPA
	bPX6P/+9lHztO20KWBVOs4ErEsnYnpmk/HI4gw8r0mOLd3/MzFzqhtK1fQbXl5io
	mLtJz6ras5JDEMPeHbJMKbPvHAuYOdYn1ASsk7uQ2JyA4OadvvlnzR9WmrzUscq+
	0jlFNoR22nZGj9i1OCRkD9TZJQ8OuRd6ziNYrKTEXrDsn9ZNOFg17aVH0Vsk9Xs4
	ZFyM12RTESp69qe8N1myQ6bH9Ld4fdnP+6sjD20OENr/yfE9IPQl47S0zhNc1tfd
	MvZdVFpQmRZtpAoWbbDnEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765752820; x=
	1765839220; bh=Vnz9yfJers5xrUKFjyXYznbWDrhz3LSl5L+nQjLKX/E=; b=u
	9W4H7hPmLizTiJ9lOIqBUmEvp0Wg8sdy3LLO3gZaE32SBzhQ0zfuwc8gaqO6DOLw
	KaNcSDupHlsf2pBTPs0ZsnWR1j5uRGSi4Y3v0hOAhxjZfVFCo/8wSHM+5bJUKoyf
	jKoiha7yMpWXVSm8ZYmDjQGPnq3RRlqClS40b9wMiCk6pxKSoeZsWGJHwmRzHivZ
	nQaaQSUHErNKrCh9sLBKqrdUxZZZcqMQzvy8oXrUw6rtQRC5riuYz3AUuov6+2DF
	TV+x9YOSepkZF9yZarO4FPCDUINQ5TvAmFJ3y3K9IzMH/+AGGzxQXz+k9YzknftX
	YRNddQFKhqReZq49ndtig==
X-ME-Sender: <xms:9D8_adesGmChtryQgUlpWWWSvEICNxgF4vqruQs-rnvKBonFpVRKMw>
    <xme:9D8_ae4CSqICdNlvC0O2ucM1b6Oyvy5C65zZCIPt_RfxzjiEHeOGNOOncctN8Ug3B
    TpDv1sTzCn3Lf_6GrP3LOwGZpZU4TM28uTfxtnIDOt0ASU_V8rHMceH>
X-ME-Received: <xmr:9D8_aQVuUPi1tcgva3bNgatyydvOys6weJX3pE4F0yPi7Anxd526cvHhxIN5vVbJ_SnHcKOKAAyJzhaa2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefhedukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepvfhinhhgmhgr
    ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeefvd
    ehleeutdfhlefgvedvgfeklefgleekgedtvdehvdfgtdefieelhfdutefgudenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
    drohhrghdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepuhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphhtthhopehmih
    gtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdr
    tghomhdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopeigrghnug
    hfuhhrhiesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihht
    hidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9D8_ad7FoKO9M2-iFrlXJJC56hV_mUfsaau0vG7-j75fmISupQOEwQ>
    <xmx:9D8_abqCV3CEJMqW0yIS2quInPClGOJaFQrzlGABjJvQewxUrR9BsA>
    <xmx:9D8_aQnkXdORChjXL7JiSRmE7epmqky27hKDJTCq1UcR706UQwoOhQ>
    <xmx:9D8_aXOkLm5CqV2zwhvMgXQw4pHlMIfmVbvZuSUb2W-faJyIMtVPRw>
    <xmx:9D8_aeimO1BiNKIkuaXUDkSX2b_HdpfBp7ygzkNX2vw0FMv08Ig8O7H0>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Dec 2025 17:53:37 -0500 (EST)
Message-ID: <ef02e290-84b0-4de9-85aa-bf94d38c0c44@maowtm.org>
Date: Sun, 14 Dec 2025 22:53:35 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, Jan Kara <jack@suse.cz>,
 Abhinav Saxena <xandfury@gmail.com>, linux-security-module@vger.kernel.org
References: <20251214170548.408142-1-utilityemal77@gmail.com>
 <20251214170548.408142-2-utilityemal77@gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20251214170548.408142-2-utilityemal77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/14/25 17:05, Justin Suess wrote:
> [...]
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index d4f47d20361a..6ab3e7bd1c81 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -127,10 +127,39 @@ struct landlock_ruleset_attr {
>   *     allowed_access in the passed in rule_attr.  When this flag is
>   *     present, the caller is also allowed to pass in an empty
>   *     allowed_access.
> + * %LANDLOCK_ADD_RULE_NO_INHERIT
> + *     When set on a rule being added to a ruleset, this flag disables the
> + *     inheritance of access rights and flags from parent objects.
> + *
> + *     This flag currently applies only to filesystem rules.  Adding it to
> + *     non-filesystem rules will return -EINVAL, unless future extensions
> + *     of Landlock define other hierarchical object types.
> + *
> + *     By default, Landlock filesystem rules inherit allowed accesses from
> + *     ancestor directories: if a parent directory grants certain rights,
> + *     those rights also apply to its children.  A rule marked with
> + *     LANDLOCK_ADD_RULE_NO_INHERIT stops this propagation at the directory
> + *     covered by the rule.  Descendants of that directory continue to inherit
> + *     normally unless they also have rules using this flag.
> + *
> + *     If a regular file is marked with this flag, it will not inherit any
> + *     access rights from its parent directories; only the accesses explicitly
> + *     allowed by the rule will apply to that file.
> + *
> + *     This flag also enforces parent-directory restrictions: rename, rmdir,
> + *     link, and other operations that would change the directory's immediate
> + *     parent subtree are denied up to the VFS root.  This prevents
> + *     sandboxed processes from manipulating the filesystem hierarchy to evade
> + *     restrictions (e.g., via sandbox-restart attacks).
> + *
> + *     In addition, this flag blocks the inheritance of rule-layer flags

tbh I feel that it's less confusing to just say "rule flags" (instead of
"rule-layer flags").

> + *     (such as the quiet flag) from parent directories to the object covered
> + *     by this rule.
>   */
>
>  /* clang-format off */
>  #define LANDLOCK_ADD_RULE_QUIET			(1U << 0)
> +#define LANDLOCK_ADD_RULE_NO_INHERIT		(1U << 1)
>  /* clang-format on */
>
>  /**
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 0b589263ea42..8d8623ea857f 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -317,6 +317,37 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>  	LANDLOCK_ACCESS_FS_IOCTL_DEV)
>  /* clang-format on */
>
> +enum landlock_walk_result {
> +	LANDLOCK_WALK_CONTINUE,
> +	LANDLOCK_WALK_STOP_REAL_ROOT,
> +	LANDLOCK_WALK_MOUNT_ROOT,
> +};
> +
> +static enum landlock_walk_result landlock_walk_path_up(struct path *const path)
> +{
> +	while (path->dentry == path->mnt->mnt_root) {
> +		if (!follow_up(path))
> +			return LANDLOCK_WALK_STOP_REAL_ROOT;
> +	}
> +
> +	if (unlikely(IS_ROOT(path->dentry))) {
> +		if (likely(path->mnt->mnt_flags & MNT_INTERNAL))
> +			return LANDLOCK_WALK_MOUNT_ROOT;

imo, LANDLOCK_WALK_MOUNT_ROOT is a somewhat confusing name for this,
especially in the context that if we see this in
is_access_to_paths_allowed() we allow access unconditionally.

Would LANDLOCK_WALK_INTERNAL be a better name here?

> +		dput(path->dentry);
> +		path->dentry = dget(path->mnt->mnt_root);
> +		return LANDLOCK_WALK_CONTINUE;
> +	}
> +
> +	struct dentry *const parent = dget_parent(path->dentry);
> +
> +	dput(path->dentry);
> +	path->dentry = parent;
> +	return LANDLOCK_WALK_CONTINUE;
> +}
> +
> +static const struct landlock_rule *find_rule(const struct landlock_ruleset *const domain,
> +					     const struct dentry *const dentry);
> +
>  /*
>   * @path: Should have been checked by get_path_from_fd().
>   */
> @@ -344,6 +375,48 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>  		return PTR_ERR(id.key.object);
>  	mutex_lock(&ruleset->lock);
>  	err = landlock_insert_rule(ruleset, id, access_rights, flags);
> +	if (err || !(flags & LANDLOCK_ADD_RULE_NO_INHERIT))
> +		goto out_unlock;
> +
> +	/* Create ancestor rules and set has_no_inherit_descendant flags */
> +	struct path walker = *path;
> +
> +	path_get(&walker);
> +	while (landlock_walk_path_up(&walker) != LANDLOCK_WALK_STOP_REAL_ROOT) {

Why not landlock_walk_path_up(&walker) == LANDLOCK_WALK_CONTINUE here?
I'm not sure if it's actually possible to end up with an infinite loop by
ignoring LANDLOCK_WALK_MOUNT_ROOT (i.e. not sure if "internal" mounts can
have disconnected dentries), but it seems safer to write to loop in a way
such that if that happens, we exit.

> +		struct landlock_rule *ancestor_rule;
> +
> +		if (WARN_ON_ONCE(!walker.dentry || d_is_negative(walker.dentry))) {
> +			err = -EIO;
> +			break;
> +		}
> +
> +		ancestor_rule = (struct landlock_rule *)find_rule(ruleset, walker.dentry);
> +		if (!ancestor_rule) {
> +			struct landlock_id ancestor_id = {
> +				.type = LANDLOCK_KEY_INODE,
> +				.key.object = get_inode_object(d_backing_inode(walker.dentry)),
> +			};
> +
> +			if (IS_ERR(ancestor_id.key.object)) {
> +				err = PTR_ERR(ancestor_id.key.object);
> +				break;
> +			}
> +			err = landlock_insert_rule(ruleset, ancestor_id, 0, 0);
> +			landlock_put_object(ancestor_id.key.object);
> +			if (err)
> +				break;
> +
> +			ancestor_rule = (struct landlock_rule *)
> +				find_rule(ruleset, walker.dentry);
> +		}
> +		if (WARN_ON_ONCE(!ancestor_rule || ancestor_rule->num_layers != 1)) {
> +			err = -EIO;
> +			break;
> +		}
> +		ancestor_rule->layers[0].flags.has_no_inherit_descendant = true;
> +	}
> +	path_put(&walker);
> +out_unlock:
>  	mutex_unlock(&ruleset->lock);
>  	/*
>  	 * No need to check for an error because landlock_insert_rule()
> @@ -772,8 +845,10 @@ static bool is_access_to_paths_allowed(
>  		_layer_masks_child2[LANDLOCK_NUM_ACCESS_FS];
>  	layer_mask_t(*layer_masks_child1)[LANDLOCK_NUM_ACCESS_FS] = NULL,
>  	(*layer_masks_child2)[LANDLOCK_NUM_ACCESS_FS] = NULL;
> -	struct collected_rule_flags *rule_flags_parent1 = &log_request_parent1->rule_flags;
> -	struct collected_rule_flags *rule_flags_parent2 = &log_request_parent2->rule_flags;
> +	struct collected_rule_flags *rule_flags_parent1 =
> +		&log_request_parent1->rule_flags;
> +	struct collected_rule_flags *rule_flags_parent2 =
> +		log_request_parent2 ? &log_request_parent2->rule_flags : NULL;

Good point, I think the original was still safe because it would not be
used by landlock_unmask_layers anyway, but this is better.  I will take
this in the next version, thanks!

>
>  	if (!access_request_parent1 && !access_request_parent2)
>  		return true;
> @@ -784,7 +859,7 @@ static bool is_access_to_paths_allowed(
>  	if (is_nouser_or_private(path->dentry))
>  		return true;
>
> -	if (WARN_ON_ONCE(!layer_masks_parent1))
> +	if (WARN_ON_ONCE(!layer_masks_parent1 || !log_request_parent1))
>  		return false;
>
>  	allowed_parent1 = is_layer_masks_allowed(layer_masks_parent1);
> @@ -851,6 +926,7 @@ static bool is_access_to_paths_allowed(
>  	 */
>  	while (true) {
>  		const struct landlock_rule *rule;
> +		enum landlock_walk_result walk_res;
>
>  		/*
>  		 * If at least all accesses allowed on the destination are
> @@ -910,46 +986,14 @@ static bool is_access_to_paths_allowed(
>  		if (allowed_parent1 && allowed_parent2)
>  			break;
>
> -jump_up:
> -		if (walker_path.dentry == walker_path.mnt->mnt_root) {
> -			if (follow_up(&walker_path)) {
> -				/* Ignores hidden mount points. */
> -				goto jump_up;
> -			} else {
> -				/*
> -				 * Stops at the real root.  Denies access
> -				 * because not all layers have granted access.
> -				 */
> -				break;
> -			}
> -		}
> -
> -		if (unlikely(IS_ROOT(walker_path.dentry))) {
> -			if (likely(walker_path.mnt->mnt_flags & MNT_INTERNAL)) {
> -				/*
> -				 * Stops and allows access when reaching disconnected root
> -				 * directories that are part of internal filesystems (e.g. nsfs,
> -				 * which is reachable through /proc/<pid>/ns/<namespace>).
> -				 */
> -				allowed_parent1 = true;
> -				allowed_parent2 = true;
> -				break;
> -			}
> -
> -			/*
> -			 * We reached a disconnected root directory from a bind mount.
> -			 * Let's continue the walk with the mount point we missed.
> -			 */

I think we might want to preserve these comments.

> -			dput(walker_path.dentry);
> -			walker_path.dentry = walker_path.mnt->mnt_root;
> -			dget(walker_path.dentry);
> -		} else {
> -			struct dentry *const parent_dentry =
> -				dget_parent(walker_path.dentry);
> -
> -			dput(walker_path.dentry);
> -			walker_path.dentry = parent_dentry;
> +		walk_res = landlock_walk_path_up(&walker_path);
> +		if (walk_res == LANDLOCK_WALK_MOUNT_ROOT) {
> +			allowed_parent1 = true;
> +			allowed_parent2 = true;
> +			break;
>  		}
> +		if (walk_res != LANDLOCK_WALK_CONTINUE)
> +			break;
>  	}
>  	path_put(&walker_path);
>
> @@ -963,7 +1007,7 @@ static bool is_access_to_paths_allowed(
>  			ARRAY_SIZE(*layer_masks_parent1);
>  	}
>
> -	if (!allowed_parent2) {
> +	if (!allowed_parent2 && log_request_parent2) {
>  		log_request_parent2->type = LANDLOCK_REQUEST_FS_ACCESS;
>  		log_request_parent2->audit.type = LSM_AUDIT_DATA_PATH;
>  		log_request_parent2->audit.u.path = *path;
> @@ -1037,8 +1081,8 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
>   * collect_domain_accesses - Walk through a file path and collect accesses
>   *
>   * @domain: Domain to check against.
> - * @mnt_root: Last directory to check.
> - * @dir: Directory to start the walk from.
> + * @mnt_root: Last path element to check.
> + * @dir: Directory path to start the walk from.
>   * @layer_masks_dom: Where to store the collected accesses.
>   *
>   * This helper is useful to begin a path walk from the @dir directory to a
> @@ -1060,29 +1104,31 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
>   */
>  static bool collect_domain_accesses(
>  	const struct landlock_ruleset *const domain,
> -	const struct dentry *const mnt_root, struct dentry *dir,
> +	const struct path *const mnt_root, const struct path *const dir,
>  	layer_mask_t (*const layer_masks_dom)[LANDLOCK_NUM_ACCESS_FS],
>  	struct collected_rule_flags *const rule_flags)
>  {

This function only walks up to the mountpoint of dir.  If dir is changed
from a *dentry to a *path, wouldn't mnt_root be redundant?  Since
mnt_root->dentry is always going to be dir->mnt->mnt_root.  This also
means that they can't accidentally not be the same.

>  	unsigned long access_dom;
>  	bool ret = false;
> +	struct path walker;
>
>  	if (WARN_ON_ONCE(!domain || !mnt_root || !dir || !layer_masks_dom))
>  		return true;
> -	if (is_nouser_or_private(dir))
> +	if (is_nouser_or_private(dir->dentry))
>  		return true;
>
>  	access_dom = landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
>  					       layer_masks_dom,
>  					       LANDLOCK_KEY_INODE);
>
> -	dget(dir);
> +	walker = *dir;
> +	path_get(&walker);
>  	while (true) {
> -		struct dentry *parent_dentry;
> +		enum landlock_walk_result walk_res;
>
>  		/* Gets all layers allowing all domain accesses. */
>  		if (landlock_unmask_layers(
> -			    find_rule(domain, dir), access_dom, layer_masks_dom,
> +			    find_rule(domain, walker.dentry), access_dom, layer_masks_dom,
>  			    ARRAY_SIZE(*layer_masks_dom), rule_flags)) {
>  			/*
>  			 * Stops when all handled accesses are allowed by at
> @@ -1091,22 +1137,69 @@ static bool collect_domain_accesses(
>  			ret = true;
>  			break;
>  		}
> -
> -		/*
> -		 * Stops at the mount point or the filesystem root for a disconnected
> -		 * directory.
> -		 */
> -		if (dir == mnt_root || unlikely(IS_ROOT(dir)))
> +		if (walker.dentry == mnt_root->dentry && walker.mnt == mnt_root->mnt)
> +			break;
> +		walk_res = landlock_walk_path_up(&walker);
> +		if (walk_res != LANDLOCK_WALK_CONTINUE)
>  			break;
> -
> -		parent_dentry = dget_parent(dir);
> -		dput(dir);
> -		dir = parent_dentry;
>  	}
> -	dput(dir);
> +	path_put(&walker);
>  	return ret;
>  }
>
> +/**
> + * deny_no_inherit_topology_change - deny topology changes on sealed paths
> + * @subject: Subject performing the operation (contains the domain).
> + * @path: Path whose dentry is the target of the topology modification.
> + *
> + * Checks whether any domain layers are sealed against topology changes at
> + * @path.  If so, emit an audit record and return -EACCES.  Otherwise return 0.
> + */
> +static int deny_no_inherit_topology_change(const struct landlock_cred_security
> +					   *subject,
> +					   const struct path *const path)

Since you're not using path->mnt here (except for a NULL check), would it
be easier to just pass the dentry instead?  In that case you wouldn't have
to do an inline initializer in current_check_refer_path / hook_path_*
below as well.

> +{
> +	layer_mask_t sealed_layers = 0;
> +	layer_mask_t override_layers = 0;
> +	const struct landlock_rule *rule;
> +	u32 layer_index;
> +	unsigned long audit_layer_index;
> +
> +	if (WARN_ON_ONCE(!subject || !path || !path->dentry || !path->mnt ||
> +			 d_is_negative(path->dentry)))
> +		return 0;
> +
> +	rule = find_rule(subject->domain, path->dentry);
> +	if (!rule)
> +		return 0;
> +
> +	for (layer_index = 0; layer_index < rule->num_layers; layer_index++) {
> +		const struct landlock_layer *layer = &rule->layers[layer_index];
> +		layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
> +
> +		if (layer->flags.no_inherit ||
> +		    layer->flags.has_no_inherit_descendant)
> +			sealed_layers |= layer_bit;
> +		else
> +			override_layers |= layer_bit;
> +	}
> +
> +	sealed_layers &= ~override_layers;
> +	if (!sealed_layers)
> +		return 0;
> +
> +	audit_layer_index = __ffs((unsigned long)sealed_layers);
> +	landlock_log_denial(subject, &(struct landlock_request) {
> +		.type = LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY,
> +		.audit = {
> +			.type = LSM_AUDIT_DATA_DENTRY,
> +			.u.dentry = path->dentry,
> +		},
> +		.layer_plus_one = audit_layer_index + 1,
> +	});
> +	return -EACCES;
> +}
> +
>  /**
>   * current_check_refer_path - Check if a rename or link action is allowed
>   *
> @@ -1191,6 +1284,21 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  	access_request_parent2 =
>  		get_mode_access(d_backing_inode(old_dentry)->i_mode);
>  	if (removable) {
> +		int err = deny_no_inherit_topology_change(subject,
> +							  &(struct path)
> +							  { .mnt = new_dir->mnt,
> +							  .dentry = old_dentry });
> +
> +		if (err)
> +			return err;
> +		if (exchange) {
> +			err = deny_no_inherit_topology_change(subject,
> +							      &(struct path)
> +							      { .mnt = new_dir->mnt,
> +							      .dentry = new_dentry });
> +			if (err)
> +				return err;
> +		}
>  		access_request_parent1 |= maybe_remove(old_dentry);
>  		access_request_parent2 |= maybe_remove(new_dentry);
>  	}
> @@ -1232,12 +1340,15 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  						      old_dentry->d_parent;
>
>  	/* new_dir->dentry is equal to new_dentry->d_parent */
> -	allow_parent1 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
> -						old_parent,
> +	allow_parent1 = collect_domain_accesses(subject->domain,
> +						&mnt_dir,
> +						&(struct path){ .mnt = new_dir->mnt,
> +						.dentry = old_parent },
>  						&layer_masks_parent1,
>  						&request1.rule_flags);
> -	allow_parent2 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
> -						new_dir->dentry,
> +	allow_parent2 = collect_domain_accesses(subject->domain, &mnt_dir,
> +						&(struct path){ .mnt = new_dir->mnt,
> +						.dentry = new_dir->dentry },
>  						&layer_masks_parent2,
>  						&request2.rule_flags);
>
> @@ -1583,12 +1694,37 @@ static int hook_path_symlink(const struct path *const dir,
>  static int hook_path_unlink(const struct path *const dir,
>  			    struct dentry *const dentry)
>  {
> +	const struct landlock_cred_security *const subject =
> +		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
> +	int err;
> +
> +	if (subject) {
> +		err = deny_no_inherit_topology_change(subject,
> +						      &(struct path)
> +						      { .mnt = dir->mnt,
> +						      .dentry = dentry });
> +		if (err)
> +			return err;
> +	}
>  	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_FILE);
>  }
>
>  static int hook_path_rmdir(const struct path *const dir,
>  			   struct dentry *const dentry)
>  {
> +	const struct landlock_cred_security *const subject =
> +		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
> +	int err;
> +
> +	if (subject) {
> +		err = deny_no_inherit_topology_change(subject,
> +						      &(struct path)
> +						      { .mnt = dir->mnt,
> +						      .dentry = dentry });
> +		if (err)
> +			return err;
> +	}
> +
>  	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
>  }
>
> [...]

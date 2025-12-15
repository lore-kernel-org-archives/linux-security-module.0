Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB9121C17D
	for <linux-security-module@vger.kernel.org>; Mon, 15 Dec 2025 22:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765837318; cv=none; b=Oc1PTVLjA7Y4bdEdgHhWodLTr9TapkaUXaAD3fSzmqV2hiHAIYeJg/BOQoUpH9PaljgEQqsyQmJOKb3+UKjXaZgdfAtYb41Fxbu/9QTJxeiJPtmpFGTTRXI3UKCSqFZPilXuYZzfnAomUSdx5mSUq4+FHW/dGSZTqza8scYQpXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765837318; c=relaxed/simple;
	bh=26rSiOehIv7/II5+H6chtATeH+dkfDopKIX5aZdD/UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPWzjq95feLHxNny12nylribMNa/d0oecR732ZpCaYujCWKBIa+9duHB+zGsTEBHdhi37K8Na00rEG4EYTP2fvGHzGZlW+5I6Ar3BoY4t6rC/mlYDBJ1FdZnJRjO1aquSKnK4YxbELXKQ9vlQWUTw1bAqY7cWem5ieyjEUkMjDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdTda3lU; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdTda3lU"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6420c08f886so4641787d50.3
        for <linux-security-module@vger.kernel.org>; Mon, 15 Dec 2025 14:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765837315; x=1766442115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26rSiOehIv7/II5+H6chtATeH+dkfDopKIX5aZdD/UY=;
        b=AdTda3lUHUN0ZIKpbzETXiaH3yx9PoAXJZfTbOj5HpUXWiOy6E8zN/KUsuamN4S9hw
         xhSlEttU86QpbjokMMKKDRCWNCu0R3Cc2huXI/D0oJMo6lTAZSvCs18g+G4RDIupO9bb
         1OvPIgwqkli799BLnGsypb/1kTq+4tEdL66boYMx4GrK8pUcbFsWXIKgwBb8/oZuS7AF
         QCz4Bbsx27fPZnSRZkFj6JoEskD4p0fyGSOG/dRefmr2lbCpUSjt/8y2sWM4qm8XQFMZ
         inBAqA83cbIGgYAqC2t6rJjj1rI9RhsIEqa0emz1fVHtLvVnr3MWCbG9OS/HRuBjJ06e
         J9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765837315; x=1766442115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=26rSiOehIv7/II5+H6chtATeH+dkfDopKIX5aZdD/UY=;
        b=YtoZsGL2j8hhgQ5T8qfJMHJ0ytLaE1SQpKVjWs/9MmXHPcBtuz3huU0NL4T/w7tB57
         ug7fCXK27Q+QX1llnraSVKOb5/nZZ88+Tz5uvnP59/WykcRV+9KY89/p61M9tV8UFBMB
         +QH5IB0mhEKi5OnK5LB36Kr2aGWu1o386cS1/4Yd+pJ1T2Ngc3ARn/agO1tpty8Nv2Bx
         9y59JzOIi8A4UYmqPvI6tsr2Z05uuoRr68qCPHRHAJ9X7nzhgCZXerPLgcVUC6kzYj+9
         yAExHI4HebrTike0HGBPsZKgEigE4KlcFcHNiy7GL9ENfXGkgvO+mdFVCdXZRhr8iOBv
         0qcA==
X-Forwarded-Encrypted: i=1; AJvYcCWG4ODp7G6GNfp5ikpIffBd2zbFdAvkc/6DgFAiO2OaH0KREC8ufUydOtH+oFtmnJfBYQHR5JPfeRDvQsr0ScKP0QC9eCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YysAQZiXATGLyyqGoqw4d3ku9DGssSG8Z3XVSl3yBz7IY1lp+3B
	UK/m1PwLhtrMlyS/NKdBmz8IK/JFz6QjKZCae4vwTFy4zaMj+Bbeff3d
X-Gm-Gg: AY/fxX46mjxecDKbcZaYRlfe5BWi/Ra79cXEr3q+V0RKzN5aQH2on0BttBKGSwkcfRG
	rmDuO3hyVHeCn5zinbJXrrqSbWlsaabEVklQVOEcdXbA+kG6S3g//uG3g52hLjfSDwtTH70h5I9
	AwaYdQn5ldXOCH8eZAzbtuAZGs8Hl1GcYNPlwXSONQ0eMgCV1/EUQsUQTMF9PJroUIuZilbKUD+
	KONzEubm2c4eAehoLbiYpIHxoYg/0phtMa25QoFaZX82gNeCD8gpNZKDUW6oF9tuTlnZ4Io/eYu
	0Accct8amTQEfn4209PAchb61400a8jVV8jjRxGAuBLqT6UO+x65GK1li1GVTfKqqOkofvh3u8t
	r/zH3ZPccyk2J00kmmL1HNiYFn6RFtLnjY34KUUCAX5qJbOx5S/kKQrgS1oNxaXNtr7IGPgZEjg
	KEhw5vmOSxCUP0D9AYk5qd0jW3FlgrWbnkSL9tlidG+OFVc1smOR38RGq+enJC
X-Google-Smtp-Source: AGHT+IGZiZuEAte3d2Aanu8Kce6O62cjIRUROLdO0PHSUvW+HMyis8Ytov/nq5gNMoUgb7WmjopjtA==
X-Received: by 2002:a05:690e:190f:b0:644:78d0:d063 with SMTP id 956f58d0204a3-6455567debfmr8186231d50.84.1765837314755;
        Mon, 15 Dec 2025 14:21:54 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64477d39b01sm6895216d50.1.2025.12.15.14.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 14:21:54 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: m@maowtm.org
Cc: gnoack@google.com,
	jack@suse.cz,
	linux-security-module@vger.kernel.org,
	mic@digikod.net,
	utilityemal77@gmail.com,
	xandfury@gmail.com
Subject: Re: [PATCH v5 1/6] landlock: Implement LANDLOCK_ADD_RULE_NO_INHERIT
Date: Mon, 15 Dec 2025 17:21:35 -0500
Message-ID: <20251215222137.458114-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <ef02e290-84b0-4de9-85aa-bf94d38c0c44@maowtm.org>
References: <ef02e290-84b0-4de9-85aa-bf94d38c0c44@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/14/25 17:53, Tingmao Wang wrote:
> On 12/14/25 17:05, Justin Suess wrote:
>> [...]
>> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
>> index d4f47d20361a..6ab3e7bd1c81 100644
>> --- a/include/uapi/linux/landlock.h
>> +++ b/include/uapi/linux/landlock.h
>> @@ -127,10 +127,39 @@ struct landlock_ruleset_attr {
>>    *     allowed_access in the passed in rule_attr.  When this flag is
>>    *     present, the caller is also allowed to pass in an empty
>>    *     allowed_access.
>> + * %LANDLOCK_ADD_RULE_NO_INHERIT
>> + *     When set on a rule being added to a ruleset, this flag disables the
>> + *     inheritance of access rights and flags from parent objects.
>> + *
>> + *     This flag currently applies only to filesystem rules.  Adding it to
>> + *     non-filesystem rules will return -EINVAL, unless future extensions
>> + *     of Landlock define other hierarchical object types.
>> + *
>> + *     By default, Landlock filesystem rules inherit allowed accesses from
>> + *     ancestor directories: if a parent directory grants certain rights,
>> + *     those rights also apply to its children.  A rule marked with
>> + *     LANDLOCK_ADD_RULE_NO_INHERIT stops this propagation at the directory
>> + *     covered by the rule.  Descendants of that directory continue to inherit
>> + *     normally unless they also have rules using this flag.
>> + *
>> + *     If a regular file is marked with this flag, it will not inherit any
>> + *     access rights from its parent directories; only the accesses explicitly
>> + *     allowed by the rule will apply to that file.
>> + *
>> + *     This flag also enforces parent-directory restrictions: rename, rmdir,
>> + *     link, and other operations that would change the directory's immediate
>> + *     parent subtree are denied up to the VFS root.  This prevents
>> + *     sandboxed processes from manipulating the filesystem hierarchy to evade
>> + *     restrictions (e.g., via sandbox-restart attacks).
>> + *
>> + *     In addition, this flag blocks the inheritance of rule-layer flags
> tbh I feel that it's less confusing to just say "rule flags" (instead of
> "rule-layer flags").
Agreed. I'll change it here and in any other locations it pops up, I'll have to see.
>> + *     (such as the quiet flag) from parent directories to the object covered
>> + *     by this rule.
>>    */
>>
>>   /* clang-format off */
>>   #define LANDLOCK_ADD_RULE_QUIET            (1U << 0)
>> +#define LANDLOCK_ADD_RULE_NO_INHERIT        (1U << 1)
>>   /* clang-format on */
>>
>>   /**
>> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
>> index 0b589263ea42..8d8623ea857f 100644
>> --- a/security/landlock/fs.c
>> +++ b/security/landlock/fs.c
>> @@ -317,6 +317,37 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>>       LANDLOCK_ACCESS_FS_IOCTL_DEV)
>>   /* clang-format on */
>>
>> +enum landlock_walk_result {
>> +    LANDLOCK_WALK_CONTINUE,
>> +    LANDLOCK_WALK_STOP_REAL_ROOT,
>> +    LANDLOCK_WALK_MOUNT_ROOT,
>> +};
>> +
>> +static enum landlock_walk_result landlock_walk_path_up(struct path *const path)
>> +{
>> +    while (path->dentry == path->mnt->mnt_root) {
>> +        if (!follow_up(path))
>> +            return LANDLOCK_WALK_STOP_REAL_ROOT;
>> +    }
>> +
>> +    if (unlikely(IS_ROOT(path->dentry))) {
>> +        if (likely(path->mnt->mnt_flags & MNT_INTERNAL))
>> +            return LANDLOCK_WALK_MOUNT_ROOT;
> imo, LANDLOCK_WALK_MOUNT_ROOT is a somewhat confusing name for this,
> especially in the context that if we see this in
> is_access_to_paths_allowed() we allow access unconditionally.
>
> Would LANDLOCK_WALK_INTERNAL be a better name here?
>
Yeah that seems better. LANDLOCK_WALK_INTERNAL seems like a better name.
Plus some documenting comments in the landlock_walk_result are warranted.

I'll fix it in the next version.

>> +        dput(path->dentry);
>> +        path->dentry = dget(path->mnt->mnt_root);
>> +        return LANDLOCK_WALK_CONTINUE;
>> +    }
>> +
>> +    struct dentry *const parent = dget_parent(path->dentry);
>> +
>> +    dput(path->dentry);
>> +    path->dentry = parent;
>> +    return LANDLOCK_WALK_CONTINUE;
>> +}
>> +
>> +static const struct landlock_rule *find_rule(const struct landlock_ruleset *const domain,
>> +                         const struct dentry *const dentry);
>> +
>>   /*
>>    * @path: Should have been checked by get_path_from_fd().
>>    */
>> @@ -344,6 +375,48 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>>           return PTR_ERR(id.key.object);
>>       mutex_lock(&ruleset->lock);
>>       err = landlock_insert_rule(ruleset, id, access_rights, flags);
>> +    if (err || !(flags & LANDLOCK_ADD_RULE_NO_INHERIT))
>> +        goto out_unlock;
>> +
>> +    /* Create ancestor rules and set has_no_inherit_descendant flags */
>> +    struct path walker = *path;
>> +
>> +    path_get(&walker);
>> +    while (landlock_walk_path_up(&walker) != LANDLOCK_WALK_STOP_REAL_ROOT) {
> Why not landlock_walk_path_up(&walker) == LANDLOCK_WALK_CONTINUE here?
> I'm not sure if it's actually possible to end up with an infinite loop by
> ignoring LANDLOCK_WALK_MOUNT_ROOT (i.e. not sure if "internal" mounts can
> have disconnected dentries), but it seems safer to write to loop in a way
> such that if that happens, we exit.

I don't *think* it's possible to end up in an infinite loop this way, but you never know.
I'll definitely take your suggestion because it's semantically clearer at the very least.

>
>> +        struct landlock_rule *ancestor_rule;
>> +
>> +        if (WARN_ON_ONCE(!walker.dentry || d_is_negative(walker.dentry))) {
>> +            err = -EIO;
>> +            break;
>> +        }
>> +
>> +        ancestor_rule = (struct landlock_rule *)find_rule(ruleset, walker.dentry);
>> +        if (!ancestor_rule) {
>> +            struct landlock_id ancestor_id = {
>> +                .type = LANDLOCK_KEY_INODE,
>> +                .key.object = get_inode_object(d_backing_inode(walker.dentry)),
>> +            };
>> +
>> +            if (IS_ERR(ancestor_id.key.object)) {
>> +                err = PTR_ERR(ancestor_id.key.object);
>> +                break;
>> +            }
>> +            err = landlock_insert_rule(ruleset, ancestor_id, 0, 0);
>> +            landlock_put_object(ancestor_id.key.object);
>> +            if (err)
>> +                break;
>> +
>> +            ancestor_rule = (struct landlock_rule *)
>> +                find_rule(ruleset, walker.dentry);
>> +        }
>> +        if (WARN_ON_ONCE(!ancestor_rule || ancestor_rule->num_layers != 1)) {
>> +            err = -EIO;
>> +            break;
>> +        }
>> +        ancestor_rule->layers[0].flags.has_no_inherit_descendant = true;
>> +    }
>> +    path_put(&walker);
>> +out_unlock:
>>       mutex_unlock(&ruleset->lock);
>>       /*
>>        * No need to check for an error because landlock_insert_rule()
>> @@ -772,8 +845,10 @@ static bool is_access_to_paths_allowed(
>>           _layer_masks_child2[LANDLOCK_NUM_ACCESS_FS];
>>       layer_mask_t(*layer_masks_child1)[LANDLOCK_NUM_ACCESS_FS] = NULL,
>>       (*layer_masks_child2)[LANDLOCK_NUM_ACCESS_FS] = NULL;
>> -    struct collected_rule_flags *rule_flags_parent1 = &log_request_parent1->rule_flags;
>> -    struct collected_rule_flags *rule_flags_parent2 = &log_request_parent2->rule_flags;
>> +    struct collected_rule_flags *rule_flags_parent1 =
>> +        &log_request_parent1->rule_flags;
>> +    struct collected_rule_flags *rule_flags_parent2 =
>> +        log_request_parent2 ? &log_request_parent2->rule_flags : NULL;
> Good point, I think the original was still safe because it would not be
> used by landlock_unmask_layers anyway, but this is better.  I will take
> this in the next version, thanks!

No problem. I actually meant to put this as a review under your patch as
a comment but I pulled it in accidentally.

Rebasing off your patch has been a breeze btw 🙂

>
>>       if (!access_request_parent1 && !access_request_parent2)
>>           return true;
>> @@ -784,7 +859,7 @@ static bool is_access_to_paths_allowed(
>>       if (is_nouser_or_private(path->dentry))
>>           return true;
>>
>> -    if (WARN_ON_ONCE(!layer_masks_parent1))
>> +    if (WARN_ON_ONCE(!layer_masks_parent1 || !log_request_parent1))
>>           return false;
>>
>>       allowed_parent1 = is_layer_masks_allowed(layer_masks_parent1);
>> @@ -851,6 +926,7 @@ static bool is_access_to_paths_allowed(
>>        */
>>       while (true) {
>>           const struct landlock_rule *rule;
>> +        enum landlock_walk_result walk_res;
>>
>>           /*
>>            * If at least all accesses allowed on the destination are
>> @@ -910,46 +986,14 @@ static bool is_access_to_paths_allowed(
>>           if (allowed_parent1 && allowed_parent2)
>>               break;
>>
>> -jump_up:
>> -        if (walker_path.dentry == walker_path.mnt->mnt_root) {
>> -            if (follow_up(&walker_path)) {
>> -                /* Ignores hidden mount points. */
>> -                goto jump_up;
>> -            } else {
>> -                /*
>> -                 * Stops at the real root.  Denies access
>> -                 * because not all layers have granted access.
>> -                 */
>> -                break;
>> -            }
>> -        }
>> -
>> -        if (unlikely(IS_ROOT(walker_path.dentry))) {
>> -            if (likely(walker_path.mnt->mnt_flags & MNT_INTERNAL)) {
>> -                /*
>> -                 * Stops and allows access when reaching disconnected root
>> -                 * directories that are part of internal filesystems (e.g. nsfs,
>> -                 * which is reachable through /proc/<pid>/ns/<namespace>).
>> -                 */
>> -                allowed_parent1 = true;
>> -                allowed_parent2 = true;
>> -                break;
>> -            }
>> -
>> -            /*
>> -             * We reached a disconnected root directory from a bind mount.
>> -             * Let's continue the walk with the mount point we missed.
>> -             */
> I think we might want to preserve these comments.

Agreed. Thank you, I missed those. I'll preserve them in the next version.

>
>> -            dput(walker_path.dentry);
>> -            walker_path.dentry = walker_path.mnt->mnt_root;
>> -            dget(walker_path.dentry);
>> -        } else {
>> -            struct dentry *const parent_dentry =
>> -                dget_parent(walker_path.dentry);
>> -
>> -            dput(walker_path.dentry);
>> -            walker_path.dentry = parent_dentry;
>> +        walk_res = landlock_walk_path_up(&walker_path);
>> +        if (walk_res == LANDLOCK_WALK_MOUNT_ROOT) {
>> +            allowed_parent1 = true;
>> +            allowed_parent2 = true;
>> +            break;
>>           }
>> +        if (walk_res != LANDLOCK_WALK_CONTINUE)
>> +            break;
>>       }
>>       path_put(&walker_path);
>>
>> @@ -963,7 +1007,7 @@ static bool is_access_to_paths_allowed(
>>               ARRAY_SIZE(*layer_masks_parent1);
>>       }
>>
>> -    if (!allowed_parent2) {
>> +    if (!allowed_parent2 && log_request_parent2) {
>>           log_request_parent2->type = LANDLOCK_REQUEST_FS_ACCESS;
>>           log_request_parent2->audit.type = LSM_AUDIT_DATA_PATH;
>>           log_request_parent2->audit.u.path = *path;
>> @@ -1037,8 +1081,8 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
>>    * collect_domain_accesses - Walk through a file path and collect accesses
>>    *
>>    * @domain: Domain to check against.
>> - * @mnt_root: Last directory to check.
>> - * @dir: Directory to start the walk from.
>> + * @mnt_root: Last path element to check.
>> + * @dir: Directory path to start the walk from.
>>    * @layer_masks_dom: Where to store the collected accesses.
>>    *
>>    * This helper is useful to begin a path walk from the @dir directory to a
>> @@ -1060,29 +1104,31 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
>>    */
>>   static bool collect_domain_accesses(
>>       const struct landlock_ruleset *const domain,
>> -    const struct dentry *const mnt_root, struct dentry *dir,
>> +    const struct path *const mnt_root, const struct path *const dir,
>>       layer_mask_t (*const layer_masks_dom)[LANDLOCK_NUM_ACCESS_FS],
>>       struct collected_rule_flags *const rule_flags)
>>   {
> This function only walks up to the mountpoint of dir.  If dir is changed
> from a *dentry to a *path, wouldn't mnt_root be redundant?  Since
> mnt_root->dentry is always going to be dir->mnt->mnt_root.  This also
> means that they can't accidentally not be the same.

Good catch, yeah they should be redundant.

I'll remove the mnt_root parameter in the next version.
>
>>       unsigned long access_dom;
>>       bool ret = false;
>> +    struct path walker;
>>
>>       if (WARN_ON_ONCE(!domain || !mnt_root || !dir || !layer_masks_dom))
>>           return true;
>> -    if (is_nouser_or_private(dir))
>> +    if (is_nouser_or_private(dir->dentry))
>>           return true;
>>
>>       access_dom = landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
>>                              layer_masks_dom,
>>                              LANDLOCK_KEY_INODE);
>>
>> -    dget(dir);
>> +    walker = *dir;
>> +    path_get(&walker);
>>       while (true) {
>> -        struct dentry *parent_dentry;
>> +        enum landlock_walk_result walk_res;
>>
>>           /* Gets all layers allowing all domain accesses. */
>>           if (landlock_unmask_layers(
>> -                find_rule(domain, dir), access_dom, layer_masks_dom,
>> +                find_rule(domain, walker.dentry), access_dom, layer_masks_dom,
>>                   ARRAY_SIZE(*layer_masks_dom), rule_flags)) {
>>               /*
>>                * Stops when all handled accesses are allowed by at
>> @@ -1091,22 +1137,69 @@ static bool collect_domain_accesses(
>>               ret = true;
>>               break;
>>           }
>> -
>> -        /*
>> -         * Stops at the mount point or the filesystem root for a disconnected
>> -         * directory.
>> -         */
>> -        if (dir == mnt_root || unlikely(IS_ROOT(dir)))
>> +        if (walker.dentry == mnt_root->dentry && walker.mnt == mnt_root->mnt)
>> +            break;
>> +        walk_res = landlock_walk_path_up(&walker);
>> +        if (walk_res != LANDLOCK_WALK_CONTINUE)
>>               break;
>> -
>> -        parent_dentry = dget_parent(dir);
>> -        dput(dir);
>> -        dir = parent_dentry;
>>       }
>> -    dput(dir);
>> +    path_put(&walker);
>>       return ret;
>>   }
>>
>> +/**
>> + * deny_no_inherit_topology_change - deny topology changes on sealed paths
>> + * @subject: Subject performing the operation (contains the domain).
>> + * @path: Path whose dentry is the target of the topology modification.
>> + *
>> + * Checks whether any domain layers are sealed against topology changes at
>> + * @path.  If so, emit an audit record and return -EACCES.  Otherwise return 0.
>> + */
>> +static int deny_no_inherit_topology_change(const struct landlock_cred_security
>> +                       *subject,
>> +                       const struct path *const path)
> Since you're not using path->mnt here (except for a NULL check), would it
> be easier to just pass the dentry instead?  In that case you wouldn't have
> to do an inline initializer in current_check_refer_path / hook_path_*
> below as well.

Yeah, this was leftover before I did some refactoring and removed
the mark_no_inherit_ancestors. Good catch.

I'll address this in the next version.

>
>> +{
>> +    layer_mask_t sealed_layers = 0;
>> +    layer_mask_t override_layers = 0;
>> +    const struct landlock_rule *rule;
>> +    u32 layer_index;
>> +    unsigned long audit_layer_index;
>> +
>> +    if (WARN_ON_ONCE(!subject || !path || !path->dentry || !path->mnt ||
>> +             d_is_negative(path->dentry)))
>> +        return 0;
>> +
>> +    rule = find_rule(subject->domain, path->dentry);
>> +    if (!rule)
>> +        return 0;
>> +
>> +    for (layer_index = 0; layer_index < rule->num_layers; layer_index++) {
>> +        const struct landlock_layer *layer = &rule->layers[layer_index];
>> +        layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
>> +
>> +        if (layer->flags.no_inherit ||
>> +            layer->flags.has_no_inherit_descendant)
>> +            sealed_layers |= layer_bit;
>> +        else
>> +            override_layers |= layer_bit;
>> +    }
>> +
>> +    sealed_layers &= ~override_layers;
>> +    if (!sealed_layers)
>> +        return 0;
>> +
>> +    audit_layer_index = __ffs((unsigned long)sealed_layers);
>> +    landlock_log_denial(subject, &(struct landlock_request) {
>> +        .type = LANDLOCK_REQUEST_FS_CHANGE_TOPOLOGY,
>> +        .audit = {
>> +            .type = LSM_AUDIT_DATA_DENTRY,
>> +            .u.dentry = path->dentry,
>> +        },
>> +        .layer_plus_one = audit_layer_index + 1,
>> +    });
>> +    return -EACCES;
>> +}
>> +
>>   /**
>>    * current_check_refer_path - Check if a rename or link action is allowed
>>    *
>> @@ -1191,6 +1284,21 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>>       access_request_parent2 =
>>           get_mode_access(d_backing_inode(old_dentry)->i_mode);
>>       if (removable) {
>> +        int err = deny_no_inherit_topology_change(subject,
>> +                              &(struct path)
>> +                              { .mnt = new_dir->mnt,
>> +                              .dentry = old_dentry });
>> +
>> +        if (err)
>> +            return err;
>> +        if (exchange) {
>> +            err = deny_no_inherit_topology_change(subject,
>> +                                  &(struct path)
>> +                                  { .mnt = new_dir->mnt,
>> +                                  .dentry = new_dentry });
>> +            if (err)
>> +                return err;
>> +        }
>>           access_request_parent1 |= maybe_remove(old_dentry);
>>           access_request_parent2 |= maybe_remove(new_dentry);
>>       }
>> @@ -1232,12 +1340,15 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>>                                 old_dentry->d_parent;
>>
>>       /* new_dir->dentry is equal to new_dentry->d_parent */
>> -    allow_parent1 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
>> -                        old_parent,
>> +    allow_parent1 = collect_domain_accesses(subject->domain,
>> +                        &mnt_dir,
>> +                        &(struct path){ .mnt = new_dir->mnt,
>> +                        .dentry = old_parent },
>>                           &layer_masks_parent1,
>>                           &request1.rule_flags);
>> -    allow_parent2 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
>> -                        new_dir->dentry,
>> +    allow_parent2 = collect_domain_accesses(subject->domain, &mnt_dir,
>> +                        &(struct path){ .mnt = new_dir->mnt,
>> +                        .dentry = new_dir->dentry },
>>                           &layer_masks_parent2,
>>                           &request2.rule_flags);
>>
>> @@ -1583,12 +1694,37 @@ static int hook_path_symlink(const struct path *const dir,
>>   static int hook_path_unlink(const struct path *const dir,
>>                   struct dentry *const dentry)
>>   {
>> +    const struct landlock_cred_security *const subject =
>> +        landlock_get_applicable_subject(current_cred(), any_fs, NULL);
>> +    int err;
>> +
>> +    if (subject) {
>> +        err = deny_no_inherit_topology_change(subject,
>> +                              &(struct path)
>> +                              { .mnt = dir->mnt,
>> +                              .dentry = dentry });
>> +        if (err)
>> +            return err;
>> +    }
>>       return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_FILE);
>>   }
>>
>>   static int hook_path_rmdir(const struct path *const dir,
>>                  struct dentry *const dentry)
>>   {
>> +    const struct landlock_cred_security *const subject =
>> +        landlock_get_applicable_subject(current_cred(), any_fs, NULL);
>> +    int err;
>> +
>> +    if (subject) {
>> +        err = deny_no_inherit_topology_change(subject,
>> +                              &(struct path)
>> +                              { .mnt = dir->mnt,
>> +                              .dentry = dentry });
>> +        if (err)
>> +            return err;
>> +    }
>> +
>>       return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
>>   }
>>
>> [...]

Overall I'm feeling pretty good about this series, but if either you or Mickaël have any more feedback I'd like to hear it.

I'll wait until your next quiet flag version comes and do a rebase before sending the revisions.

Sorry for the double tap Tingmao, I forgot to cc the mailing list :(

Regards,

Justin


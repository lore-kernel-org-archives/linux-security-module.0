Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B76233BBB5
	for <linux-security-module@vger.kernel.org>; Mon,  9 Mar 2026 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077709; cv=none; b=ubMCVLjcSYqHb0tf2pfZpMgV/VMNuJJEXD9WapAsH8Ft/p0YX74w+be6/l3eCEvZDgo9tdtYbdKiOwXaDzvDZ5WXk+9upNPdUBTff2jYHK2FeZ8oNwe4ogpskUWwz+/RLTgzKiTt3YqOxhmagRIrS7CAgC4RBOUCxJa2hwriQkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077709; c=relaxed/simple;
	bh=YetviyS5mkSpW39xNQ6sIc0K206vIoOPCEbSXKgsrVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qw3R1L7ondVCBNV41oOQRZ38WgGzApjpBqoKJcEg9ov7faZ8Zn8K7n0Lg7vlgNXlyPbD271aqEpWibheuiURZphqqd7Ah95AS5SkZGrxfBh5Eb7/GV8N8n6HFiisHfj5tDozrvEEhmDZ2MfWcsF0t2wWGTFWj/kIA8fo5uPkm0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=kEo1XE9I; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="kEo1XE9I"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fV4002StyzDRM;
	Mon,  9 Mar 2026 18:34:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773077696;
	bh=qMAo1orC+Pjafm5h68M9pX88Owx1WUsoMhbJ0KiBti4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kEo1XE9IlpTJ7CZusW8GlOrUzaUkgldo5k/vEC/kFbNz4TRimmoQ0Veuvqfw9Mlkv
	 rbgB56yhA4x1DTsWql3GX/tMVh5U9XzbroiiNUExPjHMprVfH+DxFqe6PZ59671mpy
	 OwpXxUJZ5V5BEXd6ct9wKnFB3ZZ4U+8WG2K7PYNU=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fV3zz6LKfzcc8;
	Mon,  9 Mar 2026 18:34:55 +0100 (CET)
Date: Mon, 9 Mar 2026 18:34:50 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 3/4] landlock: Improve kernel-doc "Return:" section
 consistency
Message-ID: <20260309.sheath2xiFai@digikod.net>
References: <20260304193134.250495-1-mic@digikod.net>
 <20260304193134.250495-3-mic@digikod.net>
 <20260306.b502a795f389@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260306.b502a795f389@gnoack.org>
X-Infomaniak-Routing: alpha

On Fri, Mar 06, 2026 at 08:30:29AM +0100, Günther Noack wrote:
> Just a few comment phrasing nits below
> 
> On Wed, Mar 04, 2026 at 08:31:26PM +0100, Mickaël Salaün wrote:
> > The canonical kernel-doc form is "Return:" (singular, without trailing
> > "s").  Normalize all existing "Returns:" occurrences across the Landlock
> > source tree to the canonical form.
> > 
> > Also fix capitalization for consistency.  Balance descriptions to
> > describe all possible returned values.
> > 
> > Consolidate bullet-point return descriptions into inline text for
> > functions with simple two-value or three-value returns for consistency.
> > 
> > Cc: Günther Noack <gnoack@google.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  security/landlock/cred.h    |  2 +-
> >  security/landlock/domain.c  |  4 ++--
> >  security/landlock/fs.c      | 26 +++++++++++---------------
> >  security/landlock/id.c      |  2 +-
> >  security/landlock/ruleset.c |  2 +-
> >  security/landlock/ruleset.h |  2 +-
> >  security/landlock/task.c    |  4 ++--
> >  security/landlock/tsync.c   | 17 ++++++-----------
> >  8 files changed, 25 insertions(+), 34 deletions(-)
> > 
> > diff --git a/security/landlock/cred.h b/security/landlock/cred.h
> > index c10a06727eb1..f287c56b5fd4 100644
> > --- a/security/landlock/cred.h
> > +++ b/security/landlock/cred.h
> > @@ -115,7 +115,7 @@ static inline bool landlocked(const struct task_struct *const task)
> >   * @handle_layer: returned youngest layer handling a subset of @masks.  Not set
> >   *                if the function returns NULL.
> >   *
> > - * Returns: landlock_cred(@cred) if any access rights specified in @masks is
> > + * Return: landlock_cred(@cred) if any access rights specified in @masks is
> >   * handled, or NULL otherwise.
> >   */
> >  static inline const struct landlock_cred_security *
> > diff --git a/security/landlock/domain.c b/security/landlock/domain.c
> > index 343a1aabaac6..8b9939005aa8 100644
> > --- a/security/landlock/domain.c
> > +++ b/security/landlock/domain.c
> > @@ -34,7 +34,7 @@
> >   * @exe_size: Returned size of @exe_str (including the trailing null
> >   *            character), if any.
> >   *
> > - * Returns: A pointer to an allocated buffer where @exe_str point to, %NULL if
> > + * Return: A pointer to an allocated buffer where @exe_str point to, %NULL if
> >   * there is no executable path, or an error otherwise.
> >   */
> >  static const void *get_current_exe(const char **const exe_str,
> > @@ -73,7 +73,7 @@ static const void *get_current_exe(const char **const exe_str,
> >  }
> >  
> >  /*
> > - * Returns: A newly allocated object describing a domain, or an error
> > + * Return: A newly allocated object describing a domain, or an error
> >   * otherwise.
> >   */
> >  static struct landlock_details *get_current_details(void)
> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index cfe69075bf4e..a03ec664c78e 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -119,8 +119,8 @@ static const struct landlock_object_underops landlock_fs_underops = {
> >   * Any new IOCTL commands that are implemented in fs/ioctl.c's do_vfs_ioctl()
> >   * should be considered for inclusion here.
> >   *
> > - * Returns: true if the IOCTL @cmd can not be restricted with Landlock for
> > - * device files.
> > + * Return: True if the IOCTL @cmd can not be restricted with Landlock for
> > + * device files, false otherwise.
> >   */
> >  static __attribute_const__ bool is_masked_device_ioctl(const unsigned int cmd)
> >  {
> > @@ -428,10 +428,10 @@ static bool may_refer(const struct layer_access_masks *const src_parent,
> >   * Check that a destination file hierarchy has more restrictions than a source
> >   * file hierarchy.  This is only used for link and rename actions.
> >   *
> > - * Returns: true if child1 may be moved from parent1 to parent2 without
> > - * increasing its access rights.  If child2 is set, an additional condition is
> > + * Return: True if child1 may be moved from parent1 to parent2 without
> > + * increasing its access rights (if child2 is set, an additional condition is
> >   * that child2 may be used from parent2 to parent1 without increasing its access
> > - * rights.
> > + * rights), false otherwise.
> >   */
> >  static bool no_more_access(const struct layer_access_masks *const parent1,
> >  			   const struct layer_access_masks *const child1,
> > @@ -734,9 +734,7 @@ static void test_is_eacces_with_write(struct kunit *const test)
> >   * checks that the collected accesses and the remaining ones are enough to
> >   * allow the request.
> >   *
> > - * Returns:
> > - * - true if the access request is granted;
> > - * - false otherwise.
> > + * Return: True if the access request is granted, false otherwise.
> >   */
> >  static bool
> >  is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
> > @@ -1022,9 +1020,8 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
> >   * only handles walking on the same mount point and only checks one set of
> >   * accesses.
> >   *
> > - * Returns:
> > - * - true if all the domain access rights are allowed for @dir;
> > - * - false if the walk reached @mnt_root.
> > + * Return: True if all the domain access rights are allowed for @dir, false if
> > + * the walk reached @mnt_root.
> >   */
> >  static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
> >  				    const struct dentry *const mnt_root,
> > @@ -1120,10 +1117,9 @@ static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
> >   * ephemeral matrices take some space on the stack, which limits the number of
> >   * layers to a deemed reasonable number: 16.
> >   *
> > - * Returns:
> > - * - 0 if access is allowed;
> > - * - -EXDEV if @old_dentry would inherit new access rights from @new_dir;
> > - * - -EACCES if file removal or creation is denied.
> > + * Return: 0 if access is allowed, -EXDEV if @old_dentry would inherit new
> > + * access rights from @new_dir, or -EACCES if file removal or creation is
> > + * denied.
> >   */
> >  static int current_check_refer_path(struct dentry *const old_dentry,
> >  				    const struct path *const new_dir,
> > diff --git a/security/landlock/id.c b/security/landlock/id.c
> > index 838c3ed7bb82..6c8769777fdc 100644
> > --- a/security/landlock/id.c
> > +++ b/security/landlock/id.c
> > @@ -258,7 +258,7 @@ static void test_range2_rand16(struct kunit *const test)
> >   *
> >   * @number_of_ids: Number of IDs to hold.  Must be greater than one.
> >   *
> > - * Returns: The first ID in the range.
> > + * Return: The first ID in the range.
> >   */
> >  u64 landlock_get_id_range(size_t number_of_ids)
> >  {
> > diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> > index de8386af2f30..52e48ffcc3aa 100644
> > --- a/security/landlock/ruleset.c
> > +++ b/security/landlock/ruleset.c
> > @@ -675,7 +675,7 @@ get_access_mask_t(const struct landlock_ruleset *const ruleset,
> >   * @masks: Layer access masks to populate.
> >   * @key_type: The key type to switch between access masks of different types.
> >   *
> > - * Returns: An access mask where each access right bit is set which is handled
> > + * Return: An access mask where each access right bit is set which is handled
> >   * in any of the active layers in @domain.
> >   */
> >  access_mask_t
> > diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> > index 87d52031fb5a..5e63f78f7e1a 100644
> > --- a/security/landlock/ruleset.h
> > +++ b/security/landlock/ruleset.h
> > @@ -232,7 +232,7 @@ static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
> >   *
> >   * @domain: Landlock ruleset (used as a domain)
> >   *
> > - * Returns: an access_masks result of the OR of all the domain's access masks.
> > + * Return: An access_masks result of the OR of all the domain's access masks.
> >   */
> >  static inline struct access_masks
> >  landlock_union_access_masks(const struct landlock_ruleset *const domain)
> > diff --git a/security/landlock/task.c b/security/landlock/task.c
> > index bf7c3db7ce46..f2dbdebf2770 100644
> > --- a/security/landlock/task.c
> > +++ b/security/landlock/task.c
> > @@ -174,8 +174,8 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
> >   * @server: IPC receiver domain.
> >   * @scope: The scope restriction criteria.
> >   *
> > - * Returns: True if @server is in a different domain from @client, and @client
> > - * is scoped to access @server (i.e. access should be denied).
> > + * Return: True if @server is in a different domain from @client and @client
> > + * is scoped to access @server (i.e. access should be denied), false otherwise.
> >   */
> >  static bool domain_is_scoped(const struct landlock_ruleset *const client,
> >  			     const struct landlock_ruleset *const server,
> > diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> > index b06a0fa4cedb..359aecbb1e4b 100644
> > --- a/security/landlock/tsync.c
> > +++ b/security/landlock/tsync.c
> > @@ -183,10 +183,8 @@ struct tsync_works {
> >   * capacity.  This can legitimately happen if new threads get started after we
> >   * grew the capacity.
> >   *
> > - * Returns:
> > - *   A pointer to the preallocated context struct, with task filled in.
> > - *
> > - *   NULL, if we ran out of preallocated context structs.
> > + * Return: A pointer to the preallocated context struct with task filled in, or
> > + * NULL if preallocated context structs ran out.
> >   */
> >  static struct tsync_work *tsync_works_provide(struct tsync_works *s,
> >  					      struct task_struct *task)
> > @@ -243,11 +241,8 @@ static void tsync_works_trim(struct tsync_works *s)
> >   * On a successful return, the subsequent n calls to tsync_works_provide() are
> >   * guaranteed to succeed.  (size + n <= capacity)
> >   *
> > - * Returns:
> > - *   -ENOMEM if the (re)allocation fails
> > -
> > - *   0       if the allocation succeeds, partially succeeds, or no reallocation
> > - *           was needed
> > + * Return: 0 on success or partial success, -ENOMEM if the (re)allocation
> > + * fails.
> 
> tsync_works_grow_by:
> 
> I don't know what I meant when I wrote "partially succeeds" here in
> the original patch.  Would suggest this phrasing:
> 
>   Return: 0 if sufficient space for n more elements could be provided,
>   -ENOMEM on allocation errors, -EOVERFLOW in case of integer
>   overflow.
> 
> With this function, the success criterium is that it can establish
> that invariant.  We also don't return a success if we only could
> allocate space for fewer elements.

Good, I'll fold this in the commit.

> 
> >   */
> >  static int tsync_works_grow_by(struct tsync_works *s, size_t n, gfp_t flags)
> >  {
> > @@ -363,8 +358,8 @@ static size_t count_additional_threads(const struct tsync_works *works)
> >   * For each added task_work, atomically increments shared_ctx->num_preparing and
> >   * shared_ctx->num_unfinished.
> >   *
> > - * Returns:
> > - *     true, if at least one eligible sibling thread was found
> > + * Return: True if at least one eligible sibling thread was found, false
> > + * otherwise.
> >   */
> >  static bool schedule_task_work(struct tsync_works *works,
> >  			       struct tsync_shared_context *shared_ctx)
> > -- 
> > 2.53.0
> > 
> 
> Reviewed-by: Günther Noack <gnoack3000@gmail.com>
> 

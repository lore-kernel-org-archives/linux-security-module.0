Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9822041754
	for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 21:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771190643; cv=none; b=tQz4iFpVz6yxfztRInJe7qjGXxdtYbUclDb7exxEf2cUvAI2Ll3U/4Kk1uYdWUHmeXs9Yl08k+CvY8uvDyUJzt/wcW7AhEfZsCrfIoj+9VzvGi2rkeDanWqsMt4DPWwBRgHyljYLhTQYYHw1eKGdm2HtYJyroIEJiIoJNM/2kMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771190643; c=relaxed/simple;
	bh=ImBW+vSJP+zZauAIv4RtQFaxHOuJ54z3rmBqSEbwBHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SM2mH0BVk+AreiZqqgja5VafTzd9K64UqDpHVApnvsv6NJm8dftDkZKMRHaDVz092l/O06mH9QouuA8/iB6MHve07OsxPBqZ1FCmulQeEDkcifvy36A2mmV2MiSLCoY8aEEPRXmObEGv6qJh7BoIdpZQcdFnZtfMw8jsD9zEhKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyqxQfri; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyqxQfri"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79088484065so20646137b3.1
        for <linux-security-module@vger.kernel.org>; Sun, 15 Feb 2026 13:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771190640; x=1771795440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btCuiTXxi/+l84Ipqhk8pC/ta6DjNoIA292XyqByNGk=;
        b=SyqxQfriXEh48W7zXMHlOde37dL5pinS2lR+eh38pjkKG5jnRjiCseBSLrfs86pvzM
         /PfTwp1R8u6dmE5P1oXmRAxg1Y/NkcOmlGxJof3xirt++MoTC0ONB2ABjM1ZDxYpcypJ
         fZwDcU4M6F0iR4fm8n9I8jwSrMLq7Cs29SCNM1PYorf2uWl3nvqkRB9F0e1SF11MY+pn
         jAZppSt1WXSkyrWReyAAKvK1QlW0DM7xF6zbULQJ5queSktKAkI1R9SFH0OLVduCwor9
         FaZFSsnoUnwSZzEybHlwY/bM70w51cw8mTslVHj5e8xfsDVikrfC4IAQhwpxD2VuKhDh
         3wuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771190640; x=1771795440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=btCuiTXxi/+l84Ipqhk8pC/ta6DjNoIA292XyqByNGk=;
        b=IX9Dyy/YKeRkYy3Hu8QL38Xu3K0ZiuIxMDSqGaPNhFuRwFf+XIkt5z5yNvQyEv37bp
         uM7nGrl0japUinlxhhJGXCpmNxRKWQr4bwqquiQa22kaWYETdoSf0oDrtDx7chGU2E7m
         QxTJkNpyJu7QBIyhfi3Qb4VKDSlujlLL2nDyTHj+/3mxdDBm9PxujnIJ1C2YtDRvTa7t
         BYuTspuGuIi9gbYhFowj+FSqbzuxrt04gbX71k/MjVsrVAVI5W+uFkBoRCD8w8KgU4oI
         be7+iib8cUhtkgIn+3Vecm3LE46wu1GhcdzN0aO2JN029SRXyTruDaGyM3cbMdDB9uiV
         KLvg==
X-Forwarded-Encrypted: i=1; AJvYcCWBD44/T8cDx2xF+iw7SGWfwC9uXhgW7heDaydPiLAdoWewYdbyod0SAFglSqixkCJKYu+7gfQy2IccnO2q1/wFLxZOuFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9fjmfT9AmU0pX8EFs2n9nzVJhoeye/kwFnnfkL2iAJJVmby5Z
	CJm9MEYt692mPB/ibN1m1NewJrFTyCsCT1C7uMFd3zpXJWaRcOmtWkm+rTswNw==
X-Gm-Gg: AZuq6aIIJPiY0rbNcvEdjDFtwczPGDZ7L5Cn4DorkpHOxeZzCanji080JspDkXj3hZf
	qhEKLgrWY026+moFztByK908NGn2GVAX37fm0G9B8mr3b5CF8TyqHPMszsJYZPTn6I4sQ9s2NPW
	1kh/t/omIfbvYUxOH6kCtFroarpEndbZb2BA0dN6EhAHyb5+Vp0FjZPLYKBKGcGpb+2wTPECaNs
	H2ltz8/dzSrTSPLf/kVgL7ge1Z9APwuol53w//Oa1IStTCDEbtJj+pt2HSMmn+l+1b2dcMK7HFN
	MbK4AFMAJc2npVa47+apuNwy/p64lejxl2uTvNJjeuRg9QlEIP9b6yA+qYqnngzBiQQM9LMZLyH
	3NJ8pFOkPCzIPMZDRxHgJP4iUADxvztG5c2D9aotJRFipf08i++ValS+w0UUMkjtmJ9x5QhDzD+
	Xp5GZjFIvZoG59BZIzhznr+rAdQ8QZ0dBpEHr/EgBWQb+fXqdsq/WTDM/HF4lFWNXKOGXgaoEM
X-Received: by 2002:a05:690c:7242:b0:796:26af:6126 with SMTP id 00721157ae682-797a0bc2932mr140302307b3.2.1771190640224;
        Sun, 15 Feb 2026 13:24:00 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c177773sm93045297b3.2.2026.02.15.13.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 13:23:59 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: m@maowtm.org
Cc: amir73il@gmail.com,
	gnoack@google.com,
	jack@suse.cz,
	jannh@google.com,
	linux-security-module@vger.kernel.org,
	mic@digikod.net,
	penguin-kernel@I-love.SAKURA.ne.jp,
	song@kernel.org,
	utilityemal77@gmail.com
Subject: Re: [RFC] Landlock: mutable domains (and supervisor notification uAPI options)
Date: Sun, 15 Feb 2026 16:23:52 -0500
Message-ID: <20260215212353.3549464-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <6981cdab-dcff-47fc-a236-1890f9bc9c55@maowtm.org>
References: <6981cdab-dcff-47fc-a236-1890f9bc9c55@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Feb 15, 2026 at 02:54:08AM +0000, Tingmao Wang wrote:
> Hi,
> 
> Recently I have been continuing work on the previously proposed Landlock
> supervise feature (context below).  While I do have some rough PoCs, and
> I'm aware that sometimes code is better than talk, because of the amount
> of work involved, I would like to get some early feedback on the design
> before continuing.
> 
> Scrappy demo (just 2-3 min screencasts):
> 
> - user-space implemented "permissive mode":
>     https://fileshare.maowtm.org/landlock-20260214/demo.mp4
> - mutable domains based on a reloadable config file:
>     https://fileshare.maowtm.org/landlock-20260213/demo.mp4
> 
> While I would be glad to receive reviews from anyone (and I've added
> people who have replied to the previous RFC in CC), Günther, when you are
> not too busy, can you kindly give this a review?  A lot of this has
> already been discussed with Mickaël, in fact a large part of this design
> was from his suggestions.  I apologize in advance for the length of this
> email - please feel free to respond to any part of it, and whenever you
> have time to.
> 
> PoC code used in the above videos are largely generated, somewhat buggy,
> and unreviewed, but they are available:
> 
> - mutable domains:
>     https://github.com/micromaomao/linux-dev/pull/26/changes
> - supervisor notification:
>     https://github.com/micromaomao/linux-dev/pull/27/changes
> 
> The motivations listed in [1] are still relevant, and to add to that, here
> are some additional examples of things we can do with the supervisor
> feature (all from unprivileged applications):
> 
> - Implementing a version of StemJail [2] which does not rely on bind
>   mounts and LD_PRELOAD (for the notification part, not for access
>   control).  Or in fact, any other uses of LD_PRELOAD for the purpose of
>   finding out what files are accessed.
> 
> - For island [3], some sort of denial logging tied to the context,
>   integrated in the tool itself (rather than through kernel audit) and
>   live config reload.
> 
> - Use in a non-security related context, such as automated build
>   dependency tracking.
> 
> [1]: https://lore.kernel.org/all/cover.1741047969.git.m@maowtm.org/
> [2]: https://github.com/stemjail/stemjail
> [3]: https://github.com/landlock-lsm/island
> 
> 
> Background
> ----------
> 
> A while ago I sent a "Landlock supervise" RFC patch series [1], in which I
> proposed to extend Landlock with additional functionality to support
> "interactive" rule enforcement.  In discussion with Mickaël, we decided to
> split this work into 3 stages:  quiet flag, mutable domains, and finally
> supervisor notification.  Relevant discussions are at [4] and in replies
> to [1].
> 
> The patch for quiet flag [5] has gone through multiple review iterations
> already.  It is useful on its own, but it was also motivated by the
> eventual use in controlling supervisor notification.
> 
> The next stage is to introduce "mutable domains".  The motivation for this
> is two fold:
> 
> 1. This allows the supervisor to allow access to (large) file hierarchies
>    without needing to be woken up again for each access.
> 2. Because we cannot block within security_path_mknod and other
>    directory-modification related hooks [6], the proposal was to return
>    immediately from those hooks after queuing the supervisor notification,
>    then wait in a separate task_work.  This however means that we cannot
>    directly "allow" access (and even if we can, it may introduce TOCTOU
>    problems).  In order to allow access to requested files, the supervisor
>    has to add additional rules to the (now mutable) domain which will
>    allow the required access.
> 
> [1]: https://lore.kernel.org/all/cover.1741047969.git.m@maowtm.org/
> [4]: https://github.com/landlock-lsm/linux/issues/44
> [5]: https://lore.kernel.org/all/cover.1766330134.git.m@maowtm.org/
> [6]: https://lore.kernel.org/all/20250311.Ti7bi9ahshuu@digikod.net/
> 
>
Hello Tingmao,

Thank you for sending this.

I've read the proposal and had some time to gather thoughts on it. I'm
planning to break this feedback into multiple parts.

This first part addresses the intersect flag.

> Proposed changes
> ----------------
> 
> This patchset introduces the concept of "supervisor" and "supervisee"
> rulesets (alternative names for this are "static"/"dynamic",
> "mutable"/"immutable" etc), which are Landlock rulesets that are joined
> together when enforced.  The supervisee ruleset can be thought of as the
> "static" part of a domain, and the supervisor ruleset can be thought of as
> the "dynamic" part.  The two rulesets can have different rules and access
> rights for individual rules, but they internally have the same sets of
> handled access and scope bits.  When an access request is evaluated for
> processes in such domains, the access is allowed if, for each layer,
> either the supervisee or the supervisor ruleset of that domain allows the
> access.
> 
> A Landlock supervisor will first create the supervisor ruleset, which
> internally creates a ref-counted landlock_supervisor which the unmerged
> (and in fact, unmergeable, to prevent accidental misuse) landlock_ruleset
> will point to.  Through a new ioctl, the user can get a supervisee ruleset
> with the attached supervisor (this relationship does not necessarily have
> to be 1-1), which can then be passed to landlock_restrict_self() by a
> child process.  The supervisor can also at any time (before the ioctl,
> before the landlock_restrict_self() call, or after it) modify the
> supervisor ruleset to add or remove (via a new "intersect" flag) rules or
> change access rights, and commit those changes through a flag passed to
> landlock_add_rule() (although maybe this would be better done as an
> ioctl() on the supervisor?), after which the changes start affecting the
> child.
> 
> The supervisee ruleset is immutable, it is basically the current
> landlock_ruleset, and internally we continue to "fold" rules from parents
> into the child's rbtree.  However, since all ancestor supervisor rulesets
> are mutable, we cannot simply fold the supervisor rules from parents into
> its children at enforce time, as it may be removed or changed later at a
> parent layer.  Therefore, if an access is not allowed by any layer's
> supervisee ruleset (which is quick to check thanks to the "folding" of the
> supervisee rules), Landlock will then have to check that the access is
> allowed by the supervisor rulesets of all the denying layers. (The access
> is also denied if any of the denying layers does not have a supervisor
> ruleset, in this case we don't even have to check the other supervisor
> rulesets.)
> 
> To enable removing rules from a ruleset, we also implement the
> LANDLOCK_ADD_RULE_INTERSECT flag for landlock_add_rule().  If this is
> passed, instead of adding rules, the corresponding rule, if it exists, is
> updated to be the intersection of the existing access rights and the
> specified access rights.  If the result is zero, the rule is removed.  For
> API consistency, the LANDLOCK_ADD_RULE_INTERSECT flag will be supported
> for both supervisor and supervisee (i.e. existing) rulesets, but it is
> probably only useful for supervisor rulesets.
> 
> (I'm not very certain about this intersect flag - see below for
> alternative designs)
> 
> Later on, a supervisor notification mechanism can be implemented to allow
> the supervisor to be notified when an access is denied by its supervised
> layer, but this is not in scope for the "mutable domains" feature on its
> own (although it does make it significantly more useful).  This will be
> the step after mutable domains, if we keep with the plan previously
> discussed with Mickaël.
> 
> 
> uAPI example
> ------------
> 
> ```c
> /*
>  * This landlock_ruleset_attr controls the handled/quiet/scope bits for
>  * this layer (internally shared by both the supervisor and supervisee
>  * rulesets).
>  */
> struct landlock_ruleset_attr attr = {
>     .handled_access_fs = ...,
>     /* ... */
> };
> 
> /* supervisor_fd default to CLOEXEC */
> int supervisor_fd = landlock_create_ruleset(
>     &attr, sizeof(attr), LANDLOCK_CREATE_RULESET_SUPERVISOR);
> if (supervisor_fd < 0)
>     perror("landlock_create_ruleset");
> 
> /*
>  * supervisor_fd can then be passed to landlock_add_rule, but it does not
>  * work with landlock_restrict_self.  Not working for restrict_self means
>  * that if a sandboxer accidentally passes the supervisor fd to the child,
>  * it would not work in the same way as the supervisee fd, and therefore
>  * the error is more discoverable.
>  */
>  if (landlock_add_rule(supervisor_fd, ...) < 0)
>     perror("landlock_add_rule");
> 
>  /*
>   * Any changes to the supervisor ruleset must be committed, even before
>   * any child calls landlock_restrict_self().  Without committing, the
>   * supervisor ruleset still behaves as if it is empty.
>   */
>  if (landlock_add_rule(supervisor_fd, ..., ...,
>         LANDLOCK_ADD_RULE_COMMIT_SUPERVISOR) < 0)
>     perror("landlock_add_rule(COMMIT)");
> 
> /* Creates the supervisee ruleset */
> int supervisee_fd = ioctl(supervisor_fd,
>         LANDLOCK_IOCTL_GET_SUPERVISEE_RULESET, /* flags= */ 0);
> if (supervisee_fd < 0)
>     perror("ioctl(LANDLOCK_IOCTL_GET_SUPERVISEE_RULESET)");
> 
> pid_t child = fork();
> if (child == 0) {
>     /* The supervisor should not leak supervisor_fd to any untrusted code. */
>     close(supervisor_fd);
>     if (landlock_restrict_self(supervisee_fd, 0) < 0)
>         perror("landlock_restrict_self");
>     execve(...);
>     perror("execve");
> } else {
>     close(supervisee_fd);
>     /*
>      * Here, the supervisor can add rules via landlock_add_rule(), Or
>      * remove rules via landlock_add_rule() with
>      * LANDLOCK_ADD_RULE_INTERSECT.
>      *
>      * Added rules doesn't come into effect until a final
>      * landlock_add_rule() with commit flag (which may also just add a
>      * dummy rule with access=0):
>      */
>     if (landlock_add_rule(supervisor_fd, ..., ..., LANDLOCK_ADD_RULE_COMMIT_SUPERVISOR) < 0)
>         perror("landlock_add_rule(COMMIT)");
> }
> ```
> 
> 
> Discussion on LANDLOCK_ADD_RULE_INTERSECT
> -----------------------------------------
> 
> This was initially proposed by Mickaël, although now after writing some
> example code against it [7], I'm not 100% sure that it is the most useful
> uAPI.  For a supervisor based on some sort of config file, it already has
> to track which rules are added to know what to remove, and thus I feel
> that it would be easier (both to use and to implement) to have an API that
> simply "replaces" a rule, rather than do a bitwise AND on the access.
> 
Instead of intersection being done at the rule level via
landlock_add_rule, would it be better for intersection to be done at the
ruleset_fd/ruleset level?

So instead of intersecting individual rules, you can intersect entire
rulesets, with the added benefit of being able to intersect handled
accesses as well. (so you could handle an access initially, and not
handle it later).

Intersecting at the ruleset level allows for grouping the intersection rules
together, so you could create an unenforced ruleset for the sole purpose
of intersecting with rulesets, and intersect all the rule(s) at once.

That way, the ruleset fd can be reused for this purpose later with other
supervisees, instead of creating ruleset, intersecting individual rules,
repeat.

I think also the semantics of having a function called
"landlock_add_rule" actually removing accesses (when the intersect flag
is added) is also confusing, because we're not really *add*-ing
anything, we're removing.

ALTERNATIVE #1

Maybe the best way to do it is instead continue treating rulesets as
immutable, but allow composition of them at ruleset creation time.

This would look something like:

Ruleset C = Ruleset A & Ruleset B

Ruleset A and B are never modified, but instead a new Ruleset C is
created that is the intersection of A and B. This could be done in a
variety of ways (LANDLOCK_CREATE_RULESET_INTERSECT? new IOCTL?)

An example API for what this might look like:

  struct landlock_ruleset_attr ruleset_attr = {
          // other fields for handled accesses must be blank.
          .left_fd = existing_fd,
          .right_fd = other_existing_fd,
  };
  int new_ruleset_fd = syscall(SYS_landlock_create_ruleset, &ruleset_attr, 
    sizeof(ruleset_attr), LANDLOCK_CREATE_RULESET_INTERSECT);

And then the resulting ruleset which is the intersection of existing_fd
and other_existing_fd could be returned.

Similarly, we could: 

  int new_ruleset_fd = syscall(SYS_landlock_create_ruleset, &ruleset_attr, 
      sizeof(ruleset_attr), LANDLOCK_CREATE_RULESET_UNION);

Which would be convienent for creating unions of rulesets.

Then instead mutating rulesets, we commit/replace an entirely new ruleset.

ioctl(supervisee_fd, LANDLOCK_IOCTL_COMMIT_RULESET, &new_ruleset_fd);

This has the following benefits:

1. Clearer semantics: "landlock_add_rule" is just for adding rules, not
removing.

2. Intersection of all ruleset attributes, not just individual rule
attributes.

3. Better logical grouping of rules for the purpose of intersection, and
better composition.

It does have drawbacks:

1. Intersecting individual rules requires making an entire ruleset for
that one rule.

2. Users must be responsible for closing the unused/old rulesets that
they might not longer need.

ALTERNATIVE #2

A middle ground is to keep the ruleset mutation via landlock_add_rule,
but have it be done at the ruleset_fd level.

Something like this:

  struct landlock_ruleset_operand intersection = {
    .operand = other_ruleset_fd
  };
  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_INTERSECT_RULESET, &intersection, 0))

I think this is also a valid way to do things, and increases the
reusibility of rulesets.

1. Again, having landlock_add_rule being used to actually remove rules
is confusing.

2. I'm unsure if we can change handled accesses after ruleset creation,
so we might not be able to intersect the handled accesses like we can in
the ALTERNATIVE #1.

> Another alternative is to simply have a "clear all rules in this ruleset"
> flag.  This allows the supervisor to not have to track what is already
> allowed - if it reloads the config file, it can simply clear the ruleset,
> re-add all rules based on the config, then commit it.  Although I worry
> that this might make implementing some other use cases more difficult.

At a minimum, it is cumbersome, and I worry about file descriptors
becoming inaccessible (due to bind mounts / namespace changes in the
supervisor's environment).

Of course they can just hold those file descriptors open for the purposes
of future intersections, but this is annoying and error prone.

> [...]

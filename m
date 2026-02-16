Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118615B21A
	for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 21:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771277313; cv=none; b=tTDoz1UR7gWTM2EL3exy1vYcejpOFniLwzcqH4dgd+7J1+zbCeY0Q5YLWYWmQr79QGhyuUQ7zczu05Ati6ZIx1u2oHkimaIh/iO9PEiynzWCPpGo7lM4X2rWv4P9c+3BQk/AuycE78CNrWt0OAJQ8yNnpjLP5Pt2nfE2OFyvt6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771277313; c=relaxed/simple;
	bh=75R47OVUQlSR8Ba9yeoGGUqUmo5+0gHNXFnNwS9kbnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZcCj/lp/UY6566wbyKp2ABaVBJctnhPQ77LdZlA5wSAFcQ4FDRAMRU7F80rhUEF/ynLFb86kboEoVuN4UgpgJPCR/f32dPG9QMPor0o0232wvkz+BvysPvRBkgShCwquzgQtmtfy3mSK6rUD8bkmBDJTY1mOpOoNQnbspYGVKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgdIoye+; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgdIoye+"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64c31ca77b4so1454455d50.2
        for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 13:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771277310; x=1771882110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dC24BrCGC/P7NNhq0vj02AxLk/Sl0MXjikxqnDCpZ2Y=;
        b=dgdIoye+oc+owZoAA6kXFBV1Dv88RSawtQRMWedmuMDSHRJFFdiwQw5365eazavi4T
         NlVX+HkA/KbAuf2H8Xu3zGena7H9DW3Cv6V0SkGtw+hMAGWVBa/qIXUsV5lya/0/MXoy
         7U/myPWcjzzkeuIyhMpMjhvMMGJ9NA2qk5Mx8x3p370n5fnjkd38+DABowS/wogcKi0l
         IYFRa2cTXytQtpxkPSCIgAn+9325dAaWOLzwqvByBMUDrNjaGbMc4DkoXigwfNywJ7XC
         4QpDyJVTcSzNkTKiPtcrVg2qc7Gb75z3JihyGL/6+ny1jjsIUEhJpW8rM66pDHdrq3ry
         fI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771277310; x=1771882110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dC24BrCGC/P7NNhq0vj02AxLk/Sl0MXjikxqnDCpZ2Y=;
        b=RIPTo3OYrLo6N81oG7PcbVQY1x0VxOSAw6zaXfhP3s4B6RrHracQ8NQtra4M+IVwTA
         iF0M9OX2P5gyexa46Wc1GtrVIX8buZtQ/3m8bOx8/xfqjwfTfXySpsaup/J8K1EWGkn9
         Uj1t+1L1msx15OA5GWPOnSBkwipE0w2zEPPpn5VOgYv6BS3me6e2LkVe7XrESGmEHiLF
         mgUWcTyeHxnop5epcCKoSqGT8HkOwIpAGyvPCPTnUSi07ftQsIvS3hjVSP5E3Ln82dBZ
         sDkTeVGSkCk/094DzsUdHO57GhCbxCKdVO1zP9HjMazfeHyA1wTw1PTYfMRS8MNeVIBh
         TW/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaRBS/T7cjsaqGILocVxc4qqCKPWkGAtsx/1MIZczGBCdLHnIRfjAiCJDtVmEDp9ifLN77O0yxMS4CAYtqsTesrSUVE0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKH3sNhoy0qPFY9lX5YlQxHdmQ3O/Z5ZgQaAkOh27oF6WVRj3K
	gcIdatkqYdQe6Snk/2DUf4WMDDigGzFIQSaKkerwB1Yf4t7H4z0yb84u
X-Gm-Gg: AZuq6aLeg6DdRHJaa7W/IsePxl3uznaIvhnFfcdtYw7eXO72DkQ4Da0vrWA2m5wnQQ4
	ymXnXNFgddppTF4wapuDNqzhaVu7C8BM2WXbSLMRSJ0gKprTOzgwG62rUIzOMPKWs/+0PSbEW32
	RnOBtgyZqUqv/qi+hrkDfbLHEW03zXlJBnB6OJRhaGGYA5tgcslw07Zd32Nv+6mBCjytN48W3Q1
	yxW/t/XJrzfMEIjYfA3m0S6v7YXjugjADN1Y5Vi5oy+eRPbCn6Yh6lx44htL4OEaT8Nk3I/rPfT
	NpGRTtE8uNahya2h/KiCRZVr2OPP79gt1IDkIPcnd34TBShhwxVnjTK8fbd5EF9mAhhA16Crr9q
	lXbZRPFLKgiCWh6WBqRHiFY9Rh855x0arAAPrVmG1dhcwidwtu14ZF0YXAt3s7VfksTZZG1CkCF
	aJviuiFpbNNoF4iafs5Frpmj7gYRAU27h5PCqCzf17s+/kDsc3Nflclx1ELaA6+ykd74aXuV4B
X-Received: by 2002:a05:690e:e8c:b0:64a:de2a:e6e9 with SMTP id 956f58d0204a3-64c21a96f6amr7682975d50.24.1771277309487;
        Mon, 16 Feb 2026 13:28:29 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22e6ef3esm3992194d50.1.2026.02.16.13.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 13:28:28 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: utilityemal77@gmail.com
Cc: amir73il@gmail.com,
	gnoack@google.com,
	jack@suse.cz,
	jannh@google.com,
	linux-security-module@vger.kernel.org,
	m@maowtm.org,
	mic@digikod.net,
	penguin-kernel@I-love.SAKURA.ne.jp,
	song@kernel.org
Subject: Re: [RFC] Landlock: mutable domains (and supervisor notification uAPI options)
Date: Mon, 16 Feb 2026 16:27:51 -0500
Message-ID: <20260216212753.4159224-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260215212353.3549464-1-utilityemal77@gmail.com>
References: <20260215212353.3549464-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Feb 15, 2026 at 02:54:08AM +0000, Tingmao Wang wrote:
> [...]
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

Is blocking during connect(2) allowed either if the socket is non-blocking?

This may be another example case that needs to be handled differently than calls
we can block in safely.

> [...]
> Why require a commit operation?
> -------------------------------
> 
> This is not a strictly necessary requirement with an rbtree based
> implementation - it can be made thread-safe with RCU while still allowing
> lockless access checks without too much overhead (although the code is
> indeed more tricky to write).  However, there is a possibility that the
> domain lookup might become a hashtable with some future enhancement [8],
> at which point it would be better to have an explicit commit operation to
> avoid rebuilding the hashtable for every landlock_add_rule().  Having a
> commit operation will likely also make some atomicity properties easier to
> achieve, depending on the supervisor's needs.
> 
> I've actually previously implemented hashtable domains [9], but after
> benchmarking it I did not find a very significant performance improvement
> (2.2% with 10 dir depth and 10 rules, 8.6% with 29 depth and 1000 rules) [10]
> especially considering the complexity of the changes required.  After
> discussion with Mickaël I've decided to not pursue it for now, but I'm
> open to suggestions.  If Mickaël and Günther are open to taking it, I can
> revive the patch.
> 
> [8]:  https://github.com/landlock-lsm/linux/issues/1
> [9]:  https://lore.kernel.org/all/cover.1751814658.git.m@maowtm.org/
>       Note that the benchmark posted here was inaccurate, due to the
>       relatively high cost of kfunc probes compared to the work required
>       to handle one openat().  For a more proper benchmark, refer to the
>       comment below:
> [10]: https://github.com/landlock-lsm/landlock-test-tools/pull/17#issuecomment-3594121269
>       See specifically the collapsed section "parse-microbench.py
>       base-vm.log arraydomain-vm.log"
> 
> 
> Proposed implementation
> -----------------------
> 
> In order to store additional data and locks for the supervisor, we create
> a new `struct landlock_supervisor`.  Both the supervisor and supervisee
> rulesets, and the landlock_hierarchy of each layer, will point to this
> struct.  (A future revision may optimize on this to reduce pointer chasing
> when needing to check supervisor rulesets of parent layers.)
> 
> One of the main tricky areas of this work is the implementation of
> LANDLOCK_ADD_RULE_COMMIT_SUPERVISOR and the access checks.  We want:
> 
> - atomic commit: the supervised program should not "experience" any rule
>   changes until they are committed, and once it is committed it should see
>   all the changes together
> 
> - lockless access checks (even when the supervisee ruleset does not allow
>   the access, necessitating checking the supervisor rulesets, this should
>   still not involve any locks)
> 
> - atomic access checks: an access check should either be completely based
>   on the "old" rules or the "new" rules, even if a commit happens in the
>   middle of a path walk.  This prevents incorrect denials when a commit
>   moves a rule from /a to /a/b when we've just finished checking /a/b and
>   about to check /a.
> 
> In order to achieve atomic commit, the supervisor fd cannot actually point
> to (and thus allow editing) the "live" ruleset.  Instead, when a
> `LANDLOCK_ADD_RULE_COMMIT_SUPERVISOR` is requested, a new `struct
> landlock_ruleset` is created, the rules are copied over from the existing
> supervisor ruleset, and the pointer in the landlock_supervisor is swapped.
> 
> In order to keep access checks lockless (as it is currently), the live
> ruleset pointer needs to be RCU-protected.  To reduce complexity, this
> initial implementation uses synchronize_rcu() directly in the calling
> thread of `LANDLOCK_ADD_RULE_COMMIT_SUPERVISOR`, and frees the old
> supervisor ruleset afterwards, but this can be rewritten to use call_rcu()
> in a future iteration if necessary (which will allow quicker commits,
> which can be quite impactful if we use this to auto-generate rulesets).
> 
> During access checks, for each step of the path walk, after
> landlock_unmask_layers()-ing the supervisee rule, if the access is not
> already allowed, we check for rules in the supervisor ruleset and
> effectively does landlock_unmask_layers() on them too.
> 
> In order to have atomic access checks, we need to pre-capture the
> supervisor committed ruleset pointers for all layers at the start of the
> path walk (in `is_access_to_paths_allowed`).  Storing this on the stack,
> this takes the space of 16 pointers, hence 128 bytes on 64-bit (I'm keen
> to hear suggestions on how best to mitigate this).  Another effect of this
> "caching" is that in order to be able to release rcu in the path walk
> (which is required for the path_put()), we actually need to take refcount
> on the committed ruleset (and free it at the end of
> is_access_to_paths_allowed).
> 
> 
> Optional accesses
> -----------------
> 
> Optional access (truncate and ioctl) handling is also tricky.  There are
> two possible alternatives:
> 
> - The allowed optional actions are still entirely determined at file open
>   time.  This likely works in the majority of cases, where truncate (and
>   maybe also ioctl) are given or taken away together with write access.
>   However, this may mean that we need to send an access request
>   notification immediately at open() time if e.g. write access is given
>   but truncate (or ioctl) is not, even if truncate (or ioctl) is not
>   attempted yet, since the supervisor would not be able to allow it later.
>   (or alternatively we can choose to not send this notification, and the
>   supervisor will just have to "know" to add truncate/ioctl rights if
>   required, in advance.)
> 
> - The allowed optional actions are considered to be determined at
>   operation time (even though for a static ruleset it is cached).  This
>   means that for supervised layers, we will always have to re-check their
>   supervisor rulesets, whether or not the access was initially allowed,
>   which will involve doing a path walk.  This does however means that the
>   supervisor can be notified "in the moment" when a truncate (or more
>   likely to be relevant - ioctl) is attempted.
> 
> The PoC partially implements the second one (but has bugs), but I'm not
> sure which is best.  The second one is most flexible and makes more sense
> to me from a user perspective, but does come with performance
> implications.
> 
> 
> (Disallowing) self-supervision
> ------------------------------
> 
> We should figure out a way to ensure that a process cannot call
> landlock_restrict_self() with a ruleset that has a supervisor for which it
> has access to (i.e. via a supervisor ruleset fd).  This prevents
> accidental misuse, and also prevents deadlocks as discussed in [11].  I'm
> not sure if this will be easy to implement, however.

This seems like a graph acyclicity problem.

Here are a couple cases to consider:

1. LANDLOCK_RESTRICT_SELF_TSYNC misuse:

In the case where a user wants to use this supervisor to supervise other
threads within the same process, a user could naively call
LANDLOCK_RESTRICT_SELF_TSYNC (merged into 7.0) when enforcing the
supervisee_fd. This would enforce the same policy on the thread running
the supervisor and the supervisee.

2. Transfer of the supervisee_fd (SCM_RIGHTS)

It's possible to transfer file descriptors over unix domain sockets. If
we had a supervisor daemon that used this form of IPC to send precooked
supervisee_fds to other threads, and one of those ended up in a parent
process of the supervisor, we could inadvertently end up with problems.

3. Blocking in other LSMs (pointed out in your source [11])

The hardest case to deal with, other LSMs like TOMOYO can also block and
cause dependency cycles.

---

This gets tricky, and I don't know  if just checking parent / child
relationships would work. Because the supervisor and supervisee rulesets
are just file descriptors, and there are potentially unlimited number of
ways these FDs could be transfered or instantiated.

I think the best way to deal with this is constraining the problem space:

An idea (binding supervisors/supervisees to domains on first use)

Whenever landlock_restrict_self(supervisee_fd,...) is called, check the
current domain credentials and verify that the domain is a *proper
subset* of the supervisors domain. Then permanently close the
supervisee_fd and never allow reenforcement. Similarly, once a
supervisor_fd is created, never allow commiting from a context with
"current landlock domain != original landlock domain at creation"

This prevents post-enforcement usage of the supervisee_fd by a parent
domain, and post-commit usage of a supervisee_fd by any subdomain.

I'm not sure if it's possible to check whether one domain is a
proper subset of another (ie supervisor domain includes but *doesn't equal*
supervisee domain), but I think that's one way do do it.

This idea would help, but doesn't address case 3 above.

> 
> [11]: https://lore.kernel.org/all/cc3e131f-f9a3-417b-9267-907b45083dc3@maowtm.org/
> 
> 
> Supervisor notification
> -----------------------
> 
> The above RFC only covers mutable domains.  The natural next stage of this
> work is to send notification to the supervisor on access denials, so that
> it can decide whether to allow the access or not.  For that, there are
> also lots of questions at this stage:
> 
> 
> - Should we in fact implement that first, before mutable domains?  This
>   means that the supervisor would only be able to find out about denials,
>   but not allow them without a sandbox restart.  We still eventually want
>   the mutable domains, since that makes this a lot more useful, but I can
>   see some use cases for just the notification part (e.g. island denial
>   log), and I can't see a likely use case for just mutable domains, aside
>   from live reload of landlock-config (maybe that _is_ useful on its own,
>   considering that you can also find out about denials from the kernel
>   audit log, and add missing rules based on that).
> 
> 
> - Earlier when implementing the Landlock supervise v1 RFC, I basically
>   came up with an ad-hoc uAPI for the notification [12], and the PoC code
>   linked to above also uses this uAPI.  There are of course many problems
>   with this as it stands, e.g. it only having one destname, which means
>   that for rename, the fd1 needs to be the child being moved, which does
>   not align with the vfs semantic and how Landlock treat it (i.e. the
>   thing being updated here is the parent directory, not the child itself).
>   Same for delete, which currently sends the child as fd1.
> 
>   But also, in discussion with Mickaël last year, he mentioned that we
>   could reuse the fsnotify infrastructure, and perhaps additionally, use
>   fanotify to deliver these notifications.  I do think there is some
>   potential here, as fanotify already implements an event header, a
>   mechanism for receiving and replying to events, etc.  We could possibly
>   extend it to send Landlock specific notifications via a new kind of mark
>   (FAN_MARK_LANDLOCK_DOMAIN ??) and add one or more new corresponding
>   event types.  Mickaël mentioned mount notifications [13] as an example
>   of using fanotify to send notifications other than file/dir
>   modifications.
> 
>   I'm not sure if directly extending the fanotify uAPI is a good idea tho,
>   considering that Landlock is not a feature specific to the filesystem -
>   we will also have denial events for net_port rules, and perhaps more in
>   the future.  However, Mickaël mentioned that there might be some
>   internal infrastructure which we can re-use (even if we have our own
>   notification uAPI).
I think that a new FAN_MARK would be required to use fanotify uAPI.

There are a couple questions I have with this: (if we extend fanotify)

1. What FAN_CLASS_* would notifications use?

FAN_CLASS_* specifies the type of notification, when the notification is
triggered.

See [1] for the current classes.

If we want interactive, pre-access blocking, that would correspond to
FAN_CLASS_PRE_CONTENT or FAN_CLASS_CONTENT. Both of which currently
require CAP_SYS_ADMIN regardless of FAN_MARK. Which requiring that
would require that supervisors have CAP_SYS_ADMIN, if the current
CAP_SYS_ADMIN requirements remain in place.

(If we don't have interactive blocking denials, we could just use
FAN_CLASS_NOTIF)

2. How would fanotify events be encoded?

Events in fanotify use this structure for event data (one or more of the
following must be recieved in a notification) [2]

           struct fanotify_event_metadata {
               __u32 event_len;
               __u8 vers;
               __u8 reserved;
               __u16 metadata_len;
               __aligned_u64 mask;
               __s32 fd;
               __s32 pid;
           };

There are access classes landlock restricts that might not have an fd at
all, like abstract unix sockets, tcp ports, signals etc.

Good news is fanotify supports multiple types of additional information
records, and we could potentially extend fanotify to support new ones as
you alluded to.

For examples of this, see struct fanotify_event_info_mnt,
fanotify_event_info_pidfd.

These records get attached to the event so they could be used to pass
landlock access data.

3. If we support interactive permission decisions (even for a
subset of landlock access rights only), do we use the response code? 
(question might be moot if we don't do blocking/responses at all)

From [2]:

       For permission events, the application must write(2) a structure
       of the following form to the fanotify file descriptor:

           struct fanotify_response {
               __s32 fd;
               __u32 response;
           };


response is a FAN_ALLOW or FAN_DENY. This is used by fanotify as a
one-time access decision. Would this be used to do one-off exceptions to
policy, or would we require policy decisions to go through the
supervisor_fd and ignore the response code?

4. How would we reconcile the disparity between fanotify access rights
and landlock access rights?

There's no clean 1:1 mapping between fanotify access rights and landlock
access rights as Mickaël pointed out. [2] [3]

Many fs rights (creation, deletion, rename, linking) are not handled or
implemented, (not even considering network/unix/signal scoping), so we'd
be adding all these landlock specific rights.

We could make a "catch-all" FAN_LANDLOCK_ACCESS or similar and ignore
all the existing rights, and put the actual access data in the event
record. It's awkward either way.
---

In conclusion, I think extending fanotify is more viable than seccomp,
from a purely technical standpoint. because it seems extensible,
and because it runs post-lsm hooks.

That being said, it's awkward, requires large extensions to the API, and
definition of permissions that are specific to landlock.

Whether or not landlock makes sense in fanotify from a semantic point of
view is an entirely different question. There's no precedent for
non-filesystem access controls in fanotify, so it's a little... out-of-place
for an LSM to expose features on a filesystem access notification api?

Curious on what people think.

[1]: https://man7.org/linux/man-pages/man2/fanotify_init.2.html
[2]: https://man7.org/linux/man-pages/man7/fanotify.7.html
[3]: https://lore.kernel.org/all/20250304.Choo7foe2eoj@digikod.net/
> 
> 
> - The other uAPI alternative which I have been thinking of is to extend
>   seccomp-unotify.  For example, a Landlock denial could result in the
>   syscall being trapped and a `struct seccomp_notif` being sent to the
>   seccomp supervisor (via the existing mechanism), with additional
>   information (mostly, the file(s) / net ports being accessed and access
>   rights requested) attached to the notification _somehow_.  Then the
>   supervisor can use the same kind of responses one would use for
>   seccomp-unotify to cause the syscall to either be retried (possibly via
>   `SECCOMP_USER_NOTIF_FLAG_CONTINUE`) or return with an error code of its
>   choice (or alternatively, carry out the operation on behalf of the
>   child, and pretend that the syscall succeed, which might be useful to
>   implement an "allow file creation but only this file" / "allow `mktemp
>   -d` but not arbitrary create on anything under /tmp").
> 
>   Looking at `struct seccomp_notif` and `struct seccomp_data` however, I'm
>   not sure how feasible / doable this extension would be.  Also,
>   seccomp-unotify is supposed to trigger before a syscall is actually
>   executed, whereas if we use it this way, we will want it to trigger
>   after we're already midway through the syscall (in the LSM hook).  This
>   might make it hard to implement (and also twists a bit the uAPI
>   semantics of seccomp-unotify).
>

(Some of the stuff discussed with seccomp below is derived from a side
conversation with Tingmao over this proposal)

There are some problems with extending seccomp unotify. Passing the
full context needed through this api to the supervisor is problematic.
seccomp unotify notifications look like this [4]:

           struct seccomp_notif {
               __u64  id;              /* Cookie */
               __u32  pid;             /* TID of target thread */
               __u32  flags;           /* Currently unused (0) */
               struct seccomp_data data;   /* See seccomp(2) */
           };

And struct seccomp_data [5]:

           struct seccomp_data {
               int   nr;                   /* System call number */
               __u32 arch;                 /* AUDIT_ARCH_* value
                                              (see <linux/audit.h>) */
               __u64 instruction_pointer;  /* CPU instruction pointer */
               __u64 args[6];              /* Up to 6 system call arguments */
           };

Even if we pass the syscall data, for the userspace to actually decode
the arguments to figure out what the access is doing we have two
critical problems (1,2) and one annoyance (3):

1. The syscall itself doesn't necessarily contain the full context of the access.

2. We cannot decode the pointer-based arguments from userspace for a syscall
in seccomp without TOCTOU. It also requires reaching into userspace
memory. [6]

3. Decoding the syscall number is an arch-specific operation that we now have
to expect userspace to deal with.

So unless there's something I'm missing extending seccomp unotify doesn't really make
sense. It's not as much of an extensible API like fanotify.

Unless we artificially trigger some notification after the fact, and figure out how
to jam the relevant access information into the notification or pass it through
a side channel, it's gonna be a difficult path forward to use seccomp directly.

[4]: https://man7.org/linux/man-pages/man2/seccomp_unotify.2.html
[5]: https://man7.org/linux/man-pages/man2/seccomp.2.html
[6]: https://blog.skepticfx.com/post/seccomp-pointers/
> 
> Are there any immediate reasons, from Landlock's perspective, to rule out
> either of them?  (I will probably wait for at least a first review from

I think direct extensions to seccomp are awkward at best, and it's
difficult to reason about an extension that would make sense.

fanotify seems more viable, but would require heavy extensions
(new record types, permission types) and adding landlock to it would be
inconsistent with the existing implementation semantically. (landlock is
not VFS specific).

I think the most viable path forward if this is to be done is a
dedicated uAPI. That being said, I think what Mickaël said about reusing
the internals is viable.

> the Landlock side before directing this explicitly to the fanotify and/or
> seccomp-unotify maintainers, in case the plan significantly changes, but
> if somehow a maintainer/reviewer from either of those areas are already
> reading this, firstly thanks, and feedback would be very valuable :D )
> 
> [12]: https://lore.kernel.org/all/cde6bbf0b52710b33170f2787fdcb11538e40813.1741047969.git.m@maowtm.org/#iZ31include:uapi:linux:landlock.h
> [13]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.15-rc1&id=fd101da676362aaa051b4f5d8a941bd308603041

Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75EB2D595D
	for <linux-security-module@vger.kernel.org>; Thu, 23 Apr 2026 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776952693; cv=none; b=oj56RkVODg7Kghwo7pwrpZVTd3rGUIfdNPnqobPstG53PtzsMArrSO+tsbIvUudaI0wwlBa8388D2oZh6P7PA0TADdBCqHzqb4BrYC0tHFFYpQAvO8uANzX/wEcLlidW8Rd6EXZuYYCnbSuaSTk2whH0aYMR3HlWzBFV8uov4io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776952693; c=relaxed/simple;
	bh=i1GsA90njOWwD3f73Ej7mn+eqST6Xv+q5/OxQGxlPIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TB7nILYSxZeX24kKKhquPznrkKADb+5vukq/emOdC1etvyuTgNvl9NVRHxVu9/M0C4N/Lv9LpW2c6KvU3DHUUJdwvFz/sqp4RtluOtzatUqVHW+cyH5mVKiKx4+ojOXMv+lFDmKHafbvDhLmNmDyilMPIT5MAFrE/Wz2vEOF43o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Cz7wQqMW; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Cz7wQqMW"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g1ctx1zx6zQ0h;
	Thu, 23 Apr 2026 15:51:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1776952265;
	bh=6B8gdxhiSe0gDeQJBBKHVS9LdqfRr+KcZyzPDe+Pp2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cz7wQqMW6Skr90Iq+CQJ0U3tyH/BjG/8JvlWhb9Z4WJU1W5R581lnLhwd+ML1vLou
	 0+V+XFC+Ph0hEZ13rAif6+IpkszE3GQ+ASXKU/+VWt9duXKzOg4ryfYFMk72hiUctI
	 oyBeTNWUn3CQIuSpcA7K3eEsSn1fLhIlqzWQUAGA=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4g1ctv3lSLzLFW;
	Thu, 23 Apr 2026 15:51:03 +0200 (CEST)
Date: Thu, 23 Apr 2026 15:50:59 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Paul Moore <paul@paul-moore.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Justin Suess <utilityemal77@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Shervin Oloumi <enlightened@google.com>, 
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 00/11] Landlock: Namespace and capability control
Message-ID: <20260423.iet9Taichotu@digikod.net>
References: <20260312100444.2609563-1-mic@digikod.net>
 <20260420.aaab9bf39ef8@gnoack.org>
 <20260421.aen9Pheishah@digikod.net>
 <20260422.c1e2cbee5589@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422.c1e2cbee5589@gnoack.org>
X-Infomaniak-Routing: alpha

On Wed, Apr 22, 2026 at 11:16:59PM +0200, Günther Noack wrote:
> On Tue, Apr 21, 2026 at 10:24:00AM +0200, Mickaël Salaün wrote:
> > On Mon, Apr 20, 2026 at 05:06:32PM +0200, Günther Noack wrote:
> > > Hello!
> > > 
> > > On Thu, Mar 12, 2026 at 11:04:33AM +0100, Mickaël Salaün wrote:
> > > > Namespaces are a fundamental building block for containers and
> > > > application sandboxes, but user namespace creation significantly widens
> > > > the kernel attack surface.  CVE-2022-0185 (filesystem mount parsing),
> > > > CVE-2022-25636 and CVE-2023-32233 (netfilter), and CVE-2022-0492 (cgroup
> > > > v1 release_agent) all demonstrate vulnerabilities exploitable only
> > > > through capabilities gained via user namespaces.  Some distributions
> > > > block user namespace creation entirely, but this removes a useful
> > > > isolation primitive.  Fine-grained control allows trusted programs to
> > > > use namespaces while preventing unnecessary exposure for programs that
> > > > do not need them.
> > > > 
> > > > Existing mechanisms (user.max_*_namespaces sysctls, userns_create LSM
> > > > hook, PR_SET_NO_NEW_PRIVS, and capset) each address part of this threat
> > > > but none provides per-process, fine-grained control over both namespace
> > > > types and capabilities.  Container runtimes resort to seccomp-based
> > > > clone/unshare filtering, but seccomp cannot dereference clone3's flag
> > > > structure, forcing runtimes to block clone3 entirely.
> > > > 
> > > > Landlock's composable layer model enables several patterns: a user
> > > > session manager can restrict namespace types and capabilities broadly
> > > > while allowing trusted programs to create the namespaces they need, and
> > > > each deeper layer can further restrict the allowed set.  Container
> > > > runtimes can similarly deny namespace creation inside managed
> > > > containers.
> > > 
> > > I assume we are talking about an unrestricted systemd user session
> > > manager, which would not itself be restricted?  (If the entire user
> > > session were running under Landlock, users couldn't change their
> > > passwords with "passwd" any more, because of the no_new_privs
> > > requirement.)
> > 
> > systemd can be use to create such session, as other init systems.
> > If no_new_privs is set, commands such as passwd would indeed not work,
> > but:
> > 1. The process applying the Landlock restrictions (e.g. creating the
> >    user session) doesn't need to set no_new_privs if it has
> >    CAP_SYS_ADMIN in the current user namespace.
> > 2. SUID programs can (and should probably) be replaced with proper
> >    client/server interfaces (i.e. for the client to not be privileged),
> >    see DBus services (e.g. Account) or homectl for instance.
> 
> I also think services are a better approach than the suid bit, but
> that's to my knowledge not the state of affairs yet (until Lennart
> makes it happen, hint hint ;-)).
> 
> 
> > > > This series adds two new permission categories to Landlock:
> > > > 
> > > > - LANDLOCK_PERM_NAMESPACE_ENTER: Restricts which namespace types a
> > > >   sandboxed process can acquire: both creation (unshare/clone) and entry
> > > >   (setns).  User namespace creation has no capability check in the
> > > >   kernel, so this is the only enforcement mechanism for that entry
> > > >   point.
> > > > 
> > > > - LANDLOCK_PERM_CAPABILITY_USE: Restricts which Linux capabilities a
> > > >   sandboxed process can use, regardless of how they were obtained
> > > >   (including through user namespace creation).
> > > 
> > > Given that you already went through multiple iterations here, I fully
> > 
> > It's the first public one, but it's well advanced.
> > 
> > > expect that I am overlooking something here, but based on the
> > > explanation, it's not clear to me why the capability control is needed
> > > in addition to the namespace control, to reduce the kernel attack
> > > surface.
> > > 
> > > In my understanding the "attack surface" problem with user namespaces
> > > is that they allow unprivileged processes to gain CAP_SYS_ADMIN within
> > > that namespace, which unlocks access to code paths which were
> > > traditionally reserved for the (top level) root user.
> > 
> > This capability and others.
> > 
> > > 
> > > But then, to prevent that from happening, it seems that restricting
> > > access to user namespace creation would be sufficient?
> > 
> > It would be sufficient to limit the kernel attack surface, but it would
> > make all the related features unusable.  As explained in this cover
> > letter, there are already several ways to block everything, but this
> > doesn't help for a lot of use cases and this Landlock feature proposes a
> > new fine-grained and unprivileged way to properly restrict some
> > capabilities.
> > 
> > > 
> > > (Also, in some cases, I suspect it might be possible to break
> > > assumptions that more privileged processes make about filesystem
> > > layout if the user can change the mount layout.  But that is not an
> > > issue with Landlock, as we forbid changes to mounts and also require
> > > no_new_privs.)
> > > 
> > > 
> > > > Both use new handled_perm and LANDLOCK_RULE_* constants following the
> > > > existing allow-list model.  The UAPI uses raw CAP_* and CLONE_NEW*
> > > > values directly; unknown values are silently accepted for forward
> > > > compatibility (the allow-list denies them by default).  The Landlock ABI
> > > > version is bumped from 8 to 9.
> > > 
> > > Compatibility question:
> > > 
> > > For both permission categories, when they are "handled" in the
> > > ruleset, they default to denying *all* types of namespaces, and *all*
> > > types of capabilities.
> > > 
> > > This is different to the handled_access_* rights, where we are
> > > requiring users to explicitly list all restricted rights as "handled",
> > > because the full list of available operations might be a moving
> > > target.
> > > 
> > > Why is this not a problem for capabilities and for namespaces?  Both
> > > the list of capabilities and the list of namespaces has been expanded
> > > in the past.  What happens if a new capability or namespace is
> > > invented?  If these are evolved, is that backwards compatible for the
> > > existing users of these Landlock permission categories?
> > 
> > This question is answered is the documentation (and the commit
> > messages), and that's the main difference between handled_access_* and
> > handled_perm.  In a nutshell, the permission rules uses non-Landlock
> > bits that naturally evolve without any Landlock-specific changes.
> 
> I think the deny-by-default is fine given that these namespaces and
> capabilities do not exist yet.  It is the case where users add a rule
> and we silently ignore unknown bits in the bitfield, which I think
> introduces a small problem.  I responded to the documentation commit
> with what I believe is a counterexample for the capabilities case.
> (Let's discuss it on the documentation patch in the context of the
> examples.)
> 
> 
> > > > The handled_perm infrastructure is designed to be reusable by future
> > > > permission categories.  The last patch documents the design rationale
> > > > for the permission model and the criteria for choosing between
> > > > handled_access_*, handled_perm, and scoped.  A patch series to add
> > > > socket creation control is under review [2]; it could benefit from the
> > > > same permission model to achieve complete deny-by-default coverage of
> > > > socket creation.
> > 
> > See here ^
> > 
> > > > 
> > > > This series builds on Christian Brauner's namespace LSM blob RFC [1],
> > > > included as patch 1.
> > > > 
> > > > Christian, could you please review patch 3?  It adds a FOR_EACH_NS_TYPE
> > > > X-macro to ns_common_types.h and derives CLONE_NS_ALL, replacing inline
> > > > CLONE_NEW* flag enumerations in nsproxy.c and fork.c.
> > > > 
> > > > Paul, could you please review patch 2?  It adds LSM_AUDIT_DATA_NS, a new
> > > > audit record type that logs namespace_type and inum for
> > > > namespace-related LSM denials.
> > > > 
> > > > All four example vulnerabilities follow the same pattern: an
> > > > unprivileged user creates a user namespace to obtain capabilities, then
> > > > creates a second namespace to exercise them against vulnerable code.
> > > > LANDLOCK_PERM_NAMESPACE_ENTER prevents this by denying the user
> > > > namespace (eliminating the capability grant) or the specific namespace
> > > > type needed to exercise it.  LANDLOCK_PERM_CAPABILITY_USE independently
> > > > prevents it by denying the required capability.
> > > 
> > > Here, it is also not clear to me why LANDLOCK_PERM_CAPABILITY_USE is
> > > needed in addition to LANDLOCK_PERM_NAMESPACE_ENTER.
> > 
> > This is also explained in the documentation.
> 
> > > Looking at capabilities(7), my understanding is that capabilities can
> > > only be acquired through:
> > > 
> > > (1) user namespaces (prevented with LANDLOCK_PERM_NAMESPACE_ENTER)
> > > (2) execve (setuid or individual capabilities, prevented using
> > >     PR_SET_NO_NEW_PRIVS)
> > > 
> > > ...so if a process were to start out with no such capabilities,
> > > wouldn't that be enough to prevent it from gaining more?  Am I
> > > overlooking another way through which these can be acquired?
> > > 
> > > The Landlock capability support adds a "filter" for the use of
> > > capabilities, but my understanding of the capability system was that
> > > it already *is* that filter.  As long as we prevent the acquisition of
> > > new capabilities, shouldn't that be sufficient?
> > 
> > In a nutshell, capabilities applies to namespaces (and their type), so
> > it makes sense to be able to control them together, see the chroot
> > example.  Please take a look at the documentation.
> 
> I had a hard time puzzling it together in the documentation, but the
> chroot example helped.
> 
> So, if I am understanding correctly, the idea is that you need it in
> order to create a new user namespace,

The user namespace is the only namespace that doesn't require a
capability, but all others need at least one (which can be gained with a
user namespace).

> but the restrict the use of
> capabilities within that user namespace (not only CAP_SYS_ADMIN, but
> also more individual ones).  Sounds reasonable.

That enables us to restrict the use of capabilities (within a user
namespace or not), and then, because capabilities applies to a namespace
hierarchy, to restrict some operations too.  The limitation lies in the
split of capabilities (e.g. CAP_SYS_ADMIN is needed to create most
namespaces), but we cannot do anything about that (because of
compatibility).  We can only hope that new capabilities will be
introduced to improve the situation.

> 
> I can also see that in order to do that without the Landlock
> capability support, the first process within the new namespace would
> immediately need to drop capabilities, and that may be outside of the
> control of the person defining the Landlock policy..?

Right, dropping capabilities doesn't make sense for a (sandboxed)
attacker able to create a user namespace.

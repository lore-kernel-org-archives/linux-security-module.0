From: tj@kernel.org (Tejun Heo)
Date: Wed, 14 Jun 2017 13:54:26 -0400
Subject: [PATCH 27/27] kernfs, sysfs, cgroup: Support fs_context [ver #5]
In-Reply-To: <149745355907.10897.10073768158664960494.stgit@warthog.procyon.org.uk>
References: <149745330648.10897.9605870130502083184.stgit@warthog.procyon.org.uk>
	<149745355907.10897.10073768158664960494.stgit@warthog.procyon.org.uk>
Message-ID: <20170614175426.GA26229@htj.duckdns.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hello, David.

On Wed, Jun 14, 2017 at 04:19:19PM +0100, David Howells wrote:
> Make kernfs support superblock creation/mount/remount with fs_context.
> 
> This requires that sysfs and cgroup, which are built on kernfs, be made to
> support fs_context also.

Can you please include a brief rationale for doing this and include a
pointer to the fuller description on what's going on?

> Weirdies:
> 
>  (*) cgroup_do_get_tree() calls cset_cgroup_from_root() with locks held,
>      but then uses the resulting pointer after dropping the locks.  I'm
>      told this is okay and needs commenting.

Yeah, will add the comment.

>  (*) The cgroup refcount web.  This really needs documenting.

If you're talking about the mount refcnt part, yeah, it's confusing to
me too and we definitely need to document it better.

>  (*) cgroup2 only has one root?

Yeap.

Thanks.

-- 
tejun
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

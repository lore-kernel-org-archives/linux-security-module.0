From: serge@hallyn.com (Serge E. Hallyn)
Date: Thu, 13 Jul 2017 16:13:56 -0500
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <20170713164012.brj2flnkaaks2oci@thunk.org>
References: <1499785511-17192-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1499785511-17192-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<87mv89iy7q.fsf@xmission.com>
	<20170712170346.GA17974@mail.hallyn.com>
	<877ezdgsey.fsf@xmission.com>
	<74664cc8-bc3e-75d6-5892-f8934404349f@linux.vnet.ibm.com>
	<20170713011554.xwmrgkzfwnibvgcu@thunk.org>
	<87y3rscz9j.fsf@xmission.com>
	<20170713164012.brj2flnkaaks2oci@thunk.org>
Message-ID: <20170713211356.GA6167@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Theodore Ts'o (tytso at mit.edu):
> On Thu, Jul 13, 2017 at 07:11:36AM -0500, Eric W. Biederman wrote:
> > The concise summary:
> > 
> > Today we have the xattr security.capable that holds a set of
> > capabilities that an application gains when executed.  AKA setuid root exec
> > without actually being setuid root.
> > 
> > User namespaces have the concept of capabilities that are not global but
> > are limited to their user namespace.  We do not currently have
> > filesystem support for this concept.
> 
> So correct me if I am wrong; in general, there will only be one
> variant of the form:
> 
>    security.foo at uid=15000
> 
> It's not like there will be:
> 
>    security.foo at uid=1000
>    security.foo at uid=2000
> 
> Except.... if you have an Distribution root directory which is shared
> by many containers, you would need to put the xattrs in the overlay
> inodes.

Is that a problem?  Essentially people who would try to do the
above also want to use 'shiftfs' stackable filesystem, which would
presumably eventually do this for you.

>   Worse, each time you launch a new container, with a new
> subuid allocation, you will have to iterate over all files with
> capabilities and do a copy-up operations on the xattrs in overlayfs.
> So that's actually a bit of a disaster.

Only if you create the container rootfs as a copy.

Note that generally they would want to walk the fs in that case anyway, to chown
the files into the container.  And said chown would clear out any existing file
capabilities (and suid/sgid bits).

On the other hand, unprivileged lxc containers are created by
untarring the distro image straight into the mapped user namespace.
So no chowning is needed, and - once we we have this properly supported -
the filecaps should be automatically written correctly for the container.

> So for distribution overlays, you will need to do things a different
> way, which is to map the distro subdirectory so you know that the
> capability with the global uid 0 should be used for the container
> "root" uid, right?
> 
> So this hack of using security.foo at uid=1000 is *only* useful when the
> subcontainer root wants to create the privileged executable.  You
> still have to do things the other way.
> 
> So can we make perhaps the assertion that *either*:
> 
>    security.foo
> 
> exists, *or*
> 
>    security.foo at uid=BAR
> 
> exists, but never both?  And there BAR is exclusive to only one
> instances?

I think that's fine.

-serge
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

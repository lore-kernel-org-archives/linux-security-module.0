From: dhowells@redhat.com (David Howells)
Date: Tue, 24 Apr 2018 16:22:47 +0100
Subject: [PATCH 04/24] VFS: Add LSM hooks for filesystem context [ver #7]
In-Reply-To: <aca7e68c-022b-47ac-c249-59e042d431e8@tycho.nsa.gov>
References: <aca7e68c-022b-47ac-c249-59e042d431e8@tycho.nsa.gov>
	<CAHC9VhQhaBNBFwAXJ4TxKO56UTcwb_LcT2G8LwNxdxOD96tTvA@mail.gmail.com>
	<152414466005.23902.12967974041384198114.stgit@warthog.procyon.org.uk>
	<152414469006.23902.8132059438921850399.stgit@warthog.procyon.org.uk>
	<3232.1524238511@warthog.procyon.org.uk>
Message-ID: <703.1524583367@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> Neither fsopen() nor fscontext_fs_write() appear to perform any kind of
> up-front permission checking (DAC or MAC), although some security hooks may
> be ultimately called to allocate structures, parse security options, etc.
> Is there a reason not apply a may_mount() or similar check up front?

may_mount() is called by fsmount() at the moment.  It may make sense to move
this earlier to fsopen().  Note that there's also going to be something that
looks like:

	fd = fspick("/mnt");
	fsmount(fd, "/a", MNT_NOEXEC); // ie. bind mount

or:

	fd = fspick("/mnt");
	write(fd, "o intr");
	write(fd, "x reconfigure"); // ie. something like remount
	close(fd);

I guess we'd want to call may_mount() in fspick() too.  But there's also the
possibility of using this to create a query interfact too:

	fd = fspick("/mnt");
	write(fd, "q intr");
	read(fd, value_buffer);

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

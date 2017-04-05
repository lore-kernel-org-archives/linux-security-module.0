From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 6 Apr 2017 01:38:10 +0200
Subject: [PATCH 11/24] uswsusp: Disable when the kernel is locked down
In-Reply-To: <149142336965.5101.2946578135980499557.stgit@warthog.procyon.org.uk>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142336965.5101.2946578135980499557.stgit@warthog.procyon.org.uk>
Message-ID: <CAJZ5v0hp=GJtQ+YnNdaMw6rtbBzNyueY+iqjPkHLKp57t822ZQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Apr 5, 2017 at 10:16 PM, David Howells <dhowells@redhat.com> wrote:
> From: Matthew Garrett <mjg59@srcf.ucam.org>
>
> uswsusp allows a user process to dump and then restore kernel state, which
> makes it possible to modify the running kernel.  Disable this if the kernel
> is locked down.
>
> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-pm at vger.kernel.org

You probably want to disable hibernation altogether in this case.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

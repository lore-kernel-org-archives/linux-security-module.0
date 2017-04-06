From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 6 Apr 2017 22:07:50 +0200
Subject: [PATCH 11/24] uswsusp: Disable when the kernel is locked down
In-Reply-To: <10055.1491461713@warthog.procyon.org.uk>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142336965.5101.2946578135980499557.stgit@warthog.procyon.org.uk>
	<CAJZ5v0hp=GJtQ+YnNdaMw6rtbBzNyueY+iqjPkHLKp57t822ZQ@mail.gmail.com>
	<10055.1491461713@warthog.procyon.org.uk>
Message-ID: <CAJZ5v0iZ7Wf5pWL9HSzH_0djQfDmCLT14sp0HYbs9h8UuGHPkQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Apr 6, 2017 at 8:55 AM, David Howells <dhowells@redhat.com> wrote:
> Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>> You probably want to disable hibernation altogether in this case.
>
> See patch 10.  Does that mean patch 11 is superfluous?

Yes, it does.

You can't open /dev/snapshot if hibernation_available() returns false.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: dhowells@redhat.com (David Howells)
Date: Thu, 06 Apr 2017 07:55:13 +0100
Subject: [PATCH 11/24] uswsusp: Disable when the kernel is locked down
In-Reply-To: <CAJZ5v0hp=GJtQ+YnNdaMw6rtbBzNyueY+iqjPkHLKp57t822ZQ@mail.gmail.com>
References: <CAJZ5v0hp=GJtQ+YnNdaMw6rtbBzNyueY+iqjPkHLKp57t822ZQ@mail.gmail.com>
	<149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142336965.5101.2946578135980499557.stgit@warthog.procyon.org.uk>
Message-ID: <10055.1491461713@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Rafael J. Wysocki <rafael@kernel.org> wrote:

> You probably want to disable hibernation altogether in this case.

See patch 10.  Does that mean patch 11 is superfluous?

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

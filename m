From: dhowells@redhat.com (David Howells)
Date: Wed, 11 Apr 2018 21:08:21 +0100
Subject: [PATCH 24/24] debugfs: Restrict debugfs when the kernel is locked
	down
In-Reply-To: <87zi29k26z.fsf@xmission.com>
References: <87zi29k26z.fsf@xmission.com>
	<152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
	<152346403637.4030.15247096217928429102.stgit@warthog.procyon.org.uk>
Message-ID: <12741.1523477301@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Eric W. Biederman <ebiederm@xmission.com> wrote:

> Why is mounting debugfs allowed at all?  Last I checked (it has been a while)
> the code quality of debugfs was fine for debugging but debugfs was not
> safe to mount on a production system.
> 
> Maybe the code quality is better now but for a filesystem that is
> not supposed to be needed for developers letting us mount debugfs
> seems odd.

I agree.  But debugfs has been abused and it seems that there are some things
that use it as an interface between a kernel driver and the userspace side.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: tytso@mit.edu (Theodore Y. Ts'o)
Date: Fri, 10 Aug 2018 21:46:19 -0400
Subject: BUG: Mount ignores mount options
In-Reply-To: <87pnypiufr.fsf@xmission.com>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
	<87d0uqpba5.fsf@xmission.com>
	<20180810151606.GA6515@ZenIV.linux.org.uk>
	<87pnypiufr.fsf@xmission.com>
Message-ID: <20180811014619.GA14368@thunk.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Aug 10, 2018 at 08:05:44PM -0500, Eric W. Biederman wrote:
> 
> My complaint is that the current implemented behavior of practically
> every filesystem in the kernel, is that it will ignore mount options
> when mounted a second time.

The file system is ***not*** mounted a second time.

The design bug is that we allow bind mounts to be specified via a
block device.  A bind mount is not "a second mount" of the file
system.  Bind mounts != mounts.

I had assumed we had allowed bind mounts to be specified via the block
device because of container use cases.  If the container folks don't
want it, I would be pushing to simply not allow bind mounts to be
specified via block device at all.

The only reason why we should support it is because we don't want to
break scripts; and if the goal is not to break scripts, then we have
to keep to the current semantics, however broken you think it is.

					- Ted

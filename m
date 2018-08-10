From: dhowells@redhat.com (David Howells)
Date: Fri, 10 Aug 2018 17:11:55 +0100
Subject: BUG: Mount ignores mount options
In-Reply-To: <f199f22e-f064-b089-25bd-6e37ed1a73bd@schaufler-ca.com>
References: <f199f22e-f064-b089-25bd-6e37ed1a73bd@schaufler-ca.com>
	<87d0uqpba5.fsf@xmission.com>
	<153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
	<22361.1533913891@warthog.procyon.org.uk>
	<20180810153902.GH21087@thunk.org>
Message-ID: <30317.1533917515@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> > P.S.  And as Al has pointed out, this would require special, per-file
> > system support to determine whether the mount options are conflicting
> > or not....
> 
> This extends to LSMs that support mount options (SELinux and Smack)
> as well. 

Yes.  I'm doing that.

David

